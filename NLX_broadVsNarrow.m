function [waveform, spikeArray] = NLX_broadVsNarrow(NSE)
% almost exact copy of BroadVsNarrowPlot.m written by Alex

% interpolation settings
dTT = 6;
dT = 1;  % discretize to 5.4 micro-secs
discr=[1:(dT/dTT):32];
timeline=5.4*((1:length(discr)))-((7*6)*5.4);
compactFrequencyOfDelay = zeros(length(timeline),1);

% get spikes
spikeFeatures = NSE.SpikeFeatures;
spikeArray = squeeze(NSE.SpikeWaveForm);

% normalise
amp = spikeFeatures(1,:) - spikeFeatures(2,:); % get amplitude of spike
spikeArray = bsxfun(@rdivide,spikeArray,amp);% normalize amplitude to 1
spikeArray = spline(1:32,spikeArray',discr)';% interpolate

AverageSpike = nanmean(spikeArray,2);                % Calculate mean
StdDeriv = nanstd(spikeArray,0,2) ;                  % calculate standard deviation

numPts_before_zero=find(timeline<0);
numPts_before_zero=length(numPts_before_zero);
%%%%% find first maximum
first_max=bsxfun(@eq,spikeArray,max(spikeArray(1:numPts_before_zero,:)));
first_max = first_max(:,sum(first_max,1)==1);
first_max = sum(first_max,2);
med_first_max=find(first_max==max(first_max));
timeline=timeline-timeline(med_first_max+1);
DelaysOfMinimum = bsxfun(@eq,spikeArray,min(spikeArray(1:end-7*6,:)));
DelaysOfMinimum = DelaysOfMinimum(:,sum(DelaysOfMinimum,1)==1);  %%% Remove any case where there is more or less than one minimum
FrequencyOfDelay = sum(DelaysOfMinimum,2);
compactFrequencyOfDelay = FrequencyOfDelay(1:end) / sum(FrequencyOfDelay); % Normalize the histograms

% calculate the distribution of delays
RealDelays = bsxfun(@times,DelaysOfMinimum,(timeline'));
CompactRealDelays = sum(RealDelays,1);
CleanRealDelays = CompactRealDelays(CompactRealDelays ~= (timeline(end-7*6)));  % remove data that don't have a K dip
AvarageDelays = median(CleanRealDelays);
if AvarageDelays<50
    invert_flag=-1;
end
VariationInDelays = iqr(CleanRealDelays); % inter quartile range


waveform.AvarageDelays = AvarageDelays;
waveform.VariationInDelays = VariationInDelays;
waveform.AverageSpike = AverageSpike/max(AverageSpike);
waveform.timeline = timeline;