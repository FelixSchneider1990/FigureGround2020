function out = getLFP(data, chan)
% Import NLX LFP file (.ncs) and get LFP data for each trial.
% Felix Schneider, 03/2018

disp(['Import LFP' num2str(chan) '.ncs...'])

%%  Import & convert LFP file

[Timestamps, ChannelNumbers, SampleFrequencies, NumberOfValidSamples, Samples, Header] = ...
    Nlx2MatCSC(['LFP' num2str(chan) '.ncs'], [1 1 1 1 1], 1, 1, [] );       % Get channel data [.ncs]

% Find information in header
rowAD               = find(contains(Header(:), '-ADBitVolts'));
rowADm              = find(contains(Header(:), '-ADMaxValue'));
rowFS               = find(contains(Header(:), '-SamplingFrequency'));

% Convert data
Timestamps          = Timestamps./10^3;                                     % Convert to [ms]
Timestamps          = Timestamps - data.events.firstEV;                     % Align timestamps to first event
Samples             = (Samples * str2double(Header{rowAD}(13:end))) * 1e6;  % Convert samples to [uV]

% Initialize data structures & save raw data
out                 = struct();
% out.tstamps         = Timestamps;
% out.samples         = Samples;
out.header          = Header;
out.fs              = str2double(Header{rowFS}(end-3:end));                    % Sampling rate [Hz]
out.conFact         = str2double(Header{rowAD}(13:end));                       % Conversion factor from binary to analogue
out.maxVal          = str2double(Header{rowADm}(13:end)) * out.conFact * 1e6;  % Saturation value in LFP signal

%% Vectorise samples

out.vSamples        = reshape(Samples, 1, []);                              % Vectorised samples

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

out.vTime           = reshape(new, 1, []);                                  % Vectorised timestamps

%% Extract SFG trial data

disp('Extract SFG LFP data...')

if isfield(data.param.(['ch' num2str(chan)]), 'stTrials')
    if sum(~isnan(data.param.(['ch' num2str(chan)]).stTrials(1:2))) > 0
        [stblT,stBeh] = getStableTrials(data, ['ch' num2str(chan)]);
        t = stblT.trials.SFG;
    else
        t = data.trials.SFG;                                                    % Trial boundaries
    end
else
    t = data.trials.SFG;                                                    % Trial boundaries
end

postWin             = 500;                                                  % Period after stimEnd [ms]

if ~isempty(t)
    if t.nTrials ~= 0
        
        out.SFG.WinOff = [-postWin postWin];
        
        for i = 1:length(t.BLon)
            tmp     = out.vSamples(:, out.vTime > t.BLon(i) & out.vTime < (t.sEnd(i)+postWin)); % Full trial incl BL + 500ms
            
            if length(tmp) >= 4000
                out.SFG.sig(i,:) = tmp(1:4000);
            else
                out.SFG.sig(i,:) = [tmp  nan(1,4000-length(tmp))];
            end
            
        end
    end
end

%% Extract tuning data

disp('Extract tuning LFP data...')

if isfield(data.param.(['ch' num2str(chan)]), 'stTrials')
    if sum(~isnan(data.param.(['ch' num2str(chan)]).stTrials(3:4))) > 0
        tt = data.trials.Tun;                                                   % Trial boundaries
        [stblT,~] = getStableTrials(data, ['ch' num2str(chan)]);
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
        tmp         = out.vSamples(out.vTime > (tt.(ttype).sOn(jj)-preWin) & out.vTime < (tt.(ttype).sEnd(jj)+postWin));    % [200ms BL, Full stimulus period, 100ms PostStim]
        
        if length(tmp) >= 500
            out.Tun.(ttype).sig(jj,:) = tmp(1:500);
        else
            out.Tun.(ttype).sig(jj,:) = [tmp  nan(1,500-length(tmp))];
        end
        
    end
end

%% Check if responsive

cat         = [{'SFG'}, {'PT'}, {'BPN'}];

for iCat = 1:length(cat)
    if strcmp(cat{iCat}, 'SFG') && isfield(out, 'SFG')
        [out.(cat{iCat}).sig, garbage, out.(cat{iCat}).exIdx]           = exludeTrials(out.(cat{iCat}).sig, [], 5, 'PEAK', 'NAN',1, out.maxVal);
        [out.Lat(iCat), out.Idx(iCat)]                              	= getLatency(nanmean(out.(cat{iCat}).sig), 150, 500, 1, 3);   
    elseif strcmp(cat{iCat}, 'PT') && isfield(out, 'Tun') || strcmp(cat{iCat}, 'BPN') && isfield(out, 'Tun')
        [out.Tun.(cat{iCat}).sig, garbage, out.Tun.(cat{iCat}).exIdx]   = exludeTrials(out.Tun.(cat{iCat}).sig, [], 5, 'PEAK', 'NAN',1, out.maxVal );
        [out.Lat(iCat), out.Idx(iCat)]                                 	= getLatency(nanmean(out.Tun.(cat{iCat}).sig), 150, 200, 1, 3);   
    else
        out.Lat(iCat) = 0;
        out.Idx(iCat) = 0;
     end
end

%%  Align & sort  trials

if isfield(out, 'SFG')
    out.SFG.alig    = TRL_align2event(data, out.SFG.sig, stBeh);                                        % SFG data alignment
end

if isfield(out, 'Tun')    
    if isfield(tt.PT, 'flag')
        out.Tun.PT.flag = tt.PT.flag;
    end
    twin            = 200;                                                                              % Target window (Sound) length [ms]
    out.Tun.sorted  = TRL_getCond(data, out.Tun, ['ch' num2str(chan)], tuntype, preWin, twin, 'LFP');   % Sort tuning  according to condition
end

%% Exclude if necessary

% if sum(out.Idx) == 0
%     out = [];
% else
%     if out.Idx(1) == 0 && isfield(out, 'Tun')
%         out = rmfield(out, 'Tun');
%     elseif out.Idx(3) == 0 && isfield(out, 'SFG')
%         out = rmfield(out, 'SFG');
%     end
% end

disp('Done!')

end