function out = getSpikes(data, chan)
% Import NLX spike file (.nse) and get spiking data for each trial. Adjusts
% threshold to match specified baseline firing rate.
% Felix Schneider, 03/2018

disp(['Import SE' num2str(chan) '.nse...'])

%% Import & convert SE file

if chan == 23
    out = [];
    return
end

if exist(['SE' num2str(chan) 'r.nse'], 'file') == 2                     	% Use reduced file if avaiable
    fname           = ['SE' num2str(chan) 'r.nse'];
else
    fname           = ['SE' num2str(chan) '.nse'];
end
s                   = dir(fname);

if s.bytes == 16384                                                         % Check if file is empty
    warning('Empty file. Please specify recording channels only.')
    out = [];
    return
end

% Import spike file
NSE                 = NLX_LoadNSE([data.sdir fname],'FULL',1,[]);           % Import NSE data
NSE.ClusterNr       = zeros(length(NSE.ClusterNr),1);                       % Set all cluster to zero
refT                = 500;                                                  % Define baseline period
blFR                = [20 30];                                              % Specify baseline firing rate [Hz]

% Get timestamps of target period
if ~isempty(data.trials.SFG)
    if isempty(data.trials.SFG.nTrials)
    data.trials.SFG.nTrials = 0;
    end
end

if ~isempty(data.trials.SFG) && data.trials.SFG.nTrials >= 200
    blTS         	= [([data.trials.SFG.BLon' (data.trials.SFG.BLon+500)'] + data.events.firstEV) * 10^3; ...           % Take 500ms BL period of SFG trials as reference
        ([(data.trials.Tun.PT.sOn-refT)' data.trials.Tun.PT.sOn'] + data.events.firstEV) * 10^3; ...      % Take 500ms BL period of PT trials as reference
        ([(data.trials.Tun.BPN.sOn-refT)' data.trials.Tun.BPN.sOn'] + data.events.firstEV) * 10^3];      % Take 500ms BL period of BPN trials as reference
else
    blTS           	= [([(data.trials.Tun.PT.sOn-refT)' data.trials.Tun.PT.sOn'] + data.events.firstEV) * 10^3; ...
        ([(data.trials.Tun.BPN.sOn-refT)' data.trials.Tun.BPN.sOn'] + data.events.firstEV) * 10^3];
end

% Select spikes
try
    [NSE,i]             = NLX_Freq2Threshold(NSE,0,blFR,blTS,9);                % Set threshold to 15-25Hz BL firing
    
    if i >= 20
        out = [];
        return
    end
catch
    warning(['chan' num2str(chan) ' abort'])
    out = [];
    return
end

Timestamps          = NSE.TimeStamps./10^3;                                 % Convert to [ms]
Timestamps          = Timestamps - data.events.firstEV;                     % Align timestamps to first event

% Initialize data structures
out                 = struct();
out.header          = NSE.Header;
rowFS               = find(contains(NSE.Header(:), '-SamplingFrequency'));
out.fs              = str2double(NSE.Header{rowFS}(end-4:end));            	% Sampling rate [Hz]

% Parameter
cluster             = unique(NSE.ClusterNr);                               	% Get number of clusters
tstep               = .001;                                                 % Resolution for PSTH  [s]
sigma               = .005;                                                 % Width of gaussian/window [s]
timeSFG             = tstep:tstep:4;                                        % Time vector full SFG trial
timeTun             = tstep:tstep:.5;                                       % Time vector tuning
SFGwin              = 500;                                                  % Period before/after SFG stimEnd [ms]
preWin              = 200;                                                  % Period before Tun stimOn [ms]
postWin             = 100;                                                  % Period after Tun stimEnd [ms]
tuntype             = [{'PT'}, {'BPN'}, {'CLK'}, {'WN'}];                   % PT: Pure tones || BPN: Bandpass noise || CLK: Click trains || WN: White noise

if isfield(data.param.(['ch' num2str(chan)]), 'stTrials')
    if sum(~isnan(data.param.(['ch' num2str(chan)]).stTrials(1:2))) > 0
        [stblT,stBeh] = getStableTrials(data, ['ch' num2str(chan)]);
        t = stblT.trials.SFG;
    else
        t = data.trials.SFG;                                                % Trial boundaries
    end
else
    t = data.trials.SFG;                                                    % Trial boundaries
end

if isfield(data.param.(['ch' num2str(chan)]), 'stTrials')
    if sum(~isnan(data.param.(['ch' num2str(chan)]).stTrials(3:4))) > 0
        tt = data.trials.Tun;                                              	% Trial boundaries
        [stblT,stBeh] = getStableTrials(data, ['ch' num2str(chan)]);
        tt.PT = stblT.trials.Tun.PT;
    else
        tt = data.trials.Tun;                                            	% Trial boundaries
    end
else
    tt = data.trials.Tun;                                                   % Trial boundaries
end

if ~exist('stBeh', 'var')
    stBeh = [];
end

