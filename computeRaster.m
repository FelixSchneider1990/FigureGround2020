function [xspikes, yspikes] = computeRaster(tmp_spikes, y)

xspikes = repmat(tmp_spikes,3,1);
yspikes = nan(size(xspikes));
if ~isempty(yspikes)
    yspikes(1,:) = y-1;
    yspikes(2,:) = y;
end