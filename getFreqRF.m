function no = getFreqRF(RF, figfreqs)

if size(RF,1) == 1
    f = fit((1:length(RF))', RF','smoothingspline','SmoothingParam', .9999);
    
    c = 0;
    for j = .1:.1:length(RF)
        c = c+1;
        ffit(c) = f(j);
    end
    
else
    f = fit((1:length(mean(RF)))', mean(RF)','smoothingspline','SmoothingParam', .9999);
    
    c = 0;
    for j = .1:.1:length(mean(RF))
        c = c+1;
        ffit(c) = f(j);
    end
end

% Fit tone curve
pt = [180 255 360 509 720 1018 1440 2036 2880 4073 5760 8146 11520 16292];
fpt = fit((1:length(pt))', pt','exp1');
cc = 0;
for j = .1:.1:length(pt)
    cc = cc+1;
    ptfit(cc) = fpt(j);
end

halfMax = ffit > (max(ffit) - abs(diff([min(ffit) max(ffit)]))/2);
range = [];

% Get number of figure elements in RF
for iFreq = 1:length(ptfit)-1
    if halfMax(iFreq) == 1 && halfMax(iFreq+1) == 1
        range = [range ptfit(iFreq):ptfit(iFreq+1)];
    end
end
r = unique(round(range));

for iStim = 1:size(figfreqs,3)
    fComp = round(figfreqs(:,1:8,iStim));
    for iChord = 1:size(fComp,2)
        no(iStim,iChord) = sum(ismember(fComp(:,iChord),r));
    end
end
end