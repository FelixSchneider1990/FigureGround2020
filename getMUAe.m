function out = getMUAe(data, chan)
% Import NLX MUAe file (.ncs) and get MUAe data for each trial.
% Felix Schneider, 03/2018

disp(['Import MUAe' num2str(chan) '.ncs...'])

%% Import & convert MUAe file

if exist(['MUAe' num2str(chan) '_car.ncs'], 'file') == 2                   	% Use common average referenced file if avaiable
    fname   = ['MUAe' num2str(chan) '_car.ncs'];
else
    fname   = ['MUAe' num2str(chan) '.ncs'];
end

% Import continuous file
[Timestamps, ChannelNumbers, SampleFrequencies, NumberOfValidSamples, Samples, Header] = ...
    Nlx2MatCSC(fname, [1 1 1 1 1], 1, 1, [] );                              % Get channel data [.ncs]

% Find information in header
rowAD               = find(contains(Header(:), '-ADBitVolts'));
rowFS               = find(contains(Header(:), '-SamplingFrequency'));

% Convert data
Timestamps          = Timestamps./10^3;                                     % Convert to [ms]
Timestamps          = Timestamps - data.events.firstEV;                     % Align timestamps to first event
Samples             = Samples .* str2double(Header{rowAD}(13:end)) .* 1e6;  % Convert samples to [uV]
out.fs              = str2num(Header{rowFS}(end-3:end));                    % Sampling rate

%% Vectorise samples

vSamples            = reshape(Samples, 1, []);                              % Vectorise samples

for j = 1:size(Samples,2)
    if j < size(Samples,2)-1
        ts1         = Timestamps(j);
        ts2         = Timestamps(j+1);
        diff(j)     = ts2 - ts1;
        new(:,j)    = [ts1 linspace(ts1,ts2,size(Samples,1)-1)]';           % Get timestamp for each sample
    elseif j == size(Samples,2)
        ts1         = Timestamps(j);
        ts2         = ts1+mean(diff);                                       % Mean difference between timestamps for last offset
        new(:,j)    = [ts1 linspace(ts1,ts2,size(Samples,1)-2) ts2]';
    end
end

vTime               = reshape(new, 1, []);                                  % Vectorise timestamps
                   
