function [ant, pos] = sortUnits(ML,AP, arr)

ant = {};
pos = {};
for j = 1:size(arr,2)
    if ~isempty(arr{j})
        if arr{j}.coord(1) <= AP(ML == round(arr{j}.coord(2)))
            ant = cat(2,ant, arr{j});
        else
            pos = cat(2,pos, arr{j});
        end
    end
end
end
