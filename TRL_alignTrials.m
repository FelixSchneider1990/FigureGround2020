function [out, id] = TRL_alignTrials(tr, idx, ev, pre, post, stimNo)

if nargin < 6
    stimNo = [];
end

raw     = tr(idx,:);                                                        % Sorted data
evt     = ev(idx);

% Get aligned signal
for k = 1:size(raw,1)
    
    if evt(k) >= 999e3
        evt(k) = randi([1500,2500]);                                        % For CR, no valid RT available -> Select centre section of stimulus
    end
    
    if evt(k) < 950                                                         % Exclude trials smaller with response < 450ms to avoid onset response contribution (150ms for onset transient + 300ms window of interest)
        aSIG(k,:) = nan(1, pre+post+1);
        continue
    end
    
    aSIG(k,:) 	= raw(k, evt(k)-pre:evt(k)+post);                           % Event-aligned signal for trial
end

ind             = isnan(nanmean(tr(idx,:),2));
aSIG(ind,:)     = [];

% Output
out             = aSIG;
  
if ~isempty(stimNo)
    id          = stimNo(idx);
    id(ind)     = [];
end

end