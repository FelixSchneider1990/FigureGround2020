%% Import

% load('Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\Eric\Summary\muae.mat')
% muaeE = muae;
% load('Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\Dollar\Summary\muae.mat')
% muaeD = muae;
% clear muae
% 
% load('Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\Eric\Summary\bRaw.mat')
% behE = bRaw;
% load('Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\Dollar\Summary\bRaw.mat')
% behD = bRaw;
% clear bRaw

clearvars -except muaeD muaeE behD behE

sigma = 3;
sz = 25;    % length of gaussFilter vector
x = linspace(-sz / 2, sz / 2, sz);
gaussFilter = exp(-x .^ 2 / (2 * sigma ^ 2));
gaussFilter = gaussFilter / sum (gaussFilter); % normalize

%% Get figure data

indxR       = 201:400;          % corresponds to -300:-100ms to decision
alph        = .01;              % significance boundary
boundary    = 1.1371e+03;       % Median of all figure means (see below)
mFIG        = [];
allFigF     = [];
cohV        = [];
d           = [muaeE muaeD];    % aligned units
b           = [behE; behD];     % raw behaviour
c           = 0;                % counter

for iUnit = 1:size(d,2)
    clear test ctrl trls onTrls figfreqs coh res sNo mfig
    
    incl = check20Hz(d{iUnit}); % check if sound responsive
    if length(d{iUnit}.BLslope) < 200 || incl == 0
        continue
    end
    
    datestr     = str2num([d{iUnit}.id(1:4) d{iUnit}.id(6:7) d{iUnit}.id(9:10)]);
    test        = mean([d{iUnit}.res.HI12(:,indxR); d{iUnit}.res.HI8(:,indxR)],2);
    ctrl        = mean(d{iUnit}.res.CR(:,indxR),2);
    pp          = anova1([test; ctrl],[zeros(size(test,1),1);ones(size(ctrl,1),1)], 'off');
    
    if pp < alph && sum(d{iUnit}.nTr>=10) == length(d{iUnit}.nTr) && datestr - 20190806 <= 0
        
        c       = c+1;
        mBL     = nanmean(nanmean(d{iUnit}.on.fullAvg(:,101:500),2));   % Average BL response
        trls    = d{iUnit}.on.trlOn ./ mBL;                             % Onset-aligned trials [baseline-normalised]
        figfreq = d{iUnit}.figfreqs;                                    % Stimulus specs (8 chords after figure onset)
        
        bIdx = [];
        for iSess = 1:size(b,1)
            bIdx(iSess) = strcmp(b{iSess,2}(end-18:end), d{iUnit}.id(1:19));
        end
        bIdx = logical(bIdx);
        
        coh     = b{bIdx,1}(:,7);            % Coherence level
        res     = b{bIdx,1}(:,2);            % Behavioural response (1/2 = Early MI | 3 = HI | 4 = MI | 5 = FA | 6 = CR)
        sNo     = b{bIdx,1}(:,8);            % Stimulus numbers
        sID     = unique(sNo);               % Stimulus ID (20 stim, 60% include figure -> 1:12 figure, 13:20 control stimuli)
        
        if size(trls,1) ~= size(coh,1)
            c = c-1;
            continue
        end

        % Remove excluded trials
        nanIdx          = [];
        nanIdx          = isnan(mean(trls,2));
        trls(nanIdx,:)  = [];
        coh(nanIdx)     = [];
        res(nanIdx)     = [];
        sNo(nanIdx)     = [];
        mfig            = [];
        fgvec           = zeros(length(sNo),1);
        
        for iFig = 1:size(figfreq,3)
            if iFig <= size(figfreq,3)/2
                fIdx = 8;
                cohV = cat(1,cohV,8);
            else
                fIdx = 4;
                cohV = cat(1,cohV,12);
            end
            
            f = [];
            f               = figfreq(fIdx:end,1,iFig);     % Figure frequencies
            mfig(iFig)      = geomean(f);                   % Geometric mean
            allFigF         = cat(1,allFigF,f);
            
            if mfig(iFig) > boundary
                fgvec(sNo == sID(iFig)) = 1; % high
            elseif mfig(iFig) <= boundary
                fgvec(sNo == sID(iFig)) = 2; % low
            end

        end
        
        fgs                 = sID(1:length(sID)*.6);
        figAvg              = mfig > boundary;              % Index: Figure mean > boundary?
        mFIG                = cat(2, mFIG, mfig);           % Save stimulus information
        stm{c}              = sNo;   
        
        chlvl               = zeros(length(sNo),1);
        chlvl(sNo <= 300) 	= 8;
        chlvl(sNo > 300 & sNo <= 600) = 12;
        
        clvl{c}             = chlvl;
        flvl{c}             = fgvec;
        
        % dPCA data format:
        % trialNum: N x S x D
        % firingRates: N x S x D x T x maxTrialNum
        % firingRatesAverage: N x S x D x T
        %
        % N is the number of neurons
        % S is the number of stimuli conditions (F1 frequencies in Romo's task)
        % D is the number of decisions (D=2)
        % T is the number of time-points (note that all the trials should have the
        % same length in time!)
        
        for iCat = 1:4%1:5 % figure characteristics
            stIdx = []; sIDs = [];
            
            % Get stimulus ID
            if iCat == 1
                sIDs = sID(figAvg(1:length(figAvg)));
            elseif iCat == 2
                sIDs = sID(~figAvg(1:length(figAvg)));
            elseif iCat == 3
                sIDs = sID(sID<=300);
            elseif iCat == 4
                sIDs = sID(sID>300 & sID<=600);
%             elseif iCat == 5
%                 sIDs = sID(sID>600);
            end

%          for iCat = 1:2 % Fig-Ctr
%             stIdx = []; sIDs = [];
%             
%             % Get stimulus ID
%             if iCat == 1 % figure
%                 sIDs = sID(sID<600);
%             elseif iCat == 2 % control
%                 sIDs = sID(sID>600);
%             end
            
%         for iCat = 1:2 % figure characteristics
%             stIdx = []; sIDs = [];
%             
%             % Get stimulus ID
%             if iCat == 1
%                 sIDs = sID(figAvg(1:length(figAvg)));
%             elseif iCat == 2
%                 sIDs = sID(~figAvg(1:length(figAvg)));
%             end
            
%             if iCat == 1
%                 sIDs = sID(sID<=300);
%             elseif iCat == 2
%                 sIDs = sID(sID>300 & sID<=600);
%             end
            
            for ii = 1:length(sIDs)
                stIdx(:,ii) = sNo == sIDs(ii);
            end
            stIdx = logical(sum(stIdx,2)); % Stimulus index
            
            for iRes = 1:2 
%                 % Correct-Error
%                 decIdx = [];
%                 if iCat < 5
%                     if iRes == 1
%                         decIdx = res == 3;  % Correct [HI] --- Decision index
%                     elseif iRes == 2
%                         decIdx = res == 4;  % Error [MI]
%                     end
%                 else
%                     if iRes == 1
%                         decIdx = res == 6;  % Correct [CR] --- Decision index
%                     elseif iRes == 2
%                         decIdx = res == 5;  % Error [FA]
%                     end
%                 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 % Correct-Error
%                 decIdx = [];
%                 if iCat == 1
%                     if iRes == 1
%                         decIdx = res == 3;  % Correct [HI] --- Decision index
%                     elseif iRes == 2
%                         decIdx = res == 4;  % Error [MI]
%                     end
%                 elseif iCat == 2
%                     if iRes == 1
%                         decIdx = res == 6;  % Correct [CR] --- Decision index
%                     elseif iRes == 2
%                         decIdx = res == 5;  % Error [FA]
%                     end
%                 end

                % Correct-Error
                decIdx = [];
                if iRes == 1
                    decIdx = res == 3;  % Correct [HI] --- Decision index
                elseif iRes == 2
                    decIdx = res == 4;  % Error [MI]
                end


                trialNum(c,iCat,iRes) = sum(decIdx & stIdx); % Select trials
                              
                clear tmp
                if trialNum(c,iCat,iRes) == 0
                    trialNum(c,iCat,iRes)= 1;
                    tmp = trls(randi(size(trls,1)),:); % Insert random trial if trialNum is zero
                else
                    tmp = trls(decIdx & stIdx,:);
                end          
                
                for itr = 1:size(tmp,1)
                    tfilt = gfilter(gaussFilter, tmp(itr,:));
                    tmp(itr,:) = tfilt;
                end
%                 if trialNum(c,iCat,iRes) ~= size(tmp)
%                     warning(num2str([iUnit c]))
%                 end
                
                mat                             = nan(600, 500);
                mat(:,1:size(tmp,1))            = tmp';
                firingRates(c,iCat,iRes,:,:)    = mat;
   
            end
        end
    end
end

boundary            = median(mFIG);
firingRatesAverage  = nanmean(firingRates, 5);

pth = '\\campus\rdw\ion08\08\Felix\dPCA\';
save([pth 'trialNum.mat'], 'trialNum', '-v7.3')
save([pth 'trials.mat'], 'firingRates', '-v7.3')
save([pth 'trialAvg.mat'], 'firingRatesAverage', '-v7.3')

%%
for i = 1:size(stm,2)
    aa(:,i) = autocorr(stm{i},'NumLags',50,'NumSTD',3);
    bb(:,i) = autocorr(flvl{i},'NumLags',50,'NumSTD',3);
    cc(:,i) = autocorr(clvl{i},'NumLags',50,'NumSTD',3);
    
    xc(:,i) = xcorr(flvl{i}==1,flvl{i}==2, 50,'normalized');
    xcc(:,i) = xcorr(clvl{i}==8,clvl{i}==12, 50,'normalized');
end

figure
subplot(5,2,1)
imagesc(aa')
xlabel('lags')
ylabel('units')
cb = colorbar;
subplot(5,2,2)
plot(mean(aa,2))
xlim([1 50])
title('Stim ID')
ylabel('avg autocorr')
xlabel('lags')

subplot(5,2,3)
imagesc(bb')
xlabel('lags')
ylabel('units')
cb = colorbar;
subplot(5,2,4)
plot(mean(bb,2))
xlim([1 50])
title('Fig Mean')
ylabel('avg autocorr')
xlabel('lags')

subplot(5,2,5)
imagesc(cc')
xlabel('lags')
ylabel('units')
cb = colorbar;
subplot(5,2,6)
plot(mean(cc,2))
xlim([1 50])
title('Coherence')
ylabel('avg autocorr')
xlabel('lags')
print('autocorr','-dpng', '-r400')

subplot(5,2,7)
imagesc(xc')
xlabel('lags')
ylabel('units')
cb = colorbar;
subplot(5,2,8)
plot(mean(xc,2))
xlim([1 101])
title('Fig Mean')
ylabel('avg xcorr')
xlabel('lags')

subplot(5,2,9)
imagesc(xcc')
xlabel('lags')
ylabel('units')
cb = colorbar;
subplot(5,2,10)
plot(mean(xcc,2))
xlim([1 101])
title('Coherence')
ylabel('avg xcorr')
xlabel('lags')
print('autocorr','-dpng', '-r400')

% a = zeros(1,100);
% b = zeros(1,100);
% for i = 1:100
%     if mod(i,2) == 1
%         a(i) = 1;
%     else
%         b(i) = 1;
%     end
% end
% plot(xcorr(a,b)); shg
%%
function out = gfilter(gaussFilter, in)
out = filtfilt(gaussFilter, 1, in);
end
% figure
% h = histogram(allFigF, 50);
% h.FaceColor = [0 0 0];
% l1 = line([median(allFigF) median(allFigF)], [0 4500]);
% l1.Color = [1 0 0];
% l1.LineStyle = ':';
% l1.LineWidth = 2;
% l3 = line([mean(allFigF) mean(allFigF)], [0 4500]);
% l3.Color = [0 0 1];
% l3.LineStyle = ':';
% l3.LineWidth = 2;
% 
% 
% legend([l1,l3], 'Median All', 'Mean All')
% xlabel('Freq [Hz]')
% ylabel('Number')
% title('All figure frequencies [n = 3060 stim]')
% 
% figure
% h = histogram(mFIG, 50);
% h.FaceColor = [0 0 0];
% l2 = line([median(mFIG) median(mFIG)], [0 350]);
% l2.Color = [1 0 0];
% l2.LineStyle = ':';
% l2.LineWidth = 2;
% l4 = line([mean(mFIG) mean(mFIG)], [0 350]);
% l4.Color = [0 0 1];
% l4.LineStyle = ':';
% l4.LineWidth = 2;
% 
% legend([l2,l4], 'Median FigGeomean', 'Mean FigGeomean')
% xlabel('Freq [Hz]')
% ylabel('Number')
% title('Avg figure frequencies [n = 3060 stim]')
