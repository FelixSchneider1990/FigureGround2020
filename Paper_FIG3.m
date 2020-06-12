%%% FIGURE_GROUND EPHYS PAPER %%%
%%% FELIX SCHNEIDER, 02/2020 %%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FIG 3 %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load('Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\Eric\Summary\muae.mat')
% muaeE = muae;
% load('Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\Dollar\Summary\muae.mat')
% muaeD = muae;
% clear muae

typ         = 'muae';
dest_dir    = 'X:\Felix\Documents\Publications\FigGnd_Ephys\Figures\';
indx        = 401:600; % corresponds to 201-400ms after onset
indxR       = 201:400; % corresponds to -300 - -100ms prior decision (HI) / End of figure (MI)
alph        = .01;
nMI         = 20;

for iAn = 1:2
    
    antM = []; posM = [];
    
    if iAn == 1
        animalID = 'Eric';
        load([dest_dir 'raw\tMap_' animalID '_' typ  '.mat']);
        AP      = find(logical(sum(~isnan(mfr_mat),2)));
        ML      = find(logical(sum(~isnan(mfr_mat))));
        [x,y] = coreBoundary(mfr_mat,AP,ML,false,animalID);
        [antM, posM] = sortUnits(x,y,muaeE);
        
    elseif iAn == 2
        animalID = 'Dollar';
        load([dest_dir 'raw\tMap_' animalID '_' typ  '.mat']);
        AP      = find(logical(sum(~isnan(mfr_mat),2)));
        ML      = find(logical(sum(~isnan(mfr_mat))));
        [x,y] = coreBoundary(mfr_mat,AP,ML,false,animalID);
        [antM, posM] = sortUnits(x,y,muaeD);
    end
    
    for iFi = 1:2
        
        if iFi == 1
            d = antM;
            str = 'ant';
        else
            d = posM;
            str = 'pos';
        end
        
        c = 0; dFGo = [];dFGd = []; dCOHo = []; dCOHd = []; dHMo = []; dHMd = []; dMCo = []; dMCd = []; in = [];
        aucFo = []; aucCo = []; aucHMo = []; audMCo = []; aucFd = []; aucCd = []; aucHMd = []; audMCd = [];
        
        for ii = 1:size(d,2)
            datestr         = str2num([d{ii}.id(1:4) d{ii}.id(6:7) d{ii}.id(9:10)]);
            incl(ii)        = check20Hz(d{ii});
            if length(d{ii}.BLslope) < 200 || incl(ii) == 0 || sum(d{ii}.nTr>=10) ~= length(d{ii}.nTr) || datestr - 20190806 >= 0 || numel(find(sum(~isnan(d{ii}.on.trlOn),2)))< 200
                in(ii)      = false;
                dFGo(ii) 	= nan;
                dFGd(ii)    = nan;
                dCOHo(ii) 	= nan;
                dCOHd(ii)   = nan;
                dHMo(ii)    = nan;
                dHMd(ii)    = nan;
                dMCo(ii)    = nan;
                dMCd(ii)    = nan;
                 
                aucFo(ii)  	= nan;
                aucCo(ii) 	= nan;
                aucHMo(ii) 	= nan;
                aucMCo(ii) 	= nan;
                aucFd(ii)  	= nan;
                aucCd(ii)  	= nan;
                aucHMd(ii) 	= nan;
                aucMCd(ii) 	= nan;
                continue
            end
              
            datestr     = str2num([d{ii}.id(1:4) d{ii}.id(6:7) d{ii}.id(9:10)]);
            test        = mean([d{ii}.res.HI12(:,indxR); d{ii}.res.HI8(:,indxR)],2);
            ctrl        = mean(d{ii}.res.CR(:,indxR),2);
            pp          = anova1([test; ctrl],[zeros(size(test,1),1);ones(size(ctrl,1),1)], 'off');
