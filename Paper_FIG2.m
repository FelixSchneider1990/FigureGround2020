%%% FIGURE_GROUND EPHYS PAPER %%%
%%% FELIX SCHNEIDER, 02/2020 %%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FIG 2 + FIG3 %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load('Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\Eric\Summary\muae.mat')
% muaeE = muae;
% load('Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\Dollar\Summary\muae.mat')
% muaeD = muae;
% clear muae

%%% CONTROL %%%
f = figure('Units', 'normalized', 'Position', [0 0 1 1]);
set(gcf,'color', [1 1 1]);
ax0 = axes('Position',[0 0 1 1],'Visible','off');
Fs          = 1000;                                                  	% Sampling frequency
T           = 1/Fs;                                                    	% Sampling period
L           = 2250;                                                   	% Length of signal
t           = (0:L-1)*T;                                             	% Time vector
frfft       = Fs*(0:(L/2))/L;
col         = [[0 0 0]; [.65 .65 .65]];
lw          = 1.5;
indxR       = 201:400; % corresponds to -300:-100ms to decision
indx        = 401:600;
alph        = .01;
nRep        = 1000;                                     % No. repetitions
useSEM      = true;

fullCTR = []; FIG = []; CTR = []; AP = []; ML = [];
for iAn = 1:2
    
    if iAn == 1
        dd = muaeE;
    else
        dd = muaeD;
    end
    
    fullCtrEnv = []; mfig = []; mctr = []; co = [];
    c = 0;
    
    for ii = 1:size(dd,2)
        incl = check20Hz(dd{ii});
        if length(dd{ii}.BLslope) < 200 || incl == 0
            continue
        end
        
        datestr	= str2num([dd{ii}.id(1:4) dd{ii}.id(6:7) dd{ii}.id(9:10)]);
        test = mean([dd{ii}.res.HI12(:,indxR); dd{ii}.res.HI8(:,indxR)],2);
        ctrl = mean(dd{ii}.res.CR(:,indxR),2);
        pp = anova1([test; ctrl],[zeros(size(test,1),1);ones(size(ctrl,1),1)], 'off');
        
        if pp < alph && sum(dd{ii}.nTr>=10) == length(dd{ii}.nTr) && datestr - 20190806 <= 0
            %%% Norm: subtract mBL then normalise by average control activity %%%
            mBL             = nanmean(nanmean(dd{ii}.on.fullAvg(:,101:500),2));                      % Average BL response

            c           = c+1;                                                                      % Counter
            fstim       = length(dd{ii}.figs);                                                      % Ratio of Fig to Gnd stim
            fullCtrEnv(c,:) = nanmean((dd{ii}.on.fullAvg(fstim+1:end,:)) ./mBL);                    % Control period - average across all presented stimuli
            
            mfig(c,:)  	= nanmean((dd{ii}.on.trlOn(dd{ii}.on.cat == 3,1:600)) ./mBL);              	% Figure period - average across all figure trials
            mctr(c,:)   = nanmean((dd{ii}.on.trlOn(dd{ii}.on.cat == 6,1:600)) ./mBL);
            co(c,:)     = dd{ii}.coord;
       
        end
    end
    
    cc = 1; ap =[]; ml = [];
    for j = 1:size(co,1)
        MLr      	= co(j,2);                              % ML penetration site on grid [mm]
        dep         = co(j,3);                              % depth of recording from GT tip [mm]
        offset      = (dep/sind(90)) * sind(15);          	% calculate offset [mm]
        adj         = MLr - offset;                      	% adjusted ML value [mm]
        ap(cc)      = co(j,1);
        ml(cc)      = adj;
        cc = cc+1;
    end
    
    fullCTR{iAn} = fullCtrEnv;
    FIG{iAn} = mfig;
    CTR{iAn} = mctr;
    AP{iAn} = ap;
    ML{iAn} = ml;
    
    % Bootstrap significance bar
    clear diff bootstat sig
    df                  = FIG{iAn}(:,1:600) - CTR{iAn}(:,1:600);
    %     nRep                = 5000;                                             	% No. of repetitions
    %     [bootstat,~]        = bootstrp(nRep,@mean, df);                             % Bootstrap mean for each timebin
    %     idxF                = sum(bootstat > 0);                                    % Get percentage of samples larger than zero
    %     sig                 = double(idxF < nRep*.005 | idxF > nRep*.995);          % If more than 99.5%/less than 0.5% larger than zero -> significantly different
    for iBin = 1:size(df,2)
        p(iBin) = signrank(df(:,iBin));
    end
    sig                 = double(fdr(p) < alph);
    sig(sig == 0)       = nan;
    SIG{iAn}            = sig;
