function out = TRL_align2event(data, trl, b)

if size(trl,1) < 200
    out = [];
    return
end

stID        = data.behaviour.stimID;

if isempty(b)
    s       = data.behaviour.stimNrPool;
    on      = data.behaviour.figOn*1000+500;
    res     = round(data.behaviour.RT*1000);
    cat     = data.behaviour.resCat;
    coh  	= data.behaviour.coh;
    clock   = round(data.behaviour.raw(:,end)*1000);
else
    s       = b.behaviour.stimNrPool;
    on  	= b.behaviour.figOn*1000+500;
    res  	= round(b.behaviour.RT*1000);
    cat  	= b.behaviour.resCat;
    coh  	= b.behaviour.coh;
    clock 	= round(b.behaviour.raw(:,end)*1000);
end

%% Trial-wise

for iTr = 1:size(s,1)
    
    if res(iTr) >= 999e3 && cat(iTr) == 6
        vec                 = unique(on(cat<5));                            % Select alignment based on figure onset distribution
        ev                  = vec(randi(length(vec)));                      % Randomly select timepoint for control alignment
    elseif res(iTr) >= 999e3 && cat(iTr) ~= 6
        ev                  = clock(iTr);
        if  ev < 1000                                                       % StimOn @ 500 -> first possible figure onset @ +300ms (=800) -> first possible valid response @ +200ms (=1000)
            out.on.trlOn(iTr,:) 	= nan(1,600);
            out.res.trlRes(iTr,:)   = nan(1,800);
            continue
        end
    else
        ev                  = on(iTr)+res(iTr);
    end
    
    out.on.trlOn(iTr,:)     = trl(iTr,on(iTr)-199:on(iTr)+400);             % Event @ 200
    out.on.cat(iTr,:)       = cat(iTr);                                     % Hit or error trial
    out.on.coh(iTr,:)       = coh(iTr);                                     % coherence
    out.res.trlRes(iTr,:)	= trl(iTr,ev-500:ev+299);                       % Event @ 300  
end

%% Stimulus-wise: Onset aligned

for iSt = 1:length(stID)
    if iSt <=12
        idx         = stID(iSt) == s & cat == 3;
    else
        idx         = stID(iSt) == s & cat == 6;
    end
    reps            = [];
    reps        	= trl(idx,:);
    
    if size(reps,1) < 5
        avg(iSt,:)      = nan(1,4000);
    else
        avg(iSt,:)      = nanmean(reps);
    end
    
    vec                 = unique(on(cat<5));                                % Select alignment based on figure onset distribution
    for fO = 1:size(reps,1)
        fOns(fO,:)       = vec(randi(length(vec)));
    end
    
    if isempty(b)  
        fOn     	= unique(data.behaviour.figOn(idx));                    % Stimulus specific figure onset
    else
        fOn         = unique(b.behaviour.figOn(idx));                     % Stimulus specific figure onset
    end
    fOn           	= (500+fOn*1000);
    
    if isempty(fOn) || size(trl(idx,:),1) < 5                               % If no/too few included trials...
        tar(iSt,:)	= nan(1,1400);                                          % Extract figure [-200:Figure:+200]
        trTar{iSt}	= [];                                                   % Aligned single trials
        nTr(iSt)  	= 0;                                                	% No of valid trials
        continue
    end
    
    tar(iSt,:)      = avg(iSt,fOn-199:fOn+1200);                            % Extract figure [-200:Figure:+200]
    trTar{iSt}      = reps(:,fOns-199:fOns+1200);                             % Aligned single trials
    nTr(iSt)        = sum(stID(iSt) == s);                                  % No of valid trials
    nTrHI(iSt)      = sum(~isnan(nanmean(reps,2)));                         % No of valid hit trials
end

out.on.fullAvg 	= avg;
out.on.tarAvg  	= tar;
out.on.trTar  	= trTar;

%% Stimulus-wise: Target response aligned