for cl = 1 %2:length(cluster)                                               % Loop through clusters
    
    tstamps = []; idx = [];
    cStr            = ['clus' num2str(cl)]; disp(cStr);                     % ['clus' num2str(cl)-1]
    idx             = NSE.ClusterNr == cluster(cl);
    tstamps         = Timestamps(idx);                                      % Get cluster specific timestamps
    
    %% Extract SFG trials
    
    if ~isempty(t)
        if t.nTrials ~= 0                                                   % Check if SFG detection trials
            disp('Extract SFG spike data...')
            out.(cStr).SFG.WinOff                   = [-SFGwin SFGwin];
            
            for i = 1:length(t.BLon)
                out.(cStr).SFG.spTimes{i}           = tstamps(tstamps > t.BLon(i) & tstamps < (t.sEnd(i)+SFGwin)) - t.BLon(i);     % Full trial spike times
                out.(cStr).SFG.psth(i,:)            = convGauss(out.(cStr).SFG.spTimes{i}/1000,timeSFG,sigma);                     % Full trial PSTH - arg: spiketimes,nbins,sigma[bins]
            end
            
        end
    end
    
    %% Extract tuning data
    
    disp('Extract tuning spike data...')
    
    out.(cStr).Tun.WinOff  = [-preWin postWin];
    
    for tID = 1:size(tuntype,2)
        ttype       = tuntype{tID};                                         % Tuning paradigm
        
        if ~isfield(tt, ttype)
            continue
        end
        
        for jj = 1:length(tt.(ttype).sOn)
            out.(cStr).Tun.(ttype).spikeTimes{jj}   = tstamps(tstamps > (tt.(ttype).sOn(jj)-preWin) & tstamps < (tt.(ttype).sEnd(jj)+postWin)) - (tt.(ttype).sOn(jj)-preWin); % Stimulus spike times
            out.(cStr).Tun.(ttype).psth(jj,:)       = convGauss(out.(cStr).Tun.(ttype).spikeTimes{jj}/1000,timeTun,sigma);         % PSTH - arg: spiketimes,nbins,sigma[bins]
        end
    end
    
    %% Check if unit responsive
    
    if isfield(out.(cStr), 'SFG')
        
        % Check of LFP trial exclusion index exists
        if isfield(data.(['ch' num2str(chan)]).LFP, 'SFG')
            ind                 = data.(['ch' num2str(chan)]).LFP.SFG.exIdx;
            out.(cStr).SFG.psth(ind,:)  = nan(sum(ind), 4000);
        else
            out.(cStr).SFG.psth         = exludeTrials(out.(cStr).SFG.psth, [], 5, 'BL', 'NAN');
        end
        out.(cStr).SFG.alig             = TRL_align2event(data, out.(cStr).SFG.psth, stBeh);                                                       % SFG data alignment
        out.(cStr).snr.SFG           	= getSNR(out.(cStr).SFG.psth);
        
        % SFG responsive?
        on                              = mean(out.(cStr).SFG.psth(:,501:650),2); % mean onset
        bl                              = mean(out.(cStr).SFG.psth(:,301:500),2); % mean baseline
        
        try
            [out.(cStr).p.SFG,h]           = signrank(on,bl);
        catch
            [out.(cStr).p.SFG,h]  = nan;
            h = nan;
        end
        
        % Remove data
        %     if out.(cStr).p.SFG > .05 && out.(cStr).snr.SFG  < 3
        %         out.(cStr) = rmfield(out.(cStr), 'SFG');
        %     end
    end
    
    if isfield(out.(cStr), 'Tun')
        
        %    Check of LFP trial exclusion index exists
        if isfield(data.(['ch' num2str(chan)]).LFP, 'Tun')
            indT                     = data.(['ch' num2str(chan)]).LFP.Tun.PT.exIdx;
            out.(cStr).Tun.PT.psth (indT,:) = nan(sum(indT), 500);
            indN                     = data.(['ch' num2str(chan)]).LFP.Tun.BPN.exIdx;
            out.(cStr).Tun.BPN.psth (indN,:)= nan(sum(indN), 500);
        else
            out.(cStr).Tun.PT.psth          = exludeTrials(out.(cStr).Tun.PT.psth, [], 5, 'BL', 'NAN');
            out.(cStr).Tun.BPN.psth         = exludeTrials(out.(cStr).Tun.BPN.psth, [], 5, 'BL', 'NAN');
        end
        
        twin                                = 200;                                                                                              % Target window (Sound) length [ms]
        [out.(cStr).Tun.sorted, tmat]       = TRL_getCond(data, out.(cStr).Tun, ['ch' num2str(chan)], tuntype, preWin, twin, 'Spks', cStr);     % Sort tuning  according to condition
        [out.(cStr).Tun.nPeaks, out.(cStr).Tun.Width] = getTuningType(tmat, 'PT');                                                 	% Determines number of peaks and coverage of tuning curve [% of tested freq space]

        out.(cStr).snr.PT                  	= getSNR(out.(cStr).Tun.PT.psth);   % Signal2Noise ratio
        out.(cStr).snr.BPN                	= getSNR(out.(cStr).Tun.BPN.psth);
        out.(cStr).p.PT                     = anovaSound(tmat, 'PT');           % Tuning ANOVA: freq x intensity, returns p for freq only
        out.(cStr).p.BPN                    = anovaSound(tmat, 'BPN');
        
        %         % Remove data
        %         if out.(cStr).p.PT  > .05 && out.(cStr).snr.PT < 3 % Frequency P, SNR for PT
        %             %         out = rmfield(out, 'Tun');
        %             delete([data.ddir 'var\Tun_Spks_' chan '_' cStr '.mat'])
        %         end
    end
    
    % try
    %     if pSFG > .05 && pPT(2) > .05
    %         out = [];
    %     end
    % catch
    % end
    %
    % if ~isempty(out.(cStr))
    %     if length(fieldnames(out.(cStr))) < 2
    %         out.(cStr) = [];
    %     end
    % end
    %
    % if isempty(out.(cStr))
    %     out = rmfield(out, cStr);
    % end
    
    close all hidden
    disp('Done!')
    
end

% if length(fieldnames(out)) < 3
%     out = [];
% end

end
