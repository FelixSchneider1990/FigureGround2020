function [figfreqs, figs] = getFigElem(data)

stID        = data.behaviour.stimID;
s           = data.behaviour.stimNrPool;
on          = data.behaviour.figOn*1000+500;
figs        = data.stimSpecs.fig;
frMat       = data.stimSpecs.freq_mat;
num         = 8;

for iSt = 1:size(stID,1)*.6
    idx = s == stID(iSt);
    fon = unique(on(idx));
    chordOn = (fon-500)/50;
    figfreqs(:,:,iSt) = frMat(:,chordOn+1:chordOn+num,iSt);
end
end
