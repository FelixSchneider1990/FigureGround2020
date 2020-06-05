function [tOn, tEnd, nTrials] = trialExcl_SFG(data, tOn, tEnd, nTrials)

if strcmp(data.param.fname, '2018-08-16_13-38-45') || ...
        strcmp(data.param.fname, '2018-08-31_13-22-27') || ...
        strcmp(data.param.fname, '2018-09-14_12-16-01') || ...
        strcmp(data.param.fname, '2019-02-06_12-36-56') || ...
        strcmp(data.param.fname, '2019-02-06_13-41-50') || ...
        strcmp(data.param.fname, '2019-02-06_14-08-06') || ...
        strcmp(data.param.fname, '2019-02-06_14-36-52')
    tOn             = [];
    tEnd            = [];
    nTrials         = [];
elseif strcmp(data.param.fname, '2018-08-08_13-37-30')
    tOn(3)          = [];
elseif strcmp(data.param.fname, '2018-10-05_10-05-21')
    tOn(28)         = [];
elseif strcmp(data.param.fname, '2018-10-09_11-50-39')
    tOn(165:166)    = []; %% CHECK THIS!
    tEnd(165)       = [];
    nTrials         = length(tOn);
elseif strcmp(data.param.fname, '2018-10-12_12-48-11')
    tOn(479)        = [];
elseif strcmp(data.param.fname, '2018-10-15_14-41-47')
    tOn(142)        = [];
elseif strcmp(data.param.fname, '2018-10-17_12-45-07')
    tOn(174)        = [];
elseif strcmp(data.param.fname, '2018-10-24_11-01-58')
    tOn(245)        = [];
elseif strcmp(data.param.fname, '2018-11-07_13-39-17')
    tOn(130)        = [];
elseif strcmp(data.param.fname, '2019-02-15_11-01-29')
    tOn(120)        = [];
    tOn(268)        = [];
    
    % DOLLAR
elseif strcmp(data.param.fname, '2019-05-23_11-57-07')
    tOn(45)        = [];
elseif strcmp(data.param.fname, '2019-07-11_13-33-44')
    tOn(189)       = [];    
elseif strcmp(data.param.fname, '2019-08-13_11-28-40')
    tOn(602)       = [];    
elseif strcmp(data.param.fname, '2019-08-15_11-25-06')
    tOn(244)       = [];    
end
end