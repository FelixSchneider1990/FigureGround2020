%%% STATS EPHYS PAPER %%%
%%% RUN FIGURE SCRIPT FIRST TO ACCESS VARIABLES %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% FIG1 %%%
% Behaviour: Repeated measures ANOVA

clear matD matE
% matE = dpE;
% matD = dpD;

% matE = mRTE;
% matD = mRTD;
 
matE = CVE;
matD = CVD;

matE(:,1)           = [];
matD(:,1)           = [];
matD(end-9:end,:,:) = [];

subjE   = repmat({'Eric'}, [(size(matE,1)), 1]);
subjD   = repmat({'Dollar'}, [(size(matD,1)), 1]);
subj    = vertcat(subjE,subjD);
mat     = [matE;matD];

t       = table(subj, mat(:,1), mat(:,2), ...
    'VariableName', {'Subject','coh8', 'coh12'});
meas    = table([1 2]','VariableNames',{'Measurements'});
rm      = fitrm(t,'coh8-coh12 ~ Subject','WithinDesign',meas);
sphere  = rm.mauchly;
rmTable = ranova(rm);

mean(matE)
mean(matD)
% median(matE)
% median(matD)

%% Linear mixed effects model

subjects{1} =  'Eric';
subjects{2} = 'Dollar';
sess        = [];
id          = [];
RT          = [];
coh         = [];
res         = [];
c           = 0;

for mID = 1:size(subjects,2)
    
    clear allFiles allNames Data
    monkey  = subjects{mID};
    pth     = 'Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\';
    cd([pth monkey])
    
    allFiles = dir([pth monkey]); % get all files in directory
    allNames = {allFiles.name}; % get all file names
    
    if mID == 1
        xof = 5;
    else
        xof = 2;
    end
        
    for i = 3:size(allNames,2)-xof    
        dmat        = [];
        curr_file   = allNames{i}; % get file name
        
        if exist([pth monkey '\' curr_file '\LogFile_' monkey '_' curr_file(1:10) '.csv']) == 2
            dmat = importdata([pth monkey '\' curr_file '\LogFile_' monkey '_' curr_file(1:10) '.csv']);
        else
            continue
        end
               
        % Content(curr_data):
        % column  1: Hit = 1; Error = 0;
        % column  2: PreFigEarly = 1; FigEarly = 2; Hit = 3; Late = 4;
        %            FalseAlarm = 5; CorrRejection = 6
        % column  3: RT [s]
        % column  4: Figure onset
        % column  5: Minimum bar holding time [s]
        % column  6: Maximum bar holding time [s]
        % column  7: Figure coherence
        % column  8: StimNo.
        
        if size(dmat,1) > 200
            c = c+1;
            
            if strcmp(monkey, 'Eric')
                mid = 1;
            else
                mid = 2;
            end
            
            sess    = vertcat(sess, repmat(c,size(dmat,1),1));
            id      = vertcat(id, repmat(mid,size(dmat,1),1));            
            RT      = vertcat(RT, dmat(:,3));
            res     = vertcat(res, dmat(:,2));
            coh     = vertcat(coh, dmat(:,7));

        end
    end
end

HIidx   = res == 3;
tbl     = table(RT(HIidx),coh(HIidx),sess(HIidx), id(HIidx), 'VariableNames',{'RT','Coh','Sess','ID'});

% lme = fitlme(tbl, 'RT~Coh + ( Coh | Sess ) + ( Coh | ID)'); % random intercept - repeated measures
lme1    = fitlme(tbl, 'RT ~1+ ( 1 | Sess ) + ( 1 | ID)'); % random model
lme2    = fitlme(tbl, 'RT~Coh + ( 1 | Sess ) + ( 1 | ID)'); % Coherence as predictor
stats   = compare(lme1,lme2);
[~,~,lmeStat] = fixedEffects(lme2);

%% FIG2 %%%

% Main Effect
clear figE figD ctrE ctrD subjE_fig subjD_fig subjE_ctr subjD_ctr subj Fg Ct
% indx = 201:400;
indx        = 401:600;

figE        = mean(FIG{1}(:,indx),2);
figD        = mean(FIG{2}(:,indx),2);
ctrE        = mean(CTR{1}(:,indx),2);
ctrD        = mean(CTR{2}(:,indx),2);

Fg          = [ones(size(figE,1),1);ones(size(figD,1),1)];
Ct          = [ones(size(ctrE,1),1)+1;ones(size(ctrD,1),1)+1];

subjE_fig   = repmat({'Eric'}, [(size(figE,1)), 1]);
subjD_fig   = repmat({'Dollar'}, [(size(figD,1)), 1]);
subjE_ctr   = repmat({'Eric'}, [(size(ctrE,1)), 1]);
subjD_ctr   = repmat({'Dollar'}, [(size(ctrD,1)), 1]);
subj        = vertcat(subjE_fig,subjD_fig,subjE_ctr,subjD_ctr);

[p, tbl, stats] = anovan([figE;figD;ctrE;ctrD],{subj, [Fg;Ct]},'varnames',{'subj','cond'});

% Perceptage responsive
size(FIG{1},1)/size(muaeE,2)
size(FIG{2},1)/size(muaeD,2)

% Peak delay
on = 0:50:550;
[pk, loc] = findpeaks(mean(CTR{2}), 'MinPeakHeight',1.055);
avgPK = mean(loc - on);

%% FIG 2e %%%

mFR = [mean(mt8{1,1}(:,401:600),2); ...
    mean(mt8{1,2}(:,401:600),2); ...
    mean(mt8{2,1}(:,401:600),2); ...
    mean(mt8{2,2}(:,401:600),2); ...
    mean(mt12{1,1}(:,401:600),2); ...
    mean(mt12{1,2}(:,401:600),2); ...
    mean(mt12{2,1}(:,401:600),2); ...
    mean(mt12{2,2}(:,401:600),2); ...
    mean(mc{1,1}(:,401:600),2); ...
    mean(mc{1,2}(:,401:600),2); ...
    mean(mc{2,1}(:,401:600),2); ...
    mean(mc{2,2}(:,401:600),2)];

sz   = cellfun(@size, mt8, 'UniformOutput', false);
cond = [zeros(sz{1,1}(1),1)+1; ...
    zeros(sz{1,2}(1),1)+1; ...
    zeros(sz{2,1}(1),1)+1; ...
    zeros(sz{2,2}(1),1)+1; ...
    zeros(sz{1,1}(1),1)+1; ...
    zeros(sz{1,2}(1),1)+1; ...
    zeros(sz{2,1}(1),1)+1; ...
    zeros(sz{2,2}(1),1)+1; ...
    zeros(sz{1,1}(1),1); ...
    zeros(sz{1,2}(1),1); ...
    zeros(sz{2,1}(1),1); ...
    zeros(sz{2,2}(1),1)];

field = [zeros(sz{1,1}(1),1)+1; ...
    zeros(sz{1,2}(1),1)+2; ...
    zeros(sz{2,1}(1),1)+1; ...
    zeros(sz{2,2}(1),1)+2; ...
    zeros(sz{1,1}(1),1)+1; ...
    zeros(sz{1,2}(1),1)+2; ...
    zeros(sz{2,1}(1),1)+1; ...
    zeros(sz{2,2}(1),1)+2; ...
    zeros(sz{1,1}(1),1)+1; ...
    zeros(sz{1,2}(1),1)+2; ...
    zeros(sz{2,1}(1),1)+1; ...
    zeros(sz{2,2}(1),1)+2];

subj = [zeros(sz{1,1}(1),1)+1; ...
    zeros(sz{1,2}(1),1)+1; ...
    zeros(sz{2,1}(1),1)+2; ...
    zeros(sz{2,2}(1),1)+2; ...
    zeros(sz{1,1}(1),1)+1; ...
    zeros(sz{1,2}(1),1)+1; ...
    zeros(sz{2,1}(1),1)+2; ...
    zeros(sz{2,2}(1),1)+2; ...
    zeros(sz{1,1}(1),1)+1; ...
    zeros(sz{1,2}(1),1)+1; ...
    zeros(sz{2,1}(1),1)+2; ...
    zeros(sz{2,2}(1),1)+2];

[p, tbl, stats] = anovan(mFR,{cond,field,subj},'varnames',{'cond','field','subj'});

% Mean activity
antE = mean(mean(mc{1,1}(:,401:600),2));
antD = mean(mean(mc{2,1}(:,401:600),2));

posE = mean(mean(mc{1,2}(:,401:600),2));
posD = mean(mean(mc{2,2}(:,401:600),2));

% Coherence difference
clear mFR field
mFR = [COH{1,1}'; ...
    COH{1,2}'; ...
    COH{2,1}'; ...
    COH{2,2}'];

sz = cellfun(@size, COH, 'UniformOutput', false);

field = [zeros(sz{1,1}(2),1)+1; ...
    zeros(sz{1,2}(2),1)+2; ...
    zeros(sz{2,1}(2),1)+1; ...
    zeros(sz{2,2}(2),1)+2];

[p, tbl, stats] = anovan(mFR,{field},'varnames',{'field'});

% Coherence post-hoc test
clear p
p(1) = signrank(COH{1,1}); % M1 % ANT
p(2) = signrank(COH{2,1}); % M2
p(3) = signrank(COH{1,2}); % POS
p(4) = signrank(COH{2,2});
fdr(p)

% Normalised MUA
mean(mean(mc{1,1},2))
mean(mean(mc{1,2},2))
mean(mean(mc{2,1},2))
mean(mean(mc{2,2},2))

std(mean(mc{1,1},2))
std(mean(mc{1,2},2))
std(mean(mc{2,1},2))
std(mean(mc{2,2},2))

[h,p] = ttest2(mean(mc{1,1},2),mean(mc{1,2},2))
[h,p] = ttest2(mean(mc{2,1},2),mean(mc{2,2},2))

% % Average coherence response
% mean(mean(mt8{1,1}(:,401:600),2))
% mean(mean(mt8{2,1}(:,401:600),2))
% mean(mean(mt12{1,1}(:,401:600),2))
% mean(mean(mt12{2,1}(:,401:600),2))

% % Magnitude
% daE = mean(mt12{1,1}(:,401:600),2)-mean(mt8{1,1}(:,401:600),2);
% daD = mean(mt12{2,1}(:,401:600),2)-mean(mt8{2,1}(:,401:600),2);
% dpE = mean(mt12{1,2}(:,401:600),2)-mean(mt8{1,2}(:,401:600),2);
% dpD = mean(mt12{2,2}(:,401:600),2)-mean(mt8{2,2}(:,401:600),2);
% 
% % Average difference
% mean(daD)
% mean(dpD)
% 
% % dff = [daE; daD; dpE; dpD];
% % fld = [zeros(length(daE),1);zeros(length(daD),1);ones(length(dpE),1);ones(length(dpD),1)];
% % monk = [zeros(length(daE),1);ones(length(daD),1);zeros(length(dpE),1);ones(length(dpD),1)];
% 
% % [p, tbl, stats]= anovan(dff,{fld,monk},'varnames',{'fld','monk'});
% [p, tbl, stats]= anova1([daE;dpE],[zeros(length(daE),1);ones(length(dpE),1)]);
% [p, tbl, stats]= anova1([daD;dpD],[zeros(length(daD),1);ones(length(dpD),1)]);


%% SFIG Latencies

clear coh field
Lat = [lat8{1,1}(:,3); ...
    lat8{1,2}(:,3); ...
    lat8{2,1}(:,3); ...
    lat8{2,2}(:,3); ...
    lat12{1,1}(:,3); ...
    lat12{1,2}(:,3); ...
    lat12{2,1}(:,3); ...
    lat12{2,2}(:,3)];

sz = cellfun(@size, lat8, 'UniformOutput', false);
coh = [zeros(sz{1,1}(1),1)+1; ...
    zeros(sz{1,2}(1),1)+1; ...
    zeros(sz{2,1}(1),1)+1; ...
    zeros(sz{2,2}(1),1)+1; ...
    zeros(sz{1,1}(1),1)+2; ...
    zeros(sz{1,2}(1),1)+2; ...
    zeros(sz{2,1}(1),1)+2; ...
    zeros(sz{2,2}(1),1)+2];

field = [zeros(sz{1,1}(1),1)+1; ...
    zeros(sz{1,2}(1),1)+2; ...
    zeros(sz{2,1}(1),1)+1; ...
    zeros(sz{2,2}(1),1)+2; ...
    zeros(sz{1,1}(1),1)+1; ...
    zeros(sz{1,2}(1),1)+2; ...
    zeros(sz{2,1}(1),1)+1; ...
    zeros(sz{2,2}(1),1)+2];

[p, tbl, stats] = anovan(Lat,{coh,field},'varnames',{'coh','field'});

%%% Median latency / SEM
[nanmedian(lat8{1,1}(:,3)) nanstd(lat8{1,1}(:,3)) / sqrt(length(lat8{1,1}(:,3)))]
[nanmedian(lat8{1,2}(:,3)) nanstd(lat8{1,2}(:,3)) / sqrt(length(lat8{1,2}(:,3)))]
[nanmedian(lat8{2,1}(:,3)) nanstd(lat8{2,1}(:,3)) / sqrt(length(lat8{2,1}(:,3)))]
[nanmedian(lat8{2,2}(:,3)) nanstd(lat8{2,2}(:,3)) / sqrt(length(lat8{2,2}(:,3)))]
[nanmedian(lat12{1,1}(:,3)) nanstd(lat12{1,1}(:,3)) / sqrt(length(lat12{1,1}(:,3)))]
[nanmedian(lat12{1,2}(:,3)) nanstd(lat12{1,2}(:,3)) / sqrt(length(lat12{1,2}(:,3)))]
[nanmedian(lat12{2,1}(:,3)) nanstd(lat12{2,1}(:,3)) / sqrt(length(lat12{2,1}(:,3)))]
[nanmedian(lat12{2,2}(:,3)) nanstd(lat12{2,2}(:,3)) / sqrt(length(lat12{2,2}(:,3)))]

%% FIG 3 %%%

% Percentage excitation
for iAn = 1:2      
        fracD(iAn) = sum(allAUCFD{iAn}(allIN{iAn}) > 0.5) / size(allAUCFD{iAn}(allIN{iAn}),2);
        fracO(iAn) = sum(allAUCFO{iAn}(allIN{iAn}) > 0.5) / size(allAUCFO{iAn}(allIN{iAn}),2);
end

%%% p-values, see script
% PFd
% PF
% PC
% PCd
% PHM
% PHMd
% PMC
% PMCd


%%% RT split %%%
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
        
        c = 0; ON = []; RES = [];     
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
                c = c + 1;
                ON(c,:) = d{ii}.RTsplit(1,:); % ON
                RES(c,:) = d{ii}.RTsplit(2,:); % RES
            end
        end
        on{iAn,iFi} = ON;
        res{iAn,iFi} = RES;
    end
end

frac(1,1) = sum(res{1,1}(:,1) < 0.05) / length(res{1,1}(:,1)); % [p mean(slow)>mean(fast)]
frac(1,2) = sum(res{1,2}(:,1) < 0.05) / length(res{1,2}(:,1));
frac(2,1) = sum(res{2,1}(:,1) < 0.05) / length(res{2,1}(:,1));
frac(2,2) = sum(res{2,2}(:,1) < 0.05) / length(res{2,2}(:,1));

lar(1,1) = 1 - (sum(res{1,1}(:,2) == 1) / length(res{1,1}(:,1)));
lar(1,2) = 1 - (sum(res{1,2}(:,2) == 1) / length(res{1,2}(:,1)));
lar(2,1) = 1 - (sum(res{2,1}(:,2) == 1) / length(res{2,1}(:,1)));
lar(2,2) = 1 - (sum(res{2,2}(:,2) == 1) / length(res{2,2}(:,1)));

%% FIG 4 %%%

lA8{iAn} = ant8(1:25,:,:);
lP8{iAn} = pos8(1:25,:,:);
hA8{iAn} = ant8(30:end,:,:);
hP8{iAn} = pos8(30:end,:,:);

lA12{iAn} = ant12(1:25,:,:);
lP12{iAn} = pos12(1:25,:,:);
hA12{iAn} = ant12(30:end,:,:);
hP12{iAn} = pos12(30:end,:,:);

%%% POWER %%%
clear pow coh field
ind = 201:400;

powAB = [squeeze(mean(mean(lA8{1}(:,ind,:),2))); ...
    squeeze(mean(mean(lA8{2}(:,ind,:),2))); ...
    squeeze(mean(mean(lA12{1}(:,ind,:),2))); ...
    squeeze(mean(mean(lA12{2}(:,ind,:),2))); ...
    squeeze(mean(mean(lP8{1}(:,ind,:),2))); ...
    squeeze(mean(mean(lP8{2}(:,ind,:),2))); ...
    squeeze(mean(mean(lP12{1}(:,ind,:),2))); ...
    squeeze(mean(mean(lP12{2}(:,ind,:),2)))];

powGA = [squeeze(mean(mean(hA8{1}(:,ind,:),2))); ...
    squeeze(mean(mean(hA8{2}(:,ind,:),2))); ...
    squeeze(mean(mean(hA12{1}(:,ind,:),2))); ...
    squeeze(mean(mean(hA12{2}(:,ind,:),2))); ...
    squeeze(mean(mean(hP8{1}(:,ind,:),2))); ...
    squeeze(mean(mean(hP8{2}(:,ind,:),2))); ...
    squeeze(mean(mean(hP12{1}(:,ind,:),2))); ...
    squeeze(mean(mean(hP12{2}(:,ind,:),2)))];

sz1 = length(squeeze(mean(mean(lA8{1}(:,ind,:),2))));
sz2 = length(squeeze(mean(mean(lA8{2}(:,ind,:),2))));
sz3 = length(squeeze(mean(mean(lP8{1}(:,ind,:),2))));
sz4 = length(squeeze(mean(mean(lP8{2}(:,ind,:),2))));

coh = [zeros(sz1,1); ...
    zeros(sz2,1); ...
    zeros(sz1,1)+1; ...
    zeros(sz2,1)+1; ...
    zeros(sz3,1); ...
    zeros(sz4,1); ...
    zeros(sz3,1)+1; ...
    zeros(sz4,1)+1];

field = [zeros(sz1,1); ...
    zeros(sz2,1); ...
    zeros(sz1,1); ...
    zeros(sz2,1); ...
    zeros(sz3,1)+1; ...
    zeros(sz4,1)+1; ...
    zeros(sz3,1)+1; ...
    zeros(sz4,1)+1];

nanmean(powGA)
sd      = nanstd(powGA);
n       = size(powGA,1);
sem     = sd/(sqrt(n));

nanmean(powAB)
sd      = nanstd(powAB);
n       = size(powAB,1);
sem     = sd/(sqrt(n));
    
pzero(1) = signrank(powAB);
pzero(2) = signrank(powGA);
fdr(pzero)

[p, tbl, stats] = anovan(powAB,{coh,field},'varnames',{'coh','field'});
[p, tbl, stats] = anovan(powGA,{coh,field},'varnames',{'coh','field'});


nanmean(powAB(field == 0))
nanmean(powAB(field == 1))
nanmean(powGA(field == 0))
nanmean(powGA(field == 1))
