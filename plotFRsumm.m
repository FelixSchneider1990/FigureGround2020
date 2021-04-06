function [p0,p8,p12] = plotFRsumm(mtar8,mtar12,mctr,str, dist,animalID, minBin, cm, mtar4, mctr_2)

% Difference fig-ctr for each cell
diff8               = mtar8(:,1:600) - mctr(:,1:600);
diff12              = mtar12(:,1:600) - mctr(:,1:600);

% Bootstrap significance bar
% nRep                = 5000;                                             	% No. of repetitions
% 
% [bootstat8,~]       = bootstrp(nRep,@mean, diff8);                          % Bootstrap mean for each timebin
% idx8                = sum(bootstat8 > 0);                                   % Get percentage of samples larger than zero
% sig8                = double(idx8 < nRep*.001 | idx8 > nRep*.999);          % If more than 99.5%/less than 0.5% larger than zero -> significantly different
% sig8                = double(idx8 < nRep*.05 | idx8 > nRep*.95);          % If more than 99.5%/less than 0.5% larger than zero -> significantly different
for iBin = 1:size(diff8,2)
    p8(iBin) = signrank(diff8(:,iBin));
end
sig8                 = double(fdr(p8) < .01);

% [bootstat12,~]      = bootstrp(nRep,@mean, diff12);
% idx12               = sum(bootstat12 > 0);
% sig12           	= double(idx12 < nRep*.001 | idx12 > nRep*.999);
% sig12               = double(idx12 < nRep*.05 | idx12 > nRep*.95);         
for iBin = 1:size(diff12,2)
    p12(iBin) = signrank(diff12(:,iBin));
end
sig12                 = double(fdr(p12) < .01);

if minBin == 1
    N                   = 10;                                             	% No. of consecutive samples
    t                   = find(sig8);                                     	% Find non-zero samples
    x                   = diff(t) == 1;                                     % Check if neighbours are consecutive
    f                   = find([false,x] ~= [x,false]);                   	% Extract start/end points of sequences
    g                   = find(f(2:2:end)-f(1:2:end-1) >= N);             	% All samples followed by >=N consecutive numbers
    ts                  = t(f(2*g-1));                                    	% Convert back to time bins
    zer                 = find(sig8 == 0);                               	% Find zeros
    s8                  = nan(1,600);                                    	% Initialise for plotting
    
    for i = 1:length(ts)
        oidx            = find(zer > ts(i));                               	% Get length of vector
        if isempty(oidx)
            stop = 600;
        else
            stop            = zer(oidx(1));
        end
        s8(ts(i):stop) = 1;                                             	% Replace with 1s
    end
    
    t                   = find(sig12);                                    	% Repeat for other coherence level
    x                   = diff(t) == 1;
    f                   = find([false,x] ~= [x,false]);
    g                   = find(f(2:2:end)-f(1:2:end-1) >= N);
    ts                  = t(f(2*g-1));
    zer                 = find(sig12 == 0);
    s12                 = nan(1,600);
    
    for i = 1:length(ts)
        oidx            = find(zer > ts(i));
        if isempty(oidx)
            stop = 600;
        else
            stop            = zer(oidx(1));
        end
        s12(ts(i):stop)    	= 1;
    end
else
    sig8(sig8 == 0) = nan;
    sig12(sig12 == 0) = nan;
end

%% Get data distribution

if strcmp(dist, 'CI')
    func = @mean;
    n = 1000;
    
    for j = 1:size(mtar8,2)
        CI8(:,j) = bootci(n, func, mtar8(:,j));
    end
    
    for j = 1:size(mtar12,2)
        CI12(:,j)= bootci(n, func, mtar12(:,j));
    end
    
    for j = 1:size(mctr,2)
        ctrCI(:,j)= bootci(n, func, mctr(:,j));
    end
    
elseif strcmp(dist, 'sem')
    
    for j = 1:size(mtar8,2)
        m       = mean(mtar8(:,j));
        sd      = std(mtar8(:,j));
        n       = length(mtar8(:,j));
        sem     = sd/(sqrt(n));
        CI8(:,j) = [m+sem/2; m-sem/2];
    end
    
    for j = 1:size(mtar12,2)
        m       = mean(mtar12(:,j));
        sd      = std(mtar12(:,j));
        n       = length(mtar12(:,j));
        sem     = sd/(sqrt(n));
        CI12(:,j) = [m+sem/2; m-sem/2];
    end
    
    for j = 1:size(mctr,2)
        m       = mean(mctr(:,j));
        sd      = std(mctr(:,j));
        n       = length(mctr(:,j));
        sem     = sd/(sqrt(n));
        ctrCI(:,j) = [m+sem/2; m-sem/2];
        
    end
