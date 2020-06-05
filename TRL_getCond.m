function [out, cmat] = TRL_getCond(data, in, chan, ttype, preWin, twin, str, clus, flag)

if nargin < 9
    flag = [];
end

evt             = data.trials.Tun.evt;                                      % Trial events
ev              = data.evCodes;                                             % Event codes

if strcmp(str, 'Spks')
    strmat      = 'psth';
else
    strmat      = 'sig';
end

% PT + BPN
for iType       = 1:length(ttype(1:2))                                      % For PT + BPN tuning type...
    
    d = []; stimID = []; stimVol = []; vol = [];
    
    if isfield(in.(ttype{iType}), 'flag')
        inflag = logical(in.(ttype{iType}).flag');
    else
        inflag = logical(ones(1,size(in.(ttype{iType}).(strmat),1)));       % Include all
    end
    
    d           = in.(ttype{iType}).(strmat);
    stimID      = evt{iType}(evt{iType} >= ev.(ttype{iType})(1) & evt{iType} <= ev.(ttype{iType})(2));      % Extract stimulus sequence
    stimVol     = evt{iType}(evt{iType} >= ev.dB50 & evt{iType} <= ev.dB70);                                % Extract volume sequence
    stimID      = stimID(inflag);
    stimVol     = stimVol(inflag);
    s           = unique(stimID);
    
    for iFreq   = 1:length(s)                                               % For each frequency (-band)...
        
        raw_tr  = d(stimID == s(iFreq),:);                                  % Raw trace
        vol     = stimVol(stimID == s(iFreq));                              % Get volume information
        db      = fliplr(unique(vol));
        
        for iVol = 1:length(db)                                             % For each volume...
            
            mat = [];
            mat = raw_tr(vol == db(iVol),:);                                % Get raw data
            
            cmat{iType,iFreq,iVol}       = mat;
            mmat{iType,iFreq,iVol}       = nanmean(mat,1);                  % Mean LFP
            
            [lat(iType,iFreq,iVol), latIdx(iType,iFreq,iVol)] ...
                = getLatency(mmat{iType,iFreq,iVol}, twin, preWin, 1, 3);   % Latency
            
        end
    end
end

% Store values
out.cond     = mmat;
out.lat      = lat;
out.latIdx   = latIdx;

if isempty(flag)
    % Import header for trial exclusion
    NCS             = NLX_LoadNCS(['LFP' chan(3:end) '.ncs'],'HEADER',1,[]);
    Header          = NCS.Header;
    rowAD           = find(contains(Header(:), '-ADBitVolts'));
    rowADm         	= find(contains(Header(:), '-ADMaxValue'));
    conFact         = str2double(Header{rowAD}(13:end));                        % Conversion factor from binary to analogue
    maxVal          = str2double(Header{rowADm}(13:end)) * conFact * 1e6;       % Saturation value in LFP signal
    
    % CLK
    if isfield(in, 'CLK')
        clk_EV  = evt{3}(evt{3} >= ev.CLK(1) & evt{3} <= ev.CLK(2));            % Event codes
        cFreq   = unique(clk_EV);                                               % [25 50 75 100] Hz
        clkmat  = in.(ttype{3}).(strmat);                                    	% Trial data
        
        for iCl = 1:length(cFreq)
            clk{iCl}  = clkmat(clk_EV == cFreq(iCl),:);
            if strcmp(strmat, 'psth')
                clk{iCl}      = exludeTrials(clk{iCl}, [], 5, 'BL', 'NAN');
            else
                clk{iCl}  = exludeTrials(clk{iCl}, [], 5, 'PEAK', 'NAN',1, maxVal); % Trials response to different click trains
            end
        end
        out.Clk = clk;
    end
    
    % WN
    if isfield(in, 'WN')
        wn      = in.(ttype{4}).(strmat);                                    	% Trial data
        if strcmp(strmat, 'psth')
            wn      = exludeTrials(wn, [], 5, 'BL', 'NAN');
        else
            wn  = exludeTrials(wn, [], 5, 'PEAK', 'NAN',1, maxVal); % Trials response to different click trains
        end
        mwn     = nanmean(wn);                                              	% Mean response to white noise
        out.mWN = mwn;
    end
    
    var_dir     = [data.ddir 'var\'];                                           % Save variables
    if ~(exist(var_dir,'dir'))
        mkdir(var_dir);
    end
    
    if strcmp(str, 'Spks')
        save([var_dir 'Tun_' str '_' chan '_' clus], 'mmat')
    else
        save([var_dir 'Tun_' str '_' chan], 'mmat')
    end
end
end
