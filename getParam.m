function par = getParam(animalID)

par = struct();
par.spath  	= ['Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\' animalID '\'];    % Source directory [nlx/log-files]
% par.dpath  	= ['C:\Rec\' animalID '\'];                                         % Data directory [mat/png-files]
par.dpath  	= ['D:\Rec\' animalID '\'];                                     % Data directory [mat/png-files]
c          	= 1;                                                                % Counter

switch animalID
    
    case 'Eric'
        
        par.(['sess' num2str(c)]).rec1.fname        = '2018-08-03_13-00-01';            % Folder name
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];                            % Channel
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [14 10 13.45-13.4];               % Coordinates [x y z] -> z aligned to first auditory response
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';                            % Auditory field (estimated by tonotopic and response behaviour of cell)
%       par.(['sess' num2str(c)]).rec1.ch2.stTrials = [nan nan nan nan];                % Stable trials [j:k, m:n]. k:k = SFG trials; m:n = PT Tun trials; Only shown if change needed: isnan(k | n) -> from j:end, otherwise j:k
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};                           % Number and type of cluster
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [12 9 14-13.7];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'SU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-08-03_13-58-36';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [14 10 13.64-13.4];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [12 9 14.475-13.7];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'SU','MU'};
        
        par.(['sess' num2str(c)]).rec3.fname        = '2018-08-03_14-09-13';
        par.(['sess' num2str(c)]).rec3.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec3.ch2.coord    = [14 10 13.92-13.4];
        par.(['sess' num2str(c)]).rec3.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec3.ch3.coord    = [12 9 14.655-13.7];
        par.(['sess' num2str(c)]).rec3.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch3.clus     = {'MU','MU'};
        
        par.(['sess' num2str(c)]).rec4.fname        = '2018-08-03_14-24-06';
        par.(['sess' num2str(c)]).rec4.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec4.ch2.coord    = [14 10 14.34-13.4];
        par.(['sess' num2str(c)]).rec4.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec4.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec4.ch3.coord    = [12 9 14.895-13.7];
        par.(['sess' num2str(c)]).rec4.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec4.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-08-06_13-31-47';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [16 11 16.85-15.55];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [14 11 13.82-13.7];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [11 8 12.69-12.65];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU','SU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-08-06_14-39-36';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [16 11 17.15-15.55];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [14 11 14.4-13.7];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'SU', 'SU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [11 8 13.01-12.65];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'SU', 'MU', 'MU'};
        
        par.(['sess' num2str(c)]).rec3.fname        = '2018-08-06_15-00-23';
        par.(['sess' num2str(c)]).rec3.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec3.ch2.coord    = [16 11 17.5-15.55];
        par.(['sess' num2str(c)]).rec3.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec3.ch3.coord    = [14 11 14.4-13.7];
        par.(['sess' num2str(c)]).rec3.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec3.ch4.coord    = [11 8 13.22-12.65];
        par.(['sess' num2str(c)]).rec3.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-08-07_12-00-41';
        par.(['sess' num2str(c)]).rec1.nChan        = [3 4];                    % discarded ch2 because no cell & stationary - no idea where it was
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [14 11 13.82-13.7];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [11 8 12.69-12.65];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'SU','SU','SU','MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-08-07_13-52-33';
        par.(['sess' num2str(c)]).rec2.nChan        = [3 4];
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [14 11 14.4-13.7];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.stTrials = [nan nan 1 425]; 
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [11 8 13.01-12.65];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec3.fname        = '2018-08-07_14-14-20';
        par.(['sess' num2str(c)]).rec3.nChan        = [3 4];
        par.(['sess' num2str(c)]).rec3.ch3.coord    = [14 11 14.4-13.7];
        par.(['sess' num2str(c)]).rec3.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec3.ch4.coord    = [11 8 13.22-12.65];
        par.(['sess' num2str(c)]).rec3.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch4.clus     = {'SU','SU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-08-08_12-05-41';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [15 11 18.1-17.5];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [14 10 17-16];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [12 8 17.19-14.8];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-08-08_13-16-53';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [15 11 18.9-17.5];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [14 10  17.51-16];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'SU', 'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [12 8 17.19-14.8];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'SU', 'MU'};
        
        %         par.(['sess' num2str(c)]).rec3.fname        = '2018-08-08_13-37-30';    % weird tuning timestamps
        %         par.(['sess' num2str(c)]).rec3.nChan        = [2 3 4];
        %         par.(['sess' num2str(c)]).rec3.ch2.coord    = [15 11 17.5-17.5];
        %         par.(['sess' num2str(c)]).rec3.ch2.field    = 'xxx';
        %         par.(['sess' num2str(c)]).rec3.ch2.clus     = {'SU','MU'};
        %         par.(['sess' num2str(c)]).rec3.ch3.coord    = [14 10 17.6-16];
        %         par.(['sess' num2str(c)]).rec3.ch3.field    = 'xxx';
        %         par.(['sess' num2str(c)]).rec3.ch3.clus     = {[]};
        %         par.(['sess' num2str(c)]).rec3.ch4.coord    = [12 8 17.56-14.8];
        %         par.(['sess' num2str(c)]).rec3.ch4.field    = 'xxx';
        %         par.(['sess' num2str(c)]).rec3.ch4.clus     = {[]};
        
        par.(['sess' num2str(c)]).rec4.fname        = '2018-08-08_14-42-19';
        par.(['sess' num2str(c)]).rec4.nChan        = [2];
        par.(['sess' num2str(c)]).rec4.ch2.coord    = [15 11  17.84-17.5];
        par.(['sess' num2str(c)]).rec4.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec4.ch2.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-08-09_12-37-49';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [11 7 15.81-15.65];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13 10 16.1-15.76];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        %         par.(['sess' num2str(c)]).rec2.fname        = '2018-08-09_13-38-13';    % some problem
        %         par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        %         par.(['sess' num2str(c)]).rec2.ch2.coord    = [11 7 16.16-15.65];
        %         par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        %         par.(['sess' num2str(c)]).rec2.ch2.clus     = {'SU'};
        %         par.(['sess' num2str(c)]).rec2.ch3.coord    = [13 10 16.41-15.76];
        %         par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        %         par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec3.fname        = '2018-08-09_13-59-34';
        par.(['sess' num2str(c)]).rec3.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec3.ch2.coord    = [11 7 16.16-15.65];
        par.(['sess' num2str(c)]).rec3.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec3.ch3.coord    = [13 10 16.76-15.76];
        par.(['sess' num2str(c)]).rec3.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec4.fname        = '2018-08-09_14-29-42';
        par.(['sess' num2str(c)]).rec4.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec4.ch2.coord    = [11 7 15.58-15.65];
        par.(['sess' num2str(c)]).rec4.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec4.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec4.ch3.coord    = [13 10 15.83-15.76];
        par.(['sess' num2str(c)]).rec4.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec4.ch3.stTrials = [nan nan 1 500];
        par.(['sess' num2str(c)]).rec4.ch3.clus     = {'SU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-08-10_11-36-50';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [12 7 16.1-16];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15 9 16.265-15.9];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-08-10_12-35-33';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [12 7 16.5-16];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [15 9 16.535-15.9];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'SU','MU'};
        
        par.(['sess' num2str(c)]).rec3.fname        = '2018-08-10_13-34-03';
        par.(['sess' num2str(c)]).rec3.nChan        = [2 4];
        par.(['sess' num2str(c)]).rec3.ch2.coord    = [12 7 16.82-16];
        par.(['sess' num2str(c)]).rec3.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch2.clus     = {'SU','SU'};
        par.(['sess' num2str(c)]).rec3.ch4.coord    = [15 9 16.835-15.9];
        par.(['sess' num2str(c)]).rec3.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec4.fname        = '2018-08-10_13-54-27';
        par.(['sess' num2str(c)]).rec4.nChan        = [2 4];
        par.(['sess' num2str(c)]).rec4.ch2.coord    = [12 7 17.1-16];
        par.(['sess' num2str(c)]).rec4.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec4.ch2.clus     = {'MU','SU'};
        par.(['sess' num2str(c)]).rec4.ch4.coord    = [15 9 17.13-15.9];
        par.(['sess' num2str(c)]).rec4.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec4.ch4.clus     = {'MU', 'SU'};
        
        par.(['sess' num2str(c)]).rec5.fname        = '2018-08-10_14-17-45';
        par.(['sess' num2str(c)]).rec5.nChan        = [2 4];
        par.(['sess' num2str(c)]).rec5.ch2.coord    = [12 7 17.3-16];
        par.(['sess' num2str(c)]).rec5.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec5.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec5.ch4.coord    = [15 9 17.35-15.9];
        par.(['sess' num2str(c)]).rec5.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec5.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-08-16_11-39-47';
        par.(['sess' num2str(c)]).rec1.nChan        = [3 4];
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13 9 16.7-16.6];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15 10 20.1-20];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-08-16_12-44-36';
        par.(['sess' num2str(c)]).rec2.nChan        = [3 4];
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [13 9 16.97-16.6];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [15 10 20.33-20];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec3.fname        = '2018-08-16_13-02-16';
        par.(['sess' num2str(c)]).rec3.nChan        = [3];
        par.(['sess' num2str(c)]).rec3.ch3.coord    = [13 9 17.24-16.6];
        par.(['sess' num2str(c)]).rec3.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch3.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec3.ch4.coord    = [15 10 20.6-20];
        par.(['sess' num2str(c)]).rec3.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec4.fname        = '2018-08-16_13-38-45';
        par.(['sess' num2str(c)]).rec4.nChan        = [3];
        par.(['sess' num2str(c)]).rec4.ch3.coord    = [13 9 17.46-16.6];
        par.(['sess' num2str(c)]).rec4.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec4.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec5.fname        = '2018-08-16_13-59-29';
        par.(['sess' num2str(c)]).rec5.nChan        = [3];
        par.(['sess' num2str(c)]).rec5.ch3.coord    = [13 9 17.71-16.6];
        par.(['sess' num2str(c)]).rec5.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec5.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec6.fname        = '2018-08-16_14-17-15';
        par.(['sess' num2str(c)]).rec6.nChan        = [3];
        par.(['sess' num2str(c)]).rec6.ch3.coord    = [13 9 17.91-16.6];
        par.(['sess' num2str(c)]).rec6.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec6.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-08-17_10-46-05';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [12 10 16.075-16.075];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU','SU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [14 9 16.35-16];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-08-17_11-34-43';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [12 10 16.33-16.075];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [14 9 16.4-16];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec3.fname        = '2018-08-17_11-52-38';
        par.(['sess' num2str(c)]).rec3.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec3.ch2.coord    = [12 10 16.53-16.075];
        par.(['sess' num2str(c)]).rec3.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec3.ch3.coord    = [14 9 16.6-16];
        par.(['sess' num2str(c)]).rec3.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec4.fname        = '2018-08-17_12-42-02';
        par.(['sess' num2str(c)]).rec4.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec4.ch2.coord    = [12 10 16.75-16.075];
        par.(['sess' num2str(c)]).rec4.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec4.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec4.ch3.coord    = [14 9 16.82-16];
        par.(['sess' num2str(c)]).rec4.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec4.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec5.fname        = '2018-08-17_13-26-43';
        par.(['sess' num2str(c)]).rec5.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec5.ch2.coord    = [12 10 17.06-16.075];
        par.(['sess' num2str(c)]).rec5.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec5.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec5.ch3.coord    = [14 9 17.22-16];
        par.(['sess' num2str(c)]).rec5.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec5.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec6.fname        = '2018-08-17_13-52-59';
        par.(['sess' num2str(c)]).rec6.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec6.ch2.coord    = [12 10 17.45-16.075];
        par.(['sess' num2str(c)]).rec6.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec6.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec6.ch3.coord    = [14 9 17.47-16];
        par.(['sess' num2str(c)]).rec6.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec6.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-08-22_11-06-17';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [15 12 16-12];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU','SU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 10 14.5-14.47];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'SU','MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-08-22_12-28-29';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [15 12 16.2-12];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [15 10 14.7-14.47];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'SU','MU'};
        
        par.(['sess' num2str(c)]).rec3.fname        = '2018-08-22_13-18-48';
        par.(['sess' num2str(c)]).rec3.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec3.ch2.coord    = [15 12 16.4-12];
        par.(['sess' num2str(c)]).rec3.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch2.clus     = {'SU','SU','MU'};
        par.(['sess' num2str(c)]).rec3.ch3.coord    = [15 10 15.01-14.47];
        par.(['sess' num2str(c)]).rec3.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch3.stTrials = [nan nan 1 275];
        par.(['sess' num2str(c)]).rec3.ch3.clus     = {'SU'};
        
        par.(['sess' num2str(c)]).rec4.fname        = '2018-08-22_13-49-55';
        par.(['sess' num2str(c)]).rec4.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec4.ch2.coord    = [15 12 16.61-12];
        par.(['sess' num2str(c)]).rec4.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec4.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec4.ch3.coord    = [15 10 13.8-14.47];
        par.(['sess' num2str(c)]).rec4.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec4.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-08-24_11-30-39';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [14 12 18.1-18];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.stTrials = [nan nan 50 nan];
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [16 13 17.51-17];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-08-24_12-56-02';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [14 12 18.33-18] ;
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [16 13 17.75-17];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec3.fname        = '2018-08-24_14-06-52';
        par.(['sess' num2str(c)]).rec3.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec3.ch2.coord    = [14 12 18.6-18];
        par.(['sess' num2str(c)]).rec3.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch2.clus     = {'SU','MU','SU'};
        par.(['sess' num2str(c)]).rec3.ch3.coord    = [16 13 18.17-17];
        par.(['sess' num2str(c)]).rec3.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec4.fname        = '2018-08-24_14-26-57';
        par.(['sess' num2str(c)]).rec4.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec4.ch2.coord    = [14 12 18.8-18];
        par.(['sess' num2str(c)]).rec4.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec4.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec4.ch3.coord    = [16 13 18.37-17];
        par.(['sess' num2str(c)]).rec4.ch3.stTrials = [nan nan 100 400];
        par.(['sess' num2str(c)]).rec4.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec4.ch3.clus     = {'SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-08-30_12-14-44';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [13 8 11.603-11.4];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-08-30_14-38-46';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [13 8 12-11.4];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'SU','MU','SU'};
        
        par.(['sess' num2str(c)]).rec3.fname        = '2018-08-30_15-04-22';
        par.(['sess' num2str(c)]).rec3.nChan        = [2];
        par.(['sess' num2str(c)]).rec3.ch2.coord    = [13 8 12.2-11.4];
        par.(['sess' num2str(c)]).rec3.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch2.clus     = {'SU','MU'};
        
        par.(['sess' num2str(c)]).rec4.fname        = '2018-08-30_15-24-22';
        par.(['sess' num2str(c)]).rec4.nChan        = [2];
        par.(['sess' num2str(c)]).rec4.ch2.coord    = [13 8 12.53-11.4];
        par.(['sess' num2str(c)]).rec4.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec4.ch2.clus     = {'SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-08-31_13-22-27';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [13 8 19.6-18.6];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-08-31_14-10-39';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [13 8 19.8-18.6];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-09-12_13-27-19';
        par.(['sess' num2str(c)]).rec1.nChan        = [3];
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 11 18-17.9];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'SU','MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-09-12_15-33-13';
        par.(['sess' num2str(c)]).rec2.nChan        = [3];
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [15 11 18-17.9];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-09-14_10-57-28';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [13 10 16.13-15.07];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU', 'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 11 15.53-15.28];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'SU', 'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-09-14_12-16-01';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [13 10 16.51-15.07];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [15 11 16.03-15.28];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-09-17_12-36-55';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [13 9 16.18-14.8];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','SU','SU'};       % errors during replay
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 11 13.6-13.4];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-09-17_15-43-32';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [13 9 16.41-14.8];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [15 11 14.11-13.4];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-09-25_10-32-03';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [13 9 12.3-12.2];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 11 14.8-14.6];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-09-25_12-33-17';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [13 9 12.7-12.2];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU', 'SU', 'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [15 11 15.3-14.6];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-09-26_10-17-54';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [13 9 13-12.8];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 11 14.86-14.5];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-09-26_13-14-45';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [13 9 13.5-12.8];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [15 11 15.4-14.5];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'SU', 'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-02_10-33-19';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [13 9 15.55-15.2];
        par.(['sess' num2str(c)]).rec1.ch2.stTrials = [1 210 nan nan];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','SU','MU','SU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 11 17.95-17.7];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-10-02_14-09-53';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [13 9 16-15.2];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [15 11 18.8-17.7];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {[]};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-03_11-18-15';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [13 9 13.5-13.1];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.stTrials = [1 300 nan nan];
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 11 14.45-14];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.stTrials = [75 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-10-03_13-38-50';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [13 9 13.8-13.1];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [15 11 14.82-14];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-04_11-12-23';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [13 9 15-14.6];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','SU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 11 14.7-14.6];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.stTrials = [50 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-05_10-05-21';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [13 9 13.88-13.2];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 11 14.82-13.7];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-10-05_12-33-05';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [13 9 14.32-13.2];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU', 'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [15 11 15.28-13.7];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-09_10-04-30';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [12 10 14.8-14.4];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [14 13 15.8-15.5];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-10-09_11-50-39';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [12 10 15.1-14.4];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'SU','SU','MU','MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [14 13 16.1-15.5];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-10_11-24-06';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [11 9 18.928-18.5];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13 11 19.152-19.1];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-10-10_13-48-34';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [11 9 19.3-18.5];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [13 11 19.4-19.1];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-11_11-00-10';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [12 9 14.2-13.7];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [14 11 15.61-15.37];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-10-11_12-58-54';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [12 9 14.7-13.7];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.stTrials = [1 190 nan nan];
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [14 11 15.93-15.37];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'SU'};
        
        par.(['sess' num2str(c)]).rec3.fname        = '2018-10-11_14-21-25';
        par.(['sess' num2str(c)]).rec3.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec3.ch2.coord    = [12 9 15.13-13.7];
        par.(['sess' num2str(c)]).rec3.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec3.ch3.coord    = [14 11 16.555-15.37];
        par.(['sess' num2str(c)]).rec3.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-12_10-35-42';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [10 9 14.91-14.5];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [12 11 19.47-18];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [14 12 17.87-17];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-10-12_12-48-11';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [10 9 15.2-14.5];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [12 11 19.85-18];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [14 12 18.9-17];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.stTrials = [1 350 nan nan];
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec3.fname        = '2018-10-12_14-20-21';
        par.(['sess' num2str(c)]).rec3.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec3.ch2.coord    = [10 9 15.4-14.5];
        par.(['sess' num2str(c)]).rec3.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch2.clus     = {'SU','MU','MU'};
        par.(['sess' num2str(c)]).rec3.ch3.coord    = [12 11 20.1-18];
        par.(['sess' num2str(c)]).rec3.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec3.ch4.coord    = [14 12 18.6-17];
        par.(['sess' num2str(c)]).rec3.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-15_12-23-48';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [10 8 18.15-17.84];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13 9 14.81-13.9];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15 12 18.78-18.66];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.stTrials = [100 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-10-15_14-41-47';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [10 8 18.37-17.84];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [13 9 15.11-13.9];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [15 12 19.17-18.66];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-16_12-34-02';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [11 8 15.53-15.2];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13 8 15.87-15.6];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15 10 12.78-12.5];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-10-16_13-49-35';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [11 8 15.73-15.2];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [13 8 15.97-15.6];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU','MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [15 10 12.98-12.5];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-17_10-51-32';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [10 8 10.91-10.85];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13 9 12-11.3];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15 12 18.36-18.1];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-10-17_12-45-07';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [10 8 11.11-10.85];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [13 9 12.2-11.3];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [15 12 18.57-18.1];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-18_11-06-59';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9 8 14-13.3] ;
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [12 9 13.93-13.3];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [14 11 14.5-13.9];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-19_11-08-05';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9 8 11.46-10.7];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.stTrials = [100 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13 9 14.02-13.9];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15 11 16.71-16.2];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-10-19_12-53-00';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [9 8 11.66-10.7];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [13 9 14.25-13.9];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [15 11 16.91-16.2];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-24_11-01-58';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9 8 13.46-13.1];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.stTrials = [100 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13 9 15.57-15.1];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15 12 18.32-17.4];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-10-24_13-08-32';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [9 8 13.74-13.1];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [13 9 16.41-15.1];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU','MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [15 12 18.81-17.4];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-26_10-28-46';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8 8 13.6-13.4];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [12 9 14.99-14.6];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [14 12 17.24-16];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-10-26_12-25-34';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [8 8 13.91-13.4];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [12 9 15.41-14.6];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU','MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [14 12 17.83-16];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-30_10-29-21';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [7 8 12.28-11.8];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [11 9 15.1-13.8];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'SU','SU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [13 11 15.47-14.7];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-10-30_12-49-28';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [7 8 12.59-11.8];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [11 9 15.34-13.8];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [13 11 15.67-14.7];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-10-31_10-21-11';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9 8 18.865-16.9];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13 9 13.88-13.5];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'SU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [13 11 18.6-18.4];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-10-31_12-30-15';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [9 8 19.7-16.9];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [13 9 16.04-13.5];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [15 12 18.95-18.4];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-11-01_13-25-34';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9 9 16.11-15];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13 8 14.09-12.4];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [16 11 16.9-15.8];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'SU','MU'};
        
        %         par.(['sess' num2str(c)]).rec2.fname        = '2018-11-01_14-48-20';  % no tuning
        %         par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        %         par.(['sess' num2str(c)]).rec2.ch2.coord    = [9 9 16.4-15];
        %         par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        %         par.(['sess' num2str(c)]).rec2.ch2.clus     = {[]};
        %         par.(['sess' num2str(c)]).rec2.ch3.coord    = [13 8 14.3-12.4];
        %         par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        %         par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        %         par.(['sess' num2str(c)]).rec2.ch4.coord    = [16 11 17.13-15.8];
        %         par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        %         par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU','SU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-11-02_11-13-51';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9 8 14.88-13.9];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [12 9 14.86-13.9];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [14 11 15.93-14.5];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-11-02_13-24-33';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [9 8 15.1-13.9];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [12 9 15.48-13.9];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.stTrials = [1 425 nan nan];
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [14 11 16.31-14.5];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.stTrials = [1 425 nan nan];
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-11-05_11-17-53';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8 8 12.2-11.4];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [12 8 12.59-12.2];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [14 10 17.27-16.3];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-11-05_13-07-11';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [8 8 12.45-11.4];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [12 8 13.34-12.2];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [14 10 17.83-16.3];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-11-06_10-51-09';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9 8 17.36-16.3];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13 9 17-16.3];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15 12 19.06-18.5];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-11-06_13-06-38';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [9 8 17.55-16.3];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [13 9 17.2-16.3];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [15 12 19.26-18.5];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-11-07_11-18-01';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [7 8 15.15-14.9];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [11 9 15.56-15.15];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [13 11 16.92-16.6];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-11-07_13-39-17';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [7 8 15.41-14.9];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [11 9 16.13-15.15];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.stTrials = [130 nan nan nan];
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [13 11 17.21-16.6];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-11-08_11-26-48';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9 9 16.33-14.8];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13 8 16.36-15.8];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [16 11 17.35-17.1];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-11-08_13-42-57';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [9 9 16.55-14.8];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [13 8 16.85-15.8];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.stTrials = [1 525 nan nan];
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [16 11 18.17-17.1];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-11-09_11-02-56';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [11 8 15.17-14.6];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [14 9 15.75-15.4];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.stTrials = [55 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [14 12 16.75-15.9];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-11-09_13-11-56';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [11 8 15.42-14.6];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [14 9 16.1-15.4];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [14 12 17.14-15.9];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.stTrials = [1 510 nan nan];
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-11-29_11-06-28';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [13 7 10.5-9.7];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 9 11.57-11.1];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [16 12 13.92-12.5];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'SU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-11-29_13-14-37';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [13 7 10.7-9.7];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'}';
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [15 9 11.77-11.1];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [16 12 14.15-12.5];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-12-03_12-00-02';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [14 7 10.5-9.7];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU' 'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [16 9 11.57-11.1];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [17 12 13.92-12.5];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-12-03_14-10-18';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [14 7 10.7-9.7];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [16 9 11.77-11.1];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU' 'SU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [17 12 14.15-12.5];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {[]};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-12-11_12-07-03';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [14 8 10.02-10];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [16 10 11.33-10.5];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [17 12 12.45-12.55];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-12-12_12-09-05';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [10 7 12-10.1];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 8 13.33-12.5];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [17 11 11.15-11.15];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         par.(['sess' num2str(c)]).rec1.fname        = '2018-12-13_14-28-51'; % weird...more stimuli than usual - maybe presented two sets accidentally?!
%         par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
%         par.(['sess' num2str(c)]).rec1.ch2.coord    = [14 8 20-19.7];
%         par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
%         par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
%         par.(['sess' num2str(c)]).rec1.ch3.coord    = [16 10 15.1-14.2];
%         par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
%         par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
%         par.(['sess' num2str(c)]).rec1.ch4.coord    = [17 12 15.65-15.4];
%         par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
%         par.(['sess' num2str(c)]).rec1.ch4.stTrials = [1 550 nan nan];
%         par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
%         c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-12-19_12-00-57';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [13 7 11.05-9.9];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 9 13.02-12.3];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [16 12 15.06-14.3];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
        