% [SampleRows,SampleCols] = size(Samples);
% TimeStamps = repmat(Timestamps,[SampleRows 1]) + repmat([0:SampleRows-1]',[1 SampleCols]) .* repmat(1000000./out.fs,[SampleRows 1]);
% TimeStamps = round(TimeStamps(:));

%% Extract SFG trial data

disp('Extract SFG MUAe data...')

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

postWin             = 500;                                                  % Period after stimEnd [ms]
if ~isempty(t)
    if t.nTrials ~= 0
        out.SFG.WinOff = [-postWin postWin];
        for i = 1:length(t.BLon)
            tmp	= vSamples(:, vTime > t.BLon(i) & vTime < (t.sEnd(i)+postWin)); % Full trial incl BL + 500ms
            
            if length(tmp) >= 4000
                out.SFG.sig(i,:) = tmp(1:4000);
            else
                out.SFG.sig(i,:) = [tmp  nan(1,4000-length(tmp))];
            end
            
        end
    end
end

%% Extract tuning data

disp('Extract tuning MUAe data...')

if isfield(data.param.(['ch' num2str(chan)]), 'stTrials')
    if sum(~isnan(data.param.(['ch' num2str(chan)]).stTrials(3:4))) > 0
        tt = data.trials.Tun;                                                   % Trial boundaries
        [stblT,stBeh] = getStableTrials(data, ['ch' num2str(chan)]);
        tt.PT = stblT.trials.Tun.PT;
    else
        tt = data.trials.Tun;                                                   % Trial boundaries
    end
else
    tt = data.trials.Tun;                                                   % Trial boundaries
end

if ~exist('stBeh', 'var')
    stBeh = [];
end

tuntype             = [{'PT'}, {'BPN'}, {'CLK'}, {'WN'}];                   % PT: Pure tones || BPN: Bandpass noise || CLK: Click trains || WN: White noise
preWin              = 200;                                                  % Period before stimOn [ms]
postWin             = 100;                                                  % Period after stimEnd [ms]

for tID = 1:size(tuntype,2)
    ttype           = tuntype{tID};                                         % Tuning paradigm
    
    if ~isfield(tt, ttype)
        continue
    end
    out.Tun.WinOff      = [-preWin postWin];

    for jj = 1:length(tt.(ttype).sOn)
        tmp         = vSamples(vTime > (tt.(ttype).sOn(jj)-preWin) & vTime < (tt.(ttype).sEnd(jj)+postWin));    % [200ms BL, Full stimulus period, 100ms PostStim]
        
        if length(tmp) >= 500
            out.Tun.(ttype).sig(jj,:) = tmp(1:500);
        else
            out.Tun.(ttype).sig(jj,:) = [tmp  nan(1,500-length(tmp))];
        end   
    end
end

%% Check if unit responsive

if isfield(out, 'SFG')
    
    % Check of LFP trial exclusion index exists
    if isfield(data.(['ch' num2str(chan)]).LFP, 'SFG')
        ind                 = data.(['ch' num2str(chan)]).LFP.SFG.exIdx;
        out.SFG.sig(ind,:)  = nan(sum(ind), 4000);
    else
        out.SFG.sig         = exludeTrials(out.SFG.sig, [], 5, 'PEAK', 'NAN');
    end
    out.SFG.alig            = TRL_align2event(data, out.SFG.sig, stBeh); % SFG data alignment
    out.snr.SFG           	= getSNR(out.SFG.sig);

    % SFG responsive?
    on                      = mean(out.SFG.sig(:,501:650),2); % mean onset
    bl                  	= mean(out.SFG.sig(:,301:500),2); % mean baseline
    
    try
        [out.p.SFG, h]          = signrank(on,bl);
    catch
        out.p.SFG = nan;
        h = nan;
    end
    
            % Remove data
    %     if out.p.SFG > .05 && out.snr.SFG < 3
    %         out	= rmfield(out, 'SFG');
    %     end
end

if isfield(out, 'Tun')
    
    % Check of LFP trial exclusion index exists
    if isfield(data.(['ch' num2str(chan)]).LFP, 'Tun')
        indT                  	= data.(['ch' num2str(chan)]).LFP.Tun.PT.exIdx;
        out.Tun.PT.sig(indT,:)	= nan(sum(indT), 500);
        indN                  	= data.(['ch' num2str(chan)]).LFP.Tun.BPN.exIdx;
        out.Tun.BPN.sig(indN,:)	= nan(sum(indN), 500);
    else
        out.Tun.PT.sig          = exludeTrials(out.Tun.PT.sig, [], 5, 'PEAK', 'NAN');
        out.Tun.BPN.sig         = exludeTrials(out.Tun.BPN.sig, [], 5, 'PEAK', 'NAN');
    end
    
    twin                        = 200;                                                                              % Target window (Sound) length [ms]
    [out.Tun.sorted, tmat]      = TRL_getCond(data, out.Tun, ['ch' num2str(chan)], tuntype, preWin, twin, 'MUAe'); 	% Sort tuning  according to condition
    [out.Tun.nPeaks, out.Tun.Width] = getTuningType(tmat, 'PT');                                                 	% Determines number of peaks and coverage of tuning curve [% of tested freq space]
    
    out.snr.PT                 	= getSNR(out.Tun.PT.sig);                   % Signal2Noise ratio
    out.snr.BPN               	= getSNR(out.Tun.BPN.sig);
    out.p.PT                    = anovaSound(tmat, 'PT');                 	% Tuning ANOVA: freq x intensity
    out.p.BPN                   = anovaSound(tmat, 'BPN');
    
    % Remove data
    if out.p.PT > .05 && out.snr.PT < 3 % Frequency P, SNR for PT
        %         out    	= rmfield(out, 'Tun');
        delete([data.ddir 'var\Tun_MUAe_ch' num2str(chan) '.mat'])
    end
end
    
    % try
    %     if out.p.SFG > .05 && out.p.PT > .05
    %         out     = [];
    %     end
    % catch
    % end

disp('Done!')

end