function data = import_Data(data, plotFlag, loadFlag)

% Import Neuralynx- and log-files and extract raw as well as trial data.
%
% Input:    .data: Structure, contains recording parameter
%
% Output: 	.data: appended structure, contains:
%               - corrected trial information
%               - stimulus specification
%               - behavioural performance
%               and for each channel:
%               - LFP/MUAe/PSTH signal
%
% Felix Schneider, 03/2018

if loadFlag == 0  
    % Delete existing directory
%     if exist(data.ddir, 'dir') == 7
%         disp('Delete existing directory')
%         rmdir(data.ddir, 's')
%     end
    
    % Check mic channel
    if ~isfield(data.param, 'Mic')
        data.param.Mic = 1;
    end
    
    % Import
    data.evCodes        = getEventCodes();                          % Get event codes
    data.events         = getEvents();                              % Import event file
    data.behaviour      = getBehaviour(data);                       % Get behavioural performance
    data.trials.Tun     = getTunTrials(data);                       % Get trial information [TUNING]
    data.trials.SFG     = getSFGTrials(data);                       % Get trial information [SFG]
    data.stimSpecs      = stimSpecs(data);                          % Get stimulus specification
    
    % Correct for sound latency
    d = data.param.fname;
    if str2num([d(1:4) d(6:7) d(9:10)]) - 20180822 < 0
        data            = soundLatencyCorr_SE(data);                % Based on microphone threshold crossing (NSE-file)
    else
        data            = soundLatencyCorr_CSC(data);               % Based on continuous microphone recording (CSC-file)
    end   
end

%% Extract neural data for specified channels


for chan = data.param.nChan                                     % For all channel...
    
    disp(['Import Channel ' num2str(chan) ' Start'])
    
    if chan == data.param.Mic || chan == 23
        continue
    end
    
    chanStr                  = ['ch' num2str(chan)];            % Channel string
    data.(chanStr).LFP       = getLFP(data, chan);              % Import LFP file
    data.(chanStr).MUAe      = getMUAe(data, chan);             % Import MUAe file
    data.(chanStr).Spks      = getSpikes(data, chan);           % Import spike file
    
    disp(['Ch' num2str(chan) ' import complete!'])
    
    %% Plot response profile - needs work
%     if plotFlag == 1
%         LFP_plotSpectrum(data, chanStr)                         % Plot LFP spectrum for each stimulus presentation
%         data = plotProfile(data, chanStr, [{'PT'}, {'BPN'}]); 	% Plot response profile & tuning
%     end
end

%% Save data

disp('Save data struct')

% Create output directory if not already present
if ~(exist(data.ddir,'dir'))
    mkdir(data.ddir);
end

save([data.ddir 'DataStruct_' data.param.fname(1:10) '.mat'], 'data', '-v7.3')
disp('Done!')

end