if isempty(b)
    figOn           = (data.behaviour.figOn*1000)+500;
    RT              = round(data.behaviour.RT*1000);
    clock           = round(data.behaviour.raw(:,end)*1000)+500;
    d               = data.param.fname;                             % Folder name
    if str2num([d(1:4) d(6:7) d(9:10)]) - 20190806 > 0
        HI1idx         = data.behaviour.resCat == 3 & data.behaviour.coh == 8;
        HI2idx          = data.behaviour.resCat == 3 & data.behaviour.coh == 4;
    else
        HI1idx         = data.behaviour.resCat == 3 & data.behaviour.coh == 12;
        HI2idx          = data.behaviour.resCat == 3 & data.behaviour.coh == 8;
    end
    MIidx           = data.behaviour.resCat == 4;
    FAidx           = data.behaviour.resCat == 1 | data.behaviour.resCat == 5;
    CRidx           = data.behaviour.resCat == 6;
    stimNo          = data.behaviour.stimNrPool;
else
    figOn           = (b.behaviour.figOn*1000)+500;
    RT              = round(b.behaviour.RT*1000);
    clock           = round(b.behaviour.raw(:,end)*1000)+500;
    d               = data.param.fname;                             % Folder name
    if str2num([d(1:4) d(6:7) d(9:10)]) - 20190806 > 0
        HI1idx         = b.behaviour.resCat == 3 & b.behaviour.coh == 8;
        HI2idx          = b.behaviour.resCat == 3 & b.behaviour.coh == 4;
    else
        HI1idx         = b.behaviour.resCat == 3 & b.behaviour.coh == 12;
        HI2idx          = b.behaviour.resCat == 3 & b.behaviour.coh == 8;
    end
    MIidx           = b.behaviour.resCat == 4;
    FAidx           = b.behaviour.resCat == 1 | b.behaviour.resCat == 5;
    CRidx           = b.behaviour.resCat == 6;
    stimNo          = b.behaviour.stimNrPool;
end

vec                 = unique(on(cat<5));                                % Select alignment based on figure onset distribution
for fO = 1:sum(CRidx)
    fOns(fO,:)       = vec(randi(length(vec)));
end
figOn(CRidx) = fOns;

% Stim-specific RT
for iSt = 1:length(stID)
    idx         = stID(iSt) == s;
    stRT        = RT(idx);
    stimRT(iSt) = round(mean(stRT(stRT ~= 999e3)));
end

% Exclude trials with RT < 400ms
if size(trl,1) ~= size(RT,1)
    if size(trl,1) > size(RT,1)
        trl     = trl(1:size(RT,1),:);
    elseif size(trl,1) < size(RT,1)
        RT      = RT(1:size(trl,1),:);
    end
end

trl(RT<400,:)       = [];
figOn(RT<400,:)     = [];
clock(RT<400,:)     = [];
HI1idx(RT<400,:)    = [];
HI2idx(RT<400,:)    = [];
FAidx(RT<400,:)     = [];
MIidx(RT<400,:)     = [];
CRidx(RT<400,:)     = [];
stimNo(RT<400,:)    = [];
RT(RT<400,:)        = [];

% Define event timestamps and window
pre                 = 500;
post                = 299;
ev                  = figOn+RT;
ev(FAidx)           = clock(FAidx);                                                         % Time of false alarm response
ev(MIidx)           = figOn(MIidx)+1000;                                                    % End of figure                                                  

% Get aligned data
[out.res.HI12, out.res.sNo12]	= TRL_alignTrials(trl, HI1idx, ev, pre, post, stimNo);      % Response aligned hit trials with figure coherence 12
[out.res.HI8, out.res.sNo8]   	= TRL_alignTrials(trl, HI2idx, ev, pre, post, stimNo);      % Response aligned hit trials with figure coherence 8
[out.res.CR, out.res.sNoCR]  	= TRL_alignTrials(trl, CRidx, ev, pre, post, stimNo);       % Centre section of control stimulus
[out.res.FA, out.res.sNoFA]  	= TRL_alignTrials(trl, FAidx, ev, pre, post, stimNo);       % Centre section of control stimulus
[out.res.MI, out.res.sNoMI]    	= TRL_alignTrials(trl, MIidx, ev, pre, post, stimNo);       % Centre section of control stimulus
out.nTr                       	= nTr;                                                      % No of valid trials
out.nTrHI                     	= nTrHI;                                                    % No of valid hit trials
out.stimRT                    	= stimRT;                                                   % Mean reaction time for each stimulus

end