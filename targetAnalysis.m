function [] = targetAnalysis(animalID, local, drive)
% Function imports preprocessed data for each recording session to extract
% field potentials and multi-unit activity for the target (figure) period.
%
% In addition, stimulus specs, behavioural performance, receptive fields,
% time-frequency information and  other cluster information get saved for
% each single session. Data are then concatenated and a single .mat-file
% gets saved for MUAe and LFP, respectively.
%
% Felix Schneider, 03/2019

if nargin < 2
    local = true;
    drive = 'D';
end

par         = getParam(animalID);                                               % Get recording parameter
tf_frex     = [7 100 100];                                                      % Time-frequency parameter [f1, f2, noF]

parfor iSe = 1:length(fieldnames(par))-2
    r   	= [];
    r    	= fieldnames(par.(['sess' num2str(iSe)]));                          % Recording name, string
    
    for iRec = 1:length(fieldnames(par.(['sess' num2str(iSe)])))
        disp(['Sess ' num2str(iSe) '/' num2str(length(fieldnames(par))-2) ' - Rec ' num2str(iRec) '/' num2str(length(r))])
 
        % Initialise
        out         = struct();
        fp          = struct();
        rec         = par.(['sess' num2str(iSe)]).(r{iRec});
        
        % Source directory [Local vs Network]
        if local
            source 	= [drive ':\Rec\' animalID '\' rec.fname];                       % Local
        else
            source	= ['Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\' animalID '\' rec.fname];
        end
        
        % Load data
        data        = load([source '\Data\DataStruct_' rec.fname(1:10)]);
        data        = data.data;
            
        % PERF: Get performance data
        if ~isempty(data.trials.SFG)
            if data.trials.SFG.nTrials >= 200
                perf                = condPerf(data.behaviour.raw);            	% Behavioural performance
                out.braw            = data.behaviour.raw;
                out.bID             = [animalID '_' rec.fname];
                out.mRT             = [perf(1,end-1) perf(2,end-1) perf(3,end-1)];   	% mRT [coh4 coh8 coh 12]
                out.RTsd            = [perf(1,end) perf(2,end) perf(3,end)];   	% mRT [coh4 coh8 coh 12]
                out.dp              = [perf(1,3) perf(2,3) perf(3,3)];          % Dprime [coh4 coh8 coh 12]
            end
        end
        
        if strcmp(animalID, 'Eric') && iSe == 42 && iRec == 2
            continue           
        elseif strcmp(animalID, 'Eric') && iSe == 43 && iRec == 2
            continue        
        elseif strcmp(animalID, 'Eric') && iSe == 60 && iRec == 1
            continue
        end
        
        % Loop through channels
        for iChan = 1:length(data.param.nChan)
            chan                    = ['ch' num2str(data.param.nChan(iChan))];
            disp(chan)
            
            % Skip iteration if file available or mic channel
%             f = dir([drive ':\Rec\' animalID '\Summary\SingleRec\']);
%             nam = {f.name};
%             if sum(contains(nam(:),['SE' num2str(iSe) '_Rec' num2str(iRec) '_' chan '.mat'])) == 1
%                 continue
%             end
            
            if data.param.nChan(iChan) == data.param.Mic || iChan == 23
                continue
            end
            
            % Check if sufficient SFG trials
            if ~isempty(data.trials.SFG) && isfield(data.param, (chan))
                if data.trials.SFG.nTrials >= 200
                    
                    out.coord               = data.param.(chan).coord;          	% Coordinates
                    out.id                  = data.param.fname;                    	% File identifier
                    
                    % LFP: Aligned signal, phase locking & time-freq analysis
                    if isfield(data.(chan).LFP, 'SFG')
%                         d                   = LFP_align2event(data, chan, tf_frex);                       	% Aligned trial data: raw, power, ITPC
%                         out.lfp.(chan)       = LFP_catAlignSig(fp, d, 1, [], [], tf_frex);                	% Get average for each condition
%                         [out.lfp.(chan).zmap, out.lfp.(chan).diff, out.lfp.(chan).extr] ...
%                             = LFP_zPowerPerm(d, out.lfp.(chan).bl_pownorm, 500, tf_frex);   	% Z-map, Difference map and extreme values (mult comp correction) for fig minus control
                        out.lfp.(chan).phaseLock = click_ITPC(data, chan);             	% Check if phase-locked response to click trains
                    end
                    
                    %%% Significantly different BL between SFG and TUN -> exclude %%%
                    
                    % MUAe: Aligned signal & RF
                    if isfield(data.(chan).MUAe, 'SFG') && ~isempty(data.(chan).MUAe.SFG)  
                        out.muae.(chan)                 = data.(chan).MUAe.SFG.alig;
                        [on2res, cond]                  = FigOn2Resp(data,chan);
                        [out.muae.(chan).incl, ~ , out.muae.(chan).sigT] ...
                            = checkFigSig(cond, [], false, 5);
                        if isfield(cond, 'o4')
                            [~, ~ , out.muae.(chan).sigT4] ...
                                = checkFigSig(cond, 4, false, 5);
                            [~, ~ , out.muae.(chan).sigT8] ...
                                = checkFigSig(cond, 8, false, 5);
                        else
                            [~, ~ , out.muae.(chan).sigT8] ...
                                = checkFigSig(cond, 8, false, 5);
                            [~, ~ , out.muae.(chan).sigT12] ...
                                = checkFigSig(cond, 12, false, 5);
                        end
                        out.muae.(chan).stimID        	= data.behaviour.stimID';
                        out.muae.(chan).perf          	= data.behaviour.stimPerf.perf;
                        out.muae.(chan).BLslope         = checkSlopeBL(data, chan);
                        out.muae.(chan).RTsplit         = RTsplit(data, chan);
                        [out.muae.(chan).figfreqs, out.muae.(chan).figs] ...
                            = getFigElem(data);
                        out.muae.(chan).id           	= [rec.fname '_' chan];
                        out.muae.(chan).field        	= rec.(chan).field;
                        out.muae.(chan).snr        	    = data.(chan).MUAe.snr;
                        out.muae.(chan).p        	    = data.(chan).MUAe.p;                     
                        
                        if isfield(data.(chan).MUAe, 'Tun')
%                             [out.muae.(chan).RF, ~] 	= getRF(data.(chan).MUAe.Tun.sorted.cond);
%                             out.muae.(chan).nPeaks      = data.(chan).MUAe.Tun.nPeaks;
%                             out.muae.(chan).Width       = data.(chan).MUAe.Tun.Width;
                            
                            evt   	= data.trials.Tun.evt;                                      % Trial events
                            ev   	= data.evCodes;                                             % Event codes
                            stimID 	= evt{1}(evt{1} >= ev.PT(1) & evt{1} <= ev.PT(2)); % Extract stimulus sequence
                            s     	= unique(stimID);
                            mat     = data.(chan).MUAe.Tun.PT.sig;
                            blne    = mean(nanmean(mat(:,1:200)));
                            
                           [RF, tmat] = tunCurve(mat, s, stimID, blne)
                           
                            out.muae.(chan).RF  = RF./max(RF);
                            [out.muae.(chan).nPeaks, out.muae.(chan).Width] = getTuningType(tmat, 'PT', true);                                                 	% Determines number of peaks and coverage of tuning curve [% of tested freq space]

                        end
                    end
                    
                    % Spks: Aligned signal & RF
                    if ~isempty(data.(chan).Spks)
                        fnames      = fieldnames(data.(chan).Spks);
                        cluster     = fnames(3:end);
                        
                        for iClus   = 1:length(cluster)
                            clus                           	= cluster{iClus};
                            if  isfield(data.(chan).Spks.(clus), 'SFG') &&  ~isempty(data.(chan).Spks.(clus).SFG)
                                out.spks.(chan).(clus)             	= data.(chan).Spks.(clus).SFG.alig;
                                [on2res, cond]                      = FigOn2Resp(data,chan,clus);
                                [out.spks.(chan).(clus).incl, ~ , out.spks.(chan).(clus).sigT] ...
                                    = checkFigSig(cond, [], false, 5);
                                out.spks.(chan).(clus).stimID     	= data.behaviour.stimID';
                                out.spks.(chan).(clus).perf        	= data.behaviour.stimPerf.perf;
                                out.spks.(chan).(clus).BLslope      = checkSlopeBL(data, chan, clus);
                                out.spks.(chan).(clus).RTsplit   	= RTsplit(data, chan, clus);
                                [out.spks.(chan).(clus).figfreqs, out.spks.(chan).(clus).figs]...
                                    = getFigElem(data);
                                out.spks.(chan).(clus).id        	= [rec.fname '_' chan];
                                out.spks.(chan).(clus).field      	= rec.(chan).field;
                                out.spks.(chan).(clus).snr        	= data.(chan).Spks.(clus).snr;
                                out.spks.(chan).(clus).p        	= data.(chan).Spks.(clus).p;
                                
                                if isfield(data.(chan).Spks.(clus), 'Tun')
                                    [out.spks.(chan).(clus).RF, ~] 	= getRF(data.(chan).Spks.(clus).Tun.sorted.cond);
                                    out.spks.(chan).(clus).nPeaks  	= data.(chan).Spks.(clus).Tun.nPeaks;
                                    out.spks.(chan).(clus).Width  	= data.(chan).Spks.(clus).Tun.Width;
                                end
                            end
                        end
                    end
                    
                    out = writeAndClear(out, on2res, drive, animalID, iSe, iRec, chan);
                    on2res = [];
                    
                end
            end
        end
    end
end
disp('All Rec processed')

%% Concatenate data

disp('Concatenate data...')
lfp     = struct();
spks    = [];
muae    = [];
c       = 0;
cc      = 0;
fpath   = [drive ':\Rec\' animalID '\Summary\singleRec\'];
dest    = ['Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\' animalID '\Summary\singleRec'];
nFiles  = dir([fpath '*.mat']);

for iRec = 1:size(nFiles,1)
    source  = [fpath nFiles(iRec).name];
    copyfile(source, dest)

    if contains(source, 'on2res')
        continue
    end

    load(source);
    t = out;

    if isfield(t, 'spks')
        try
            tmp     = fieldnames(t.spks);
        catch
            continue
        end
    else
        try
            tmp     = fieldnames(t.muae);
        catch
            tmp     = fieldnames(t.lfp);
            tmp     = tmp(end);
        end
    end
    ch          = tmp{1};

    try
    if isfield(t, 'lfp')
        coord       = t.coord;
        id          = [t.id '_' ch];
        lfp         = LFP_catAlignSig(lfp, t.lfp.(ch), 0, id, coord);
        lfp.phLock  = t.lfp.(ch).phaseLock;
    end
    catch
    end

    if isfield(t, 'muae')
        c            	= c+1;
        muae{c}      	= t.muae.(ch);
        muae{c}.coord 	= t.coord;
        muae{c}.phLock  = t.lfp.(ch).phaseLock;
    end

    if isfield(t, 'spks')
        fnames = fieldnames(t.spks.(ch));

        for iCl = 1:length(fnames)
            cls = fnames{iCl};
            cc             	= cc+1;
            spks{cc}      	= t.spks.(ch).(cls);
            spks{cc}.coord 	= t.coord;
            spks{cc}.phLock = t.lfp.(ch).phaseLock;
        end
    end
end

cc          = 0;
allnames    = {nFiles.name};
for iSe = 1:length(fieldnames(par))-2
    r   	= [];
    r    	= fieldnames(par.(['sess' num2str(iSe)]));                          % Recording name, string
    for iRec = 1:length(fieldnames(par.(['sess' num2str(iSe)])))
        vSess           = allnames(contains(allnames(:), ['SE' num2str(iSe) '_Rec' num2str(iRec)]));
        if ~isempty(vSess)
            load([fpath vSess{1}])
            cc          = cc + 1;
            bRaw{cc,1}  = out.braw;
            bRaw{cc,2}  = out.bID;
            dp(cc,:)    = out.dp;
            mRT(cc,:)   = out.mRT;
            RTsd(cc,:)   = out.RTsd;
        end
    end
end

disp('Save concatenated data...')

save(['Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\' animalID '\Summary\spks.mat'], 'spks', '-v7.3')
save(['Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\' animalID '\Summary\muae.mat'], 'muae', '-v7.3')
save(['Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\' animalID '\Summary\dprime.mat'], 'dp', '-v7.3')
save(['Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\' animalID '\Summary\mRT.mat'], 'mRT', '-v7.3')
save(['Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\' animalID '\Summary\RTsd.mat'], 'RTsd', '-v7.3')
save(['Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\' animalID '\Summary\bRaw.mat'], 'bRaw', '-v7.3')
% save(['Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\' animalID '\Summary\mLFP.mat'], 'lfp', '-v7.3')

disp('Done!')
end


function [RF, tmat] = tunCurve(mat, s, stimID, blne)
for iFreq   = 1:length(s)                                         	% For each frequency (-band)...
    fidx            = stimID == s(iFreq);                         	% Get volume information
    RF(iFreq)       = mean(nanmean(mat(fidx,201:300)) - blne);   	% Tuning
    tmat{iFreq}  	= mat(fidx,:);
end
end