%         par.(['sess' num2str(c)]).rec2.fname        = '2018-12-19_13-54-46';
%         par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
%         par.(['sess' num2str(c)]).rec2.ch2.coord    = [13 7 11.5-9.9];
%         par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
%         par.(['sess' num2str(c)]).rec2.ch2.stTrials = [100 nan nan nan];
%         par.(['sess' num2str(c)]).rec2.ch2.clus     = {[]};
%         par.(['sess' num2str(c)]).rec2.ch3.coord    = [15 9 13.22-12.3];
%         par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
%         par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
%         par.(['sess' num2str(c)]).rec2.ch4.coord    = [16 12 15.26-14.3];
%         par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
%         par.(['sess' num2str(c)]).rec2.ch4.stTrials = [75 425 nan nan];
%         par.(['sess' num2str(c)]).rec2.ch4.clus     = {[]};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-12-20_11-06-58';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9 7 10.22-9.7];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [16 8 10.82-10];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [17 11 14.13-13.88];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-12-20_13-50-21';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [9 7 10.42-9.7];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [16 8 11.52-10];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [17 11 14.33-13.88];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2018-12-21_11-07-13';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8 7 10.35-10];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU' 'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [14 8 12.5-11.85];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [17 10 14.25-13.4];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'SU' 'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2018-12-21_13-02-22';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [8 7 10.56-10];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [14 8 13.3-11.85];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [17 10 14.71-13.4];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .2;                   	% Inter-electrode spacing, Thomas Recording 8ch-Multitrode
        arr                                         = 0:sp:(7*sp);              % Contact depth from most superficial contact
        par.(['sess' num2str(c)]).rec2.fname        = '2019-01-03_11-23-48';
        par.(['sess' num2str(c)]).rec2.nChan        = [2:9];                   % [superficial deep], 8ch probe [2:9]
        par.(['sess' num2str(c)]).rec2.Plexon       = 'y';
        par.(['sess' num2str(c)]).rec2.Mic          = 1;

        for i = 1:8
            par.(['sess' num2str(c)]).rec2.(['ch' num2str(i+1)]).coord   = [16 10 arr(i)];
            par.(['sess' num2str(c)]).rec2.(['ch' num2str(i+1)]).field   = [];
        end

        %%%
        sp                                          = .2;                   	% Inter-electrode spacing, Thomas Recording 8ch-Multitrode
        arr                                         = .53:sp:((7*sp)+.53);      % Contact depth from most superficial contact
        par.(['sess' num2str(c)]).rec2.fname        = '2019-01-03_13-25-42';
        par.(['sess' num2str(c)]).rec2.nChan        = [2:9];                   % [superficial deep], 8ch probe [2:9]
        par.(['sess' num2str(c)]).rec2.Plexon       = 'y';
        par.(['sess' num2str(c)]).rec2.Mic          = 1;

        for i = 1:8
            par.(['sess' num2str(c)]).rec2.(['ch' num2str(i+1)]).coord   = [16 10 arr(i)];
            par.(['sess' num2str(c)]).rec2.(['ch' num2str(i+1)]).field   = [];
        end
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %         par.(['sess' num2str(c)]).rec1.fname        = '2019-01-04_11-20-24';      % probably not AC
        %         par.(['sess' num2str(c)]).rec1.nChan        = [10 11];
        %         par.(['sess' num2str(c)]).rec1.ch10.coord   = [17 8 8.11-7.3];
        %         par.(['sess' num2str(c)]).rec1.ch10.field   = 'xxx';
        %         par.(['sess' num2str(c)]).rec1.ch10.clus    = {'xxx'};
        %         par.(['sess' num2str(c)]).rec1.ch11.coord   = [17 11 15.3-12.2];
        %         par.(['sess' num2str(c)]).rec1.ch11.field   = 'xxx';
        %         par.(['sess' num2str(c)]).rec1.ch11.clus    = {'xxx'};
        
        sp                                          = .2;                   	% Inter-electrode spacing, Thomas Recording 8ch-Multitrode
        arr                                         = 0:sp:(7*sp);              % Contact depth from most superficial contact
        par.(['sess' num2str(c)]).rec2.fname        = '2019-01-04_14-30-39';
        par.(['sess' num2str(c)]).rec2.nChan        = [2:11];                   % [superficial deep], 8ch probe [2:9]
        par.(['sess' num2str(c)]).rec2.Plexon       = 'y';
        par.(['sess' num2str(c)]).rec2.Mic          = 1;

        for i = 1:8
            par.(['sess' num2str(c)]).rec2.(['ch' num2str(i+1)]).coord   = [17 8 arr(i)];
            par.(['sess' num2str(c)]).rec2.(['ch' num2str(i+1)]).field   = [];
        end
        
        par.(['sess' num2str(c)]).rec2.ch10.coord   = [17 8 12.1-7.3];
        par.(['sess' num2str(c)]).rec2.ch10.field   = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch10.clus    = {'xxx'};
        par.(['sess' num2str(c)]).rec2.ch11.coord   = [17 11 14.55-12.2];
        par.(['sess' num2str(c)]).rec2.ch11.field   = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch11.clus    = {'xxx'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-01-08_10-33-20';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [10 7 15.9-14.7];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [17 9 11.8-11.1];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU','MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [16 12 12.6-12.3];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        %         par.(['sess' num2str(c)]).rec2.fname        = '2019-01-08_12-34-30';      % no tuning - should be?! PC crashed trial 243
        %         par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        %         par.(['sess' num2str(c)]).rec2.ch2.coord    = [10 7 16.1-14.7];
        %         par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        %         par.(['sess' num2str(c)]).rec2.ch2.clus     = {[]};
        %         par.(['sess' num2str(c)]).rec2.ch3.coord    = [17 9 12-11.1];
        %         par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        %         par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        %         par.(['sess' num2str(c)]).rec2.ch4.coord    = [16 12 12.85-12.3];
        %         par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        %         par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-01-09_12-56-11';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [10 7 15.9-14.7];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [17 9 11.8-11.1];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [17 12 12.6-12.3];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-01-09_14-49-16';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [10 7 16.1-14.7];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [17 9 12-11.1];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [17 12 12.85-12.3];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.stTrials = [80 nan nan nan];
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {[]};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-01-10_12-40-38';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [10 9 17.76-16.6];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 9 14.52-14.1];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [14 12 17.45-16.3];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-01-10_13-52-58';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [10 9 17.96-16.6];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [15 9 14.77-14.1];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [14 12 17.95-16.3];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-01-11_11-09-51';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8 7 11.8-11.3];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 7 12.36-10.9];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15 11 18.91-18.5];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-01-11_13-14-49';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [8 7 12.05-11.3];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};                 % not sure about sorting
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [15 7 12.56-10.9];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [15 11 19.11-18.5];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-01-16_12-06-22';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [10 8 14-14];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [16 7 9.4-8.8];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [16 13 10.9-10.5];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU','MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-01-16_14-23-36';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [10 8 14.2-14];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [16 7 9.6-8.8];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'SU','SU','MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [16 13 11.1-10.5];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-01-17_11-22-37';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [10 9 14.13-13.5];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [17 7 10.88-10.5];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15 13 12.78-12.5];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'SU','MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-01-17_13-11-25';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [10 9 14.33-13.5];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [17 7 11.11-10.5];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [15 13 13.35-12.5];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.stTrials = [1 290 nan nan];
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-01-18_11-54-42';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9 9 13.8-13.2];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [17 8 12.35-11.2];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [17 13 13.7-13.2];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-01-18_13-55-11';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [9 9 14.01-13.2];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [17 8 12.57-11.2];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [17 13 13.92-13.2];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-01-23_11-37-09';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9 10 14.34-14.2];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [17 9 14.25-14.24];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [16 14 18.65-18.65];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
        sp                                          = .2;                   	% Inter-electrode spacing, Thomas Recording 8ch-Multitrode
        arr                                         = 0:sp:(7*sp);              % Contact depth from most superficial contact
        par.(['sess' num2str(c)]).rec1.fname        = '2019-01-25_12-27-13';
        par.(['sess' num2str(c)]).rec1.nChan        = [2:11];                   % [superficial deep], 8ch probe [2:9] + 2 x FHC tungsten electrode [10:11]
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';
        par.(['sess' num2str(c)]).rec1.Mic          = 1;

        for i = 1:8
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i+1)]).coord   = [16 10 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i+1)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch10.coord   = [10 10 14-13.6];
        par.(['sess' num2str(c)]).rec1.ch10.field   = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch10.clus    = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch11.coord   = [15 14 19.66-19.3];
        par.(['sess' num2str(c)]).rec1.ch11.field   = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch11.clus    = {[]};
        %%%%
        sp                                          = .2;                   	% Inter-electrode spacing, Thomas Recording 8ch-Multitrode
        arr                                         = 0:sp:(7*sp);              % Contact depth from most superficial contact
        par.(['sess' num2str(c)]).rec2.fname        = '2019-01-25_15-07-18';
        par.(['sess' num2str(c)]).rec2.nChan        = [2:11];                   % [superficial deep], 8ch probe [2:9] + 2 x FHC tungsten electrode [10:11]
        par.(['sess' num2str(c)]).rec2.Plexon       = 'y';
        par.(['sess' num2str(c)]).rec2.Mic          = 1;

        for i = 1:8
            par.(['sess' num2str(c)]).rec2.(['ch' num2str(i+1)]).coord   = [16 10 arr(i)];
            par.(['sess' num2str(c)]).rec2.(['ch' num2str(i+1)]).field   = [];
            par.(['sess' num2str(c)]).rec2.(['ch' num2str(i+1)]).stTrials= [1 350 nan nan];
        end 
        par.(['sess' num2str(c)]).rec2.ch10.coord    = [15 14 19.86-19.3];
        par.(['sess' num2str(c)]).rec2.ch10.field   = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch10.clus    = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch11.coord   = [10 10 14.41-13.6];
        par.(['sess' num2str(c)]).rec2.ch11.field   = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch11.clus    = {[]};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %         par.(['sess' num2str(c)]).rec1.fname        = '2019-02-04_12-26-38';  % copy correct folder
        %         par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        %         par.(['sess' num2str(c)]).rec1.ch2.coord    = [12 9 16.6-16.4];
        %         par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        %         par.(['sess' num2str(c)]).rec1.ch2.clus     = {[]};
        %         par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 14 17.35-17.2];
        %         par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        %         par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-02-04_13-21-39';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [12 9 16.8-16.4];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.stTrials = [nan nan 1 425];
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [15 14 17.79-17.2];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.stTrials = [1 400 nan nan];
        par.(['sess' num2str(c)]).rec2.ch3.stTrials2= [400 nan nan nan];
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {[]};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-02-06_12-36-56';      % Tuning only - remove SFG trials
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [12 10 15.55-14.9];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'R';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [14 14 16.6-16.6];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'MM';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [16 8 11.45-11.4];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'A1';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-02-06_13-41-50';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [12 10 15.78-14.9];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'R';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [14 14 16.8-16.6];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'MM';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [16 8 11.65-11.4];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'A1';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'SU','MU'};
        
        par.(['sess' num2str(c)]).rec3.fname        = '2019-02-06_14-08-06';
        par.(['sess' num2str(c)]).rec3.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec3.ch2.coord    = [12 10 16.03-14.9];
        par.(['sess' num2str(c)]).rec3.ch2.field    = 'R';
        par.(['sess' num2str(c)]).rec3.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec3.ch3.coord    = [14 14 17-16.6];
        par.(['sess' num2str(c)]).rec3.ch3.field    = 'MM';
        par.(['sess' num2str(c)]).rec3.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec3.ch4.coord    = [16 8 11.85-11.4];
        par.(['sess' num2str(c)]).rec3.ch4.field    = 'A1';
        par.(['sess' num2str(c)]).rec3.ch4.clus     = {'SU','MU','SU'};
        
        par.(['sess' num2str(c)]).rec4.fname        = '2019-02-06_14-36-52';
        par.(['sess' num2str(c)]).rec4.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec4.ch2.coord    = [12 10 16.33-14.9];
        par.(['sess' num2str(c)]).rec4.ch2.field    = 'R';
        par.(['sess' num2str(c)]).rec4.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec4.ch3.coord    = [14 14 17.2-16.6];
        par.(['sess' num2str(c)]).rec4.ch3.field    = 'MM';
        par.(['sess' num2str(c)]).rec4.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec4.ch4.coord    = [16 8 12.07-11.4];
        par.(['sess' num2str(c)]).rec4.ch4.field    = 'A1';
        par.(['sess' num2str(c)]).rec4.ch4.clus     = {'SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        sp                                          = .2;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-02-07_13-18-39';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:16];                   % [superficial deep], 16ch probe [1:16]
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 17;                          
        
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [16 8 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end  
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .2;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-02-08_12-15-16';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:16];                   % [superficial deep], 16ch probe [1:16]
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 17;                          
        
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [16 9 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end  
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .2;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-02-13_12-35-05';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:16];                   % [superficial deep], 16ch probe [1:16]
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 17;                          
        
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [16 9 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end  
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .2;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-02-14_10-57-10';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:16];                   % [superficial deep], 16ch probe [1:16]
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 17;                          
        
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [10 8 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end    
        %%%%
        sp                                          = .2;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec2.fname        = '2019-02-14_13-25-25';       
        par.(['sess' num2str(c)]).rec2.nChan        = [1:16];                   % [superficial deep], 16ch probe [1:16]
        par.(['sess' num2str(c)]).rec2.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec2.Mic          = 17;                          
        
        for i = 1:16
            par.(['sess' num2str(c)]).rec2.(['ch' num2str(i)]).coord   = [10 8 arr(i)];
            par.(['sess' num2str(c)]).rec2.(['ch' num2str(i)]).field   = [];
        end
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .2;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-02-15_11-01-29';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:16];                   % [superficial deep], 16ch probe [1:16]
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 17;                          
        
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [17 10 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end  
        c                                           = c+1;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    case 'Dollar'
        
        par.(['sess' num2str(c)]).rec1.fname        = '2019-03-27_10-21-17';            % Folder name
        par.(['sess' num2str(c)]).rec1.nChan        = [2];                              % Channel
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [10.5 10 16.05-15.8];             % Coordinates [x y z] -> z aligned to first auditory response
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';                            % Auditory field (estimated by tonotopic and response behaviour of cell)
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};                           % Number and type of cluster
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-03-27_11-40-17';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [10.5 10 16.2-15.8];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec3.fname        = '2019-03-27_12-23-15';
        par.(['sess' num2str(c)]).rec3.nChan        = [2];
        par.(['sess' num2str(c)]).rec3.ch2.coord    = [10.5 10 16.35-15.8];
        par.(['sess' num2str(c)]).rec3.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec3.ch2.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
        par.(['sess' num2str(c)]).rec1.fname        = '2019-03-29_10-28-12';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9.5 9 16.2-16.1];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-03-29_11-57-02';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [9.5 9 16.4-16.1];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-02_10-23-34';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8.5 7 16.5-16.5];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-03_10-42-29';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8.5 6 15.8-15.5];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-04-03_12-56-30';  
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [8.5 6 16-15.5];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'SU','MU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-04_10-49-06';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9 6 14.3-14.3];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-04-04_12-44-37';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [9 6 14.5-14.3];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-05_10-54-30';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [7.5 6 16.6-16.1];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-04-05_13-01-57';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [7.5 6 16.8-16.1];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-10_10-53-58';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9.5 8 15.2-15];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-04-10_12-39-18';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [9.5 8 15.35-15];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-11_11-09-09';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9.5 7 15-14.7];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-04-11_13-10-07';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [9.5 7 15.15-14.7];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-12_10-43-44';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9.5 6 14.5-13.5];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-04-12_13-48-00';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [9.5 6 14.65-13.5];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'SU','SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-16_10-34-46';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [10.5 9 16.2-15.9];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','SU','MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-04-16_12-33-10';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [10.5 9 16.35-15.9];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-17_11-08-28';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [11.5 8 14.6-13.9];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-04-17_13-15-30';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [11.5 8 14.75-13.9];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-18_11-02-59';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [12.5 8 13.05-13];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU', 'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-04-18_12-47-08';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [12.5 8 13.2-13];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'SU', 'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-19_11-54-30';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [12.5 9 15.5-15.4];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-04-19_13-52-47';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [12.5 9 15.65-15.4];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-22_10-47-17';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [12.5 10 17.5-16.7];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU', 'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-04-22_13-31-10';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [12.5 10 17.65-16.7];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-23_09-53-06';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [13.5 10 17.1-16.8];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-04-23_11-38-31';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [13.5 10 17.25-16.8];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-25_12-08-14';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8 6.5 21.1-21];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.stTrials = [1 400 nan nan];
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13.5 9 14.3-13.5];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.stTrials = [150 510 nan nan];
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-26_12-22-45';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9 7.5 24.5-24];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13.5 7.5 12.83-12.5];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-04-26_14-20-29';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [9 7.5 24.65-24];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [13.5 7.5 13-12.5];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.stTrials = [80 nan nan nan];
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-04-29_12-02-17';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [7 5.5 20.7-20.5];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13 6.5 13.7-13.7];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-04-29_14-28-15';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [7 5.5 20.9-20.5];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [13 6.5 13.9-13.7];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-05-01_12-42-26'; % Ch2 excluded
        par.(['sess' num2str(c)]).rec1.nChan        = [3];
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13.5 6.5 12.5-12.2];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-05-02_10-54-11';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8 4.5 20.2-20.2];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU', 'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13 6.5 14.6-14.5];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-05-02_12-59-20';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [8 4.5 20.35-20.2];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [13 6.5 14.8-14.5];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-05-03_11-01-21';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9 4.5 18-17.5];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [14.5 8.5 12-11.5];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-05-03_13-47-30';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [9 4.5 18.2-17.5];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [14.5 8.5 12.2-11.5];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-05-08_11-17-21';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [10 5 18.7-18.7];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [15 9 13.8-13.8];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-05-08_13-35-03';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [10 5 18.7-18.85];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.stTrials = [80 nan nan nan];
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [15 9 13.8-13.95];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-05-09_11-30-41';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9 7.5 22.5-21.8];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-05-10_11-28-42';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [10.5 8.5 22-22];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.stTrials = [1 330 nan nan];
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [11.5 6.5 16-13.3];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.stTrials = [1 330 nan nan];
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-05-13_12-44-00';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [7 5 19-18.9];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [12 8 14.7-14.7];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-05-14_10-50-19';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [6 5.5 19.1-19.1];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [11.5 9 16-15.8];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-05-14_13-45-46';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [6 5.5 19.3-19.1];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [11.5 9 16.15-15.8];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-05-15_11-18-29';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [6 6 19.4-19.3];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [11.5 9.5 15.5-15.4];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-05-15_13-18-52';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [6 6 19.6-19.3];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [11.5 9.5 15.65-15.4];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-05-16_11-14-22';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [6 6.5 19.7-19.7];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [10.5 8 14.2-14];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-05-16_13-15-03';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [6 6.5 19.85-19.7];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'SU', 'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [10.5 8 14.35-14];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-05-20_12-01-40';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [7 7 22.2-22.2];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [11 6.5 13.1-13];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-05-20_14-03-20';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [7 7 22.35-22.2];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [11 6.5 13.25-13];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-05-22_11-03-49';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8 7.5 23.85-23.85];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13.5 10.5 16.3-16.1];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-05-22_13-16-42';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [8 7.5 24-23.85];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [13.5 10.5 16.45-16.1];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-05-23_11-57-07';
        par.(['sess' num2str(c)]).rec1.nChan        = [3];
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [13 10.5 14.75-14];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-05-24_10-56-34';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [7 7.5 22.3-21.7];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [12 10.5 21.1-20];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-05-24_14-22-24';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [7 7.5 22.45-21.7];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [12 10.5 21.5-20];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-05-29_11-15-56';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [5 7 22.3-22];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [11 11 24.25-24.25];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-06-07_11-14-11';
        par.(['sess' num2str(c)]).rec1.nChan        = [2];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [14 9.5 13.8-13.6];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-06-07_13-25-45';
        par.(['sess' num2str(c)]).rec2.nChan        = [2];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [14 9.5 14.1-13.6];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-06-12_10-59-00';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [6 6 19.35-19.3];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [12.5 7.5 14.5-14.4];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-06-12_13-09-10';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [6 6 19.5-19.3];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [12.5 7.5 14.65-14.4];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-06-17_15-44-25';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 8;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [9 5 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
            if i == []
                par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).clus    = {[]};
            else
                par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).clus    = {[]};
            end
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [14 9 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
            if i == []
                par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).clus    = {[]};
            else
                par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).clus    = {[]};
            end
        end
        
        par.(['sess' num2str(c)]).rec1.ch10.stTrials = [125 nan nan nan];

        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-06-18_09-49-48';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 8;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [6 7 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [12 9 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-06-19_11-21-28';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [8 6 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [14 8 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch13.stTrials = [1 400 nan nan];
        par.(['sess' num2str(c)]).rec1.ch14.stTrials = [1 375 nan nan];
        par.(['sess' num2str(c)]).rec1.ch17.stTrials = [1 375 nan nan];
        par.(['sess' num2str(c)]).rec1.ch18.stTrials = [1 375 nan nan];
        par.(['sess' num2str(c)]).rec1.ch19.stTrials = [1 375 nan nan];
        par.(['sess' num2str(c)]).rec1.ch20.stTrials = [1 375 nan nan];
        par.(['sess' num2str(c)]).rec1.ch21.stTrials = [1 375 nan nan];
        par.(['sess' num2str(c)]).rec1.ch22.stTrials = [1 375 nan nan];
        par.(['sess' num2str(c)]).rec1.ch24.stTrials = [1 400 nan nan];
        par.(['sess' num2str(c)]).rec1.ch26.stTrials = [1 400 nan nan];
        par.(['sess' num2str(c)]).rec1.ch27.stTrials = [1 375 nan nan];
        par.(['sess' num2str(c)]).rec1.ch28.stTrials = [1 400 nan nan];
        par.(['sess' num2str(c)]).rec1.ch29.stTrials = [1 375 nan nan];
        par.(['sess' num2str(c)]).rec1.ch30.stTrials = [1 375 nan nan];
        par.(['sess' num2str(c)]).rec1.ch31.stTrials = [1 375 nan nan];
        par.(['sess' num2str(c)]).rec1.ch31.stTrials = [130 400 nan nan];

        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-02_11-59-08';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [9 7 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [15 9 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch31.stTrials = [1 325 nan nan];
        par.(['sess' num2str(c)]).rec1.ch32.stTrials = [1 400 nan nan];

        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-03_11-01-30';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [7 6 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [13 10 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch2.stTrials = [1 600 nan nan];
        par.(['sess' num2str(c)]).rec1.ch3.stTrials = [50 600 nan nan];
        par.(['sess' num2str(c)]).rec1.ch4.stTrials = [50 600 nan nan];
        par.(['sess' num2str(c)]).rec1.ch5.stTrials = [1 600 nan nan];
        par.(['sess' num2str(c)]).rec1.ch24.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch27.stTrials = [1 650 nan nan];
        par.(['sess' num2str(c)]).rec1.ch28.stTrials = [1 600 nan nan];
        par.(['sess' num2str(c)]).rec1.ch30.stTrials = [1 625 nan nan];
        par.(['sess' num2str(c)]).rec1.ch31.stTrials = [1 625 nan nan];
        par.(['sess' num2str(c)]).rec1.ch32.stTrials = [1 625 nan nan];

        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-04_14-20-16';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [10 5 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [15 10 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch5.stTrials = [1 450 nan nan];
        par.(['sess' num2str(c)]).rec1.ch6.stTrials = [1 650 nan nan];
        par.(['sess' num2str(c)]).rec1.ch10.stTrials = [1 650 nan nan];
        par.(['sess' num2str(c)]).rec1.ch12.stTrials = [1 500 nan nan];

        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-05_11-56-10';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [8 5 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [13 9 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch10.stTrials = [1 275 nan nan];
        par.(['sess' num2str(c)]).rec1.ch17.stTrials = [1 360 nan nan];
        par.(['sess' num2str(c)]).rec1.ch18.stTrials = [1 360 nan nan];
        par.(['sess' num2str(c)]).rec1.ch19.stTrials = [1 360 nan nan];
        par.(['sess' num2str(c)]).rec1.ch20.stTrials = [1 360 nan nan];
        par.(['sess' num2str(c)]).rec1.ch21.stTrials = [1 360 nan nan];
        par.(['sess' num2str(c)]).rec1.ch22.stTrials = [1 360 nan nan];
        par.(['sess' num2str(c)]).rec1.ch24.stTrials = [1 360 nan nan];
        par.(['sess' num2str(c)]).rec1.ch25.stTrials = [1 360 nan nan];
        par.(['sess' num2str(c)]).rec1.ch26.stTrials = [1 360 nan nan];
        par.(['sess' num2str(c)]).rec1.ch27.stTrials = [1 360 nan nan];
        par.(['sess' num2str(c)]).rec1.ch28.stTrials = [1 360 nan nan];
        par.(['sess' num2str(c)]).rec1.ch29.stTrials = [1 360 nan nan];
        par.(['sess' num2str(c)]).rec1.ch30.stTrials = [1 360 nan nan];
        par.(['sess' num2str(c)]).rec1.ch31.stTrials = [1 360 nan nan];
        par.(['sess' num2str(c)]).rec1.ch32.stTrials = [1 360 nan nan];

        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-08_11-50-04';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [8.8 6.4 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [14.4 7.2 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch9.stTrials = [65 nan nan nan];

        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-09_10-12-54';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [8 7.2 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [14.4 8.8 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch9.stTrials = [60 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch17.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch18.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch19.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch20.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch21.stTrials = [1 300 nan nan];
        par.(['sess' num2str(c)]).rec1.ch22.stTrials = [1 300 nan nan];
        par.(['sess' num2str(c)]).rec1.ch24.stTrials = [1 300 nan nan];
        par.(['sess' num2str(c)]).rec1.ch25.stTrials = [1 300 nan nan];
        par.(['sess' num2str(c)]).rec1.ch26.stTrials = [1 300 nan nan];
        par.(['sess' num2str(c)]).rec1.ch27.stTrials = [1 300 nan nan];
        par.(['sess' num2str(c)]).rec1.ch28.stTrials = [1 300 nan nan];
        par.(['sess' num2str(c)]).rec1.ch29.stTrials = [1 300 nan nan];
        par.(['sess' num2str(c)]).rec1.ch30.stTrials = [1 300 nan nan];
        par.(['sess' num2str(c)]).rec1.ch31.stTrials = [1 300 nan nan];
        par.(['sess' num2str(c)]).rec1.ch32.stTrials = [1 300 nan nan];

        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-10_11-22-42';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [7.2 4.8 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [12.8 8 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch5.stTrials = [1 525 nan nan];
        par.(['sess' num2str(c)]).rec1.ch6.stTrials = [1 525 nan nan];
        par.(['sess' num2str(c)]).rec1.ch7.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch8.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch11.stTrials = [275 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch13.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch14.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch17.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch18.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch19.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch20.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch21.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch22.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch24.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch25.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch26.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch27.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch28.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch29.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch30.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch31.stTrials = [1 500 nan nan];
        par.(['sess' num2str(c)]).rec1.ch32.stTrials = [1 500 nan nan];

        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-11_13-33-44';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [10.4 7.2 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [14.4 11.2 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch1.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch2.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch3.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch4.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch5.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch6.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch7.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch8.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch9.stTrials = [1 425 nan nan];
        par.(['sess' num2str(c)]).rec1.ch10.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch11.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch12.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch13.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch14.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch15.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch17.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch18.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch19.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch20.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch21.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch22.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch24.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch25.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch26.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch27.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch28.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch29.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch30.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch31.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch32.stTrials = [1 550 nan nan];

        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-12_11-16-08';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [7.2 7.2 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [12.8 7.2 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch17.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch18.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch19.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch20.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch21.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch22.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch24.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch25.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch26.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch27.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch28.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch29.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch30.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch31.stTrials = [1 340 nan nan];
        par.(['sess' num2str(c)]).rec1.ch32.stTrials = [1 340 nan nan];

        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-15_12-02-58';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [6.4 7.2 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [12.8 11.2 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch1.stTrials = [100 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch18.stTrials = [100 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch19.stTrials = [100 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch24.stTrials = [200 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch25.stTrials = [200 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch26.stTrials = [200 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch27.stTrials = [200 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch32.stTrials = [1 550 nan nan];

        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-16_11-30-46';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [4.8 8 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [12 10.4 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch17.stTrials = [1 330 nan nan];         % !!!!!!!! data split possible !!!!!!!!!!!!!!!!!!
        par.(['sess' num2str(c)]).rec1.ch18.stTrials = [1 330 nan nan];
        par.(['sess' num2str(c)]).rec1.ch19.stTrials = [1 330 nan nan];
        par.(['sess' num2str(c)]).rec1.ch20.stTrials = [1 330 nan nan];
        par.(['sess' num2str(c)]).rec1.ch21.stTrials = [1 330 nan nan];
        par.(['sess' num2str(c)]).rec1.ch22.stTrials = [1 330 nan nan];
        par.(['sess' num2str(c)]).rec1.ch24.stTrials = [1 330 nan nan];
        par.(['sess' num2str(c)]).rec1.ch25.stTrials = [1 330 nan nan];
        par.(['sess' num2str(c)]).rec1.ch26.stTrials = [1 330 nan nan];
        par.(['sess' num2str(c)]).rec1.ch27.stTrials = [1 330 nan nan];
        par.(['sess' num2str(c)]).rec1.ch28.stTrials = [1 330 nan nan];
        par.(['sess' num2str(c)]).rec1.ch29.stTrials = [1 330 nan nan];
        par.(['sess' num2str(c)]).rec1.ch30.stTrials = [1 330 nan nan];
        par.(['sess' num2str(c)]).rec1.ch31.stTrials = [1 330 nan nan];
        par.(['sess' num2str(c)]).rec1.ch32.stTrials = [1 330 nan nan];
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-17_11-43-09';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:17];                   % [superficial deep], One electrode broke, changed headstage, replay with correct mapping
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 17;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [6.4 4.8 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
%         % Probe 2
%         for i = 17:32
%             par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [12 8 arr(i-16)];
%             par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
%         end
%         c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-18_11-28-26';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [10.4 6.4 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [12 11.2 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch1.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch2.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch3.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch4.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch5.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch6.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch7.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch8.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch9.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch10.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch11.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch12.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch13.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch14.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch15.stTrials = [1 550 nan nan];
        par.(['sess' num2str(c)]).rec1.ch17.stTrials = [1 380 nan nan];
        par.(['sess' num2str(c)]).rec1.ch18.stTrials = [1 380 nan nan];
        par.(['sess' num2str(c)]).rec1.ch19.stTrials = [1 380 nan nan];
        par.(['sess' num2str(c)]).rec1.ch20.stTrials = [1 380 nan nan];
        par.(['sess' num2str(c)]).rec1.ch21.stTrials = [1 380 nan nan];
        par.(['sess' num2str(c)]).rec1.ch22.stTrials = [1 380 nan nan];
        par.(['sess' num2str(c)]).rec1.ch24.stTrials = [1 380 nan nan];
        par.(['sess' num2str(c)]).rec1.ch25.stTrials = [1 380 nan nan];
        par.(['sess' num2str(c)]).rec1.ch26.stTrials = [1 380 nan nan];
        par.(['sess' num2str(c)]).rec1.ch27.stTrials = [1 380 nan nan];
        par.(['sess' num2str(c)]).rec1.ch28.stTrials = [1 380 nan nan];
        par.(['sess' num2str(c)]).rec1.ch29.stTrials = [1 380 nan nan];
        par.(['sess' num2str(c)]).rec1.ch30.stTrials = [1 380 nan nan];
        par.(['sess' num2str(c)]).rec1.ch31.stTrials = [1 380 nan nan];
        par.(['sess' num2str(c)]).rec1.ch32.stTrials = [1 380 nan nan];

        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-19_10-44-01';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [9 8 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [12 9 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch21.stTrials = [50 nan nan nan];
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-24_11-12-09';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [7.5 8 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [12 7 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch8.stTrials = [1 300 nan nan];
        par.(['sess' num2str(c)]).rec1.ch12.stTrials = [1 275 nan nan];

        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sp                                          = .15;                   	% Inter-electrode spacing
        arr                                         = 0:sp:(15*sp);             % Contact depth from most superficial contact 
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-25_11-27-24';       
        par.(['sess' num2str(c)]).rec1.nChan        = [1:32];                   % [superficial deep], Two 16ch probes [1:16; 17:32] with different coordinates!
        par.(['sess' num2str(c)]).rec1.Plexon       = 'y';                          
        par.(['sess' num2str(c)]).rec1.Mic          = 16;                          
        
        % Probe 1
        for i = 1:16
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [7.2 5.6 arr(i)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        
        % Probe 2
        for i = 17:32
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).coord   = [11.2 7.2 arr(i-16)];
            par.(['sess' num2str(c)]).rec1.(['ch' num2str(i)]).field   = [];
        end
        par.(['sess' num2str(c)]).rec1.ch2.stTrials = [1 425 nan nan];          % !!!!!! data split possible !!!!!
        par.(['sess' num2str(c)]).rec1.ch6.stTrials = [300 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch7.stTrials = [300 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch11.stTrials = [300 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch12.stTrials = [300 nan nan nan];

        c                                           = c+1;   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-26_11-56-56';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8 6.4 11.2-11];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [11.2 8 12.3-11.8];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [14.4 10.4 14.46-14.46];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        
        par.(['sess' num2str(c)]).rec2.fname        = '2019-07-26_14-28-19';
        par.(['sess' num2str(c)]).rec2.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec2.ch2.coord    = [8 6.4 11.4-11];
        par.(['sess' num2str(c)]).rec2.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch3.coord    = [11.2 8 12.5-11.8];
        par.(['sess' num2str(c)]).rec2.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec2.ch4.coord    = [14.4 10.4 14.66-14.46];
        par.(['sess' num2str(c)]).rec2.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec2.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-30_10-20-37';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [7.2 6.4 16.1-16.3];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [11.2 10.4 16.17-15.7];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15.2 10.4 11.76-11.5];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-07-31_11-45-17';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [6.4 5.6 18.57-18.4];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [10.4 8 17.02-16.8];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15.2 8.8 9.56-9.1];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        c                                           = c+1;  
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-08-01_12-38-29';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3];
        par.(['sess' num2str(c)]).rec1.ref          = [5 6];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [7.2 4.8 15.5-15.3];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [14.4 8 17.55-17];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'SU','MU'};
        c                                           = c+1; 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-08-05_12-14-12';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ref          = [5 6];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [6.4 7.2 18.8-18.5];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [11.2 6.4 17.63-16.9];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15.2 11.2 10.5-10];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'SU','MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-08-06_11-17-18';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ref          = [5 6];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [7.2 7.2 18.8-18.5];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [12 6.4 15.58-14.6];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15.2 12 13.31-12.6];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% NEW STIMULI: COH 4+8
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-08-07_10-35-55';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ref          = [5 6];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8 7.2 20.27-19.8];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.stTrials = [100 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {'SU','MU'};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [12.8 6.4 14.3-14];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {'MU'};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [14.4 12 13.2-11.5];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {'MU'};
        c                                           = c+1;        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-08-08_11-51-43';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ref          = [5 6];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8 6.4 16-15.5];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.stTrials = [150 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [12 7.2 16.53-16.2];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [12.8 12 17.2-17];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-08-09_10-59-44';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ref          = [5 6];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [7.2 5.6 19-18.6];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [11.2 8 15.5-15.2];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.stTrials = [1 300 nan nan];
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [14.4 11.2 15.35-14.8];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-08-12_12-21-54';
        par.(['sess' num2str(c)]).rec1.nChan        = [3 4];
        par.(['sess' num2str(c)]).rec1.ref          = [5 6];
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [11.2 8.8 19-18.6];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.stTrials = [200 nan nan nan];
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15.2 11.2 17.4-17.2];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-08-13_11-28-40';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ref          = [5 6];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8.8 5.6 16.61-16.2];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [12 9.6 15.9-15.7];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15.2 10.4 15.95-15.6];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-08-14_11-43-04';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ref          = [5 6];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [9.6 5.6 14.51-14.4];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [12 8.8 18.4-18];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15.2 9.6 11.35-10.8];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-08-15_11-25-06';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 4];
        par.(['sess' num2str(c)]).rec1.ref          = [5 6];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8.8 4.8 12-11.7];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [15.2 8.8 12.3-12.1];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-08-16_11-30-50';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ref          = [5 6];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8 5.6 20.35-20];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.stTrials = [1 525 nan nan];
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [11.2 6.4 22.8-22.7];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [14.4 8.8 15.78-15.5];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-08-19_11-40-31';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ref          = [5 6];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [7.2 5.6 15.7-15.5];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [12 6.4 16.1-15.3];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [14.4 9.6 0];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
        c                                           = c+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        par.(['sess' num2str(c)]).rec1.fname        = '2019-08-21_10-44-29';
        par.(['sess' num2str(c)]).rec1.nChan        = [2 3 4];
        par.(['sess' num2str(c)]).rec1.ref          = [5 6];
        par.(['sess' num2str(c)]).rec1.ch2.coord    = [8 6.4 14.91-14.4];
        par.(['sess' num2str(c)]).rec1.ch2.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch2.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch3.coord    = [11.2 8 0];
        par.(['sess' num2str(c)]).rec1.ch3.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch3.clus     = {[]};
        par.(['sess' num2str(c)]).rec1.ch4.coord    = [14.4 11.2 14.8-14.4];
        par.(['sess' num2str(c)]).rec1.ch4.field    = 'xxx';
        par.(['sess' num2str(c)]).rec1.ch4.clus     = {[]};
        c                                           = c+1;
end
end