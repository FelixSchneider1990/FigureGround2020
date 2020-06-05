function copyFiles(par)

disp('Copy to network...')
list = dir(par.dpath);
fname = {list.name}; % get all file names

for i = 3:length(fname)-1
    progressbar(i/length(fname))
    f = fname{i};
    source = [par.dpath f];
    dest = [par.spath f];
    copyfile(source, dest)
end
end