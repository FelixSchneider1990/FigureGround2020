function [trl, cond] = FigOn2Resp(data, chan, clus)

if nargin < 3
    mat     = data.(chan).MUAe.SFG.sig;                                     % Full trials [500ms BL, 3000ms sound, 500ms silence]
else
    mat     = data.(chan).Spks.(clus).SFG.psth;                           	% Full trials [500ms BL, 3000ms sound, 500ms silence]
end

if isfield(data.param.(chan), 'stTrials')
    if sum(~isnan(data.param.(chan).stTrials(1:2))) > 0
        [~,b] = getStableTrials(data, chan);
        on      = (b.behaviour.figOn*1000) + 500;                                % Figure onset times [ms from soundOn]
        res     = round((b.behaviour.figOn+b.behaviour.RT)*1000) + 500;    	% Reaction times [ms from figOn]
        hi      = b.behaviour.resCat == 3;                                       % Index: hit trials [figure]
        cr      = b.behaviour.resCat == 6;                                       % Index: correct rejection [no figure]
        coh     = b.behaviour.coh;                                               % Coherence level
        sID     = b.behaviour.stimNrPool;
    else
        on      = (data.behaviour.figOn*1000) + 500;                                % Figure onset times [ms from soundOn]
        res     = round((data.behaviour.figOn+data.behaviour.RT)*1000) + 500;    	% Reaction times [ms from figOn]
        hi      = data.behaviour.resCat == 3;                                       % Index: hit trials [figure]
        cr      = data.behaviour.resCat == 6;                                       % Index: correct rejection [no figure]
        coh     = data.behaviour.coh;                                               % Coherence level
        sID     = data.behaviour.stimNrPool;
    end
else
    on      = (data.behaviour.figOn*1000) + 500;                                % Figure onset times [ms from soundOn]
    res     = round((data.behaviour.figOn+data.behaviour.RT)*1000) + 500;    	% Reaction times [ms from figOn]
    hi      = data.behaviour.resCat == 3;                                       % Index: hit trials [figure]
    cr      = data.behaviour.resCat == 6;                                       % Index: correct rejection [no figure]
    coh     = data.behaviour.coh;                                               % Coherence level
    sID     = data.behaviour.stimNrPool;
end

trl     = cell(1,size(hi,1));
for i = 1:size(hi,1)
    if res(i) >= 999e3
        vec     = 1001:50:2501;
        n       = vec(randi(length(vec)));                                	% Randomly select timepoint for control alignment
        trl{i}  = mat(i,n:n+999);                                           % 1000ms control sample
    else            
        trl{i}  = mat(i,on(i)-200:res(i)+200);                             	% [FigOn-200:Response+200]
    end
end

cnt     = 0;
cnt1    = 0;
cnt2    = 0;
cnt3    = 0;

for ii = 1:length(trl)
    
    if res(ii)-on(ii) < 400
        continue
    end
    
    if hi(ii) && coh(ii) == 8
        cnt                 = cnt+1;
        cond.o8(cnt,:)      = trl{ii}(1:700);
        cond.r8(cnt,:)      = trl{ii}(end-699:end);
        cond.sNo8(cnt,:)    = sID(ii);
    elseif hi(ii) && coh(ii) == 12
        cnt1                = cnt1+1;
        cond.o12(cnt1,:)	= trl{ii}(1:700);
        cond.r12(cnt1,:)    = trl{ii}(end-699:end);
        cond.sNo12(cnt1,:)   = sID(ii);
    elseif hi(ii) && coh(ii) == 4
        cnt2                = cnt2+1;
        cond.o4(cnt2,:)	= trl{ii}(1:700);
        cond.r4(cnt2,:)    = trl{ii}(end-699:end);
        cond.sNo4(cnt2,:)  = sID(ii);
    elseif cr(ii)
        cnt3                = cnt3+1;
        cond.cc(cnt3,:)     = trl{ii};
        cond.sNoC(cnt3,:)   = sID(ii);
    end
end

% plot(nanmean(o12))
% hold on
% plot(nanmean(o8))
% plot(nanmean(cc(:,201:800)))
% 
% plot(nanmean(r12))
% hold on
% plot(nanmean(r8))
% plot(nanmean(cc(:,201:800)))

end