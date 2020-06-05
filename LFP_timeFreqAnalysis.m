function [cSig, frex] = LFP_timeFreqAnalysis(sig, fs, minF, maxF, noF)
%% Create Morlet wavelets
% Wavelet FFT -> Gaussian shape, essentially bandpass-filtering signal

if nargin < 3
    minF    =  3;
    maxF    = 100;
end

frex        = linspace(minF,maxF,noF);
wavtime     = -10:1/fs:10;              % Best practice is to have time = 0 at the center of the wavelet
% cycles      = 7;
% s           = cycles ./ (2*pi*frex);    % No. cycles / (2*pi*frex)
range_cycles = [4 10]; % different no. of cycles for each freq, balances spectral and temporal precision
s = logspace(log10(range_cycles(1)),log10(range_cycles(end)),noF) ./ (2*pi*frex); % no. cycles / (2*pi*frex)

cmw         = createMorletWavelet(frex, wavtime, s);

%% FFT & Convolution
% Strategy 1 [Time domain]: Signal -> Convolution (Kernel.*Signal) -> FFT
% Strategy 2 [Freq domain]: Signal -> FFT (Kernel & Signal) ->
%                           Multiplication (Kernel.*Signal) -> IFFT
% Convolution in time domain equivalent to multiplication in frequency
% domain & IFFT to get convoluted signal back in time domain
% Freq domain convolution much faster!
% Michael X Cohen: "Convolution via frequency domain multiplication"

% Define convolution parameters
nWave       = length(wavtime);
nData       = length(sig);
nConv       = nWave + nData - 1;
half_wave   = (length(wavtime)-1)/2;
cSig        = [];

% Fast Fourier Transform, automatically zero-padded
sigX        = fft(sig ,nConv);

for j = 1:noF
    
    % FFT [wavelet]
    cmwX    = fft(cmw(j,:),nConv);
    
    % Amplitude-normalization in freq-domain
    cmwX    = cmwX ./ max(cmwX);
    
    % Convolution (inverse fourier tranform of pointwise multiplication)
    conSig  = ifft(sigX .* cmwX);
    
    % Cut 1/2 of the length of the wavelet from the beginning and from the end
    conSig  = conSig(half_wave + 1 : end-half_wave);
    cSig    = [cSig; conSig];
    
end
end