end

%% PLOT FIG2 %%%

axA = axes('Position',[.075 .77 .35 .2]); hold on

if useSEM
    m       = mean(fullCTR{1});
    sd      = std(fullCTR{1});
    n       = size(fullCTR{1},1);
    sem     = sd/(sqrt(n));
    CI      = [m+sem/2; m-sem/2];
else
    CI      = bootci(nRep,@mean,fullCTR{1});
end
l = 1:length(CI);
len = [l fliplr(l)];
ci = [CI(1,:) fliplr(CI(2,:))];
fill(len,ci,col(1,:)*0.7,'EdgeColor','none', 'FaceAlpha', .3);
hold on
plot(mean(fullCTR{1}), 'Color', col(1,:), 'LineWidth', lw)

if useSEM
    m       = mean(fullCTR{2});
    sd      = std(fullCTR{2});
    n       = size(fullCTR{2},1);
    sem     = sd/(sqrt(n));
    CI      = [m+sem/2; m-sem/2];
else
    CI      = bootci(nRep,@mean,fullCTR{2});
end
l = 1:length(CI);
len = [l fliplr(l)];
ci = [CI(1,:) fliplr(CI(2,:))];
fill(len,ci,col(2,:)*0.7,'EdgeColor','none', 'FaceAlpha', .3);
hold on
plot(mean(fullCTR{2}), 'Color', col(2,:), 'LineWidth', lw)

axA.YTick = [1 1.1 1.2];
axA.YLim = [.97 1.25];
axA.XTick = [500 2000 3500];
axA.XTickLabel = {'0','1500','3000'};
axA.XLabel.String = 'Time [ms]';
axA.YLabel.String = 'MUA [norm]';
axA.FontSize = 14;

text(200,1.2, 'M1', 'FontSize', 12, 'Color', col(1,:), 'FontWeight', 'bold')
text(200,1.18, 'M2', 'FontSize', 12, 'Color', col(2,:), 'FontWeight', 'bold')
line([500 500],[0 2], 'LineStyle', '--', 'LineWidth',lw, 'Color','k')
line([3500 3500],[0 2], 'LineStyle', '--', 'LineWidth',lw, 'Color','k')

axI = axes('Position',[.15 .92 .075 .05]); hold on
plot(mean(fullCTR{1}(:,1900:2100)), 'Color', col(1,:), 'Linewidth', lw);
plot(mean(fullCTR{2}(:,1900:2100)), 'Color', col(2,:), 'Linewidth', lw);
axI.YLim = [1.02 1.12];
axI.XLim = [0 200];
axI.XTick = [0 200];
axI.YTick = [.1 .2];
axI.XTickLabel = {'1400','1600'};
axI.XLabel.String = 'Time [ms]';
axI.YAxis.Visible = 'off';
axI.FontSize = 12;

of = diff(axI.YLim)*.1;
lv = axI.YLim(2)-of;

seq = [lv lv+of lv+of lv lv lv-of lv-of lv];
ch = [0 5 45 50];
for ic = 1:4
    fi  = fill([ch fliplr(ch)],seq, [0 0 0], 'LineStyle','none');
    ch = ch+50;
end

annotation('line',[.17 .187],[.98 .98],'LineWidth', 1.5);
text(.168, .99, '50ms', 'Parent', ax0)

axI2 = axes('Position',[.27 .92 .075 .05]); hold on
for k = 1:2
    fftEnv = [];
    for iCell = 1:size(fullCTR{k},1)
        y = fft(fullCTR{k}(iCell,751:3000));
        P2              = abs(y/L);
        P1              = P2(1:L/2+1);
        P1(2:end-1)     = 2*P1(2:end-1);
        fftEnv(iCell,:) = P1;
    end
    plot(frfft,mean(fftEnv)./ max(mean(fftEnv)), 'Color', col(k,:), 'LineWidth', lw)
    box off
    axI2.XLim = [1 50];
    axI2.YLim = [0 .04];
    axI2.YTick = [];
    axI2.YLabel.String = 'Power';
    axI2.XLabel.String = 'Freq [Hz]';
    axI2.FontSize = 12;
end

