clear all
close all

%% Paths

addpath Y:\EPHYS\SCRIPTS\MATLAB\Conversion\MatlabImportExport_v6.0.0
addpath X:\Felix\Figure_Ground\Ephys\FigureGround2020
addpath X:\Felix\Figure_Ground\Ephys\neuralynx-matlabtoolbox
addpath X:\Felix\Figure_Ground\Ephys\geezlematlib
addpath X:\Felix\Figure_Ground\Ephys\utilities
addpath X:\Felix\Figure_Ground\Ephys\nlx2mat
addpath X:\Felix\Scripts\Stuff

%% Get parameter

animalID    = 'Dollar';             % Specify animal ID
par         = getParam(animalID);   % Get recording parameter

car         = 0;                    % Common average referencing
wMUAe       = 0;                    % Write MUAe-files
rNSE        = 0;                    % Reduce .nse file-size
import      = 0;                    % 1: Import data | 0: Load existing data
plotFlag    = 0;                    % Plot response profile
process     = 'all';                % 'all': all session || 'select': give vector with session number
cpy2Ntwrk   = 1;                    % Copy to network
getUnits    = 0;                    % Concatenate aligned units

%% Extract & preprocess experimental data

if strcmp(process, 'all')
    sess    = 1:length(fieldnames(par))-2;
elseif strcmp(process, 'select')
    sess    = [65 66];
end

parfor i = sess % use 'parfor' if process == all || use 'for' if process == select !!! No visualisation with 'parfor', writes files nonetheless
    rec = fieldnames(par.(['sess' num2str(i)]));                            % Recording name, string
    
    for ii = 1:length(fieldnames(par.(['sess' num2str(i)])))
        data            = struct();                                         % Initialize output
        data.param      = par.(['sess' num2str(i)]).(rec{ii});              % Add recording info to struct
        data.sdir       = [par.spath data.param.fname '\'];               	% Source directory
        data.ddir       = [par.dpath data.param.fname '\Data\'];           	% Data directory
        data.pdir       = [par.dpath data.param.fname '\Plots\'];         	% Plot directory
        data.stimdir    = [par.dpath data.param.fname '\Stim\'];            % Plot directory
        data.animalID   = animalID;                                         % Animal name
               
%         f = dir(par.dpath);
%         nam = {f.name};
%         if sum(contains(nam(:), data.param.fname)) == 1
%             disp(['Skip: ' data.ddir(1:33)])
%             continue
%         end
        
        disp(['Processing ' data.param.fname])
        cd(data.sdir)                                                       % Change to source directory
        
        if car == 1 && isfield(data.param, 'Plexon')                        % Common average referencing
            CAR(data)
        end
        
        if wMUAe == 1                                                       % Filter and write MUAe-files
            writeMUAe(data,0)
        end
        
        if rNSE == 1
            reduceNSE(data)                                                 % Reduce .nse file-size
        end
        
        if import == 1
            data        = import_Data(data, plotFlag,0);                  	% Data import & preprocessing
        else
            
%             ddr = dir(data.ddir);
%             flg = 0;
%             fnme = ['DataStruct_' data.param.fname(1:10) '.mat'];
%             for idr = 1:size(ddr,1)
%                 if strcmp(ddr(idr).name, fnme)
%                     if datetime(2020,04,28) < ddr(idr).date
%                         flg = 1;
%                     end
%                 end
%             end
%             
%             if flg == 1
%                 continue
%             end
            
            try
                d           = load([data.ddir 'DataStruct_' data.param.fname(1:10) '.mat']); % Load data from file
            catch
                d           = load([data.sdir '\Data\DataStruct_' data.param.fname(1:10) '.mat']); % Load data from file
            end
            data        = d.data;
            data.sdir   = [par.spath data.param.fname '\'];               	% Source directory
            data.ddir   = [par.dpath data.param.fname '\Data\'];           	% Data directory
            data.pdir   = [par.dpath data.param.fname '\Plots\'];         	% Plot directory
            data.stimdir= [par.dpath data.param.fname '\Stim\'];            % Plot directory           
            data        = import_Data(data, plotFlag,1);                  	% Data import & preprocessing
        end       
    end
end

if cpy2Ntwrk == 1
    copyFiles(par)                                                          % Copy data & plots to network
end

if getUnits == 1
    targetAnalysis(animalID);                                         
end