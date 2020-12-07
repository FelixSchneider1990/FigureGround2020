function out = checkSlopeBL(data, chan, clus)

if nargin < 3
    bl      = mean(data.(chan).MUAe.SFG.sig(:,1:500),2);                    % Get average baseline activity
else
    bl      = mean(data.(chan).Spks.(clus).SFG.psth(:,1:500),2);        	% Get average baseline activity
end
                                                         % Return slope
out = bl;
end
