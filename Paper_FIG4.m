%%% FIGURE_GROUND EPHYS PAPER %%%
%%% FELIX SCHNEIDER, 02/2020 %%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FIG 4 %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% load('Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\Eric\Summary\muae.mat')
% muaeE = muae;
% load('Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\Dollar\Summary\muae.mat')
% muaeD = muae;
% clear muae
% load('Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\Eric\Summary\mLFP.mat')
% lfpE = lfp;
% load('Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\Dollar\Summary\mLFP.mat')
% lfpD = lfp;
% clear lfp

f           = figure('Units', 'normalized', 'Position', [0 0 1 1]); axis off
set(gcf,'color', [1 1 1]);
ax0         = axes('Position',[0 0 1 1],'Visible','off');
f1        	= 7;
f2          = 100;
noF         = 100;
fr        	= round(linspace(7,100,100));
row         = linspace(.1, .74, 6);
clm         = [0.08    0.27    0.62 .81];
dim         = [.17 .17];
txtsz       = 12;
indx        = 201:400; % corresponds to -301:-100ms to decision
dest_dir    = 'X:\Felix\Documents\Publications\FigGnd_Ephys\Figures\';
typ         = 'muae';

clear idxE idxD
n = 10;
for iCh = 1:size(lfpE.so,1)
    mbl     = mean(lfpE.so(iCh,1:250));
    sdbl    = std(lfpE.so(iCh,1:250));
    thr     = [mbl - n*sdbl mbl + n*sdbl];
    
    [lat, idxE(iCh)]= getLatency(lfpE.so(iCh,:), 300, 300, 1, 10);
end
for iCh = 1:size(lfpD.so,1)
    mbl     = mean(lfpD.so(iCh,1:250));
    sdbl    = std(lfpD.so(iCh,1:250));
    thr     = [mbl - n*sdbl mbl + n*sdbl];
    
    [lat, idxD(iCh)]= getLatency(lfpD.so(iCh,:), 300, 300, 1, 10);
end

for iAn = 1:2
    lfp = []; x = []; y = [];
    
    if iAn == 1
        animalID = 'Eric';
        load([dest_dir 'raw\tMap_' animalID '_' typ  '.mat']);
        AP      = find(logical(sum(~isnan(mfr_mat),2)));
        ML      = find(logical(sum(~isnan(mfr_mat))));
        [x,y]   = coreBoundary(mfr_mat,AP,ML,false,animalID);
        lfp     = lfpE;
        idx     = idxE;
    else
        animalID = 'Dollar';
        load([dest_dir 'raw\tMap_' animalID '_' typ  '.mat']);
        AP      = find(logical(sum(~isnan(mfr_mat),2)));
        ML      = find(logical(sum(~isnan(mfr_mat))));
        [x,y]   = coreBoundary(mfr_mat,AP,ML,false,animalID);
        lfp     = lfpD;
        idx     = idxD;
    end
    
    % Check area
    post = [];
    for i = 1:size(lfp.so,1)
        if idx(i) == 0
            continue
        end
        
        if lfp.coord(i,1) > y(round(lfp.coord(i,2))-(x(1)-1))
            post(i) = true;
        else
            post(i) = false;
        end
    end
    post = logical(post);
    
    for iSite = 1:size(lfp.so,1)
        if idx(iSite) == 0
            continue
        end
        z8(:,:,iSite)   = lfp.zmap8(:,:,iSite);
        z12(:,:,iSite)  = lfp.zmap12(:,:,iSite);
    end
    
    ant8 = []; pos8 = []; ant12=[]; pos12 = [];    
    ant8        = z8(:,:,~post);
    pos8        = z8(:,:,post);
    a8          = nanmean(ant8,3);
    p8          = nanmean(pos8,3);
        
    ant12       = z12(:,:,~post);
    pos12       = z12(:,:,post);
    a12         = nanmean(ant12,3);
    p12         = nanmean(pos12,3);

    % Remove 1/2 cycle before response to avoid artefact contribution
    a8          = LFP_exclCycle(a8(:,1:500), f1, f2, noF, 2);
    p8          = LFP_exclCycle(p8(:,1:500), f1, f2, noF, 2);
    a12         = LFP_exclCycle(a12(:,1:500), f1, f2, noF, 2);
    p12         = LFP_exclCycle(p12(:,1:500), f1, f2, noF, 2);
    
    lA8{iAn}    = ant8(1:25,:,:);
    lP8{iAn}    = pos8(1:25,:,:);
    hA8{iAn}    = ant8(30:end,:,:);
    hP8{iAn}    = pos8(30:end,:,:);
    
    lA12{iAn}   = ant12(1:25,:,:);
    lP12{iAn}   = pos12(1:25,:,:);
    hA12{iAn}   = ant12(30:end,:,:);
    hP12{iAn}   = pos12(30:end,:,:);
    
    for iPlot = 1:4
        
        if iPlot == 1
            tfmat = a8;
            r = 3; c = 1;
        elseif iPlot == 2
            tfmat = p8;
            r = 1; c = 1;
        elseif iPlot == 3
            tfmat = a12;
            r = 3; c = 2;
        elseif iPlot == 4
            tfmat = p12;
            r = 1; c = 2;
        end
        
        if iAn == 2
            c = c+2;
        end
        
        ax = axes('Position',[clm(c) row(r) dim]);
        h = pcolor(tfmat);
        set(h, 'EdgeColor', 'none');
        ax.YTick = [1 50 100];