end

%% Plot

% Control/Ground stimuli
l = 1:length(ctrCI);
len = [l fliplr(l)];
ci = [ctrCI(1,:) fliplr(ctrCI(2,:))];
fill(len,ci,cm(1,:)*0.7,'EdgeColor','none', 'FaceAlpha', .3);
hold on
p0 = plot(mean(mctr), 'Color', cm(1,:), 'LineWidth', 2);
xlim([1 600])

l = 1:length(CI8);
len = [l fliplr(l)];
ci = [CI8(1,:) fliplr(CI8(2,:))];
fill(len,ci,cm(2,:)*0.7,'EdgeColor','none', 'FaceAlpha', .3);
hold on
p8 = plot(mean(mtar8), 'Color', cm(2,:), 'LineWidth', 2);

l = 1:length(CI12);
len = [l fliplr(l)];
ci = [CI12(1,:) fliplr(CI12(2,:))];
fill(len,ci,cm(3,:)*0.7,'EdgeColor','none', 'FaceAlpha', .3);
hold on
p12 = plot(mean(mtar12), 'Color', cm(3,:), 'LineWidth', 2);

ax = gca;
ax.FontSize = 14;
ax.XTick = [1 200 400 600];
ax.XTickLabel = {-200 0 200 400};
xlabel('Time [ms]')
box off

% if strcmp(str, 'ant')
%     ylabel({'ANT';'MUA [norm]'})
% else
%     ylabel({'POS';'MUA [norm]'})
% end

if strcmp(str, 'ant')
    ylabel({'MUA [norm]'})
else
    ylabel({'MUA [norm]'})
end

switch animalID
    case 'Dollar'
        if strcmp(str, 'ant')
%             ax.YTick = [1 1.1];
            ax.YLim = [1 1.16];
            plot([200 200], [-1 2], 'k--', 'Linewidth', 1.5)
        elseif strcmp(str, 'pos')
%             ax.YTick = [1 1.1];
            ax.YLim = [1 1.16];
            plot([200 200], [-1 2], 'k--', 'Linewidth', 1.5)
        end
        
        sig8(~isnan(sig8)) = ax.YLim(2) - diff(ax.YLim)*.03;
        sig12(~isnan(sig12)) = ax.YLim(2) - diff(ax.YLim)*.01;
        plot(1:length(sig8), sig8,  'Color', cm(2,:), 'LineWidth', 3);
        plot(1:length(sig12), sig12,  'Color', cm(3,:), 'LineWidth', 3);   
        
%         %%% COH4 SETTINGS %%%
%         if strcmp(str, 'ant')
%             ax.YTick = [0 .3 .6];
%             ax.YLim = [-.1 .6];
%             plot([200 200], [-1 1], 'k--', 'Linewidth', 1.5)
%             
%             plot(1:length(sig8), sig8-.42,  'Color', cm(2,:), 'LineWidth', 3);
%             plot(1:length(sig12), sig12-.41,  'Color', cm(3,:), 'LineWidth', 3);
%             
%         elseif strcmp(str, 'pos')
%             ax.YTick = [0 .22 .42];
%             ax.YLim = [-.1 .4];
%             plot([200 200], [-1 1], 'k--', 'Linewidth', 1.5)
%             
%             plot(1:length(sig8), sig8-.62,  'Color', cm(2,:), 'LineWidth', 3);
%             plot(1:length(sig12), sig12-.61,  'Color', cm(3,:), 'LineWidth', 3);
%         end
        
    case 'Eric'
        if strcmp(str, 'ant')
%             ax.YTick = [1 1.1];
            ax.YLim = [1 1.16];
            plot([200 200], [-1 2], 'k--', 'Linewidth', 1.5)
        elseif strcmp(str, 'pos')
%             ax.YTick = [1 1.1];
            ax.YLim = [1 1.16];
            plot([200 200], [-1 2], 'k--', 'Linewidth', 1.5)
        end
                    
        sig8(~isnan(sig8)) = ax.YLim(2) - diff(ax.YLim)*.03;
        sig12(~isnan(sig12)) = ax.YLim(2) - diff(ax.YLim)*.01;
        plot(1:length(sig8), sig8,  'Color', cm(2,:), 'LineWidth', 3);
        plot(1:length(sig12), sig12,  'Color', cm(3,:), 'LineWidth', 3);
            
end

% print(f,['Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\' animalID '\Plots\FRsummary_' str], '-dpng', '-r500')

end