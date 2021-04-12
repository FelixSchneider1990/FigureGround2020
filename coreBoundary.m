function [x,y] = coreBoundary(tMap,vec1, vec2, plotFlag, animalID)
%% Remove empty columns

source  = tMap(vec1,vec2);

if strcmp(animalID, 'Eric') || strcmp(animalID, 'M1')
    source(1,2) = nan;
end

if strcmp(animalID, 'Dollar') || strcmp(animalID, 'M2')
    source(1,4) = nan;
    source(end-1:end,7) = nan;
end

minVals = source == min(source);

for i = 1:size(minVals,2)
    loc = []; loc2 = []; flag = 0;
    loc = find(minVals(:,i));
    
    if numel(loc > 1)
        loc = min(loc);
    end
    
    try
        if isnan(source(loc-1,i))
            loc2 = loc-1;
        elseif isnan(source(loc+1,i))
            loc2 = loc+1;
        end
    catch
        flag = 1;
    end
    
    if flag ~= 1
        if loc == 1
            loc2 = size(source,1)+1;
        elseif  loc == size(source,1)
            loc2 = size(source,1)-1;
        else
            closest = min(source(loc-1,i),source(loc+1,i));
            loc2 = find(source(:,i) == closest);
        end
    else
        loc2 = loc-1;
    end
    
    bound(i) = (loc+loc2)/2;
end

y = bound + vec1(1)-1;
x = vec2;

if strcmp(animalID, 'Dollar')
    y(end) = y(end-1);
end

c = 1;
for j = 1:length(y)
    yy(c) = y(j);
    xx(c) = x(j)-.5;
    c = c+1;
    yy(c) = y(j);
    xx(c) = x(j)+.5;
    c = c+1;
end

if plotFlag
    fig = figure;
    imagesc(tMap);
    hold on
    plot(xx,yy, 'k','LineWidth', 4)
    cb = colorbar;
    caxis([5 9])
    cb.Label.String = 'Best Freq [Hz]';
    cb.Label.FontWeight = 'bold';
    cm = [0 0 0; flipud(jet(256))];
    colormap(cm)
end
end


