function out = RTsplit(data, chan, clus, plotFlag)

if nargin < 4
    plotFlag = false;
end

if isempty(data.(chan).MUAe.SFG.alig)
    out = [];
    return
end

if exist('clus','var') == 0   
    trlOn       = data.(chan).MUAe.SFG.alig.on.trlOn;                       % Onset-aligned trials
    trlRes      = data.(chan).MUAe.SFG.alig.res.trlRes;
else
    trlOn       = data.(chan).Spks.(clus).SFG.alig.on.trlOn;             	% Onset-aligned trials
    trlRes      = data.(chan).Spks.(clus).SFG.alig.res.trlRes;          	% Response-aligned trials
end
cat         = data.behaviour.resCat;                                        % Response category
rt          = data.behaviour.RT;                                            % Trial-wise reactiont time

if size(cat,1) ~= size(trlOn,1)
    cat = cat(1:size(trlOn,1));
    rt = rt(1:size(trlOn,1));
end

hiOn     	= trlOn(cat == 3,:);                                            % Get hit trials only
hiRes   	= trlRes(cat == 3,:);
RT          = rt(cat == 3,:);
med      	= median(RT);                                                   % Median split of reaction times

fast_ON 	= hiOn(RT<med,:);
slow_ON   	= hiOn(RT>=med,:);
fast_RES 	= hiRes(RT<med,:);
slow_RES   	= hiRes(RT>=med,:);

fON        	= mean(fast_ON(:,401:600),2);                                   % Compare firing rates between conditions
sON        	= mean(slow_ON(:,401:600),2);
condF       = repmat('fast',length(fON),1);
condS       = repmat('slow',length(sON),1);
[pON, tbl, stat] = anova1([fON; sON]', cellstr(vertcat(condF, condS)), 'off');

fRES     	= mean(fast_RES(:,1:200),2);
sRES       	= mean(slow_RES(:,1:200),2);
condF       = repmat('fast',length(fRES),1);
condS       = repmat('slow',length(sRES),1);
[pRES, tbl, stat] = anova1([fRES; sRES]', cellstr(vertcat(condF, condS)), 'off');

out         = [pON mean(sON)>mean(fON); pRES mean(sRES)>mean(fRES)];        % Returns ANOVA-p and index

if plotFlag
    subplot(2,1,1)
    plot(nanmean(fast_ON));
    hold on
    plot(nanmean(slow_ON))
    vline(200)
    subplot(2,1,2)
    plot(nanmean(fast_RES));
    hold on
    plot(nanmean(slow_RES))
    vline(300)
end

end