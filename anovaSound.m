function out = anovaSound(tmat, ttype)

if strcmp(ttype, 'PT')
    idx	= 1;
    sz  = 14;
elseif strcmp(ttype, 'BPN')
    idx = 2;
    sz  = 13;
else error('No such type!')
end

all     = [];
int     = [];
freq    = strings();

for iV  = 1:3
    pt  = tmat(idx,:,iV);
    for iF = 1:sz
        a       = [];
        a       = max(pt{iF}(:,201:400),[],2);
        f       = ['freq' num2str(iF)];
        v       = ['int' num2str(iV)];
        
        all     = vertcat(all, a);
        freq    = vertcat(freq,repmat(f,length(a),1));
        int     = vertcat(int,repmat(v,length(a),1));
    end
end

if sum(isnan(all)) == length(all)
    out = nan;
    return
end

freq(1)         = [];
[p, tbl, stat]	= anovan(all,{cellstr(int), cellstr(freq)},'model','interaction','varnames',{'int','freq'},'display','off');
out             = p(2);

end