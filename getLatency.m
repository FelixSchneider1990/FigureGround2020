function [outLat, outIdx] = getLatency(vec, twin, preWin, type, nStd)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The neural latency was the first bin after stimulus presentation to cross 
% a response threshold and remain there for a minimum number of bins (here, 
% three bins). The algorithm defined a response threshold as 3 Gaussian SDs 
% of the spontaneous rate above the mean spontaneous firing rate.
% Camalier et al. (2012) PNAS

% Neural latency was defined as the time of the first bin in which the 
% smoothed value exceeded the average smoothed firing rate from the 250 ms 
% preceding the stimulus onset by at least 2 SDs and remained above 2 SD 
% for at least 10 ms.
% Kusmierek et al. (2014) J Neurophysiol

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define threshold: Mean(preWin before stimOn) +  Std(preWin before stimOn) * nStd
thresh    	= [mean(vec(1:preWin)) + (std(vec(1:preWin)) * nStd), mean(vec(1:preWin)) - (std(vec(1:preWin)) * nStd)];
bins       	= 9; % timestamp + 9 bins = 10ms

% onAligned  	= find(vec(preWin+1:end) > thresh(1));
% if ~isempty(onAligned)
%     outLat  = onAligned(1);
%     outIdx  = true;
% else
%     outLat  = nan;
%     outIdx  = false;
% end

% For transient response in defined time window
for s = preWin+1:preWin+twin-bins  
    % Check at each point in time if next 10ms are exceeding
    % threshhold (both directions for LFP)
    if type == 1 % LFP
        if sum(vec(s:s+bins) >= thresh(1)) == (bins+1) || sum(vec(s:s+bins) <= thresh(2)) == (bins+1)
            exc(s) = s; % Save location
        end
    elseif type == 2 % Spikes
        if sum(vec(s:s+bins) >= thresh(1)) == (bins+1)
            exc(s) = s; 
        end
    end
end

if exist('exc') == 0
    outLat  = nan;
    outIdx  = 0;
else
    % First crossing of thresh == response latency
    x       = find(exc);
    outLat  = x(1) - preWin;
    outIdx  = 1;
end
end