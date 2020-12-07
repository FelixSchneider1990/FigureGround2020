function [zmap, extr] = LFP_zmap(permmat, diff, nperm, tf_frex)

f1      = tf_frex(1);
f2      = tf_frex(2);
noF     = tf_frex(3);

% Create z-map
mean_h0	= mean(permmat,3);                                                  % Mean permutation map, Null hypothesis
std_h0	= std(permmat,[],3);                                                % Std permutation map, Null hypothesis

zmap    = (diff-mean_h0) ./ std_h0;                                         % Z-scored difference data

% Corrections for multiple comparisons
extrVal     = zeros(nperm,2);
tmp         = LFP_exclCycle(permmat, f1, f2, noF, 2);                       % Exclude 1/2 wavelet

for i = 1:nperm
    temp            = reshape(tmp(:,:,i),1,[]);                            	% Vectorise
    extrVal(i,:)    = [min(temp) max(temp)];                                % Get data
end

pval = .025;                                                                % Two-sided test
lo  = prctile(extrVal(:,1), 100-100*(1-pval));
hi  = prctile(extrVal(:,2), 100-100*pval);
extr = [lo hi];

end