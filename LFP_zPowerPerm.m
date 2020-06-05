function [zmap, diff, extr] = LFP_zPowerPerm(d, blPow, nperm, tf_frex)

% Get data
coh1    = d.fr8.trPow(:,1:500,:) ./ blPow;          % Figure coherence 8 trials, baseline normalised
if isfield(d, 'fo4')
    coh2    = d.fr4.trPow(:,1:500,:) ./ blPow;      % Figure coherence 4 trials, baseline normalised
else
    coh2    = d.fr12.trPow(:,1:500,:) ./ blPow;     % Figure coherence 12 trials, baseline normalised
end
cfig    = cat(3,coh1,coh2);                         % All figure trials
ctr     = d.rcr.trPow ./ blPow;                     % Control trials, baseline normalised
ctr     = mean(ctr(:,501:end,:),2);             	% Average power per freq band, excl sound onset
ctr     = repmat(ctr,[1,500,1]);                   	% Match matrix dimensions of figure condition

% Get difference map
diff(:,:,1)         = mean(coh1,3)-mean(ctr,3);                   
diff(:,:,2)         = mean(coh2,3)-mean(ctr,3);                  
diff(:,:,3)         = mean(cfig,3)-mean(ctr,3);                  

% Permutation
for i = 1:nperm    
    % Shuffle control trials, assigning to maps to new variable faster than
    % reshuffling matrix
    sctr            = [];
    sctr            = ctr(:,:,Shuffle(1:size(ctr,3)));
    
    % Concatenate figure and control condition, same number of trials for
    % each condition
    if size(coh1,3) <= size(sctr,3)
        con1            = cat(3,coh1, sctr(:,:,1:size(coh1,3)));
    else
        con1            = cat(3,ctr, coh1(:,:,1:size(ctr,3)));
    end
    
    if size(coh2,3) <= size(ctr,3)
        con2           = cat(3,coh2, ctr(:,:,1:size(coh2,3)));
    else
        con2           = cat(3,ctr, coh2(:,:,1:size(ctr,3)));
    end
    
    cfig                 = cfig(:,:,Shuffle(1:size(cfig,3)));
    if size(cfig,3) <= size(ctr,3)
        config           = cat(3,cfig, ctr(:,:,1:size(cfig,3)));
    else
        config           = cat(3,ctr, cfig(:,:,1:size(ctr,3)));
    end  
   
    bound1       	= floor(size(con1,3)/2);
    bound2          = floor(size(con2,3)/2);
    boundfig        = floor(size(config,3)/2);
    
    % Shuffle matrix
    scon1 = []; scon2 = []; sconfig = [];
    scon1            = con1(:,:,Shuffle(1:size(con1,3)));
    scon2            = con2(:,:,Shuffle(1:size(con2,3)));
    sconfig          = config(:,:,Shuffle(1:size(config,3)));
    
    % Split matrix in half, Difference between averages to build null
    % hypothesis
    perm1(:,:,i)    = mean(scon1(:,:,1:bound1),3) - mean(scon1(:,:,bound1+1:end),3);      
    perm2(:,:,i)    = mean(scon2(:,:,1:bound2),3) - mean(scon2(:,:,bound2+1:end),3);  
    permfig(:,:,i)  = mean(sconfig(:,:,1:boundfig),3) - mean(sconfig(:,:,boundfig+1:end),3);  
end

% Get zmap and extreme values for multiple comparison correction for each coherence level
[zmap(:,:,1), extr(:,1)]    = LFP_zmap(perm1, diff(:,:,1), nperm, tf_frex);
[zmap(:,:,2), extr(:,2)]    = LFP_zmap(perm2, diff(:,:,2), nperm, tf_frex);
[zmap(:,:,3), extr(:,3)]    = LFP_zmap(permfig, diff(:,:,3), nperm, tf_frex);

end
