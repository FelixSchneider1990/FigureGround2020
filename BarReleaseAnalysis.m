%% Bar release paradigm: Import, trial extraction, analysis

clear all

r = {'2019-09-11_12-51-27' ...
    '2019-09-11_12-18-47' ...
    '2019-09-11_11-53-25' ...
    '2019-09-11_11-28-28' ...
    '2019-09-11_10-42-40' ...
    '2019-09-10_14-13-02' ...
    '2019-09-10_13-14-55' ...
    '2019-09-10_12-34-32' ...
    '2019-09-10_11-51-15' ...
    '2019-09-10_10-37-45'};

allWN = [];
allBR = [];
sigBR = [];
alltfa = [];
allBR_alig = [];
allBR_notalig = [];

for iRec = 1:length(r)
    clearvars -except allWN allBR allBR_alig allBR_notalig alltfa sigBR r iRec
    
    data.sdir = ['/Users/fschneider/OneDrive - Newcastle University/' r{iRec} '/'];
    data.param.nChan = [2 3 4];
    cd(data.sdir)
%     writeMUAe(data,0)
    
    % Event codes
    trl = 198;  % trial start
    bar = 199;  % bar touch
    rel = 200;  % bar release
    rew = 194;  % reward
    
    WNstart         = 221;          % White noise start
    WNend           = 222;          % White noise end
    WNon            = 199;          % White noise on
    WNoff           = 210;          % White noise off

    % Import events
    [TimestampsEV, EventIDs, TTLs, Extras, EventStrings, HeaderEV] ...
        = Nlx2MatEV('Events.nev', [1 1 1 1 1], 1, 1, [] );  % get event file
    
    TimestampsEV  	= TimestampsEV./10^3;               % convert to ms
    firstEV         = TimestampsEV(1);                  % get first event
    EVts          	= TimestampsEV - firstEV;           % align to first event
    TTLs            = TTLs;
    
    %% Get trial boundaries

    %%% Get WN sequences %%%
    wnOn   = find(TTLs == WNstart);
    wnEnd  = find(TTLs == WNend);
    
    % Extract TTLs and timestamps
    for i = 1:length(wnEnd)
        wnEvents{i}     = (wnOn(i):wnEnd(i));
        wnEv{i}         = TTLs(wnEvents{i});                           
        wnTS{i}         = EVts(wnEvents{i});                          
    end
    
    TSwn = []; EVwn = [];
    for ii = 1:length(wnEvents)
        if length(wnEvents{ii}) > 2
            TSwn = horzcat(TSwn,wnTS{ii});
            EVwn = horzcat(EVwn,wnEv{ii});
        end
    end
    
    WN.sOn     = TSwn(EVwn == WNon);
    WN.sEnd    = TSwn(EVwn == WNoff);
    
    %%% Get bar release trials %%%
    ton   = find(TTLs == bar);
    tend = find(TTLs == rew);
    
    for i = 1:length(tend)
        tOn(i) = max(ton(ton < tend(i)));
    end
    
    % Extract TTLs and timestamps
    for i = 1:length(tend)
        events{i}     = (tOn(i):tend(i));
        ev{i}         = TTLs(events{i});                           
        ts{i}         = EVts(events{i}); 
        
        BR.on(i)    = ts{i}(1);
        BR.end(i)    = ts{i}(end);
    end
   
    %% Import channel data
    for iCh = 1:length(data.param.nChan)
        clear WNsig BRsig tfa
        chan = data.param.nChan(iCh);

        %% MUA 
        fname   = ['MUAe' num2str(chan) '.ncs'];
        
        % Import continuous file
        [Timestamps, ChannelNumbers, SampleFrequencies, NumberOfValidSamples, Samples, Header] = ...
            Nlx2MatCSC(fname, [1 1 1 1 1], 1, 1, [] );                              % Get channel data [.ncs]
        
        % Find information in header
        rowAD               = find(contains(Header(:), '-ADBitVolts'));
        rowFS               = find(contains(Header(:), '-SamplingFrequency'));
        
        % Convert data
        Timestamps          = Timestamps./10^3;                                     % Convert to [ms]
        Timestamps          = Timestamps - firstEV;                                 % Align timestamps to first event
        Samples             = Samples .* str2double(Header{rowAD}(13:end)) .* 1e6;  % Convert samples to [uV]
        
        % Vectorise samples
        vSamplesMUA        = reshape(Samples, 1, []);                              % Vectorised samples
        
        for j = 1:size(Samples,2)
            if j < size(Samples,2)-1
                ts1         = Timestamps(j);
                ts2         = Timestamps(j+1);
                diff(j)     = ts2 - ts1;
                new(:,j)    = [ts1 linspace(ts1,ts2,size(Samples,1)-1)]';           % Get timestamp for each sample
            elseif j == size(Samples,2)
                ts1         = Timestamps(j);
                ts2         = ts1+mean(diff);                                       % Mean difference between timestamps for last offset
                new(:,j)    = [ts1 linspace(ts1,ts2,size(Samples,1)-2) ts2]';
            end
        end
        
        vTimeMUA           = reshape(new, 1, []);                                  % Vectorised timestamps
        
        %% LFP
        clear Timestamps ChannelNumbers SampleFrequencies NumberOfValidSamples Samples Header
        fname   = ['LFP' num2str(chan) '.ncs'];
        
        % Import continuous file
        [Timestamps, ChannelNumbers, SampleFrequencies, NumberOfValidSamples, Samples, Header] = ...
            Nlx2MatCSC(fname, [1 1 1 1 1], 1, 1, [] );                              % Get channel data [.ncs]
        
        % Find information in header
        rowAD               = find(contains(Header(:), '-ADBitVolts'));
        rowFS               = find(contains(Header(:), '-SamplingFrequency'));
        
        % Convert data
        Timestamps          = Timestamps./10^3;                                     % Convert to [ms]
        Timestamps          = Timestamps - firstEV;                                 % Align timestamps to first event
        Samples             = Samples .* str2double(Header{rowAD}(13:end)) .* 1e6;  % Convert samples to [uV]
        
        % Vectorise samples
        vSamplesLFP        = reshape(Samples, 1, []);                              % Vectorised samples
        
        for j = 1:size(Samples,2)
            if j < size(Samples,2)-1
                ts1         = Timestamps(j);
                ts2         = Timestamps(j+1);
                diff(j)     = ts2 - ts1;
                new(:,j)    = [ts1 linspace(ts1,ts2,size(Samples,1)-1)]';           % Get timestamp for each sample
            elseif j == size(Samples,2)
                ts1         = Timestamps(j);
                ts2         = ts1+mean(diff);                                       % Mean difference between timestamps for last offset
                new(:,j)    = [ts1 linspace(ts1,ts2,size(Samples,1)-2) ts2]';
            end
        end
        
        vTimeLFP           = reshape(new, 1, []);                                  % Vectorised timestamps
                                
        %% Get MUA WN response
        
        preWin              = 200;                                                  % Period before stimOn [ms]
        postWin             = 100;                                                  % Period after stimEnd [ms]
       
        for jj = 1:length(WN.sOn)
            tmp         = vSamplesLFP(vTimeLFP > (WN.sOn(jj)-preWin) & vTimeLFP < (WN.sEnd(jj)+postWin));    % [200ms BL, Full stimulus period, 100ms PostStim]
            
            if length(tmp) >= 500
                WNsig.LFP(jj,:) = tmp(1:500);
            else
                WNsig.LFP(jj,:) = [tmp  nan(1,500-length(tmp))];
            end
        end
        
        for jj = 1:length(WN.sOn)
            tmp         = vSamplesMUA(vTimeMUA > (WN.sOn(jj)-preWin) & vTimeMUA < (WN.sEnd(jj)+postWin));    % [200ms BL, Full stimulus period, 100ms PostStim]
            
            if length(tmp) >= 500
                WNsig.MUA(jj,:) = tmp(1:500);
            else
                WNsig.MUA(jj,:) = [tmp  nan(1,500-length(tmp))];
            end
        end  
        
        % Exclude trials
        idx = logical(sum((WNsig.LFP(:,[1:200 401:500]) < -399 | WNsig.LFP(:,[1:200 401:500]) > 399),2));
        WNsig.MUA(idx,:) = [];
        WNsig.LFP(idx,:) = [];
        
        %% Get MUA bar release responses
        clear tmp
        preWin              = 1000;                                                  % Period before bar release [ms]
        postWin             = 100;                                                  % Period after bar release [ms]
        
        for jj = 1:length(BR.end)
            tmp         = vSamplesLFP(vTimeLFP > (BR.end(jj)-preWin) & vTimeLFP < (BR.end(jj)+postWin));
            
            if length(tmp) >= 1100
                BRsig.LFP(jj,:) = tmp(1:1100);
            else
                BRsig.LFP(jj,:) = [tmp  nan(1,1100-length(tmp))];
            end
        end
                
        for jj = 1:length(BR.end)
            tmp         = vSamplesMUA(vTimeMUA > (BR.end(jj)-preWin) & vTimeMUA < (BR.end(jj)+postWin));
            
            if length(tmp) >= 1100
                BRsig.MUA(jj,:) = tmp(1:1100);
            else
                BRsig.MUA(jj,:) = [tmp  nan(1,1100-length(tmp))];
            end
        end
        
        % Exclude trials
        idx = logical(sum((BRsig.LFP(:,1:900) < -250 | BRsig.LFP(:,1:900) > 250),2));
        BRsig.MUA(idx,:) = [];
        BRsig.LFP(idx,:) = [];
          
        % Time-frequency analysis
        for iTr = 1:size(BRsig.LFP,1)
            tr(iTr,:) = BRsig.LFP(iTr,1:1000);
            cSig(:,:,iTr)  = LFP_timeFreqAnalysis(tr(iTr,:), 1000, 7, 100, 100);
        end
        tfa = LFP_exclCycle(abs(cSig).^2, 7, 100, 100, 2);
        norm = nanmean(mean(tfa,3),2);
        npow(:,:,iCh) = mean(tfa,3) ./ norm;
        
        % Baseline correction & Normalisation by max WN response
        nVal            = max(nanmean(WNsig.MUA(:,201:400)));

        % Average
        avgWN(iCh,:)    = nanmean(WNsig.MUA ./ nVal);
        avgBR(iCh,:)    = nanmean(BRsig.MUA ./ nVal);  
       
        map = BRsig.LFP > 399;
        ind = logical(sum(map(:,1:1000),2));
        avgBR_alig(iCh,:)    = nanmean(BRsig.MUA(~ind,:) ./ nVal);
        avgBR_notalig(iCh,:) = nanmean(BRsig.MUA(ind,:) ./ nVal);

