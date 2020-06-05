function out = getBehaviour(data)
% Import log-file and calculate behavioural performance.
% Felix Schneider, 03/2018

disp('Get behavioural performance...')
fname = [data.sdir 'LogFile_' data.animalID ...
    '_' data.param.fname(1:10) '.csv'];

if exist(fname, 'file') == 2
    bdata = importdata(fname);                                              % load behavioural data
    
    % Exclude trials
    if strcmp(data.param.fname, '2018-10-09_11-50-39')
        bdata(165,:)    = [];
    elseif strcmp(data.param.fname, '2018-11-07_13-39-17')
        bdata(130,:)    = [];
    elseif strcmp(data.param.fname, '2018-11-29_11-06-28')
        bdata(414:end,:)    = [];
    elseif strcmp(data.param.fname, '2019-07-11_13-33-44')
        bdata(189,:)    = [];
    end
    
    % Raw behavioural data
    out.raw         = bdata;
    out.corrResp    = bdata(:,1);                                           % correct response
    out.resCat      = bdata(:,2);                                           % response category
    out.RT          = bdata(:,3);                                           % reaction time
    out.figOn       = bdata(:,4);                                           % figure onset
    out.Tmin        = bdata(:,5);                                           % min bar holding time
    out.Tmax        = bdata(:,6);                                           % max bar holding time
    out.coh         = bdata(:,7);                                           % figure coherence
    out.stimNrPool  = bdata(:,8);                                           % stimulus number
    
    % Split figure- and catch-trials
    StimTrialIdx    = bdata(:,2) < 5;
    out.ftrials     = bdata(StimTrialIdx,:);
    CatchTrialIdx   = bdata(:,2) >= 5;
    out.ctrials     = bdata(CatchTrialIdx,:);
    
    % Reaction times
    HitIdx          = out.ftrials(:,1) == 1;                                % hit index
    RT              = out.ftrials(HitIdx,3);                                % reaction times for hit trials
    out.mRT         = mean(RT);                                             % mean reaction time
    
    % General performance
    Tmin            = 0.4;                                                  % trial exclusion boundary
    out.nHI         = sum(out.ftrials(:,1));                                % no. of hits
    out.nMI         = sum(out.ftrials(:,1) == 0);                           % no. of misses
    out.nCR         = sum(out.ctrials(:,1));                                % no. of correct rejections
    out.nFA         = sum(out.ctrials(:,1) == 0);                           % no. of false alarms
    
    out.HIr         = out.nHI /(size(out.ftrials,1));                       % hit rate
    CRr             = out.nCR /(size(out.ctrials,1));                       % rejection rate
    out.FAr         = 1 - CRr;                                              % false alarm rate
    
    % Condition performance
    out.condPerf	= condPerf(out.raw);                                    % condition performance [HIr FAr dp] -> [coh8; coh12]
    
    % Single stimulus performance
    out.stimID      = unique(out.stimNrPool);                               % stimuli for this session
    out.stimPerf    = stimPerf(out.stimID, out.stimNrPool, out.corrResp);   % stimulus performance and no. repetition
    
else
    out = [];
end

disp('Done!')

end