%         ax.YTickLabel = [fr(1) fr(25) fr(50) fr(75) fr(100)];
        ax.YTickLabel = [fr(1) fr(50) fr(100)];
        ax.XTick = [100 200 300 400 500];
        ax.XTickLabel = {'-400','-300','-200','-100','0'};
        ax.FontSize = txtsz;
        ax.XLim = [1 401];
        
        if iPlot == 1 || iPlot == 3
            ax.XAxis.Visible = 'off';
        end
        
        if iPlot == 1 || iPlot == 2
        else
            ax.YAxis.Visible = 'off';       
        end
        
        if iPlot ==1 && iAn == 1
            r = rectangle('Position',[201 1 200 25]);
            r.LineWidth = 2;
            r.LineStyle = '--';
            r = rectangle('Position',[201 30 200 70]);
            r.LineWidth = 2;
            r.LineStyle = '--';
        end
        
        caxis([-2 2])
        colormap('jet')
        xlabel('Time [ms]')
        box off 
        
        if iAn == 1
            ylabel('Freq [Hz]');           
        end
        
        l = line([500 500],[0 100]);
        l.LineStyle = ':';
        l.LineWidth = 2;
        l.Color = 'k';
        
        if iAn == 1 && iPlot == 4
            cb = colorbar;
            cb.Position(1) = clm(2)+.2;
            cb.Ticks = [-2 0 2];
            cb.Label.String = {'Power difference';'[z-score]'};
        end
    end
end

