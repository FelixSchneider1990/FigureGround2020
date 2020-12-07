function [outPT, outBPN, RF] = getRF(carr, perc, plot, BLcorr)

if nargin < 3
    plot = false;
    BLcorr = true;
end

if nargin < 2
    perc = .2;
end

mat = cat(1,carr(1,:,1),carr(1,:,2),carr(1,:,3));

if BLcorr
    for i = 1:size(mat,1)
        for ii = 1:size(mat,2)
            bl(i,ii) = mean(mat{i,ii}(1:200));
        end
    end
    BL = nanmean(nanmean(bl));
else
    BL = 0;
end

for i = 1:size(mat,1)
    for ii = 1:size(mat,2)
        outPT(i,ii) = mean(mat{i,ii}(201:300)) - BL;            % Mean better reflection of overall response
        %         outPT(i,ii) = max(mat{i,ii}(201:300)) - BL;           % Max susceptible to fluctuations
    end
end

if plot == 1
    [RF.PT.xCentre,RF.PT.yCentre,RF.PT.tresh] = plotRF(outPT, perc);
else
    RF = [];
end

tmp = []; mat = []; bl = [];
mat = cat(1,carr(2,:,1),carr(2,:,2),carr(2,:,3));

if BLcorr
    for i = 1:size(mat,1)
        for ii = 1:size(mat,2)-1
            bl(i,ii) = mean(mat{i,ii}(1:200));
        end
    end
    BL = nanmean(nanmean(bl));
else
    BL = 0;
end

for i = 1:size(mat,1)
    for ii = 1:size(mat,2)-1
        outBPN(i,ii) = mean(mat{i,ii}(201:300)) - BL;
        %         outBPN(i,ii) = max(mat{i,ii}(201:300)) - BL;
    end
end

if plot == 1
    [RF.BPN.xCentre,RF.BPN.yCentre,RF.BPN.tresh] = plotRF(outBPN, perc);
else
    RF = [];
end
end

