cd Y:\EPHYS\RAWDATA\NHP\Neuralynx\FigureGround\Eric\2018-10-09_10-04-30
ddir = '\\campus\rdw\ion02\02\auditory\Felix\Documents\Publications\FigGnd_Ephys\Figures\';

NSE                 = NLX_LoadNSE('SE2r.nse','FULL',1,[]);
idx                 = NSE.ClusterNr == 1;
NSE.TimeStamps      = NSE.TimeStamps(idx);
NSE.ScNr            = NSE.ScNr(idx);
NSE.ClusterNr       = NSE.ClusterNr(idx);
NSE.SpikeFeatures   = NSE.SpikeFeatures(:,idx);
NSE.SpikeWaveForm   = NSE.SpikeWaveForm(:,:,idx);
[waveform, spikeArray] = new_NLX_broadVsNarrow(NSE);

f = figure;hold on
for i = 1:100:size(spikeArray,2)
    plot(spikeArray(:,i), 'Color', [0 0 0 .2])
end
box off
axis off
export_fig([ddir 'wave'], '-transparent', '-r400',f);

NSE                 = NLX_LoadNSE('SE2r.nse','FULL',1,[]);
idx                 = NSE.ClusterNr == 1;
f                   = figure; 
h                   = histogram(log10(diff(NSE.TimeStamps(idx))), linspace(log10(1), log10(1e7), 100));
h.FaceColor      	= 'k';
h.EdgeColor         = 'k';
h.FaceAlpha         = 1;
h.EdgeAlpha         = 0;

line([3 3], [0 max(h.Values)], 'Color', 'r', 'LineWidth', 3)
ax                  = gca;
ax.XLim             = [2 7];
ax.XTick            = [3 4 5 6];
ax.XTickLabel       = {'1','10','100','1000'};
ax.XLabel.String    = 'ms';
% ax.YAxis.Visible  = 'off';
box off
axis off
export_fig([ddir 'ISI'], '-transparent', '-r400',f);