%%% Location %%%
dest_dir = 'X:\Felix\Documents\Publications\FigGnd_Ephys\Figures\raw';
typ = 'muae';
alp = .7;

for iAn = 2:-1:1
    par = []; mfr_mat = []; mlat_mat = []; cc = 0;
    
    if iAn == 1
        animalID = 'Eric';
        axC = axes('Position',[.26 .46 .23 .2]); hold on
    else
        animalID = 'Dollar';
        axC = axes('Position',[.28 .13 .23 .2]); hold on
    end
    
    load([dest_dir '\tMap_' animalID '_' typ  '.mat']);
    imagesc(1:size(mfr_mat,1),-18:-1, flipud(mfr_mat));
    
    if iAn == 1
        sc = scatter([ML{iAn}],[-AP{iAn}]);
        axC.YLim = [-18 -5];
        axC.YLim = [-18 -5];
        %         text(6,-20, 'Fig ~= Ctr','FontSize', 12, 'Color', [1 0 0], 'FontWeight', 'bold')
    else
        sc = scatter([ML{iAn}],[-AP{iAn}]);
        axC.YLim = [-16 -3];
    end
    axC.YAxis.Visible = 'off';
    axC.XAxis.Visible = 'off';
    
    sc.SizeData = 20;
    sc.Marker = '^';
    sc.MarkerFaceColor = [1 0 0];
    sc.MarkerEdgeColor = [1 0 0];
    
    colormap([[1 1 1]; gray(256)])
    freqStart       = 180;                                          % Tuning low freq [Hz]
    steps           = 14;                                           % No of desired tones
    PT(1)           = freqStart;                                    % Starting frequency [Hz]
    for i = 2:steps                                                 % For no of tones...
        PT(i)       =  PT(i-1)*2^(1/2);                             % 1/2 octave steps
    end
    frex            = round(PT);
    
    cm = gray(256);
    axCB = axes('Position',[.37 .33 .001 .1]);
    axCB.Visible = 'off';
    colormap(axCB, cm)
    cb = colorbar(axCB);
    cb.Color = [0 0 0];
    cb.Position(3) = .01;
    cb.Label.String = 'Best frequency [Hz]';
    cb.FontSize = 12;
    caxis([log(frex(1)) log(frex(11))])
    caxis([5 log(frex(11))])
    cb.Ticks = [log(frex(1)),log(frex(7)),log(frex(11))];
    cb.TickLabels = {num2str(frex(1)), num2str(frex(7)), ['>' num2str(frex(11))]};
end

%%% FIGURE ONSET %%%
col = [[0 0 0]; [1 0 0]];
SEM = []; m = []; sd = [];
mID = {'M1','M2'};

for kk = 1:2
    if kk == 1
        axB = axes('Position',[.075 .46 .23 .2]); hold on
        ofst = .12;
    else
        axB = axes('Position',[.075 .13 .23 .2]); hold on
        ofst = .12;
    end
    
    if useSEM
        m       = mean(CTR{kk});
        sd      = std(CTR{kk});
        n       = size(CTR{kk},1);
        sem     = sd/(sqrt(n));
        CI      = [m+sem/2; m-sem/2];
    else
        CI      = bootci(nRep,@mean,CTR{kk});
    end
    l = 1:length(CI);
    len = [l fliplr(l)];
    ci = [CI(1,:) fliplr(CI(2,:))];
    fill(len,ci,col(1,:)*0.7,'EdgeColor','none', 'FaceAlpha', .3);
    hold on
    plot(mean(CTR{kk}), 'Color', col(1,:), 'LineWidth', lw)
    plot(1:length(SIG{kk}), SIG{kk}+ofst,  'Color', [.5 .5 .5], 'LineWidth', 3);
    
    if useSEM
        m       = mean(FIG{kk});
        sd      = std(FIG{kk});
        n       = size(FIG{kk},1);
        sem     = sd/(sqrt(n));
        CI      = [m+sem/2; m-sem/2];
    else
        CI      = bootci(nRep,@mean,FIG{kk});
    end
    l = 1:length(CI);
    len = [l fliplr(l)];
    ci = [CI(1,:) fliplr(CI(2,:))];
    fill(len,ci,col(2,:)*0.7,'EdgeColor','none', 'FaceAlpha', .3);
    hold on
    plot(mean(FIG{kk}), 'Color', col(2,:), 'LineWidth', lw)
    
    axB.XLim = [1 600];
    axB.XTick = [1 200 400 600];
    axB.XTickLabel = {'-200','0','200','400'};
    axB.XLabel.String = 'Time [ms]';
    axB.YLabel.String = {mID{kk};'MUA [norm]'};
    axB.FontSize = 14;
    line([200 200],[-1 2], 'LineStyle', '--', 'LineWidth',lw, 'Color','k')
    
    if kk == 1
        axB.YLim = [1.01 1.12];
        text(50,1.1, 'CTR', 'FontSize', 12, 'Color', 'k', 'FontWeight', 'bold')
        text(50,1.11, 'FIG', 'FontSize', 12, 'Color', 'r', 'FontWeight', 'bold')
        of = diff(axB.YLim)*.04;
        lv = axB.YLim(1)+of;
    else
        axB.YLim = [1.01 1.12];