%             [h,pp]= ttest2(test,ctrl)

            if pp < alph
                in(ii)  = true;
            else
                in(ii)  = false;
            end
            
            clear FIGo FIGd HIo8 HId8 HIo12 HId12 CRo CRd MIo MId mBL
            mBL         = nanmean(nanmean(d{ii}.on.fullAvg(:,101:500),2));        	% Average BL response   
            
            FIGo     	= d{ii}.on.trlOn(d{ii}.on.cat == 3 | d{ii}.on.cat == 4,indx) ./mBL;
            HIo8      	= d{ii}.on.trlOn(d{ii}.on.cat == 3 & d{ii}.on.coh == 8,indx) ./mBL;
            HIo12    	= d{ii}.on.trlOn(d{ii}.on.cat == 3 & d{ii}.on.coh == 12,indx) ./mBL;
            CRo        	= d{ii}.on.trlOn(d{ii}.on.cat == 6,indx) ./mBL;
            
            if sum(d{ii}.on.cat == 4) >= nMI
                MIo    	= d{ii}.on.trlOn(d{ii}.on.cat == 4,indx) ./mBL;
            else
                MIo  	= nan(2,200);
            end
            
            HId8      	= d{ii}.res.HI8(:,indxR) ./mBL; % Response aligned trials
            HId12    	= d{ii}.res.HI12(:,indxR) ./mBL;
            CRd       	= d{ii}.res.CR(:,indxR) ./mBL;
            
            if size(d{ii}.res.MI,1) >= nMI
                MId   	= (d{ii}.res.MI(:,indxR)) ./mBL;
            else
                MId   	= nan(2,200);
            end
            FIGd     	= [HId12; HId8; MId];
            
            %%% dAB = (mA–mB)/s, where mA and mB are the mean responses in stimulus
            %%% conditions A and B, and s is the pooled standard deviation.
            %%% Poort et al. (2016) Cereb Cortex
            dFGo(ii)   	= mean((nanmean(FIGo) - nanmean(CRo)) ./ nanstd([FIGo; CRo]));
            dFGd(ii)   	= mean((nanmean(FIGd) - nanmean(CRd)) ./ nanstd([FIGd; CRd]));
            
            dCOHo(ii)  	= mean((nanmean(HIo12) - nanmean(HIo8)) ./ nanstd([HIo8; HIo12]));
            dCOHd(ii)   = mean((nanmean(HId12) - nanmean(HId8)) ./ nanstd([HId8; HId12]));
            
            dHMo(ii)   	= mean((nanmean([HIo8; HIo12]) - nanmean(MIo)) ./ nanstd([HIo8; HIo12; MIo]));
            dHMd(ii)   	= mean((nanmean([HId8; HId12]) - nanmean(MId)) ./ nanstd([HId8; HId12; MId]));
            
            dMCo(ii)    = mean((nanmean(MIo) - nanmean(CRo)) ./ nanstd([MIo; CRo]));
            dMCd(ii)  	= mean((nanmean(MId) - nanmean(CRd)) ./ nanstd([MId; CRd]));
            
            %%% AUROC %%%
            aucFo(ii) 	= f_auroc(mean(CRo,2),mean(FIGo,2));
            aucMCo(ii)	= f_auroc(mean(CRo,2),mean(MIo,2));
            aucHMo(ii) 	= f_auroc(mean(MIo,2),mean([HIo8;HIo12],2));
            aucCo(ii)  	= f_auroc(mean(HIo8,2),mean(HIo12,2));
                            
            aucFd(ii) 	= f_auroc(mean(CRd,2),mean(FIGd,2));
            aucMCd(ii) 	= f_auroc(mean(CRd,2),mean(MId,2));
            aucHMd(ii)	= f_auroc(mean(MId,2),mean([HId8;HId12],2));
            aucCd(ii)  	= f_auroc(mean(HId8,2),mean(HId12,2));
        end
        
        IN{iAn,iFi}     = logical(in);
        FGo{iAn,iFi}    = dFGo;
        FGd{iAn,iFi}    = dFGd;
        COHo{iAn,iFi}   = dCOHo;
        COHd{iAn,iFi}   = dCOHd;
        HMo{iAn,iFi}   	= dHMo;
        HMd{iAn,iFi}    = dHMd;
        MCo{iAn,iFi}    = dMCo;
        MCd{iAn,iFi}    = dMCd;
        
        AUCFD{iAn,iFi}	= aucFd;
        AUCFO{iAn,iFi} 	= aucFo;
        AUCC{iAn,iFi}   = aucCo;
        AUCCD{iAn,iFi} 	= aucCd;
        AUCHM{iAn,iFi} 	= aucHMo;
        AUCMC{iAn,iFi}  = aucMCo;
        AUCHMD{iAn,iFi}	= aucHMd;
        AUCMCD{iAn,iFi} = aucMCd;
        
        pFd(iAn,iFi) 	= signrank(FGd{iAn,iFi}(IN{iAn,iFi}));
        pF(iAn,iFi)    	= signrank(FGo{iAn,iFi}(IN{iAn,iFi}));
        pC(iAn,iFi)    	= signrank(COHo{iAn,iFi}(IN{iAn,iFi}));
        pCd(iAn,iFi)  	= signrank(COHd{iAn,iFi}(IN{iAn,iFi}));
        pHM(iAn,iFi)   	= signrank(HMo{iAn,iFi}(IN{iAn,iFi}));
        pHMd(iAn,iFi) 	= signrank(HMd{iAn,iFi}(IN{iAn,iFi}));
        pMC(iAn,iFi)   	= signrank(MCo{iAn,iFi}(IN{iAn,iFi}));
        pMCd(iAn,iFi)  	= signrank(MCd{iAn,iFi}(IN{iAn,iFi}));
        
        npFd(iAn,iFi)  	= signrank(FGd{iAn,iFi}(~IN{iAn,iFi}));
        npF(iAn,iFi)   	= signrank(FGo{iAn,iFi}(~IN{iAn,iFi}));
        npC(iAn,iFi)   	= signrank(COHo{iAn,iFi}(~IN{iAn,iFi}));
        npCd(iAn,iFi)  	= signrank(COHd{iAn,iFi}(~IN{iAn,iFi}));
        npHM(iAn,iFi)  	= signrank(HMo{iAn,iFi}(~IN{iAn,iFi}));
        npHMd(iAn,iFi) 	= signrank(HMd{iAn,iFi}(~IN{iAn,iFi}));
        npMC(iAn,iFi) 	= signrank(MCo{iAn,iFi}(~IN{iAn,iFi}));
        npMCd(iAn,iFi) 	= signrank(MCd{iAn,iFi}(~IN{iAn,iFi}));
    end
end

pFd    	= fdrP([pFd(1,:), pFd(2,:)]);
pF    	= fdrP([pF(1,:), pF(2,:)]);
pC      = fdrP([pC(1,:), pC(2,:)]);
pCd     = fdrP([pCd(1,:), pCd(2,:)]);
pHM     = fdrP([pHM(1,:), pHM(2,:)]);
pHMd    = fdrP([pHMd(1,:), pHMd(2,:)]);
pMC     = fdrP([pMC(1,:), pMC(2,:)]);
pMCd    = fdrP([pMCd(1,:), pMCd(2,:)]);

npFd    = fdrP([npFd(1,:), npFd(2,:)]);
npF     = fdrP([npF(1,:), npF(2,:)]);
npC     = fdrP([npC(1,:), npC(2,:)]);
npCd    = fdrP([npCd(1,:), npCd(2,:)]);
npHM    = fdrP([npHM(1,:), npHM(2,:)]);
npHMd   = fdrP([npHMd(1,:), npHMd(2,:)]);
npMC    = fdrP([npMC(1,:), npMC(2,:)]);
npMCd   = fdrP([npMCd(1,:), npMCd(2,:)]);

f           = figure('Units', 'normalized', 'Position', [0 0 1 1]); axis off
set(gcf,'color', [1 1 1]);

cm          = [[0 0 .9]; [0 .9 0]; [.9 0 0]];
alp         = .7;
clm         = linspace(.1, .79, 4);
row         = fliplr(linspace(.05, .86, 8));
dim         = [.2 .1];
txtsz       = 14;
xax         = [-.5 .75];

