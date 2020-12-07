function out = getSoundOn(sig,bl,tr)

if nargin < 3
    tr  = 999;
end

if length(sig) < bl*32
    out = 0;
    return
end

s       = abs(sig);                                                         % No neg values
n       = 50;                                                               % Window/2
e       = movmean(s,n);                                                     % Envelope
% e     = envelope(sig,200,'rms');
thresh  = mean(e(1:bl*32)) + (std(e(1:bl*32)) * 5);                     	% Threshold: 5Std above baseline mean
N       = 3*32;                                                             % Number of samples considered at a time [3ms*32samples/ms]

t       = find(e >= thresh);                                               	% Samples greater than threshold
x       = diff(t) == 1;                                                     % Check if neighbours are consecutive
f       = find([false,x] ~= [x,false]);                                     % Extract start/end points of sequences
g       = find(f(2:2:end)-f(1:2:end-1) >= N,1,'first');                     % First sample of sequence with >=N consecutive numbers
out     = t(f(2*g-1)) - bl*32;                                          	% Convert back to time sample, subtract baseline samples

if isempty(out)
    out = nan;
end

% % Check significance
% for j = N+1:length(s)-N
%     if sum(e(j:j+N) >= thresh) >= N
%         x(j) = j;
%     end
% end
%
% % Get first occurence of significance
% try
%     idx                 = x(x ~= 0);
%     idx(idx < bl*32)    = [];
%     out                 = idx(1) - bl*32;
% catch
%     out                 = 0;
% end

% % Plot outliers
% if out/(32000/10^3) > 75
%     figure
%     plot(sig)
%     hold on
%     plot(e)
%     vline(out + bl*32)
%     title(['Trial' num2str(tr)])
% end

end