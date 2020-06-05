function cmw = createMorletWavelet(frex, wavtime, s)

% Create complex sine waves [freq, samples]
sine_wave	= exp( 1i*2*pi*frex'.*wavtime );
% Create Gaussian window
gaus_win    = exp( (-wavtime.^2) ./ (2*s'.^2) );
% Multiplication -> Morlet wavelet for each frequency
cmw         = sine_wave .* gaus_win;

end