function out = stimPerf(stimID, stimNrPool, corrResp)

for i = 1:size(stimID,1)
    % Get stimulus trials
    idx = stimNrPool == stimID(i);
    
    % Get stimulus performance
    perf = corrResp(idx);
    out.perf(i) = sum(perf)/length(perf);
    out.nRep(i) = sum(idx);
end
end
