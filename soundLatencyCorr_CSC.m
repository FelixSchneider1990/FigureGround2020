function data = soundLatencyCorr_CSC(data)
%% Import microphone recording

disp('Correcting sound onset timestamps')

% Select mic-channel
if isfield(data.param, 'Mic')
    ch = data.param.Mic;
else
    ch = 1;
end

[Timestamps, ChannelNumbers, SampleFrequencies, NumberOfValidSamples, Samples, Header] = ...
    Nlx2MatCSC(['CSC' num2str(ch) '.ncs'], [1 1 1 1 1], 1, 1, [] );     	% Get channel data [.ncs]

% Find information in header
rowAD               = find(contains(Header(:), '-ADBitVolts'));
rowFS               = find(contains(Header(:), '-SamplingFrequency'));

% Convert data
Timestamps          = Timestamps./10^3;                                     % Convert to [ms]
Timestamps          = Timestamps - data.events.firstEV;                     % Align to first event
Samples             = (Samples * str2double(Header{rowAD}(13:end))) .* 1e6;	% Convert samples to uV
fs                  = str2double(Header{rowFS}(end-4:end));                	% Sampling rate [Hz]

%% Vectorise samples

mic                 = reshape(Samples, 1, []);                              % Vectorised analogue signal

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

ts                  = reshape(new, 1, []);                                  % Vectorised timestamps

%% Get tuning sound latencies

tuntype             = [{'PT'}, {'BPN'}];                                    % PT: Pure tones || BPN: Bandpass noise
ind                 = data.trials.Tun.evt{1} >= data.evCodes.PT(1) &...
    data.trials.Tun.evt{1} <= data.evCodes.PT(2);
sNo                 = data.trials.Tun.evt{1}(ind) - 159;                    % Stimulus event code

for tID = 1:size(tuntype,2)
    ttype           = tuntype{tID};                                         % Define tuning type
    tr              = data.trials.Tun.(ttype);                              % Get trial boundaries
    bl              = 500;                                                  % Baseline period for reference [ms]
    c               = 1;
    offset          = zeros(1,length(tr.sOn));
    
    for i = 1:length(tr.sOn)                                                % For each sound presentation...
        sig         = mic(ts > tr.sOn(i)-bl & ts <  tr.sEnd(i));            % Get signal between trial signal
        offset(i)   = getSoundOn(sig, bl, i);                               % Estimate sound onset
        
        if isnan(offset(i))
            fail(c) = sNo(i);                                               % Save stimNo if onset estimation failed
            c = c+1;
        end
    end
    
    offset(offset > 3200 | offset < -3200) = nan;                           % Values larger or smaller than 100ms are not accepted. Such system latency doesn't make sense  
    offset(isnan(offset))               = mean(offset(~isnan(offset)));     % Take mean if no value
    offset                              = offset./(fs/10^3);                % Convert to ms
    data.latency.tun.(ttype).offset   	= offset;                           % Output: trial offsets [ms]
    data.latency.tun.(ttype).fail     	= fail;                             % Output: category of failed trials
    
    % Correct trial information for onset latencies
    data.trials.Tun.(tuntype{tID}).sOn  = data.trials.Tun.(tuntype{tID}).sOn + offset;
    data.trials.Tun.(tuntype{tID}).sEnd = data.trials.Tun.(tuntype{tID}).sEnd + offset;
end

clear tr offset

%% Get SFG sound latencies

tr                          = data.trials.SFG;
if ~isempty(tr)
    if tr.nTrials > 0
        bl                      = 500;                                          % Baseline period [ms]
        
        for i = 1:length(tr.sOn)                                                % For each sound presentation...
            sig                 = mic(ts > tr.sOn(i)-bl & ts <  tr.sEnd(i));    % Get signal between trial boundaries
            offset(i)           = getSoundOn(sig,bl,i);                         % Estimate sound onset
        end
        
        offset(offset > 3200 | offset < -3200) = nan;                           % Values larger or smaller than 100ms are not accepted. Such system latency doesn't make sense
        offset(isnan(offset))   = mean(offset(~isnan(offset)));                 % Take mean if no value
        offset                  = offset./(fs/10^3);                            % Convert to ms
        data.latency.sfg        = offset;                                       % Output
        
        % Correct for onset latencies
        data.trials.SFG.sOn     = data.trials.SFG.sOn + offset;
        data.trials.SFG.sEnd    = data.trials.SFG.sEnd + offset;
    end
end

disp('Done!')

%% Plot histograms
%
% f = figure('units','normalized','outerposition',[0 0 1 1]);
% d = out.tun.PT.offset;
% m = mean(d(d~=0));
% s = std(d(d~=0));
% subplot(1,3,1)
% hist(d,25)
% title(['Inbuild [PT] Mean: ' num2str(m) '| Std: ' num2str(s)])
%
% m=[]; s=[];
% dd = out.tun.BPN.offset;
% m  = mean(dd(dd~=0));
% s  = std(dd(dd~=0));
% subplot(1,3,2)
% hist(dd,25)
% title(['Inbuild [BPN] Mean: ' num2str(m) '| Std: ' num2str(s)])
%
% try
%     m=[]; s=[];
%     m = mean(out.sfg);
%     s = std(out.sfg);
%     subplot(1,3,3)
%     hist(out.sfg,25)
%     title(['Inbuild [SFG] Mean: ' num2str(m) ' | Std: ' num2str(s)])
% catch
% end
%
% print(f,[data.pdir 'latencies'],'-dpng', '-r300');

end