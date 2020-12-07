function out = getTunTrials(data)
% Extract tuning trial information. Timestamps for each event get added to
% data structure.
% Felix Schneider, 07/2018

disp('Extract tuning trial information...')

ev      = data.evCodes;     % event codes
d       = data.events;      % event timestamps

% Get tuning sequences
tunOn   = find(d.TTLs == ev.tunStart);
tunEnd  = find(d.TTLs == ev.tunEnd);

% Trials exclusion
[tunOn, tunEnd] = trialExcl_Tun(data, tunOn, tunEnd);

% Extract TTLs and timestamps
for i = 1:length(tunEnd)
    tunEvents{i}    = (tunOn(i):tunEnd(i));
    trEv{i}         = d.TTLs(tunEvents{i});                                 % trial event code
    trialTS{i}      = d.timestamps(tunEvents{i});                           % trial event timestamps
    PTidx(i)        = sum(trEv{i} >= ev.PT(1) & trEv{i} <= ev.PT(2)) ~= 0;  % check if PT trial
    BPNidx(i)       = sum(trEv{i} >= ev.BPN(1) & trEv{i} <= ev.BPN(2)) ~= 0;  % check if PT trial
    CLKidx(i)       = sum(trEv{i} >= ev.CLK(1) & trEv{i} <= ev.CLK(2)) ~= 0;  % check if PT trial
end

% Initiate variables
if sum(CLKidx) == 0
    evt     = {[],[]};
    ts      = {[],[]};
else
    evt     = {[],[],[]};
    ts      = {[],[],[]};
end

% Sort & concatenate vectors
for ii = 1:length(PTidx)
    if PTidx(ii) == 1   % for PT
        evt{1}      = horzcat(evt{1},trEv{ii});
        ts{1}       = horzcat(ts{1},trialTS{ii});
    elseif BPNidx(ii) == 1 % for BPN
        evt{2}      = horzcat(evt{2},trEv{ii});
        ts{2}       = horzcat(ts{2},trialTS{ii});
    elseif CLKidx(ii) == 1 % for Click trains
        evt{3}      = horzcat(evt{3},trEv{ii});
        ts{3}       = horzcat(ts{3},trialTS{ii});
    end
end

% Extract single stimulus presentation
tuntype = [{'PT'}, {'BPN'}, {'CLK'}]; % PT: Pure tones || BPN: Bandpass noise || Click trains

for iii = 1:length(evt)
    out.(tuntype{iii}).tStart   = ts{iii}(evt{iii} == ev.trialStart);
    out.(tuntype{iii}).BLend    = ts{iii}(evt{iii} == ev.BLend);
    out.(tuntype{iii}).sOn      = ts{iii}(evt{iii} >= ev.(tuntype{iii})(1) & evt{iii} <= ev.(tuntype{iii})(2));
    out.(tuntype{iii}).sEnd     = ts{iii}(evt{iii} == ev.soundEnd);
    out.(tuntype{iii}).sVol     = evt{iii}(evt{iii} >= ev.dB50 & evt{iii} <= ev.dB70);
end

out.tunOn   = tunOn;
out.tunEnd  = tunEnd;
out.evt     = evt;
out.ts      = ts;

%% White noise

try
    % Get WN sequences
    wnOn   = find(d.TTLs == ev.WNstart);
    wnEnd  = find(d.TTLs == ev.WNend);
    
    % Extract TTLs and timestamps
    for i = 1:length(wnEnd)
        wnEvents{i}     = (wnOn(i):wnEnd(i));
        wnEv{i}         = d.TTLs(wnEvents{i});                                 % trial event code
        wnTS{i}         = d.timestamps(wnEvents{i});                           % trial event timestamps
    end
    
    TSwn = []; EVwn = [];
    for ii = 1:length(wnEvents)
        if length(wnEvents{ii}) > 2
            TSwn = horzcat(TSwn,wnTS{ii});
            EVwn = horzcat(EVwn,wnEv{ii});
        end
    end
    
    out.WN.wnOn    = wnOn;
    out.WN.wnEnd   = wnEnd;
    out.WN.sOn     = TSwn(EVwn == ev.WNon);
    out.WN.sEnd    = TSwn(EVwn == ev.WNoff);
catch
end

disp('Done!')
end