%         text(50,1.1, 'CTR', 'FontSize', 12, 'Color', 'k', 'FontWeight', 'bold')
%         text(50,1.11, 'FIG', 'FontSize', 12, 'Color', 'r', 'FontWeight', 'bold')
        of = diff(axB.YLim)*.04;
        lv = axB.YLim(1)+of;
    end
    
    seq = [lv lv+of lv+of lv lv lv-of lv-of lv];
    ch = [0 5 45 50];
    for ic = 1:12
        fi  = fill([ch fliplr(ch)],seq, [0 0 0], 'LineStyle','none');
        ch = ch+50;
    end
end

%% Get data

mt8 = []; mt12 = []; mc = []; FG8 = []; FG12 = []; COH = []; F8 = []; F12 = []; lat8 = []; lat12 = [];
for iAn = 1:2
    
    ant = []; pos = []; muae = [];
    
    if iAn == 1
        animalID = 'Eric';
    else
        animalID = 'Dollar';
    end
    
    load([dest_dir '\tMap_' animalID '_' typ  '.mat']);
    AP      = find(logical(sum(~isnan(mfr_mat),2)));
    ML      = find(logical(sum(~isnan(mfr_mat))));
    [x,y] = coreBoundary(mfr_mat,AP,ML,false,animalID);
    
    if strcmp(animalID, 'Eric')
        muae = muaeE;
    elseif strcmp(animalID, 'Dollar')
        muae = muaeD;
    end
    
    [ant, pos] = sortUnits(x,y,muae);
    
    for iFi = 1:2
        
        if iFi == 1
            d = ant;
            str = 'ant';
        else
            d = pos;
            str = 'pos';
        end
        
        c = 0; cc = 0; mtar8 = []; mtar12 = []; mctr = []; f8 = []; f12 = []; latency12 = []; latency8 = []; dFG8 = []; dFG12 = []; dCoh = [];
        
        for ii = 1:size(d,2)
            incl = check20Hz(d{ii});
            if length(d{ii}.BLslope) < 200 || incl == 0
                continue
            end
            
            datestr	= str2num([d{ii}.id(1:4) d{ii}.id(6:7) d{ii}.id(9:10)]);
            test = mean([d{ii}.res.HI12(:,indxR); d{ii}.res.HI8(:,indxR)],2);
            ctrl = mean(d{ii}.res.CR(:,indxR),2);
            pp = anova1([test; ctrl],[zeros(size(test,1),1);ones(size(ctrl,1),1)], 'off');
            
            if pp < alph && sum(d{ii}.nTr>=10) == length(d{ii}.nTr) && datestr - 20190806 <= 0
                
                %%% Norm: subtract mBL then normalise by average control activity %%%
                mBL             = nanmean(nanmean(d{ii}.on.fullAvg(:,101:500),2));                          % Average BL response    
                c               = c+1;                                                                      % Counter
                fstim           = size(d{ii}.figfreqs,3);                                                   % Ratio of Fig to Gnd stim

                HIo8            = d{ii}.on.trlOn(d{ii}.on.cat == 3 & d{ii}.on.coh == 8,indx) ./mBL;
                HIo12           = d{ii}.on.trlOn(d{ii}.on.cat == 3 & d{ii}.on.coh == 12,indx) ./mBL;
                CRo             = d{ii}.on.trlOn(d{ii}.on.cat == 6,indx) ./mBL;

                mtar8(c,:)  	= nanmean(d{ii}.on.trlOn(d{ii}.on.cat == 3 & d{ii}.on.coh == 8,1:600) ./mBL);      	% Figure period - average across all coherence8 stimuli
                mtar12(c,:)  	= nanmean(d{ii}.on.trlOn(d{ii}.on.cat == 3 & d{ii}.on.coh == 12,1:600) ./mBL);      % Figure period - average across all coherence12 stimuli
                mctr(c,:)    	= nanmean(d{ii}.on.trlOn(d{ii}.on.cat == 6,1:600) ./mBL);                          	% Control period - average across all presented stimuli

                dCoh(c)         = mean((nanmean(HIo12) - nanmean(HIo8)) ./ nanstd([HIo8; HIo12]));                  % neural d-prime
                dFG8(c)         = mean((nanmean(HIo8) - nanmean(CRo)) ./ nanstd([HIo8; CRo]));
                dFG12(c)        = mean((nanmean(HIo12) - nanmean(CRo)) ./ nanstd([HIo12; CRo]));
            
                latency8(c,:) = d{ii}.sigT8;
                latency12(c,:) = d{ii}.sigT12;
                
                if ~isnan(sum(sum(d{ii}.RF)))
                    cc = cc+1;
                    no = [];
                    no = getFreqRF(d{ii}.RF, d{ii}.figfreqs);
                    
                    f8 = vertcat(f8, no(1:fstim/2,:));
                    f12 = vertcat(f12, no(fstim/2+1:fstim,:));
                end
            end
        end
        
        mt8{iAn,iFi} = mtar8;
        mt12{iAn,iFi} = mtar12;
        mc{iAn,iFi} = mctr;
        FG8{iAn,iFi} = dFG8;
        FG12{iAn,iFi} = dFG12;
        COH{iAn,iFi} = dCoh;
        lat8{iAn,iFi} = latency8;
        lat12{iAn,iFi} = latency12;
        F8{iAn,iFi} = f8;
        F12{iAn,iFi} = f12;
    end
