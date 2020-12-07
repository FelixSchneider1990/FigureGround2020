function reduceNSE(data)
%% Loop through all folders

disp('Reduce NSE-file size...')

if nargin < 1
    sub = {'Dollar', 'Eric'};
    for iSub = 1:2
        path    = ['Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\' sub{iSub} '\'];
        list    = dir(path);
        fname   = {list.name}; % get all folder names
        idx     = horzcat(find(contains(fname,'2018')),find(contains(fname,'2019'))); % find recording folders
        fname   = fname(idx);
        
        for i = 1:length(fname)
            progressbar((i-st-1)/(length(fname)-st-1))
            cd([path fname{i}])
            for no = 2:11
                if exist(['SE' num2str(no) '.nse'], 'file') == 2
                    nse = ['SE' num2str(no) '.nse'];
                    new = ['SE' num2str(no) 'r.nse'];
                    NLXFILE_Reduce_spike_files2(nse, new)
                end
            end
            disp('Done!')
        end
    end
    
else
    fname = data.sdir;
    cd(fname)
    for no = data.param.nChan
        if exist(['SE' num2str(no) '.nse'], 'file') == 2
            if exist(['SE' num2str(no) 'r.nse'], 'file') == 2               % if reduced file available, don't repeat procedure
            else
                nse = ['SE' num2str(no) '.nse'];
                new = ['SE' num2str(no) 'r.nse'];
                NLXFILE_Reduce_spike_files2(nse, new)
            end
        end
    end
    disp('Done!')
end
end
