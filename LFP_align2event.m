function out = LFP_align2event(data, chan, tf_frex)

lfp     = data.(chan).LFP.SFG.sig;                                          % Valid trials
fs      = data.(chan).LFP.fs;                                               % Sampling frequency
f1      = tf_frex(1);                                                       % Min frex
f2      = tf_frex(2);                                                       % Max frex
noF     = tf_frex(3);                                                       % Num frex

% Line noise filter
% bpFilt	= designfilt('bandpassfir','FilterOrder',1000, ...
%     'CutoffFrequency1',49,'CutoffFrequency2',51, ...
%     'SampleRate',fs);

for iTr = 1:size(lfp,1)
    % Baseline-correct data
    mbl             = mean(lfp(iTr,301:500));                                % BL period - 200ms, soundOn @ 501ms;
    tr(iTr,:)       = lfp(iTr,:) - mbl;                                      % Subtract line noise
    
    % Time-Frequency analysis
    if ~isnan(nanmean(tr(iTr,:)))
        cSig(:,:,iTr)  = LFP_timeFreqAnalysis(tr(iTr,:), fs, f1, f2, noF);
    elseif isnan(nanmean(tr(iTr,:)))
        cSig(:,:,iTr) = nan(noF, 4000);
    end
end

%% Align signal %%

if isfield(data.param.(chan), 'stTrials')
    stTr                    	= data.param.(chan).stTrials;
    
    if sum(~isnan(stTr(1:2))) > 0
        if isnan(stTr(2))
            tidx             	= zeros(length(data.trials.SFG.tOn),1);
            tidx(stTr(1):end)	= true;
        else
            trls              	= stTr(1):stTr(2);
            tidx                = zeros(length(data.trials.SFG.tOn),1);
            tidx(trls)          = true;
        end
        out.tidx = tidx;
    else
        tidx = ones(size(data.(chan).LFP.SFG.sig,1),1);
    end
else
    tidx = ones(size(data.(chan).LFP.SFG.sig,1),1);
end
tidx = logical(tidx);

% Sound onset
idx     = true(1,size(lfp,1));
ev      = ones(1,size(lfp,1)) * 501;
evBL    = ones(1,size(lfp,1)) * 500;

bl      = LFP_alignTrials(tr, cSig, idx, evBL, 499, 0);
so      = LFP_alignTrials(tr, cSig, idx, ev, 299, 300);

% Response aligned
% Figure onset & response, coh8
idx8        = data.behaviour.resCat == 3 & data.behaviour.coh == 8;
figOn8      = data.behaviour.figOn(idx8)*1000;
rt8         = data.behaviour.RT(idx8)*1000;
evO         = 500+figOn8; % [500ms appended before/after trial]
evR         = 500+figOn8+round(rt8);
pre         = 499;
post        = 500;

fo8         = LFP_alignTrials(tr, cSig, idx8(tidx), evO, pre, post-100);
fr8         = LFP_alignTrials(tr, cSig, idx8(tidx), evR, pre, post);

% Figure onset & response, coh4 + coh12
dd = data.param.fname(1:10);
datestr	= str2num([dd(1:4) dd(6:7) dd(9:10)]);

if datestr - 20190806 > 0
    idx4        = data.behaviour.resCat == 3 & data.behaviour.coh == 4;
    figOn4      = data.behaviour.figOn(idx4)*1000;
    rt4         = data.behaviour.RT(idx4)*1000;
    evO         = 500+figOn4;
    evR         = 500+figOn4+round(rt4);
    pre         = 499;
    post        = 500;
    chArt       = 0;
    
    fo4         = LFP_alignTrials(tr, cSig, idx4(tidx), evO, pre, post-100);
    fr4         = LFP_alignTrials(tr, cSig, idx4(tidx), evR, pre, post);
else
    idx12       = data.behaviour.resCat == 3 & data.behaviour.coh == 12;
    figOn12     = data.behaviour.figOn(idx12)*1000;
    rt12        = data.behaviour.RT(idx12)*1000;
    evO         = 500+figOn12;
    evR         = 500+figOn12+round(rt12);
    pre         = 499;
    post        = 500;
    chArt       = 0;
    
    fo12        = LFP_alignTrials(tr, cSig, idx12(tidx), evO, pre, post-100);
    fr12        = LFP_alignTrials(tr, cSig, idx12(tidx), evR, pre, post);
end

% Misses
% idxMI       = data.behaviour.resCat == 4;
% figOnMI     = data.behaviour.figOn(idxMI)*1000;
% ev          = figOnMI+1500;
% pre         = 499;
% post        = 500;
% chArt       = 0;
%
% rmi         = LFP_alignTrials(tr, cSig, idxMI, ev, pre, post);
%
% % False Alarms
% idxFA       = data.behaviour.resCat == 1 | data.behaviour.resCat == 5;
% rtFA        = data.behaviour.raw(idxFA,end)*1000;
% ev          = 500+round(rtFA);
% pre         = 499;
% post        = 500;
% chArt       = 0;
%
% idxFA(ev < pre) = []; % exclude trials with response < pre
% ev(ev < pre)    = [];
%
% rfa         = LFP_alignTrials(tr, cSig, idxFA, ev, pre, post);

% Correct rejections
idxCR       = data.behaviour.resCat == 6;
figOnCR     = data.behaviour.figOn(idxCR)*1000;
ev          = ones(length(figOnCR),1)*501;
pre         = 0;
post        = 2999;
chArt       = 1;

rcr         = LFP_alignTrials(tr, cSig, idxCR(tidx), ev, pre, post);

out.bl     = bl;
out.so     = so;
out.fo8    = fo8;
out.fr8    = fr8;
if datestr - 20190806 > 0
    out.fr4   = fr4;
    out.fo4   = fo4;
else
    out.fr12   = fr12;
    out.fo12   = fo12;
end
% alig.rmi    = rmi;
% alig.rfa    = rfa;
out.rcr    = rcr;
out.field = data.param.(chan).field;
end
