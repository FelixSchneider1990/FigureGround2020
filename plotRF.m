function [xCentre,yCentre,thresh] = plotRF(mat, perc)

ma = round(max(max(mat)));
mi = round(min(min(mat)));
rf = round(ma - (ma-mi) * perc);

f = figure;
[p, pp] = contour(mat,[ma-1 ma-1]);
xCentre = mean(p(1,2:end));
yCentre = mean(p(2,2:end));
close(f);

f = figure;
[thresh, threshh] = contourf(mat,[rf rf]);
thresh(:,find(thresh(1,:)>14)) = [];
threshh.LineWidth = 2;
hold on
plot(xCentre,yCentre,'ko', 'LineWidth', 2)
ax = gca;
ax.YTick = [1 2 3];
ax.YTickLabel = {'50', '60', '70'};
ax.XTick = [1 6 13];

if size(mat,2) == 13
    ax.XTickLabel = [217        1229       13906];
else
    ax.XTickLabel = [180        1018       11520];
end
end



