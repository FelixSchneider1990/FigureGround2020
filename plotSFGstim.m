function plotSFGstim(freqMat, no, figOn, figElem)

lw      = 1.75;
of      = .1;
mat     = freqMat(:,:,no);

for iBin = 1:size(freqMat,2)
    
    frex    = mat(:,iBin);
    y       = repmat(frex',3,1);
    x       = nan(size(y));
    
    if ~isempty(x)
        x(1,:) = iBin-1;
        x(2,:) = iBin;
    end
    
    x(1,:)  = x(1,:)+ of;
    x(2,:)  = x(2,:)- of;
    plot(x, y, 'Color', 'k', 'LineWidth', lw); hold on
end

if no <= 12
    figOnBin = figOn/.05;
    
    for iFig = figOnBin:figOnBin+20
        
        y   = repmat(figElem,3,1);
        x   = nan(size(y));
        
        if ~isempty(x)
            x(1,:) = iFig-1;
            x(2,:) = iFig;
        end
        
        x(1,:)  = x(1,:)+ of;
        x(2,:)  = x(2,:)- of;
        plot(x, y, 'Color', 'r', 'LineWidth', lw)
    end
end

ax                  = gca;
ax.YScale           = 'log';
ax.FontSize         = 14;
ax.XLim             = [-5 65];
ax.XColor           = [0 0 0];
ax.YColor           = [0 0 0];
ax.YLabel.String    = 'Frequency [Hz]';
ax.XLabel.String    = 'Time [ms]';
ax.XTick            = [0 30 60];
ax.XTickLabel       = {'0' '1500' '3000'};
box off
end