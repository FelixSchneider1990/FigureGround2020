function snr = getSNR(mat)

len                 = 49;                                                   % Window length
mmat                = nanmean(mat);                                         % Average response
steps               = 10:10:100;

if size(mat,2) == 4000
    idx             = 301:500;                                             	% BL index
    onEV            = 501;                                                  % Sound onset
elseif size(mat,2) == 500
    idx             = 1:200;
    onEV            = 201;
end

bl                  = nanmean(mmat(idx));                                  	% Baseline
for i = 1:length(steps)
    on              = nanmean(mmat(onEV+steps(i):onEV+steps(i)+len));    	% Average onset response in specified window
    snr_win(i)      = (on-bl)/std(mmat(idx));                             	% Signal2Noise ratio
end
snr                 = mean(snr_win);                                      	% Average SNR over windows

end
