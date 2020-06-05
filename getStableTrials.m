function [out, outB, out2, out2B] = getStableTrials(data, chan)

idx = data.param.(chan).stTrials;

% SFG trials
if sum(~isnan(idx(1:2))) > 0
    if isnan(idx(2))  
        out.trials.SFG.flag            	= zeros(length(data.trials.SFG.tOn),1);
        out.trials.SFG.flag(idx(1):end) = true;
        
        out.trials.SFG.tOn          = data.trials.SFG.tOn(idx(1):end);
        out.trials.SFG.tEnd         = data.trials.SFG.tEnd(idx(1):end);
        out.trials.SFG.nTrials      = size(out.trials.SFG.tOn,2);
        out.trials.SFG.trialEvents  = data.trials.SFG.trialEvents(idx(1):end);
        out.trials.SFG.trialTS      = data.trials.SFG.trialTS(idx(1):end);
        out.trials.SFG.stimNr       = data.trials.SFG.stimNr(idx(1):end);
        out.trials.SFG.BLon         = data.trials.SFG.BLon(idx(1):end);
        out.trials.SFG.sOn          = data.trials.SFG.sOn(idx(1):end);
        out.trials.SFG.sEnd         = data.trials.SFG.sEnd(idx(1):end);
        
        outB.behaviour.raw          = data.behaviour.raw(idx(1):end,:);
        outB.behaviour.corrResp     = data.behaviour.corrResp(idx(1):end);
        outB.behaviour.resCat       = data.behaviour.resCat(idx(1):end);
        outB.behaviour.RT           = data.behaviour.RT(idx(1):end);
        outB.behaviour.figOn        = data.behaviour.figOn(idx(1):end);
        outB.behaviour.Tmin         = data.behaviour.Tmin(idx(1):end);
        outB.behaviour.Tmax         = data.behaviour.Tmax(idx(1):end);
        outB.behaviour.coh          = data.behaviour.coh(idx(1):end);
        outB.behaviour.stimNrPool  	= data.behaviour.stimNrPool(idx(1):end);
        outB.behaviour.ftrials      = [];
        outB.behaviour.ctrials   	= [];
    else
        trls                        = idx(1):idx(2);
        out.trials.SFG.flag       	= zeros(length(data.trials.SFG.tOn),1);
        out.trials.SFG.flag(trls) 	= true;
        
        out.trials.SFG.tOn          = data.trials.SFG.tOn(trls);
        out.trials.SFG.tEnd         = data.trials.SFG.tEnd(trls);
        out.trials.SFG.nTrials      = idx(2);
        out.trials.SFG.trialEvents  = data.trials.SFG.trialEvents(trls);
        out.trials.SFG.trialTS      = data.trials.SFG.trialTS(trls);
        out.trials.SFG.stimNr       = data.trials.SFG.stimNr(trls);
        out.trials.SFG.BLon         = data.trials.SFG.BLon(trls);
        out.trials.SFG.sOn          = data.trials.SFG.sOn(trls);
        out.trials.SFG.sEnd         = data.trials.SFG.sEnd(trls);

        outB.behaviour.raw          = data.behaviour.raw(trls,:);
        outB.behaviour.corrResp     = data.behaviour.corrResp(trls);
        outB.behaviour.resCat       = data.behaviour.resCat(trls);
        outB.behaviour.RT           = data.behaviour.RT(trls);
        outB.behaviour.figOn        = data.behaviour.figOn(trls);
        outB.behaviour.Tmin         = data.behaviour.Tmin(trls);
        outB.behaviour.Tmax         = data.behaviour.Tmax(trls);
        outB.behaviour.coh          = data.behaviour.coh(trls);
        outB.behaviour.stimNrPool   = data.behaviour.stimNrPool(trls);
        outB.behaviour.ftrials      = [];
        outB.behaviour.ctrials   	= [];
    end
end

% TUN trials
if sum(~isnan(idx(3:4))) > 0
    if isnan(idx(4))
        out.trials.Tun.PT.flag      = zeros(length(data.trials.Tun.PT.sOn),1);
        out.trials.Tun.PT.flag(idx(3):end) = true;
        
        out.trials.Tun.PT.sOn       = data.trials.Tun.PT.sOn(idx(3):end);
        out.trials.Tun.PT.sEnd      = data.trials.Tun.PT.sEnd(idx(3):end);
        out.trials.Tun.PT.sVol      = data.trials.Tun.PT.sVol(idx(3):end);
        outB.behaviour              = data.behaviour;  
    else
        trls = idx(3):idx(4);
        out.trials.Tun.PT.flag      = zeros(length(data.trials.Tun.PT.sOn),1);
        out.trials.Tun.PT.flag(trls)= true;
        
        out.trials.Tun.PT.sOn       = data.trials.Tun.PT.sOn(trls);
        out.trials.Tun.PT.sEnd      = data.trials.Tun.PT.sEnd(trls);
        out.trials.Tun.PT.sVol      = data.trials.Tun.PT.sVol(trls);
        outB.behaviour              = data.behaviour;
    end
