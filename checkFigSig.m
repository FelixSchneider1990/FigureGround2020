function [incl, hc, lat] = checkFigSig(cond, coh, plotFlag, N)
%% Compare FIG vs CTR
% Do 2-Factor ANOVA [figure x coherence]

if isempty(coh)
    if isfield(cond, 'o4')
        fig     = [cond.o4; cond.o8];                                        	% Get hit trials - across coherence levels
        figR    = [cond.r4; cond.r8];                                       	% Get hit trials - across coherence levels
        no      = [cond.sNo4; cond.sNo8];                                     	% Get hit trials - across coherence levels, response aligned
    else
        fig     = [cond.o8; cond.o12];                                        	% Get hit trials - across coherence levels
        figR    = [cond.r8; cond.r12];                                       	% Get hit trials - across coherence levels
        no      = [cond.sNo8; cond.sNo12];                                     	% Get hit trials - across coherence levels, response aligned
    end
else
    if ~isfield(cond, ['o' num2str(coh)])
        incl = []; hc = []; lat = [];
        return
    end
    
    fig     = cond.(['o' num2str(coh)]);
    figR    = cond.(['r' num2str(coh)]);
    no      = cond.(['sNo' num2str(coh)]);
end

ctr         = cond.cc(:,1:size(fig,2));                                  	% Get correct rejections
strf        = repmat('fig', size(fig,1), 1);                              	% Label
strc        = repmat('ctr', size(ctr,1), 1);                            	% Label
fact        = vertcat(strf,strc);                                          	% Concatenate figure and control trials
mat         = vertcat(fig,ctr);

for i = 1:size(mat,2)
    bin         = mat(:,i);                                                 % For each timebin...
    p(i)        = anova1(bin, cellstr(fact), 'off');                        % ANOVA to check if conditions differ
end

[pID, hc]       = fdr(p, 0.05);                                   	        % Corrections for multiple comparisons via false discovery rate
hc              = double(hc);
hc(hc == 0)     = nan;
h               = double(p < .05);
h(h == 0)       = nan;

if plotFlag
    % Plot data
    figure
    plot(nanmean(fig), 'r')
    hold on
    plot(nanmean(ctr), 'b')
    
    % Plot significance bar
    m = floor(min([nanmean(fig) nanmean(ctr)])) - .5;
    
    h           = h + m ;
    plot(h, 'k', 'LineWidth', 3)
    plot(hc + (m+.2), 'g', 'LineWidth', 3)
end

%% Check if units is responsive to single figure stimuli

% Avg of all trials in target window
mmat    = [mean(figR(:,201:400),2); mean(ctr(:,201:400),2)];                % Res @ 500: exclude -100:0, use -300:-100
pVal    = anova1(mmat, cellstr(fact), 'off');                               % ANOVA to check if conditions differ
incl(1) = pVal < .05;

% Single Stim
idF     = unique(no);                                                       % Get stimulus numbers for both conditions
idC     = unique(cond.sNoC);
dfAll   = [];
dfAllR  = [];

for iFig = 1:length(idF)
    f = []; c = []; idx = []; df = [];
    idx         = no == idF(iFig);                                          % Get trials for each stimulus
    f           = fig(idx,:);                                               % Onset aligned
    fR          = figR(idx,:);                                              % Response aligned
    mf(iFig,:)  = nanmean(f(:,401:600));                                	% Get average activity per figure stimulus [+200:+400ms after figOn]
    mfR(iFig,:) = nanmean(fR(:,201:400));                                	% Get average activity per figure stimulus -> response aligned [-300:-100ms before response]
    
    for iCtr = 1:length(idC)
        c               = ctr(cond.sNoC == idC(iCtr),:);                    % Get trials for each control stimulus
        mc(iCtr,:)      = nanmean(c(:,401:600));                          	% Get average activity per control stimulus [figOn+200:figOn+400]
        df(iCtr,:)      = nanmean(f)-nanmean(c);                            % Difference between FIG - CTR
        %         dfR(iCtr,:)     = nanmean(fR)-nanmean(c);
        
        if isnan(sum(mf(iFig,:))) || isnan(sum(mc(iCtr,:)))
            ppO(iCtr, iFig) = 1;
            ppR(iCtr, iFig) = 1;
        else
            ppO(iCtr, iFig) = signrank(mf(iFig,:),mc(iCtr,:));            	% Check if significantly different
            ppR(iCtr, iFig) = signrank(mfR(iFig,:),mc(iCtr,:));            	% Check if significantly different
        end
    end
    dfAll = vertcat(dfAll, df);                                             % Concatenate difference matrix across figures - onset aligned
    %     dfAllR = vertcat(dfAllR, dfR);                                          % Concatenate difference matrix across figures - response aligned
end

pBC = .05 / (size(ppR,1)* size(ppR,2));                                     % Bonferoni correction
responsiveO      = sum(ppO < pBC) > length(idC)/2;                         	% If FIG-CTR significantly different for more than half of control stimuli -> stimulus elicits figure response
responsiveR      = sum(ppR < pBC) > length(idC)/2;
incl(2)          = sum(responsiveO) > length(idF)/2;                     	% If at least half of stimuli induce a figure response -> unit is figure-responsive -> include in analysis
incl(3)          = sum(responsiveR) > length(idF)/2;

%% Find latency of figure response

% Get significant samples from bin-wise comparison
for i = 1:2
    clear t
    if i == 1
        t	= find(~isnan(h));                                            	% Get significant samples, uncorrected
    elseif i == 2
        t	= find(~isnan(hc));                                         	% Get significant samples, corrected for multiple comparisons
    end
    t(t<250)= [];                                                           % Exclude times before onset of second figure chord
    x       = diff(t) == 1;                                               	% Check if neighbours are consecutive
    f       = find([false,x] ~= [x,false]);                               	% Extract start/end points of sequences
    g       = find(f(2:2:end)-f(1:2:end-1) >= N,1,'first');               	% First sample followed by >=N consecutive numbers
    first_t = t(f(2*g-1));                                                  % Convert back to time sample
    
    if isempty(first_t)
        first_t = nan;
    end
    lat(i) = first_t-200;                                                   % Align to figure onset
end

% Bootstrap significance bar base on difference FIG-CTR
nRep            = 5000;                                                     % No. of repetitions
[bootstat,~]	= bootstrp(nRep,@mean, dfAll);                              % Bootstrap mean for each timebin
idx           	= sum(bootstat > 0);                                        % Get percentage of samples larger than zero
sig         	= double(idx < nRep*.001 | idx > nRep*.999);                % If more than 99.9%/less than 0.1% larger than zero -> significantly different
sig(sig == 0)  	= nan;
t             	= find(~isnan(sig));                                        % Get significant samples
t(t<250)    	= [];                                                       % Exclude times before onset of seconds figure chord
x               = diff(t) == 1;                                            	% Check if neighbours are consecutive
f               = find([false,x] ~= [x,false]);                           	% Extract start/end points of sequences
g               = find(f(2:2:end)-f(1:2:end-1) >= N,1,'first');            	% First sample followed by >=N consecutive numbers
first_t         = t(f(2*g-1));

if isempty(first_t)
    first_t = nan;
end
lat(3) = first_t-200;
end