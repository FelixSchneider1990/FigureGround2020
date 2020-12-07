function out = check20Hz(cArr)

if ~isfield(cArr, 'on') || ~isfield(cArr, 'res') 
    out = 0;
    return
end

if ~isfield(cArr.on, 'cat') 
    out = 0;
    return
end

fullCtr = cArr.on.trlOn(cArr.on.cat==6,:);        % Control period - average across all presented stimuli
Fs          = 1000;                                                  	% Sampling frequency
T           = 1/Fs;                                                    	% Sampling period
L           = 600;                                                   	% Length of signal
t           = (0:L-1)*T;                                             	% Time vector
fSig       = Fs*(0:(L/2))/L;

for i = 1:size(fullCtr,1)
    y   = fft(fullCtr(i,:));
    P2              = abs(y/L);
    P1              = P2(1:L/2+1);
    P1(2:end-1)     = 2*P1(2:end-1);
    fftEnv(i,:)     = P1;
end

fullBL = cArr.on.fullAvg(:,1:500);        % Baseline period - average across all presented stimuli
Fs          = 1000;                                                  	% Sampling frequency
T           = 1/Fs;                                                    	% Sampling period
L           = 500;                                                   	% Length of signal
t           = (0:L-1)*T;                                             	% Time vector
fBL         = Fs*(0:(L/2))/L;

for i = 1:size(fullBL,1)
    yy = fft(fullBL(i,:));
    PP2              = abs(yy/L);
    PP1              = PP2(1:L/2+1);
    PP1(2:end-1)     = 2*PP1(2:end-1);
    fftBL(i,:) = PP1;
end

thr = nanmean(fftBL(:,find(fBL == 20))) + (2*(nanstd(fftBL(:,find(fBL == 20)))));
out = nanmean(fftEnv(:,find(fSig == 20))) > thr;

%     figure
%     plot(fBL,mean(fftBL))
%     hold on
%     plot(fSig, nanmean(fftEnv))
%     xlim([15 50])
%     hline(thr)

end