end

if isfield(data.param.(chan), 'stTrials2')
    idx = data.param.(chan).stTrials2;

    if sum(~isnan(idx(1:2))) > 0
        if isnan(idx(2))
            out2.trials.SFG.flag                = zeros(length(data.trials.SFG.tOn),1);
            out2.trials.SFG.flag(idx(1):end)	= true;
        
            out2.trials.SFG.tOn          = data.trials.SFG.tOn(idx(1):end);
            out2.trials.SFG.tEnd         = data.trials.SFG.tEnd(idx(1):end);
            out2.trials.SFG.nTrials      = size(out2.trials.SFG.tOn,2);
            out2.trials.SFG.trialEvents  = data.trials.SFG.trialEvents(idx(1):end);
            out2.trials.SFG.trialTS      = data.trials.SFG.trialTS(idx(1):end);
            out2.trials.SFG.stimNr       = data.trials.SFG.stimNr(idx(1):end);
            out2.trials.SFG.BLon         = data.trials.SFG.BLon(idx(1):end);
            out2.trials.SFG.sOn          = data.trials.SFG.sOn(idx(1):end);
            out2.trials.SFG.sEnd         = data.trials.SFG.sEnd(idx(1):end);
            
            out2B.behaviour.raw          = data.behaviour.raw(idx(1):end,:);
            out2B.behaviour.corrResp     = data.behaviour.corrResp(idx(1):end);
            out2B.behaviour.resCat       = data.behaviour.resCat(idx(1):end);
            out2B.behaviour.RT           = data.behaviour.RT(idx(1):end);
            out2B.behaviour.figOn        = data.behaviour.figOn(idx(1):end);
            out2B.behaviour.Tmin         = data.behaviour.Tmin(idx(1):end);
            out2B.behaviour.Tmax         = data.behaviour.Tmax(idx(1):end);
            out2B.behaviour.coh          = data.behaviour.coh(idx(1):end);
            out2B.behaviour.stimNrPool   = data.behaviour.stimNrPool(idx(1):end);
            out2B.behaviour.ftrials      = [];
            out2B.behaviour.ctrials   	 = [];
        else
            trls = idx(1):idx(2);
            out2.trials.SFG.flag      	= zeros(length(data.trials.SFG.tOn),1);
            out2.trials.SFG.flag(trls) 	= true;
            
            out2.trials.SFG.tOn         = data.trials.SFG.tOn(trls);
            out2.trials.SFG.tEnd        = data.trials.SFG.tEnd(trls);
            out2.trials.SFG.nTrials     = idx(2);
            out2.trials.SFG.trialEvents = data.trials.SFG.trialEvents(trls);
            out2.trials.SFG.trialTS     = data.trials.SFG.trialTS(trls);
            out2.trials.SFG.stimNr      = data.trials.SFG.stimNr(trls);
            out2.trials.SFG.BLon        = data.trials.SFG.BLon(trls);
            out2.trials.SFG.sOn         = data.trials.SFG.sOn(trls);
            out2.trials.SFG.sEnd        = data.trials.SFG.sEnd(trls);
            
            out2B.behaviour.raw          = data.behaviour.raw(trls,:);
            out2B.behaviour.corrResp     = data.behaviour.corrResp(trls);
            out2B.behaviour.resCat       = data.behaviour.resCat(trls);
            out2B.behaviour.RT           = data.behaviour.RT(trls);
            out2B.behaviour.figOn        = data.behaviour.figOn(trls);
            out2B.behaviour.Tmin         = data.behaviour.Tmin(trls);
            out2B.behaviour.Tmax         = data.behaviour.Tmax(trls);
            out2B.behaviour.coh          = data.behaviour.coh(trls);
            out2B.behaviour.stimNrPool   = data.behaviour.stimNrPool(trls);
            out2B.behaviour.ftrials      = [];
            out2B.behaviour.ctrials   	 = [];
        end
    end
else
    out2 = [];
    out2B = [];
end

end