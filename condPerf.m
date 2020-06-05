function [out] = condPerf(mat)

if size(mat,1) >= 200
    
    gndTr       = mat(mat(:,2) > 4,:);
    CRr         = sum(gndTr(:,1)) /(size(gndTr,1));
    FAr         = 1 - CRr;
            
    for i = 1:3
        
        if i == 1
            idx  	 = mat(:,7) == 4;
        elseif i == 2
            idx  	 = mat(:,7) == 8;
        elseif i == 3
            idx   	= mat(:,7) == 12;
        end
        
        cmat        = mat(idx,:);

        if isempty(cmat)
            out(i,:) = nan(1,5);
        else
            figTr       = cmat(cmat(:,2) < 5,:); 
            HIr         = sum(figTr(:,1)) /(size(figTr,1));
            dp          = norminv(HIr) - norminv(FAr);   
            
            RT          = figTr(logical(figTr(:,1)),3);
            mRT         = median(RT*1000);
            sd          = std(RT*1000);
            
            out(i,:)    = [HIr FAr dp mRT sd];

        end
    end
else
    out = nan(3,5);       
end
end