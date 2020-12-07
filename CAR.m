function CAR(data)

addpath(genpath('X:\Felix\Figure_Ground\Ephys\neuralynx-matlabtoolbox'))
addpath(genpath('X:\Felix\Figure_Ground\Ephys\geezlematlib'))
fprintf('Common average referencing...\n')

if isfield(data.param, 'Plexon')
    
    nChan   = data.param.nChan;   
    dest    = data.ddir(1:end-5);
        
    % Create output directory if not already present
    if ~(exist(data.ddir,'dir'))
        mkdir(data.ddir);
    end

    for i = 1:16
        SourcePaths{i}  = [data.sdir 'CSC' num2str(nChan(i)) '.ncs'];
        SavePaths{i}    = [dest 'CSC' num2str(nChan(i)) '_car.ncs'];
        nsePaths{i}     = [dest 'SE' num2str(nChan(i)) '_car.nse'];            
    end
    
    try
        SourcePaths(data.param.Mic) = [];
        SavePaths(data.param.Mic) = [];
        nsePaths(data.param.Mic) = [];
        flag = 1;
    catch
        flag = 0;
    end
    
    CARPath     = [dest 'CAR_ref.ncs'];
    settings = struct();
    ok = NLX_CommonReferenceAverage(SourcePaths,SavePaths,CARPath, settings);
    
    
    if length(nChan) == 32
        for i = 17:32
            SourcePaths{i}  = [data.sdir 'CSC' num2str(nChan(i)) '.ncs'];
            SavePaths{i}    = [dest 'CSC' num2str(nChan(i)) '_car.ncs'];
            nsePaths{i}     = [dest 'SE' num2str(nChan(i)) '_car.nse'];
        end
        
        SourcePaths(23) = [];
        SavePaths(23) = [];
        nsePaths(23) = [];
        
        if flag == 0
            SourcePaths(data.param.Mic) = [];
            SavePaths(data.param.Mic) = [];
            nsePaths(data.param.Mic) = [];
        end
        
        CARPath     = [dest 'CAR_ref_2.ncs'];
        settings = struct();
        ok = NLX_CommonReferenceAverage(SourcePaths(17:31),SavePaths(17:31),CARPath, settings);  
    end
    
%% Write new spike files
%     
%     fprintf('Write new spike files...\n')
%     
%     thresh = getThresh(SavePaths);    
%     settings = struct();
%     ok = NLX_SpikeExtractor(SavePaths,nsePaths,settings,thresh);
%     disp('Done!')
    
end
end
