function [tOn, tEnd] = trialExcl_Tun(data, tOn, tEnd)

if strcmp(data.param.fname, '2018-08-08_13-37-30')
    tOn(1)        = [];
elseif strcmp(data.param.fname, '2018-08-17_12-42-02')
    tOn(1:2)      = [];
elseif strcmp(data.param.fname, '2018-10-12_12-48-11')
    tOn(end)      = [];
elseif strcmp(data.param.fname, '2018-10-17_12-45-07')
    tOn(end)      = [];
end
end