end

for iAn = 1:2
    for iFi = 1:2
        p8(iAn,iFi)   = signrank(FG8{iAn, iFi});
        p12(iAn,iFi)  = signrank(FG12{iAn, iFi});
        pC(iAn,iFi)   = signrank(COH{iAn, iFi});
    end
end

pC = fdr(pC);
p8 = fdr(p8);
p12 = fdr(p12);

%% PLOT ANT vs POS %%%

lw = 1.5;
col = [0 0 0; 0 .9 0; .9 0 0];
dist = 'sem';
dim = [.2 .2];

for iAn = 1:2
    for iFi = 1:2
        
        if iAn == 1
            animalID = 'Eric';
            sigY        = [.4 .4;.475 .475;.55 .55];
            sigX        = [1.1 1.9; 1.1 2.9; 2.1 2.9];
            ofst        = .035;
            Yof         = .035;
        else
            animalID = 'Dollar';
            sigY        = [.27 .27;.32 .32;.37 .37];
            sigX        = [1.1 1.9; 1.1 2.9; 2.1 2.9];
            ofst        = .035;
            Yof         = .025;
        end
        
        %%% TIME TRACE %%%
        if iFi == 1 && iAn == 1
            axA = axes('Position',[.53 .77 .2 .2]); hold on
            axA.Title.String = 'M1';
            axA.XAxis.Visible = 'off';
            str = 'ant';
        elseif iFi == 2 && iAn == 1
            axA = axes('Position',[.53 .53 .2 .2]); hold on
            str = 'pos';
        elseif iFi == 1 && iAn == 2
            axA = axes('Position',[.78 .77 .2 .2]); hold on
            axA.Title.String = 'M2';
            axA.XAxis.Visible = 'off';
            str = 'ant';
        elseif iFi == 2 && iAn == 2
            axA = axes('Position',[.78 .53 .2 .2]); hold on
            str = 'pos';
        end
        
        axA.XLim = [1 600];
        plotFRsumm(mt8{iAn,iFi}(:,1:600),mt12{iAn,iFi}(:,1:600),mc{iAn,iFi}(:,1:600),str, dist,animalID, 0, col)
        
        of = diff(axA.YLim)*.04;
        lv = axA.YLim(1)+of;
        seq = [lv lv+of lv+of lv lv lv-of lv-of lv];
        ch = [0 5 45 50];
        for ic = 1:12
            fi  = fill([ch fliplr(ch)],seq, [0 0 0], 'LineStyle','none');
            ch = ch+50;
        end
        
        if iAn == 2
            axA.YLabel.String = [];
        elseif iFi == 1 && iAn == 1
            text(50,1.10, 'COH12', 'FontSize', 12, 'Color', col(3,:), 'FontWeight', 'bold')
            text(50,1.09, 'COH8', 'FontSize', 12, 'Color', col(2,:), 'FontWeight', 'bold')
            text(50,1.08, 'CTR', 'FontSize', 12, 'Color', col(1,:), 'FontWeight', 'bold')
        end
        
        %%% BAR PLOT %%%
        if iFi == 1 && iAn == 1
            axB1 = axes('Position',[.53 .23 dim]); hold on
            axB1.XAxis.Visible = 'off';
        elseif iFi == 2 && iAn == 1
            axB1 = axes('Position',[.53 .03 dim]); hold on
        elseif iFi == 1 && iAn == 2
            axB1 = axes('Position',[.77 .23 dim]); hold on
            axB1.XAxis.Visible = 'off';
        elseif iFi == 2 && iAn == 2
            axB1 = axes('Position',[.77 .03 dim]); hold on
        end
        
        arr = []; mat = [];
        arr = [ones(size(FG8{iAn,iFi},2),1); ones(size(FG12{iAn,iFi},2),1)+1;ones(size(COH{iAn,iFi},2),1)+2];
        mat = [FG8{iAn,iFi}';FG12{iAn,iFi}';COH{iAn,iFi}'];
        bx = boxplot(mat, arr, 'Colors', [0 0 0]);
        set(bx(end,:),'Visible','off')
        set(bx, {'linew'},{lw})
        box off  
        
        hgt = .58;
        ofs = .1;
        for iB = 1:3
            dpvec = [];
            if iB == 1
                dpvec = FG8{iAn,iFi};
                p = p8(iAn,iFi);
            elseif iB == 2
                dpvec = FG12{iAn,iFi};
                p = p12(iAn,iFi);
            elseif iB == 3
                dpvec = COH{iAn,iFi};
                p = pC(iAn,iFi);
            end
            
            x = [.8 1.8 2.8];
            xx = x(iB) + ((x(iB)+.4)-x(iB)).*rand(1,sum(arr == iB));
            sc = scatter(xx, mat(arr == iB)','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',0);
            if iB == 1
                sc.MarkerFaceColor = [0 1 0];
                sc.MarkerEdgeColor = [0 1 0];
            elseif iB == 2
                sc.MarkerFaceColor = [1 0 0];
                sc.MarkerEdgeColor = [1 0 0];
            elseif iB == 3
                sc.MarkerFaceColor = [.5 .5 .5];
                sc.MarkerEdgeColor = [.5 .5 .5];
            end
            sc.SizeData = 20;
            
            if p < .05
                if p < .001
                    xstar = [iB-ofs iB iB+ofs];
                    ystar = [repmat(hgt,1,3)];
                elseif p < .01 && p > .001
                    xstar = [iB-ofs/2 iB+ofs/2];
                    ystar = [repmat(hgt,1,2)];
                elseif p < .05 && p > .01
                    xstar = iB;
                    ystar = hgt;
                end
                star = plot(xstar, ystar, 'k*', 'LineWidth', 1.1);
                star.MarkerSize = 8;
            end
        end
        
        if iAn == 1
            if iFi == 1
                axB1.YLabel.String = {'ANT'; 'd-prime'};
                axB1. Position = [.53 .27 dim];
            else
                axB1.YLabel.String = {'POS'; 'd-prime'};
                axB1. Position = [.53 .05 dim];
            end
        else
            if iFi == 1
                axB1. Position = [.77 .27 dim];
            else
                axB1. Position = [.77 .05 dim];
            end
        end
        
        axB1.XTick = [1 2 3];
        axB1.XTickLabel = {'Coh8-Ctr', 'Coh12-Ctr', 'Coh12-Coh8'};
        axB1.XTickLabelRotation = 10;
        axB1.FontSize = 14;
        axB1.YLim = [-.3 .7];
 
    end
end

ax0 = axes('Position',[0 0 1 1],'Visible','off');
text(0,.98, 'a', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(0,.68, 'b', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(.32,.68, 'c', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(.46,.98, 'd', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(.46,.5, 'e', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')

addpath X:\Felix\Scripts\Stuff\export_fig-master
dest_dir = 'X:\Felix\Documents\Publications\FigGnd_Ephys\Figures\';
export_fig([dest_dir 'FIG23'], '-r400',f);