function out = getSFGTrials(data)
% Extract SFG trial information. Timestamps for each event get added to
% data structure.
% Felix Schneider, 07/2018

if isempty(data.behaviour)
    out = [];
else
    disp('Extract SFG trial information...')
    ev          = data.evCodes;     % event codes
    d           = data.events;      % event timestamps
    
    %% Remove tuning trials for simplicity
    
    mat         = [];
    tunOn       = data.trials.Tun.tunOn;
    tunEnd      = data.trials.Tun.tunEnd;
    
    for m = 1:length(tunEnd)
        pos{m}  = tunOn(m):tunEnd(m);
        mat     = horzcat(mat,pos{m});
    end
    
    try
        wnOn        = data.trials.Tun.WN.wnOn;
        wnEnd       = data.trials.Tun.WN.wnEnd;
        for n = 1:length(wnEnd)
            pos{m+n}= wnOn(n):wnEnd(n);
            mat     = horzcat(mat,pos{m+n});
        end
    catch
    end
    
    d.TTLs(mat)         = [];
    d.timestamps(mat)   = [];
    
    %% Extract SFG trials
    
    out.tOn         = find(d.TTLs == ev.trialStart);            % get trial start timestamps
    out.tEnd        = find(d.TTLs == ev.trialEnd);              % get trial end timestamps
    out.nTrials     = min(size(out.tOn,2), size(out.tEnd,2));   % get number of trials
    cc              = 1;                                        % counter
    
    % Trial exclusion
    [out.tOn, out.tEnd, out.nTrials] = trialExcl_SFG(data, out.tOn, out.tEnd, out.nTrials);
    
    % Get timestamps of events
    for i = 1:out.nTrials
        
        trEvents            = out.tOn(i):out.tEnd(i);                   % location of events
        out.trialEvents{i}  = d.TTLs(trEvents);                         % trial event code
        out.trialTS{i}      = d.timestamps(trEvents);                   % trial event timestamps
        stimIdx             = out.trialEvents{i} >= ev.SFG(1) & ...
            out.trialEvents{i} <= ev.SFG(2);          % check if SFG trial
        
        if sum(stimIdx) > 0
            % Event data
            out.stimNr(cc)  = out.trialEvents{i}(stimIdx);              % stimulus number
            out.BLon(cc)    = out.trialTS{i}(out.trialEvents{i} == ...
                ev.barTouch);                             % baseline start timestamps
            out.sOn(cc)     = out.trialTS{i}(stimIdx);                  % stimOn timestamps
            out.sEnd(cc)    = out.trialTS{i}(out.trialEvents{i} == ...
                ev.stimEnd);                              % stimEnd timestamps
            
            cc = cc + 1;
        else             disp(i)
        end
    end
    
    disp('Done!')
    
end
end