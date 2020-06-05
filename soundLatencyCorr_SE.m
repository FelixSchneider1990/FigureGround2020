function data = soundLatencyCorr_SE(data)

disp('Correct for sound latency')

% Import mic data
[Timestamps, ScNumbers, CellNumbers, Features, Samples, Header] = ...
    Nlx2MatSpike(['SE1.nse'], [1 1 1 1 1], 1, 1, []);       % Get channel data [.nse]

Timestamps      = Timestamps./10^3;                         % Convert to [ms]
Timestamps      = Timestamps - data.events.firstEV;         % Align to first event
tstamps         = Timestamps(CellNumbers == 0);             % Consider unclustered data only (there shouldn't be a cluster here)

%% Tuning trials

tuntype         = [{'PT'}, {'BPN'}];                        % PT: Pure tones || BPN: Bandpass noise

for tID = 1:size(tuntype,2)
    ttype       = tuntype{tID};                             % Define tuning type
    t           = data.trials.Tun.(ttype);                  % Get trial boundaries
    mat         = zeros(length(t.sOn),1);                   % Initialise output variable
    
    for i = 1:length(t.sOn)                                 % For each sound presentation...
        clear sptimes
        sptimes         = tstamps(tstamps > t.sOn(i) & ...
            tstamps < t.sEnd(i)) - t.sOn(i);                % Get sound responses
        
        if ~isempty(sptimes) && length(sptimes) > 50        % If not empty and at least 50 threshold crossings...
            mat(i)      = sptimes(1);                       % Get first threshhold crossing
        end
    end
    
    mat(mat == 0)       = mean(mat(mat ~= 0));              % Take mean if no value
    data.latency.tun.(ttype)     = mat;
    
    % Correct for onset latencies
    data.trials.Tun.(tuntype{tID}).sOn  = data.trials.Tun.(tuntype{tID}).sOn + mat';
    data.trials.Tun.(tuntype{tID}).sEnd = data.trials.Tun.(tuntype{tID}).sEnd + mat';
end

clear mat

%% SFG trials

tt = data.trials.SFG;                                               % Get trial boundaries

if tt.nTrials ~= 0
    for j = 1:length(tt.sOn)                                        % For sound presentation...
        mat                 = tstamps(tstamps > tt.sOn(j) & ...
                              tstamps < tt.sEnd(j)) - tt.sOn(j);    % All treshold crossings
        sfg(j)              = mat(1);                               % First threshhold crossing
    end
    
    sfg(sfg == 0)           = mean(sfg(sfg ~= 0));                  % Take mean if no value
    data.latency            = sfg;
    
    % Correct for onset latencies
    data.trials.SFG.sOn 	= data.trials.SFG.sOn + sfg;
    data.trials.SFG.sEnd    = data.trials.SFG.sEnd + sfg;
end

disp('Done!')

end


