function out = click_ITPC(data, chan)

if ~isfield(data.(chan).LFP, 'Tun') || ~isfield(data.(chan).LFP.Tun.sorted, 'Clk')
    out = [];
    return
end

for c = 1:4                                                                 % [25 50 75 100Hz]
    clear nSig nBL
    
    mat         = data.(chan).LFP.Tun.sorted.Clk{c};                    	% Data [trial x time]
    ind         = isnan(nanmean(mat,2));                                 	% Exclude trials
    mat(ind,:)  = [];
    sig         = mat(:,201:400);                                           % Stimulus period
    bl          = mat(:,1:200);                                             % Baseline period
    
    Fs          = 1000;                                                  	% Sampling frequency
    T           = 1/Fs;                                                    	% Sampling period
    L           = 200;                                                   	% Length of signal
    t           = (0:L-1)*T;                                             	% Time vector
    f           = Fs*(0:(L/2))/L;                                           % Frequency vector
 
    for i = 1:size(sig,1)
        clear Y P1 P2 PP1 PP2
        Y               = fft(sig(i,:));                                    % One-sided fast Fourier transform for signal and BL
        P2              = abs(Y/L);
        P1              = P2(1:L/2+1);
        P1(2:end-1)     = 2*P1(2:end-1);
        
        YY              = fft(bl(i,:));
        PP2             = abs(YY/L);
        PP1             = PP2(1:L/2+1);
        PP1(2:end-1)	= 2*PP1(2:end-1);
        
        fftSig(i,:)   	= P1;                                            	% Trialwise FFT
        fftBL(i,:)    	= PP1;
    end
    
    m                   = mean(fftBL);                                  	% Determine threshold
    s                   = std(fftBL);
    thresh              = m + s*3;
    avg                 = mean(fftSig);

    if c == 1
        out(1) = avg(f == 25)  > thresh(f == 25);                           % Check if significant for click train frequencies
    elseif c == 2
        out(2) = avg(f == 50) > thresh(f == 50);
    elseif c == 3
        out(3) = avg(f == 75) > thresh(f == 75);
    elseif c == 4
        out(4) = avg(f == 100) > thresh(f == 100);
    end  
end
end