%%% PLOT %%%
for iAn = 1:2
    for iFi = 1:2
        bin         = linspace(-1, 1,50);
        inclIdx     = IN{iAn,iFi};    % Only sound-responsive units with sign. FGM
        
        %%% COLUMN 1: Fig vs Ctr
        if iAn == 1 && iFi == 1
            axO     = axes('Position',[clm(1) row(1) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axO     = axes('Position',[clm(1) row(3) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axO     = axes('Position',[clm(1) row(5) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axO     = axes('Position',[clm(1) row(7) dim]); hold on
        end
        
        vec1                = FGo{iAn,iFi}(~inclIdx);
        vec2                = FGo{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        axO.XLim            = xax;

        line([0 0],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axO.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axO.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npF, iAn, iFi, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pF, iAn, iFi, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1 && iFi == 1
            lg = legend('n.s.','p < .01', 'Location','Northwest');
            lg.FontSize = 8;
            legend boxoff
        end
        
        if iAn == 1 && iFi == 1
            axD     = axes('Position',[clm(1) row(2) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axD     = axes('Position',[clm(1) row(4) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axD     = axes('Position',[clm(1) row(6) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axD     = axes('Position',[clm(1) row(8) dim]); hold on
        end
        
        vec1                = FGd{iAn,iFi}(~inclIdx);
        vec2                = FGd{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+(2*Yof)];
        axD.XLim            = xax;

        line([0 0],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npFd, iAn, iFi, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pFd, iAn, iFi, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2 && iFi == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [-1 -.5 0 .5 1];
            axD.XLabel.String = 'd-prime';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end
        
        %%% COLUMN 2: Coherence
        if iAn == 1 && iFi == 1
            axO     = axes('Position',[clm(2) row(1) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axO     = axes('Position',[clm(2) row(3) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axO     = axes('Position',[clm(2) row(5) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axO     = axes('Position',[clm(2) row(7) dim]); hold on
        end
        
        vec1                = COHo{iAn,iFi}(~inclIdx);
        vec2                = COHo{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        axO.XLim            = xax;
        
        line([0 0],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-.5/50 nanmean(vec1) nanmean(vec1)+.5/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-.5/50 nanmean(vec2) nanmean(vec2)+.5/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npC, iAn, iFi, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pC, iAn, iFi, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1 && iFi == 1
            axD     = axes('Position',[clm(2) row(2) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axD     = axes('Position',[clm(2) row(4) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axD     = axes('Position',[clm(2) row(6) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axD     = axes('Position',[clm(2) row(8) dim]); hold on
        end
        
        vec1                = COHd{iAn,iFi}(~inclIdx);
        vec2                = COHd{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+Yof];
        axD.XLim            = xax;
        
        line([0 0],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-.5/50 nanmean(vec1) nanmean(vec1)+.5/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-.5/50 nanmean(vec2) nanmean(vec2)+.5/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npCd, iAn, iFi, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pCd, iAn, iFi, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2 && iFi == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [-1 -.5 0 .5 1];
            axD.XLabel.String = 'd-prime';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end
        
        %%% COLUMN 3: HI vs MI
        if iAn == 1 && iFi == 1
            axO     = axes('Position',[clm(3) row(1) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axO     = axes('Position',[clm(3) row(3) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axO     = axes('Position',[clm(3) row(5) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axO     = axes('Position',[clm(3) row(7) dim]); hold on
        end
        
        vec1                = HMo{iAn,iFi}(~inclIdx);
        vec2                = HMo{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        axO.XLim            = xax;

        line([0 0],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axO.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axO.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npHM, iAn, iFi, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pHM, iAn, iFi, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1 && iFi == 1
            axD     = axes('Position',[clm(3) row(2) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axD     = axes('Position',[clm(3) row(4) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axD     = axes('Position',[clm(3) row(6) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axD     = axes('Position',[clm(3) row(8) dim]); hold on
        end
        
        vec1                = HMd{iAn,iFi}(~inclIdx);
        vec2                = HMd{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+(2*Yof)];
        axD.XLim            = xax;

        line([0 0],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npHMd, iAn, iFi, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pHMd, iAn, iFi, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2 && iFi == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [-1 -.5 0 .5 1];
            axD.XLabel.String = 'd-prime';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end
        
        %%% COLUMN 4: MI vs CR
        if iAn == 1 && iFi == 1
            axO     = axes('Position',[clm(4) row(1) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axO     = axes('Position',[clm(4) row(3) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axO     = axes('Position',[clm(4) row(5) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axO     = axes('Position',[clm(4) row(7) dim]); hold on
        end
        
        vec1                = MCo{iAn,iFi}(~inclIdx);
        vec2                = MCo{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        axO.XLim            = xax;

        line([0 0],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axO.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axO.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npMC, iAn, iFi, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pMC, iAn, iFi, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1 && iFi == 1
            axD     = axes('Position',[clm(4) row(2) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axD     = axes('Position',[clm(4) row(4) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axD     = axes('Position',[clm(4) row(6) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axD     = axes('Position',[clm(4) row(8) dim]); hold on
        end
        
        vec1                = MCd{iAn,iFi}(~inclIdx);
        vec2                = MCd{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+(2*Yof)];
        axD.XLim            = xax;

        line([0 0],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npMCd, iAn, iFi, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pMCd, iAn, iFi, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2 && iFi == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [-1 -.5 0 .5 1];
            axD.XLabel.String = 'd-prime';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end
    end
end

of = .05;
ax0 = axes('Position',[0 0 1 1],'Visible','off');
text(clm(1)-of,.99, 'a', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(clm(2)-of,.99, 'b', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(clm(3)-of,.99, 'c', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(clm(4)-of,.99, 'd', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')

annotation('line',[.05 .05],[row(1)+.1-.03 row(2)+.03], 'LineWidth', 2, 'Color', 'k')
annotation('line',[.05 .05],[row(3)+.1-.03 row(4)+.03], 'LineWidth', 2, 'Color', 'k')
annotation('line',[.05 .05],[row(5)+.1-.03 row(6)+.03], 'LineWidth', 2, 'Color', 'k')
annotation('line',[.05 .05],[row(7)+.1-.03 row(8)+.03], 'LineWidth', 2, 'Color', 'k')
text(.035,row(2)+.09, 'ANT', 'Parent', ax0, 'FontSize', 14, 'Color', 'k','Rotation',90)
text(.035,row(4)+.09, 'POS', 'Parent', ax0, 'FontSize', 14, 'Color', 'k','Rotation',90)
text(.02,row(3)+.09, 'M1', 'Parent', ax0, 'FontSize', 20, 'Color', 'k', 'FontWeight', 'bold','Rotation',90)
text(.035,row(6)+.09, 'ANT', 'Parent', ax0, 'FontSize', 14, 'Color', 'k','Rotation',90)
text(.035,row(8)+.09, 'POS', 'Parent', ax0, 'FontSize', 14, 'Color', 'k','Rotation',90)
text(.02,row(7)+.09, 'M2', 'Parent', ax0, 'FontSize', 20, 'Color', 'k', 'FontWeight', 'bold','Rotation',90)

text(clm(1)+of, .985, 'Fig vs Ctr', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')
text(clm(2)+.025, .985, 'Coh8 vs Coh12', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')
text(clm(3)+of, .985, 'HI vs MI', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')
text(clm(4)+of, .985, 'MI vs CR', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')

addpath X:\Felix\Scripts\Stuff\export_fig-master
dest_dir = 'X:\Felix\Documents\Publications\FigGnd_Ephys\Figures\';
export_fig([dest_dir 'FIG5_dprime'], '-r400',f);

%%% POOL AC %%%
for iAn = 1:2
    allIN{iAn}              = [IN{iAn,1} IN{iAn,2}];
    allFD{iAn}              = [FGd{iAn,1} FGd{iAn,2}];
    allFO{iAn}              = [FGo{iAn,1} FGo{iAn,2}];
    allC{iAn}               = [COHo{iAn,1} COHo{iAn,2}];
    allCD{iAn}              = [COHd{iAn,1} COHd{iAn,2}];
    allHM{iAn}              = [HMo{iAn,1} HMo{iAn,2}];
    allMC{iAn}              = [MCo{iAn,1} MCo{iAn,2}];
    allHMD{iAn}             = [HMd{iAn,1} HMd{iAn,2}];
    allMCD{iAn}             = [MCd{iAn,1} MCd{iAn,2}];
    
    inclIdx                 = allIN{iAn};    % Only sound-responsive units with sign. FGM
    PFd(iAn)                = signrank(allFD{iAn}(inclIdx));
    PF(iAn)                 = signrank(allFO{iAn}(inclIdx));
    PC(iAn)                 = signrank(allC{iAn}(inclIdx));
    PCd(iAn)                = signrank(allCD{iAn}(inclIdx));
    PHM(iAn)                = signrank(allHM{iAn}(inclIdx));
    PHMd(iAn)               = signrank(allHMD{iAn}(inclIdx));
    PMC(iAn)                = signrank(allMC{iAn}(inclIdx));
    PMCd(iAn)               = signrank(allMCD{iAn}(inclIdx));
    
    nPFd(iAn)               = signrank(allFD{iAn}(~inclIdx));
    nPF(iAn)                = signrank(allFO{iAn}(~inclIdx));
    nPC(iAn)                = signrank(allC{iAn}(~inclIdx));
    nPCd(iAn)               = signrank(allCD{iAn}(~inclIdx));
    nPHM(iAn)               = signrank(allHM{iAn}(~inclIdx));
    nPHMd(iAn)              = signrank(allHMD{iAn}(~inclIdx));
    nPMC(iAn)               = signrank(allMC{iAn}(~inclIdx));
    nPMCd(iAn)              = signrank(allMCD{iAn}(~inclIdx));
end

PFd    	= fdr(PFd);
PF    	= fdr(PF);
PC      = fdr(PC);
PCd     = fdr(PCd);
PHM     = fdr(PHM);
PHMd    = fdr(PHMd);
PMC     = fdr(PMC);
PMCd    = fdr(PMCd);

nPFd    = fdr(nPFd);
nPF     = fdr(nPF);
nPC     = fdr(nPC);
nPCd    = fdr(nPCd);
nPHM    = fdr(nPHM);
nPHMd   = fdr(nPHMd);
nPMC    = fdr(nPMC);
nPMCd   = fdr(nPMCd);

f           = figure('Units', 'normalized', 'Position', [0 0 1 1]); axis off
set(gcf,'color', [1 1 1]);
alp         = .7;
clm         = linspace(.08, .79, 4);
row         = fliplr(linspace(.05, .76, 4));
dim         = [.2 .2];
txtsz       = 14;

for iAn = 1:2    
        bin         = linspace(-1, 1,50);
        inclIdx     = allIN{iAn};    % Only sound-responsive units with sign. FGM
        
        %%% COLUMN 1: Fig vs Ctr
        if iAn == 1
            axO     = axes('Position',[clm(1) row(1) dim]); hold on
        elseif iAn == 2
            axO     = axes('Position',[clm(1) row(3) dim]); hold on
        end
        
        vec1                = allFO{iAn}(~inclIdx);
        vec2                = allFO{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        axO.XLim            = xax;

        line([0 0],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axO.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axO.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPF, 1, iAn, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PF, 1, iAn, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1 
            lg = legend('n.s.','p < .01', 'Location','Northwest');
            lg.FontSize = 8;
            legend boxoff
        end
        
        if iAn == 1
            axD     = axes('Position',[clm(1) row(2) dim]); hold on
        elseif iAn == 2
            axD     = axes('Position',[clm(1) row(4) dim]); hold on
        end
        
        vec1                = allFD{iAn}(~inclIdx);
        vec2                = allFD{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+(2*Yof)];
        axD.XLim            = xax;

        line([0 0],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPFd, 1, iAn, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PFd, 1, iAn, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2 && iFi == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [-1 -.5 0 .5 1];
            axD.XLabel.String = 'd-prime';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end  
        
        %%% COLUMN 2: Coherence
        if iAn == 1 
            axO     = axes('Position',[clm(2) row(1) dim]); hold on
        elseif iAn == 2
            axO     = axes('Position',[clm(2) row(3) dim]); hold on
        end
        
        vec1                = allC{iAn}(~inclIdx);
        vec2                = allC{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        axO.XLim            = xax;
        
        line([0 0],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-.5/50 nanmean(vec1) nanmean(vec1)+.5/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-.5/50 nanmean(vec2) nanmean(vec2)+.5/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPC, 1, iAn, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PC, 1, iAn, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1
            axD     = axes('Position',[clm(2) row(2) dim]); hold on
        elseif iAn == 2 
            axD     = axes('Position',[clm(2) row(4) dim]); hold on
        end
        
        vec1                = allCD{iAn}(~inclIdx);
        vec2                = allCD{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+Yof];
        axD.XLim            = xax;
        
        line([0 0],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-.5/50 nanmean(vec1) nanmean(vec1)+.5/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-.5/50 nanmean(vec2) nanmean(vec2)+.5/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPCd, 1, iAn, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PCd, 1, iAn, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2 && iFi == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [-1 -.5 0 .5 1];
            axD.XLabel.String = 'd-prime';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end
        
        %%% COLUMN 3: HI vs MI
        if iAn == 1
            axO     = axes('Position',[clm(3) row(1) dim]); hold on
        elseif iAn == 2 
            axO     = axes('Position',[clm(3) row(3) dim]); hold on

        end
        
        vec1                = allHM{iAn}(~inclIdx);
        vec2                = allHM{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        axO.XLim            = xax;

        line([0 0],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axO.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axO.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPHM, 1, iAn, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PHM, 1, iAn, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1 
            axD     = axes('Position',[clm(3) row(2) dim]); hold on
        elseif iAn == 2 
            axD     = axes('Position',[clm(3) row(4) dim]); hold on
        end
        
        vec1                = allHMD{iAn}(~inclIdx);
        vec2                = allHMD{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+(2*Yof)];
        axD.XLim            = xax;

        line([0 0],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPHMd, 1, iAn, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PHMd, 1, iAn, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [-1 -.5 0 .5 1];
            axD.XLabel.String = 'd-prime';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end
        
        %%% COLUMN 4: MI vs CR
        if iAn == 1 
            axO     = axes('Position',[clm(4) row(1) dim]); hold on
        elseif iAn == 2 
            axO     = axes('Position',[clm(4) row(3) dim]); hold on
        end
        
        vec1                = allMC{iAn}(~inclIdx);
        vec2                = allMC{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        axO.XLim            = xax;

        line([0 0],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axO.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axO.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPMC, 1, iAn, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PMC, 1, iAn, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1 
            axD     = axes('Position',[clm(4) row(2) dim]); hold on
        elseif iAn == 2 
            axD     = axes('Position',[clm(4) row(4) dim]); hold on
        end
        
        vec1                = allMCD{iAn}(~inclIdx);
        vec2                = allMCD{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+(2*Yof)];
        axD.XLim            = xax;

        line([0 0],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPMCd, 1, iAn, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PMCd, 1, iAn, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [-1 -.5 0 .5 1];
            axD.XLabel.String = 'd-prime';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end
end

of = .05;
ax0 = axes('Position',[0 0 1 1],'Visible','off');
text(clm(1)-of,.99, 'a', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(clm(2)-of,.99, 'b', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(clm(3)-of,.99, 'c', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(clm(4)-of,.99, 'd', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')

text(.02,row(2)+.2, 'M1', 'Parent', ax0, 'FontSize', 20, 'Color', 'k', 'FontWeight', 'bold','Rotation',90)
text(.02,row(4)+.2, 'M2', 'Parent', ax0, 'FontSize', 20, 'Color', 'k', 'FontWeight', 'bold','Rotation',90)

text(clm(1)+of, .985, 'Fig vs Ctr', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')
text(clm(2)+.025, .985, 'Coh8 vs Coh12', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')
text(clm(3)+of, .985, 'HI vs MI', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')
text(clm(4)+of, .985, 'MI vs CR', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')

export_fig([dest_dir 'FIG5_dprime_pooled'], '-r400',f);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT AUROC %%%

for iAn = 1:2
    for i = 1:2
        inclIdx                 = IN{iAn,i};    % Only sound-responsive units with sign. FGM
        pFd(iAn,i)              = signrank(AUCFD{iAn,i}(inclIdx),.5);
        pF(iAn,i)            	= signrank(AUCFO{iAn,i}(inclIdx),.5);
        pC(iAn,i)               = signrank(AUCC{iAn,i}(inclIdx),.5);
        pCd(iAn,i)              = signrank(AUCCD{iAn,i}(inclIdx),.5);
        pHM(iAn,i)              = signrank(AUCHM{iAn,i}(inclIdx),.5);
        pHMd(iAn,i)             = signrank(AUCHMD{iAn,i}(inclIdx),.5);
        pMC(iAn,i)              = signrank(AUCMC{iAn,i}(inclIdx),.5);
        pMCd(iAn,i)             = signrank(AUCMCD{iAn,i}(inclIdx),.5);
        
        npFd(iAn,i)              = signrank(AUCFD{iAn,i}(~inclIdx),.5);
        npF(iAn,i)               = signrank(AUCFO{iAn,i}(~inclIdx),.5);
        npC(iAn,i)               = signrank(AUCC{iAn,i}(~inclIdx),.5);
        npCd(iAn,i)              = signrank(AUCCD{iAn,i}(~inclIdx),.5);
        npHM(iAn,i)              = signrank(AUCHM{iAn,i}(~inclIdx),.5);
        npHMd(iAn,i)             = signrank(AUCHMD{iAn,i}(~inclIdx),.5);
        npMC(iAn,i)              = signrank(AUCMC{iAn,i}(~inclIdx),.5);
        npMCd(iAn,i)             = signrank(AUCMCD{iAn,i}(~inclIdx),.5);
    end
end

pFd    	= fdrP([pFd(1,:), pFd(2,:)]);
pF    	= fdrP([pF(1,:), pF(2,:)]);
pC      = fdrP([pC(1,:), pC(2,:)]);
pCd     = fdrP([pCd(1,:), pCd(2,:)]);
pHM     = fdrP([pHM(1,:), pHM(2,:)]);
pHMd    = fdrP([pHMd(1,:), pHMd(2,:)]);
pMC     = fdrP([pMC(1,:), pMC(2,:)]);
pMCd    = fdrP([pMCd(1,:), pMCd(2,:)]);

npFd    = fdrP([npFd(1,:), npFd(2,:)]);
npF     = fdrP([npF(1,:), npF(2,:)]);
npC     = fdrP([npC(1,:), npC(2,:)]);
npCd    = fdrP([npCd(1,:), npCd(2,:)]);
npHM    = fdrP([npHM(1,:), npHM(2,:)]);
npHMd   = fdrP([npHMd(1,:), npHMd(2,:)]);
npMC    = fdrP([npMC(1,:), npMC(2,:)]);
npMCd   = fdrP([npMCd(1,:), npMCd(2,:)]);

f           = figure('Units', 'normalized', 'Position', [0 0 1 1]); axis off
set(gcf,'color', [1 1 1]);
cm          = [[0 0 .9]; [0 .9 0]; [.9 0 0]];
alp         = .7;
clm         = linspace(.1, .79, 4);
row         = fliplr(linspace(.05, .86, 8));
dim         = [.2 .1];
txtsz       = 14;

%%% PLOT %%%
for iAn = 1:2
    for iFi = 1:2
        bin         = linspace(0, 1,50);
        inclIdx     = IN{iAn,iFi};    % Only sound-responsive units with sign. FGM
        
        %%% COLUMN 1: Fig vs Ctr
        if iAn == 1 && iFi == 1
            axO     = axes('Position',[clm(1) row(1) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axO     = axes('Position',[clm(1) row(3) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axO     = axes('Position',[clm(1) row(5) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axO     = axes('Position',[clm(1) row(7) dim]); hold on
        end
        
        vec1                = AUCFO{iAn,iFi}(~inclIdx);
        vec2                = AUCFO{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        
        line([.5 .5],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axO.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axO.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npF, iAn, iFi, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pF, iAn, iFi, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1 && iFi == 1
            lg = legend('n.s.','p < .01', 'Location','Northwest');
            lg.FontSize = 8;
            legend boxoff
        end
        
        if iAn == 1 && iFi == 1
            axD     = axes('Position',[clm(1) row(2) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axD     = axes('Position',[clm(1) row(4) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axD     = axes('Position',[clm(1) row(6) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axD     = axes('Position',[clm(1) row(8) dim]); hold on
        end
        
        vec1                = AUCFD{iAn,iFi}(~inclIdx);
        vec2                = AUCFD{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+(2*Yof)];
        
        line([.5 .5],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npFd, iAn, iFi, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pFd, iAn, iFi, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2 && iFi == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [0 .25 .5 .75 1];
            axD.XLabel.String = 'AUROC';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end
        
        %%% COLUMN 2: Coherence
        if iAn == 1 && iFi == 1
            axO     = axes('Position',[clm(2) row(1) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axO     = axes('Position',[clm(2) row(3) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axO     = axes('Position',[clm(2) row(5) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axO     = axes('Position',[clm(2) row(7) dim]); hold on
        end
        
        vec1                = AUCC{iAn,iFi}(~inclIdx);
        vec2                = AUCC{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        
        line([.5 .5],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npC, iAn, iFi, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pC, iAn, iFi, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1 && iFi == 1
            axD     = axes('Position',[clm(2) row(2) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axD     = axes('Position',[clm(2) row(4) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axD     = axes('Position',[clm(2) row(6) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axD     = axes('Position',[clm(2) row(8) dim]); hold on
        end
        
        vec1                = AUCCD{iAn,iFi}(~inclIdx);
        vec2                = AUCCD{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+Yof];
        
        line([.5 .5],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npCd, iAn, iFi, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pCd, iAn, iFi, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2 && iFi == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [0 .25 .5 .75 1];
            axD.XLabel.String = 'AUROC';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end
        
        %%% COLUMN 3: HI vs MI
        if iAn == 1 && iFi == 1
            axO     = axes('Position',[clm(3) row(1) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axO     = axes('Position',[clm(3) row(3) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axO     = axes('Position',[clm(3) row(5) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axO     = axes('Position',[clm(3) row(7) dim]); hold on
        end
        
        vec1                = AUCHM{iAn,iFi}(~inclIdx);
        vec2                = AUCHM{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        
        line([.5 .5],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axO.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axO.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npHM, iAn, iFi, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pHM, iAn, iFi, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1 && iFi == 1
            axD     = axes('Position',[clm(3) row(2) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axD     = axes('Position',[clm(3) row(4) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axD     = axes('Position',[clm(3) row(6) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axD     = axes('Position',[clm(3) row(8) dim]); hold on
        end
        
        vec1                = AUCHMD{iAn,iFi}(~inclIdx);
        vec2                = AUCHMD{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+(2*Yof)];
        
        line([.5 .5],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npHMd, iAn, iFi, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pHMd, iAn, iFi, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2 && iFi == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [0 .25 .5 .75 1];
            axD.XLabel.String = 'AUROC';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end
        
        %%% COLUMN 4: MI vs CR
        if iAn == 1 && iFi == 1
            axO     = axes('Position',[clm(4) row(1) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axO     = axes('Position',[clm(4) row(3) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axO     = axes('Position',[clm(4) row(5) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axO     = axes('Position',[clm(4) row(7) dim]); hold on
        end
        
        vec1                = AUCMC{iAn,iFi}(~inclIdx);
        vec2                = AUCMC{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        
        line([.5 .5],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axO.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axO.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npMC, iAn, iFi, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pMC, iAn, iFi, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1 && iFi == 1
            axD     = axes('Position',[clm(4) row(2) dim]); hold on
        elseif iAn == 1 && iFi == 2
            axD     = axes('Position',[clm(4) row(4) dim]); hold on
        elseif iAn == 2 && iFi == 1
            axD     = axes('Position',[clm(4) row(6) dim]); hold on
        elseif iAn == 2 && iFi == 2
            axD     = axes('Position',[clm(4) row(8) dim]); hold on
        end
        
        vec1                = AUCMCD{iAn,iFi}(~inclIdx);
        vec2                = AUCMCD{iAn,iFi}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+(2*Yof)];
        
        line([.5 .5],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(npMCd, iAn, iFi, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(pMCd, iAn, iFi, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2 && iFi == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [0 .25 .5 .75 1];
            axD.XLabel.String = 'AUROC';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end
    end
end

of = .05;
ax0 = axes('Position',[0 0 1 1],'Visible','off');
text(clm(1)-of,.99, 'a', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(clm(2)-of,.99, 'b', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(clm(3)-of,.99, 'c', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(clm(4)-of,.99, 'd', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')

annotation('line',[.05 .05],[row(1)+.1-.03 row(2)+.03], 'LineWidth', 2, 'Color', 'k')
annotation('line',[.05 .05],[row(3)+.1-.03 row(4)+.03], 'LineWidth', 2, 'Color', 'k')
annotation('line',[.05 .05],[row(5)+.1-.03 row(6)+.03], 'LineWidth', 2, 'Color', 'k')
annotation('line',[.05 .05],[row(7)+.1-.03 row(8)+.03], 'LineWidth', 2, 'Color', 'k')
text(.035,row(2)+.09, 'ANT', 'Parent', ax0, 'FontSize', 14, 'Color', 'k','Rotation',90)
text(.035,row(4)+.09, 'POS', 'Parent', ax0, 'FontSize', 14, 'Color', 'k','Rotation',90)
text(.02,row(3)+.09, 'M1', 'Parent', ax0, 'FontSize', 20, 'Color', 'k', 'FontWeight', 'bold','Rotation',90)
text(.035,row(6)+.09, 'ANT', 'Parent', ax0, 'FontSize', 14, 'Color', 'k','Rotation',90)
text(.035,row(8)+.09, 'POS', 'Parent', ax0, 'FontSize', 14, 'Color', 'k','Rotation',90)
text(.02,row(7)+.09, 'M2', 'Parent', ax0, 'FontSize', 20, 'Color', 'k', 'FontWeight', 'bold','Rotation',90)

of = .015;
text(clm(1)+of, .985, 'Fig vs Ctr', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')
text(clm(2)+of, .985, 'Coh8 vs Coh12', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')
text(clm(3)+of, .985, 'HI vs MI', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')
text(clm(4)+of, .985, 'MI vs CR', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')

addpath X:\Felix\Scripts\Stuff\export_fig-master
dest_dir = 'X:\Felix\Documents\Publications\FigGnd_Ephys\Figures\';
export_fig([dest_dir 'FIG5_roc'], '-r400',f);

%%% POOL AC %%%
for iAn = 1:2
    allIN{iAn}              = [IN{iAn,1} IN{iAn,2}];
    allAUCFD{iAn}           = [AUCFD{iAn,1} AUCFD{iAn,2}];
    allAUCFO{iAn}           = [AUCFO{iAn,1} AUCFO{iAn,2}];
    allAUCC{iAn}            = [AUCC{iAn,1} AUCC{iAn,2}];
    allAUCCD{iAn}           = [AUCCD{iAn,1} AUCCD{iAn,2}];
    allAUCHM{iAn}           = [AUCHM{iAn,1} AUCHM{iAn,2}];
    allAUCMC{iAn}           = [AUCMC{iAn,1} AUCMC{iAn,2}];
    allAUCHMD{iAn}          = [AUCHMD{iAn,1} AUCHMD{iAn,2}];
    allAUCMCD{iAn}          = [AUCMCD{iAn,1} AUCMCD{iAn,2}];
    
    inclIdx                 = allIN{iAn};    % Only sound-responsive units with sign. FGM
    PFd(iAn)                = signrank(allAUCFD{iAn}(inclIdx),.5);
    PF(iAn)                 = signrank(allAUCFO{iAn}(inclIdx),.5);
    PC(iAn)                 = signrank(allAUCC{iAn}(inclIdx),.5);
    PCd(iAn)                = signrank(allAUCCD{iAn}(inclIdx),.5);
    PHM(iAn)                = signrank(allAUCHM{iAn}(inclIdx),.5);
    PHMd(iAn)               = signrank(allAUCHMD{iAn}(inclIdx),.5);
    PMC(iAn)                = signrank(allAUCMC{iAn}(inclIdx),.5);
    PMCd(iAn)               = signrank(allAUCMCD{iAn}(inclIdx),.5);
    
    nPFd(iAn)               = signrank(allAUCFD{iAn}(~inclIdx),.5);
    nPF(iAn)                = signrank(allAUCFO{iAn}(~inclIdx),.5);
    nPC(iAn)                = signrank(allAUCC{iAn}(~inclIdx),.5);
    nPCd(iAn)               = signrank(allAUCCD{iAn}(~inclIdx),.5);
    nPHM(iAn)               = signrank(allAUCHM{iAn}(~inclIdx),.5);
    nPHMd(iAn)              = signrank(allAUCHMD{iAn}(~inclIdx),.5);
    nPMC(iAn)               = signrank(allAUCMC{iAn}(~inclIdx),.5);
    nPMCd(iAn)              = signrank(allAUCMCD{iAn}(~inclIdx),.5);
end

PFd    	= fdr(PFd);
PF    	= fdr(PF);
PC      = fdr(PC);
PCd     = fdr(PCd);
PHM     = fdr(PHM);
PHMd    = fdr(PHMd);
PMC     = fdr(PMC);
PMCd    = fdr(PMCd);

nPFd    = fdr(nPFd);
nPF     = fdr(nPF);
nPC     = fdr(nPC);
nPCd    = fdr(nPCd);
nPHM    = fdr(nPHM);
nPHMd   = fdr(nPHMd);
nPMC    = fdr(nPMC);
nPMCd   = fdr(nPMCd);

f           = figure('Units', 'normalized', 'Position', [0 0 1 1]); axis off
set(gcf,'color', [1 1 1]);
alp         = .7;
clm         = linspace(.08, .79, 4);
row         = fliplr(linspace(.05, .76, 4));
dim         = [.2 .2];
txtsz       = 14;

for iAn = 1:2    
       bin         = linspace(0, 1,50);
       inclIdx     = allIN{iAn};    % Only sound-responsive units with sign. FGM
        
        %%% COLUMN 1: Fig vs Ctr
        if iAn == 1
            axO     = axes('Position',[clm(1) row(1) dim]); hold on
        elseif iAn == 2
            axO     = axes('Position',[clm(1) row(3) dim]); hold on
        end
        
        vec1                = allAUCFO{iAn}(~inclIdx);
        vec2                = allAUCFO{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        
        line([.5 .5],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axO.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axO.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPF, 1, iAn, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PF, 1, iAn, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1 
            lg = legend('n.s.','p < .01', 'Location','Northwest');
            lg.FontSize = 8;
            legend boxoff
        end
        
        if iAn == 1
            axD     = axes('Position',[clm(1) row(2) dim]); hold on
        elseif iAn == 2
            axD     = axes('Position',[clm(1) row(4) dim]); hold on
        end
        
        vec1                = allAUCFD{iAn}(~inclIdx);
        vec2                = allAUCFD{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+(2*Yof)];
        
        line([.5 .5],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPFd, 1, iAn, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PFd, 1, iAn, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2 && iFi == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [0 .25 .5 .75 1];
            axD.XLabel.String = 'AUROC';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end    
        
        %%% COLUMN 2: Coherence
        if iAn == 1 
            axO     = axes('Position',[clm(2) row(1) dim]); hold on
        elseif iAn == 2
            axO     = axes('Position',[clm(2) row(3) dim]); hold on
        end
        
        vec1                = allAUCC{iAn}(~inclIdx);
        vec2                = allAUCC{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        
        line([.5 .5],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPC, 1, iAn, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PC, 1, iAn, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1
            axD     = axes('Position',[clm(2) row(2) dim]); hold on
        elseif iAn == 2 
            axD     = axes('Position',[clm(2) row(4) dim]); hold on
        end
        
        vec1                = allAUCCD{iAn}(~inclIdx);
        vec2                = allAUCCD{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+Yof];
        
        line([.5 .5],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPCd, 1, iAn, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PCd, 1, iAn, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2 && iFi == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [0 .25 .5 .75 1];
            axD.XLabel.String = 'AUROC';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end
        
        %%% COLUMN 3: HI vs MI
        if iAn == 1
            axO     = axes('Position',[clm(3) row(1) dim]); hold on
        elseif iAn == 2 
            axO     = axes('Position',[clm(3) row(3) dim]); hold on

        end
        
        vec1                = allAUCHM{iAn}(~inclIdx);
        vec2                = allAUCHM{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        
        line([.5 .5],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axO.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axO.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPHM, 1, iAn, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PHM, 1, iAn, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1 
            axD     = axes('Position',[clm(3) row(2) dim]); hold on
        elseif iAn == 2 
            axD     = axes('Position',[clm(3) row(4) dim]); hold on
        end
        
        vec1                = allAUCHMD{iAn}(~inclIdx);
        vec2                = allAUCHMD{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+(2*Yof)];
        
        line([.5 .5],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPHMd, 1, iAn, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PHMd, 1, iAn, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [0 .25 .5 .75 1];
            axD.XLabel.String = 'AUROC';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end
        
        %%% COLUMN 4: MI vs CR
        if iAn == 1 
            axO     = axes('Position',[clm(4) row(1) dim]); hold on
        elseif iAn == 2 
            axO     = axes('Position',[clm(4) row(3) dim]); hold on
        end
        
        vec1                = allAUCMC{iAn}(~inclIdx);
        vec2                = allAUCMC{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axO.YLabel.String   = {'Onset';'No. units'};
        Yof                 = axO.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axO.YLim            = [0 maxV+(2*Yof)];
        
        line([.5 .5],[axO.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axO.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axO.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axO.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPMC, 1, iAn, nanmean(vec1), axO.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PMC, 1, iAn, nanmean(vec2), axO.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axO.XLim(2)/50)
        
        if iAn == 1 
            axD     = axes('Position',[clm(4) row(2) dim]); hold on
        elseif iAn == 2 
            axD     = axes('Position',[clm(4) row(4) dim]); hold on
        end
        
        vec1                = allAUCMCD{iAn}(~inclIdx);
        vec2                = allAUCMCD{iAn}(inclIdx);
        h1                  = histogram(vec1, bin,'Facecolor', 'k','Edgecolor', 'k','Facealpha', alp,'Edgealpha', 0);
        h2                  = histogram(vec2, bin,'Facecolor', 'r','Edgecolor', 'r','Facealpha', alp,'Edgealpha', 0);
        axD.YLabel.String   = {'Decision';'No. units'};
        Yof                 = axD.YLim(2)/5;
        maxV                = max([h1.Values,h2.Values]);
        axD.YLim            = [0 maxV+(2*Yof)];
        
        line([.5 .5],[axD.YLim], 'LineStyle', ':', 'LineWidth', 2, 'Color', 'k')
        fill([nanmean(vec1)-axD.XLim(2)/50 nanmean(vec1) nanmean(vec1)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [0 0 0], 'FaceAlpha', alp)
        fill([nanmean(vec2)-axD.XLim(2)/50 nanmean(vec2) nanmean(vec2)+axD.XLim(2)/50],[maxV+Yof/2 maxV+Yof/4 maxV+Yof/2], [1 0 0], 'FaceAlpha', alp, 'EdgeColor', [1 0 0])
        plotStar(nPMCd, 1, iAn, nanmean(vec1), axD.XLim(2)/50, maxV+Yof, [0 0 0])
        plotStar(PMCd, 1, iAn, nanmean(vec2), axD.XLim(2)/50, maxV+Yof, [1 0 0])
        testDist(vec1,vec2,  maxV+(1.6*Yof), maxV+(1.95*Yof), axD.XLim(2)/50)
        
        if iAn == 2
            axO.XAxis.Visible = 'off';
            axD.XTick = [0 .25 .5 .75 1];
            axD.XLabel.String = 'AUROC';
        else
            axO.XAxis.Visible = 'off';
            axD.XAxis.Visible = 'off';
        end
end

of = .05;
ax0 = axes('Position',[0 0 1 1],'Visible','off');
text(clm(1)-of,.99, 'a', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(clm(2)-of,.99, 'b', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(clm(3)-of,.99, 'c', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(clm(4)-of,.99, 'd', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')

text(.02,row(2)+.2, 'M1', 'Parent', ax0, 'FontSize', 20, 'Color', 'k', 'FontWeight', 'bold','Rotation',90)
text(.02,row(4)+.2, 'M2', 'Parent', ax0, 'FontSize', 20, 'Color', 'k', 'FontWeight', 'bold','Rotation',90)

of = .015;
text(clm(1)+of, .985, 'Fig vs Ctr', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')
text(clm(2)+of, .985, 'Coh8 vs Coh12', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')
text(clm(3)+of, .985, 'HI vs MI', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')
text(clm(4)+of, .985, 'MI vs CR', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')

export_fig([dest_dir 'FIG5_roc_pooled'], '-r400',f);

%%

function out = fdrP(vec)
tmp = fdr(vec);
out(1,:) = tmp(1:2);
out(2,:) = tmp(3:4);
end

function plotStar(Parr, iAn, iFi, xcntr, ofst, ylev, clr)
if Parr(iAn,iFi) < .05
    if Parr(iAn,iFi) < .001
        xstar = [xcntr-ofst xcntr xcntr+ofst];
        ystar = [ylev ylev ylev];
    elseif Parr(iAn,iFi) < .01 && Parr(iAn,iFi) > .001
        xstar = [xcntr-ofst/2 xcntr+ofst/2];
        ystar = [ylev ylev];
    elseif Parr(iAn,iFi) < .05 && Parr(iAn,iFi) > .01
        xstar = xcntr;
        ystar = ylev;
    end
    star = plot(xstar, ystar, '*', 'Color', [clr .6], 'LineWidth', 1.1);
    star.MarkerSize = 6;
end
end

function testDist(vec1,vec2, ylev, ystr, xofst)

% p = anova1([vec1 vec2], [zeros(1,length(vec1)), ones(1,length(vec2))], 'off');
p = ranksum(vec1,vec2);

if p < .05
    line([nanmean(vec1) nanmean(vec2)],[ylev ylev], 'LineWidth', 2, 'Color', [.5 .5 .5])
    xcntr = mean([nanmean(vec1), nanmean(vec2)]);
    
    if p < .001
        xstar = [xcntr-xofst xcntr xcntr+xofst];
        ystar = [ystr ystr ystr];
    elseif p < .01 && p > .001
        xstar = [xcntr-xofst/2 xcntr+xofst/2];
        ystar = [ystr ystr];
    elseif p < .05 && p > .01
        xstar = xcntr;
        ystar = ystr;
    end
    star = plot(xstar, ystar, '*', 'Color', [.5 .5 .5 .6], 'LineWidth', 1.1);
    star.MarkerSize = 6;
end
end
