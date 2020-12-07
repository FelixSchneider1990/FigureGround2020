function [mat, sp, excl] = exludeTrials(mat, sp, nStd, cat, nanflag, lfpflag, maxVal)

if nargin < 6
    lfpflag = false;
    maxVal = [];
end

% Reference period
if strcmp(cat, 'BL')
    if  size(mat,2) == 4000             % SFG
        sig     = (mat(:,301:500));     % BL period as reference
        nmat    = mat(:, 1:800);        % Test signal
    elseif size(mat,2) == 500           % Tun
        sig     = mat(:,1:200);
    end
elseif strcmp(cat, 'PEAK')
    if  size(mat,2) == 4000             % SFG
        sig     = mat(:,501:700);       % Onset transient as reference
        nmat    = mat(:, 1:800);        % Test signal
    elseif size(mat,2) == 500           % Tun
        sig     = mat(:,201:300);
    end
end

m               = mean(sig,2);          % Mean activity
s               = std(sig,[],2);        % Standard deviation
ex              = 250;

if isempty(maxVal)
    excl        = false(size(sig,1),1);
else
    excl        = logical(sum(sig == maxVal | sig == -maxVal,2));   % Exclude saturation trials
end

for iTrial = 1:size(sig,1)
    
    if excl(iTrial)                     % Skip saturation trial
        continue
    end
    
    idx                 = excl;         % Don't include test trial in average
    idx(iTrial)         = true;
    thresh              = [mean(m(~idx)) + mean(s(~idx))*nStd mean(m(~idx)) - mean(s(~idx))*nStd];  % Threshold computed over all other trials

    if exist('nmat')
        excl(iTrial)    = logical(sum(nmat(iTrial,:) > thresh(1) | nmat(iTrial,:) < thresh(2)));    % Check if threshold crossing
        if lfpflag && excl(iTrial) == false
           excl(iTrial) =  logical(sum(nmat(iTrial,301:500) > ex)) | logical(sum(nmat(iTrial,301:500) < -ex));
        end
    else
        excl(iTrial)    = logical(sum(mat(iTrial,:) > thresh(1) | mat(iTrial,:) < thresh(2)));
        if lfpflag && excl(iTrial) == false
            excl(iTrial) =  logical(sum(mat(iTrial,1:200) > ex)) | logical(sum(mat(iTrial,1:200) < -ex));
        end
    end
end


if strcmp(nanflag, 'NAN')                               % Replace trial with nan
    mat(excl,:)         = nan(size(mat(excl,:)));
elseif strcmp(nanflag, 'REM')                           % Remove trial
    mat(excl,:)         = [];
end

if ~isempty(sp)
    sp(excl)            = [];
end
end

