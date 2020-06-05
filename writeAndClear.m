function out = writeAndClear(out, on2res, drive, animalID, iSe, iRec, chan)

if isfield(out,'spks') || isfield(out,'muae') || isfield(out,'lfp')
    save([drive ':\Rec\' animalID '\Summary\singleRec\SE' num2str(iSe) '_Rec' num2str(iRec) '_' chan '.mat'], 'out', '-v7.3')
    if isfield(out,'spks')
        save([drive ':\Rec\' animalID '\Summary\singleRec\SE' num2str(iSe) '_Rec' num2str(iRec) '_' chan '_on2res.mat'], 'on2res', '-v7.3')
    end
end

disp('Done!')

if isfield(out,'spks')
    out = rmfield(out, 'spks');
end

if isfield(out,'muae')
    out = rmfield(out, 'muae');
end

if isfield(out,'lfp')
    out = rmfield(out, 'lfp');
end
end