text(clm(1)+.07,.97, 'Coh8', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')
text(clm(2)+.05,.97, 'Coh12', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')
text(clm(3)+.07,.97, 'Coh8', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')
text(clm(4)+.05,.97, 'Coh12', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold')

text(clm(1),.97, 'M1', 'Parent', ax0, 'FontSize', 25, 'Color', 'k', 'FontWeight', 'bold')
text(clm(3),.97, 'M2', 'Parent', ax0, 'FontSize', 25, 'Color', 'k', 'FontWeight', 'bold')

% t1 = text(.03,row(3)+.18, 'ANT', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold');set(t1,'Rotation',90);
% t2 = text(.03,row(1)+.18, 'POS', 'Parent', ax0, 'FontSize', 14, 'Color', 'k', 'FontWeight', 'bold');set(t2,'Rotation',90);

%%% MUAe %%%%
HI8 = []; HI12 = []; CR = [];
alph = .01;

for iAn = 1:2
    
    if iAn == 1
        antM = []; posM = [];
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
        
        c = 0; hi8 = []; hi12 = []; cr = [];
        
        for ii = 1:size(d,2)
            incl = check20Hz(d{ii});
            if length(d{ii}.BLslope) < 200 || incl == 0
                continue
            end
            
            datestr	= str2num([d{ii}.id(1:4) d{ii}.id(6:7) d{ii}.id(9:10)]);
            test = mean([d{ii}.res.HI12(:,indx); d{ii}.res.HI8(:,indx)],2);
            ctrl = mean(d{ii}.res.CR(:,indx),2);
            pp = anova1([test; ctrl],[zeros(size(test,1),1);ones(size(ctrl,1),1)], 'off');
            
            if pp < alph && sum(d{ii}.nTr>=10) == length(d{ii}.nTr) && datestr - 20190806 <= 0
                mBL         = nanmean(nanmean(d{ii}.on.fullAvg(:,101:500),2));        	% Average BL response
                c = c+1;
                hi8(c,:) = nanmean((muaeD{ii}.res.HI8)./mBL);
                hi12(c,:) = nanmean((muaeD{ii}.res.HI12)./mBL);
                cr(c,:) = nanmean((muaeD{ii}.res.CR)./mBL);
                
            end
        end
        HI8{iAn, iFi} = hi8;
        HI12{iAn, iFi} = hi12;
        CR{iAn, iFi} = cr;
    end 
end

%%% PLOT %%%
for iAn = 1:2
    for iFi = 1:2
        clear tfmat8 tfmat12      
        mat8 = HI8{iAn, iFi}-CR{iAn, iFi};
        mat12 = HI12{iAn, iFi}-CR{iAn, iFi};
        [~,idx] = sort(nanmean(mat8(:,indx),2),'descend'); 

        if iAn == 1 && iFi == 1
            r = 4; c = 1;
        elseif iAn == 1 && iFi == 2
            r = 2; c = 1;
        elseif iAn == 2 && iFi == 1
            r = 4; c = 3;
        elseif iAn == 2 && iFi == 2
            r = 2; c = 3;
        end
        
        ax1 = axes('Position',[clm(c) row(r) dim]);
        imagesc(mat8(idx,1:401))
        ax1.FontSize = txtsz;
        ax1.YTick = [1 round(size(HI12{iAn, iFi},1)/2) size(HI12{iAn, iFi},1)];
        cm = colormap(ax1,jet(256));
        caxis(ax1,[-.025 .025])
        box off
                
        if iAn == 1 && iFi == 1
            rr = rectangle('Position',[201 1 200 size(HI12{iAn, iFi},1)-1]);
            rr.LineWidth = 2;
            rr.EdgeColor = [0 0 0];
            rr.LineStyle = '--';
        end

        if iAn == 1
            ax1.YLabel.String = 'Unit';
        end

        ax2 = axes('Position',[clm(c+1) row(r) dim]);
        imagesc(mat12(idx,1:401))
        ax2.FontSize = txtsz;
        ax2.YAxis.Visible = 'off';
        colormap(ax2,jet(256));
        caxis(ax2,[-.025 .025])
        box off

        ax1.XAxis.Visible = 'off';
        ax2.XAxis.Visible = 'off';  
        
        if iAn == 1 && iFi == 1
            cb = colorbar;
            cb.Position(1) = clm(2)+.2;
            cb.Ticks = [-.02 0 .02];
            cb.Label.String = {'MUA difference';'[Fig - Ctr]'};
        end
    end
end

text(0,row(4)+.18, 'a', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(0,row(2)+.18, 'b', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')

addpath X:\Felix\Scripts\Stuff\export_fig-master
dest_dir = 'X:\Felix\Documents\Publications\FigGnd_Ephys\Figures\';
export_fig([dest_dir 'FIG4'], '-r400',f);

%% SFIG 4.1 Grand average LFP

f = figure('Units', 'normalized', 'Position', [0 0 1 1]);
set(gcf,'color', [1 1 1]);
ax0         = axes('Position',[0 0 1 1],'Visible','off');
row         = [.58 .15];
clm         = [.05 .28];
dim         = [.2 .3];
fr        	= round(linspace(100,7,100));
f1        	= 7;
f2          = 100;
noF         = 100;

clear idxE idxD
n = 20;
for iCh = 1:size(lfpE.so,1)
    mbl = mean(lfpE.so(iCh,1:250));
    sdbl = std(lfpE.so(iCh,1:250));
    thr = [mbl - n*sdbl mbl + n*sdbl];
    
    [lat, idxE(iCh)]= getLatency(lfpE.so(iCh,:), 300, 300, 1, 10);
end
for iCh = 1:size(lfpD.so,1)
    mbl = mean(lfpD.so(iCh,1:250));
    sdbl = std(lfpD.so(iCh,1:250));
    thr = [mbl - n*sdbl mbl + n*sdbl];
    
    [lat, idxD(iCh)]= getLatency(lfpD.so(iCh,:), 300, 300, 1, 10);
end

for iSite = 1:size(lfpE.so,1)
    if idxE(iSite) == 0
        continue
    end
    % Average baseline power per frequency band
    mbl_powE      = lfpE.bl_pownorm(:,iSite);
    % Baseline normalisation & dB conversion
    rcrE(:,:,iSite)  = 10*log10(lfpE.rcr_pow(:,:,iSite) ./ mbl_powE);
end

for iSite = 1:size(lfpD.so,1)
    if idxD(iSite) == 0
        continue
    end
    % Average baseline power per frequency band
    mbl_powD      = lfpD.bl_pownorm(:,iSite);
    % Baseline normalisation & dB conversion
    rcrD(:,:,iSite)  = 10*log10(lfpD.rcr_pow(:,:,iSite) ./ mbl_powD);
end

% Average across monkeys and recording sites
mrcr = nanmean(cat(3,rcrE,rcrD),3);
ax = axes('Position',[clm(1) row(1) dim]);
imagesc(flipud(mrcr))
ax.YTick = [1 25 50 75 100];
ax.YTickLabel = [fr(1) fr(25) fr(50) fr(75) fr(100)];
ax.XTick = [1 1500 3000];
ax.FontSize = 14;
caxis([-1 2])
cm = ([1 1 1; jet(256)]);
colormap(cm);
cb = colorbar;
cb.Label.String = 'Power [dB]';
cb.FontSize = 12;
cb.Ticks = [-1 0 1 2];
xlabel('Time [ms]')
ylabel('Freq [Hz]')
box off

% ITPC
ax = axes('Position',[clm(2) row(1) dim]);
imagesc(flipud(nanmean(cat(3,lfpE.rcr_itpc(:,:,logical(idxE)),lfpD.rcr_itpc(:,:,logical(idxD))),3)))
ax.YTick = [1 25 50 75 100];
ax.YTickLabel = [fr(1) fr(25) fr(50) fr(75) fr(100)];
ax.XTick = [1 1500 3000];
ax.FontSize = 14;
ax.YAxis.Visible = 'off';
caxis([0 .5])
cm = ([1 1 1; jet(256)]);
colormap(cm);
cb = colorbar;
cb.Label.String = 'ITPC';
cb.FontSize = 12;
cb.Ticks = [0 .25 .5];
xlabel('Time [ms]')
ylabel('Freq [Hz]')
box off

% Grand average - decision aligned
ax = axes('Position',[clm(1) row(2) dim]);
all = LFP_exclCycle(nanmean(cat(3,lfpE.zmapF(:,:,logical(idxE)),lfpD.zmapF(:,:,logical(idxD))),3), f1, f2, noF, 2);
imagesc(flipud(all))
ax.YTick = [1 25 50 75 100];
ax.YTickLabel = [fr(1) fr(25) fr(50) fr(75) fr(100)];
ax.XTick = [100 200 300 400 500];
ax.XTickLabel = {'-400','-300','-200','-100','0'};
ax.FontSize = 14;
caxis([-5 3])
cm = ([1 1 1; jet(256)]);
colormap(cm);
cb = colorbar;
cb.Label.String = 'Power difference [z-score]';
cb.FontSize = 12;
cb.Ticks = [-5 -2.5 0 2.5];
xlabel('Time [ms]')
ylabel('Freq [Hz]')
box off

r = rectangle('Position',[201 1 200 70]);
r.LineWidth = 2;
r.LineStyle = '--';
r = rectangle('Position',[201 75 200 25]);
r.LineWidth = 2;
r.LineStyle = '--';

%%% Bar release control
ax = axes('Position',[clm(2) row(2) dim]);
load('Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\Dollar\Summary\tfa_BR.mat')
map = 10*log10(alltfa);
imagesc(flipud(mean(map(:,501:1000,:),3)))
ax.XTick = [100 200 300 400 500];
ax.XTickLabel = {'-400', '-300','-200','-100', '0'};
ax.FontSize = 14;
ax.YAxis.Visible = 'off';
colormap(cm);
cb = colorbar;
caxis([-1 1])
cb.Label.String = 'Power [dB]';
cb.FontSize = 12;
cb.Ticks = [-1 -.5 0 .5 1];
box off 
xlabel('Time [ms]')

text(0,.92, 'a', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(.26,.92, 'b', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(0,.51, 'c', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(.26,.51, 'd', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(.52,.98, 'e', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')

%% SFIG 4.2
typ     = 'muae';
lfp     = [];
f1      = 7;
f2      = 100;
noF     = 100;

%%% PLOT %%%
ind = 151:350;
dim = [.35 .2];
row = fliplr(linspace(.04, .74, 4));
c = 0;

for iAn = 1:2
    lfp = [];
    
    if iAn == 1
        animalID = 'Eric';
        load([dest_dir 'raw\tMap_' animalID '_' typ  '.mat']);
        AP      = find(logical(sum(~isnan(mfr_mat),2)));
        ML      = find(logical(sum(~isnan(mfr_mat))));
        [x,y] = coreBoundary(mfr_mat,AP,ML,false,animalID);
        lfp = lfpE;
        idx = idxE;
    else
        animalID = 'Dollar';
        load([dest_dir 'raw\tMap_' animalID '_' typ  '.mat']);
        AP      = find(logical(sum(~isnan(mfr_mat),2)));
        ML      = find(logical(sum(~isnan(mfr_mat))));
        [x,y] = coreBoundary(mfr_mat,AP,ML,false,animalID);
        lfp = lfpD;
        idx = idxD;
    end
    
    % Check area
    post = [];
    for i = 1:size(lfp.so,1)
        if idx(i) == 0
            continue
        end
        
        if lfp.coord(i,1) > y(round(lfp.coord(i,2))-(x(1)-1))
            post(i) = true;
        else
            post(i) = false;
        end
    end
    post = logical(post);
    
    for iSite = 1:size(lfp.so,1)
        if idx(iSite) == 0
            continue
        end

        z8(:,:,iSite) = lfp.zmap8(:,:,iSite);
        z12(:,:,iSite) = lfp.zmap12(:,:,iSite);
    end
    
    ant8 = []; pos8 = []; ant12=[]; pos12 = [];
    
    ant8    = z8(:,:,~post);
    pos8    = z8(:,:,post);
    a8      = nanmean(ant8,3);
    p8      = nanmean(pos8,3);
    
    ant12    = z12(:,:,~post);
    pos12    = z12(:,:,post);
    a12      = nanmean(ant12,3);
    p12      = nanmean(pos12,3);
    
    % Remove 1/2 cycle before response to avoid artefact contribution
    a8      = LFP_exclCycle(a8(:,1:500), f1, f2, noF, 2);
    p8      = LFP_exclCycle(p8(:,1:500), f1, f2, noF, 2);
    a12     = LFP_exclCycle(a12(:,1:500), f1, f2, noF, 2);
    p12     = LFP_exclCycle(p12(:,1:500), f1, f2, noF, 2);
    
    lA8{iAn} = ant8(1:25,:,:);
    lP8{iAn} = pos8(1:25,:,:);
    hA8{iAn} = ant8(30:end,:,:);
    hP8{iAn} = pos8(30:end,:,:);
    
    lA12{iAn} = ant12(1:25,:,:);
    lP12{iAn} = pos12(1:25,:,:);
    hA12{iAn} = ant12(30:end,:,:);
    hP12{iAn} = pos12(30:end,:,:);
    
    pga8     = LFP_exclCycle(hP8{iAn}, fr(size(hP8{iAn},1)+1), fr(1), size(hP8{iAn},1), 2);
    pab8     = LFP_exclCycle(lP8{iAn}, fr(end), fr(100-size(lP8{iAn},1)), size(lP8{iAn},1), 2);
    pga12     = LFP_exclCycle(hP12{iAn}, fr(size(hP12{iAn},1)+1), fr(1), size(hP12{iAn},1), 2);
    pab12     = LFP_exclCycle(lP12{iAn}, fr(end), fr(100-size(lP12{iAn},1)), size(lP12{iAn},1), 2);
    
    aga8     = LFP_exclCycle(hA8{iAn}, fr(size(hA8{iAn},1)+1), fr(1), size(hA8{iAn},1), 2);
    aab8     = LFP_exclCycle(lA8{iAn}, fr(end), fr(100-size(lA8{iAn},1)), size(lA8{iAn},1), 2);
    aga12    = LFP_exclCycle(hA12{iAn}, fr(size(hA12{iAn},1)+1), fr(1), size(hA12{iAn},1), 2);
    aab12    = LFP_exclCycle(lA12{iAn}, fr(end), fr(100-size(lA12{iAn},1)), size(lA12{iAn},1), 2);
 
    [abAP(iAn) abAH(iAn)] = signrank(squeeze(nanmean(nanmean(aab8(:,ind,:),2))),squeeze(nanmean(nanmean(aab12(:,ind,:),2))));
    [abPP(iAn) abPH(iAn)] = signrank(squeeze(nanmean(nanmean(pab8(:,ind,:),2))),squeeze(nanmean(nanmean(pab12(:,ind,:),2))));
    [gaAP(iAn) gaAH(iAn)] = signrank(squeeze(nanmean(nanmean(aga8(:,ind,:),2))),squeeze(nanmean(nanmean(aga12(:,ind,:),2))));
    [gaPP(iAn) gaPH(iAn)] = signrank(squeeze(nanmean(nanmean(pga8(:,ind,:),2))),squeeze(nanmean(nanmean(pga12(:,ind,:),2))));
    
    for iCond = 1:2
        if iAn == 1 && iCond == 1
            ax = axes('Position',[.6 row(1) dim]); hold on
            str = 'ANT';
        elseif iAn == 1 && iCond == 2
            ax = axes('Position',[.6 row(2) dim]); hold on
            str = 'POS';
        elseif iAn == 2 && iCond == 1
            ax = axes('Position',[.6 row(3) dim]); hold on
            str = 'ANT';
        else
            ax = axes('Position',[.6 row(4) dim]); hold on
            str = 'POS';
        end
        
        ax.XAxis.Visible = 'off';
        ax.YLim = [-4 3];
        ax.XLim = [.5 4.5];
        ax.FontSize = 14;
        ax.YLabel.String = {str; 'Z-Score'};
        
        k = [];
        if iCond == 1
            k = [squeeze(nanmean(nanmean(aab8(:,ind,:),2))),...
                squeeze(nanmean(nanmean(aab12(:,ind,:),2))),...
                squeeze(nanmean(nanmean(aga8(:,ind,:),2))),...
                squeeze(nanmean(nanmean(aga12(:,ind,:),2)))];
        else
            k = [squeeze(nanmean(nanmean(pab8(:,ind,:),2))),...
                squeeze(nanmean(nanmean(pab12(:,ind,:),2))),...
                squeeze(nanmean(nanmean(pga8(:,ind,:),2))),...
                squeeze(nanmean(nanmean(pga12(:,ind,:),2)))];
        end
        
        %         disp(nanmean([k(:,3);k(:,4)]))
        b1 = bar(1,nanmean(k(:,1)));
        b2 = bar(2,nanmean(k(:,2)));
        b3 = bar(3,nanmean(k(:,3)));
        b4 = bar(4,nanmean(k(:,4)));
        
        col = {[0 1 0],[1 0 0],[0 1 0],[1 0 0]};
        %     e = errorbar([1 2 3 4], [nanmean(k(:,1)) nanmean(k(:,2)) nanmean(k(:,3)) nanmean(k(:,4))],...
        %         [std(nanmean(k(:,1)))/sqrt(length(nanmean(k(:,1)))) std(nanmean(k(:,2)))/sqrt(length(nanmean(k(:,2)))) ...
        %         std(nanmean(k(:,3)))/sqrt(length(nanmean(k(:,3)))) std(nanmean(k(:,4)))/sqrt(length(nanmean(k(:,4))))], '.' );
        set(b1,'FaceColor','k'); set(b1,'EdgeColor','k'); set(b1, {'linew'},{1.5});
        set(b2,'FaceColor','k'); set(b2,'EdgeColor','k'); set(b2, {'linew'},{1.5});
        set(b3,'FaceColor','k'); set(b3,'EdgeColor','k'); set(b3, {'linew'},{1.5});
        set(b4,'FaceColor','k'); set(b4,'EdgeColor','k'); set(b4, {'linew'},{1.5});
        
        pz(1) = signrank(k(:,1));
        pz(2) = signrank(k(:,2));
        pz(3) = signrank(k(:,3));
        pz(4) = signrank(k(:,4));
        
        for iPV = 1:4
            if iPV < 3
                x = 1.35;
            else
                x = 3.35;
            end
            
            if iPV == 1 || iPV == 3
                y = 1.2;
                cl = 'g';
            else
                y = 1.8;
                cl = 'r';
            end
            
            if pz(iPV) < .001
                text(x,y, 'p<0.001', 'FontSize', 10,'Color', cl)
            elseif pz(iPV) < .01
                text(x,y, 'p<0.01', 'FontSize', 10,'Color', cl)
            elseif pz(iPV) < .05
                text(x,y, 'p<0.05', 'FontSize', 10,'Color', cl)
            end

        end
        x = [.75 1.25; 1.75 2.25; 2.75 3.25; 3.75 4.25];
        for i = 1:4
            xx = x(i,1) + (x(i,2)-x(i,1)).*rand(1,size(k(:,i),1));
            sc = scatter(xx,k(:,i));
            sc.MarkerFaceColor = col{i};
            sc.MarkerEdgeColor = 'none';
            sc.MarkerFaceAlpha = .6;
        end
        
        xline = [1 2 3 4];
        yline = 2.5;
        ofst = .3;
        ofs = .05;
        
        %         disp([id iCond])
        if iCond == 1
            PP = [abAP(iAn) gaAP(iAn)];
        else
            PP = [abPP(iAn) gaPP(iAn)];
        end
        PP = fdr(PP);
        
        c = c+1;
        PPP(c,:) = PP;
        ctre = [1.5 3.5];
        
        for pv = 1:length(PP)
            if pv == 1
                of = 0;
            else
                of = 1;
            end
            
            if PP(pv) < .05
                
                l = line([xline(pv+of) xline(pv+of+1)], [yline yline]);
                l.LineWidth = 2;
                l.Color = [0 0 0];
                
                if PP(pv) < .001
                    xstar = [ctre(pv)-ofs ctre(pv) ctre(pv)+ofs];
                    ystar = [yline+ofst yline+ofst yline+ofst];
                elseif PP(pv) < .01 && PP(pv) > .001
                    xstar = [ctre(pv)-ofs ctre(pv)+ofs];
                    ystar = [yline+ofst yline+ofst];
                elseif PP(pv) < .05 && PP(pv) > .01
                    xstar = ctre(pv);
                    ystar = yline+ofst;
                end
                star = scatter(xstar, ystar,'Marker','*', 'LineWidth', 1.2);
                star.MarkerFaceColor = [0 0 0];
                star.MarkerEdgeColor = [0 0 0];
                star.SizeData = 20;
            end
        end
    end
end

ax.XAxis.Visible = 'on';
ax.XTick = [1 2 3 4];
ax.XTickLabel = {'Coh8', 'Coh12','Coh8', 'Coh12'};

text(.64,.98, 'Alpha/Beta', 'Parent', ax0, 'FontSize', 20, 'Color', 'k', 'FontWeight', 'bold')
text(.83,.98, 'Gamma', 'Parent', ax0, 'FontSize', 20,'Color', 'k', 'FontWeight', 'bold')

ylab4 = text(0.53,.71, 'M1', 'Parent', ax0, 'FontSize', 20, 'Color', 'k', 'FontWeight', 'bold'); set(ylab4,'Rotation',90);
ylab5 = text(0.53,.25, 'M2', 'Parent', ax0, 'FontSize', 20, 'Color', 'k', 'FontWeight', 'bold'); set(ylab5,'Rotation',90);

addpath X:\Felix\Scripts\Stuff\export_fig-master
dest_dir = 'X:\Felix\Documents\Publications\FigGnd_Ephys\Figures\';
export_fig([dest_dir 'SFIG3'], '-r300',f);
