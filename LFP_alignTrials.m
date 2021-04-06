function out = LFP_alignTrials(tr, cSig, idx, ev, pre, post)

raw     = tr(idx,:);                                            % Sorted data
tfa     = cSig(:,:,idx);
aSIG    = [];
aTFA    = [];

% Get aligned signal
for k = 1:size(raw,1)    
    aSIG(k,:) 	= raw(k, ev(k)-pre:ev(k)+post);                 % Event-aligned signal for trial
    aTFA(:,:,k)	= tfa(:,ev(k)-pre:ev(k)+post,k);                % Event-aligned time-freq analysis
end
  
ind             = isnan(nanmean(tr(idx,:),2));
aSIG(ind,:)     = [];
aTFA(:,:,ind)   = [];

pow          	= abs(aTFA).^2;                                 % Power
% itpc          	= getITPC(aTFA);                                % Inter-trial phase coherence

% Output
out.trAlign     = aSIG;
out.trPow       = pow;
% out.ITPC        = itpc;
end