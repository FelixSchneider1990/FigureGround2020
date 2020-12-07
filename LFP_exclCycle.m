function out = LFP_exclCycle(mat, f1, f2, noF, flag)

sz      = size(mat);
nmat    = ones(sz(1:2));
frex    = linspace(f1,f2,noF);
rCycl   = [4 10];
cycl    = logspace(log10(rCycl(1)),log10(rCycl(end)),noF);

for i = 1:length(frex)
    nBlock          = round( ((1/frex(i)*cycl(i))/2) *1000); % Half wavelet window in [ms]: length oscillation * no of cycles
    
    if size(mat,2) <= nBlock
        nmat(i,:)   = nan;
    else
        switch flag
            case 1
                nmat(i,end-(nBlock-1):end)  = nan;
                nmat(i,1:nBlock)            = nan;
            case 2
                nmat(i,end-(nBlock-1):end)  = nan;
        end
    end
end

if numel(sz) == 2
    out     = mat.*nmat;
elseif numel(sz) == 3
    for i = 1:sz(3)
        out(:,:,i)     = mat(:,:,i).*nmat;
    end
end
end

