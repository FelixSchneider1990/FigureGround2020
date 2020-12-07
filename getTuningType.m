function [nPeaks, freqSpace] = getTuningType(tmat, ttype, flag)
%% Get spontaneous activity
 if nargin < 3
     flag = false;
 end
 
% Check condition
if strcmp(ttype, 'PT')
    idx             = 1;
    sz              = 14;
elseif strcmp(ttype, 'BPN')
    idx             = 2;
    sz              = 13;
else error('No such type!')
end

if flag
    spont = [];
    cls = cellfun(@nanmean, tmat,'UniformOutput', false);
    for i = 1:size(cls,2)
        spont = cat(1,tmat{i}(:,1:200));
        mmFR(i) = mean(cls{i}(201:300));
    end
    % Determine treshold
    m                   = nanmean(nanmean(spont,2));
    s                   = nanmean(nanstd(spont,[],2));
    thresh              = m + s*3; 
else
    % Matrix preparation
    mmat                = cellfun(@nanmean, tmat,'UniformOutput', false);
    idx1                = cellfun(@(C) any(isnan(C(:))), mmat);
    idx2                = cellfun(@length, mmat) < 500;
    mmat(idx1 & idx2)   = [];
    
    % Get spontaneous activity across conditions
    for iC = 1:length(mmat)
        spont(iC,:)     = mmat{iC}(1:200);
    end
    
    % Determine treshold
    m                   = mean(nanmean(spont,2));
    s                   = mean(nanstd(spont,[],2));
    thresh              = m + s*2.5;
    
    %% Determine maxima
    nmat                = cellfun(@nanmean, tmat,'UniformOutput', false);
    [outPT, outBPN]     = getRF(nmat,[],false,false);  % Get FRA
       
    if idx == 1
        mFR             = outPT;
    elseif idx == 2
        mFR             = outBPN;
    end
    
    if sum(isnan(nanmean(mFR))) > 3
        nPeaks          = nan;
        freqSpace       = nan;
        return                                                                                  % Return if more than 3 NaN's in RF
    end
    
    mmFR                = nanmean(mFR);                                                         % Average across intensities
end

if sum(isnan(mmFR))
    mmFR(isnan(mmFR)) = nanmean(mmFR);                                                      % Replace NaN's with mean if necessary - figure out why there are NAN's!
end
    
f                   = fit((1:length(mmFR))',mmFR','smoothingspline','SmoothingParam',0.98); % Smooth curve
ff                  = f(1:sz);                                                              % Sample fit

[pks,locs]          = findpeaks(ff);                                                        % Get local maxima
nPeaks              = numel(locs(pks > thresh));                                            % Count number of peaks above threshhold

%% Check Width at FWHM

c = 0;
for j = 1:.01:length(mmFR)
    c       = c+1;
    ffit(c) = f(j);
end

mVal        = max(ffit);
miniVal     = min(ffit);
halfMax     = ffit > (mVal - (mVal-miniVal)/2);
freqSpace   = sum(halfMax)/length(halfMax);

end