%         % Significant?
%         st = 501:100:951;
%         for i = 1:length(st)
%         [p(iCh, i),h(iCh,i)] = signrank(mean(BRsig.MUA(:,1:500),2), nanmean(BRsig.MUA(:,st(i):st(i)+49),2));
%         end
    end
    
    allWN = vertcat(allWN, avgWN);
    allBR = vertcat(allBR, avgBR);
    alltfa = cat(3,alltfa, npow);
    
    allBR_alig = vertcat(allBR_alig, avgBR_alig);
    allBR_notalig = vertcat(allBR_notalig, avgBR_notalig);
    
%     sigBR = vertcat(sigBR, h);
end
dest_dir = '/Users/fschneider/ownCloud/NCL_revision';
save([dest_dir 'allWN.mat'], 'allWN', '-v7.3')
save([dest_dir 'allBR.mat'], 'allBR', '-v7.3')
save([dest_dir 'tfa_BR.mat'], 'alltfa', '-v7.3')
save([dest_dir 'allBR_alig.mat'], 'allBR_alig', '-v7.3')
save([dest_dir 'allBR_notalig.mat'], 'allBR_notalig', '-v7.3')

% for j = 1:size(allBR,1)
%     figure
%     plot(allBR(j,:))
%     ym = mean(allBR(j,1:500));
%     ys = std(allBR(j,1:500));
%     ylim([ym-(3*ys)  ym+(5*ys)])
%     vline(1000)
% end