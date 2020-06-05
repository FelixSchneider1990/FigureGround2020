function out = stimSpecs(data)
% Get SFG-stimulus specification used for respective recording session.
% Provides spectrogram and SFG chord parameter.
% Felix Schneider, 03/2018

if isempty(data.behaviour)
    out = [];
else
    disp('Extract stimulus specification...')
    d               = data.param.fname;                             % Folder name
    stimID          = data.behaviour.stimID;                        % Stimuli used during session
    dest            = data.stimdir ;                                % Destination directory
    
    if ~(exist(dest,'dir'))                                         % Create output directory if not already present
        mkdir(dest);
    end
    
    % Load frequency information for all stimuli
    if str2num([d(1:4) d(6:7) d(9:10)]) - 20180831 < 0              % Select right stimlus set
        path        = {['X:\Felix\Sound\backup\Stimuli_coh8\'], ['X:\Felix\Sound\backup\Stimuli_coh12\']};
        p.coh8      = load([path{1} 'StimParam_coh8.mat'], 'cohFreq', 'ncohFreq');
        p.coh12     = load([path{2} 'StimParam_coh12.mat'], 'cohFreq', 'ncohFreq');
        source      = 'C:\Rec\Stim\Backup\Stimuli_coh0812\';
        id          = 1;
    elseif str2num([d(1:4) d(6:7) d(9:10)]) - 20190806 > 0              
        path        = {['X:\Felix\Sound\Stimuli_coh4\'], ['X:\Felix\Sound\Stimuli_coh8\']};
        p.coh4      = load([path{1} 'StimParam_coh4.mat'], 'cohFreq', 'ncohFreq');
        p.coh8      = load([path{2} 'StimParam_coh8.mat'], 'cohFreq', 'ncohFreq');
        source      = 'C:\Rec\Stim\Stimuli_coh0408\';
        id          = 2;
    else
        path = {['X:\Felix\Sound\Stimuli_coh8\'], ['X:\Felix\Sound\Stimuli_coh12\']};
        p.coh8      = load([path{1} 'StimParam_coh8.mat'], 'cohFreq', 'ncohFreq');
        p.coh12     = load([path{2} 'StimParam_coh12.mat'], 'cohFreq', 'ncohFreq');
        source      = 'C:\Rec\Stim\Stimuli_coh0812\';
        id          = 0;
    end
    
    % Frequency pool
    out.freq_pool   = 440 * 2 .^((-31:97)/24);                      % SFG frequency pool
    freqStart       = 180;                                          % Tuning low freq [Hz]
    steps           = 14;                                           % No of desired tones
    fs              = 44100;                                        % Sampling freq
    out.PT(1)       = freqStart;                                    % Starting frequency [Hz]
    
    for i = 2:steps                                                 % For no of tones...
        out.PT(i)   =  out.PT(i-1)*2^(1/2);                         % 1/2 octave steps
    end
    out.PT          = out.PT;
    
    for ii = 1:length(out.PT)-1
        out.BPNc(ii) = out.PT(ii) + ((out.PT(ii+1)-out.PT(ii)) / 2); % Centre freq of bandpass noise
    end
    
    %% Get stimulus configuration
    
    % temporary fix
    if sum(stimID == 0) > 0
        stimID(stimID == 0)=[];
    end
    
    for st = 1:length(stimID)
        %% Copy stimulus into data folder
        
        sname       = [source 'SFGstim' num2str(stimID(st)) '.wav'];                        % Stimulus file name
        copyfile(sname, dest)                                                               % Copy file
        
        %% Get stimulus parameter
        
        cohIdx      = data.behaviour.stimNrPool == stimID(st);
        coh         = unique(data.behaviour.coh(cohIdx));                                   % Get coherence level
        gnd         = p.(['coh' num2str(coh)]).ncohFreq(stimID,:);                          % Get frequency elements of ground signal
        fig         = p.(['coh' num2str(coh)]).cohFreq(stimID,:);                           % Get frequency elements of figure
        c           = 1;
        
        if stimID(st) < 600
            if id == 1
                out.fig{st} = fig{st};
            else
                out.fig{st} = fig{st}{1};                                                       % Save figure elements
            end
        end
        
        % Extract frequency elements for each chord...
        for i = 1:size(gnd(st,:),2)
            for ii = 1:size(gnd{st,i},2)
                
                % Skip if no chord
                if numel(gnd{i}) == 1
                else
                    
                    % Concatenate figure and ground signal -> 15 elements/chord
                    if length(gnd{st,i}) == 1                                               % If only one element check if chord or an empty field
                        if strcmp(class(gnd{st,i}), 'double')                               % If empty: do nothing
                        else                                                                % Otherwise add chord to freq matrix
                            out.freq_mat(:,c,st)    = gnd{st,i}{ii}';                       % Freq matrix for each chord
                        end
                        
                    else
                        if length(gnd{st,i}{ii}) < 15                                       % If number of gnd freqs lower than 15
                            if id == 1
                                gnd{st,i}{ii}       = horzcat(gnd{st,i}{ii},fig{st});       % Add figure elements to vector
                            else
                                gnd{st,i}{ii}       = horzcat(gnd{st,i}{ii},fig{st}{ii});   % Add figure elements to vector
                            end
                        end
                        out.freq_mat(:,c,st)        = gnd{st,i}{ii}';                       % Freq matrix for each chord
                        
                    end
                end
                c = c+1;
            end
        end
        
        %     figure
        %     clear fm
        %     cLen = 50;
        %     preWin = 500;
        %     fm = out.freq_mat(:,:,st);
        %     for ii = 1:size(fm,2)
        %         line([(ii*cLen)+preWin-cLen+1,(ii*cLen)+preWin],[fm(:,ii),fm(:,ii)], 'Color', 'k');
        %     end
        
        % Count representation of freq_channel per stimulus
        for j = 1:length(out.freq_pool)
            freqSum(j)      = sum(sum(out.freq_mat(:,:,st) == out.freq_pool(j)));
        end
        
        % Output
        out.nFreq(:,:,st)   = horzcat(out.freq_pool', freqSum');
        
    end
    
    progressbar(1)
    disp('Done!')
    
end
end