function out = convGauss(sptimes, time, sigma)

% Convolution of spike times with gaussian kernel.
%
% Input:    .sptimes: Vector, spike times
%           .nbins: Scalar, number of bins
%           .sigma: Scalar, standard deviation of gaussian [bins]
%
% Output:   .out: Vector, normalised spike density function
%
% 03/2018
% Felix Schneider


if isempty(sptimes)
    out	= zeros(1,length(time));
else
    
    % For every spike
    for i = 1:length(sptimes)
        
        % Center gaussian at spike time
        mu          = sptimes(i);
        
        % Calculate gaussian
        p1        	= -.5 * ((time - mu)/sigma) .^ 2;
        p2          = (sigma * sqrt(2*pi));
        gauss(i,:)  = exp(p1) ./ p2;
        
    end
    
    % Sum over all distributions to get PSTH
    out	= sum(gauss,1);
end
end