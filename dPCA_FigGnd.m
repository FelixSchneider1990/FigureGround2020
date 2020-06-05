% addpath \\campus\rdw\ion02\02\auditory\Felix\Figure_Ground\Ephys\dPCA\matlab
% load('\\campus\rdw\ion08\08\Felix\dPCA\trialAvg.mat')
% load('\\campus\rdw\ion08\08\Felix\dPCA\trialNum.mat')
% load('\\campus\rdw\ion08\08\Felix\dPCA\trials.mat')

time = 1:600;
% Time events of interest (e.g. stimulus onset/offset, cues etc.)
% They are marked on the plots with vertical lines
timeEvents = 200; % figure onset

% check consistency between trialNum and firingRates
for n = 1:size(firingRates,1)
    for s = 1:size(firingRates,2)
        for d = 1:size(firingRates,3)
            assert(isempty(find(isnan(firingRates(n,s,d,:,1:trialNum(n,s,d))), 1)), 'Something is wrong!')
        end
    end
end

%% Define parameter grouping

% *** Don't change this if you don't know what you are doing! ***
% firingRates array has [N S D T E] size; herewe ignore the 1st dimension 
% (neurons), i.e. we have the following parameters:
%    1 - stimulus 
%    2 - decision
%    3 - time
% There are three pairwise interactions:
%    [1 3] - stimulus/time interaction
%    [2 3] - decision/time interaction
%    [1 2] - stimulus/decision interaction
% And one three-way interaction:
%    [1 2 3] - rest
% As explained in the eLife paper, we group stimulus with stimulus/time interaction etc.:

combinedParams = {{1, [1 3]}, {2, [2 3]}, {3}, {[1 2], [1 2 3]}};
margNames = {'Stimulus', 'Decision', 'Cond. indep.', 'S/D Interaction'};
margColours = [23 100 171; 187 20 25; 150 150 150; 114 97 171]/256;

%% Step 1: PCA of the dataset

X = firingRatesAverage(:,:);
X = bsxfun(@minus, X, mean(X,2));

[W,~,~] = svd(X, 'econ');
W = W(:,1);

% minimal plotting
dpca_plot(firingRatesAverage, W, W, @dpca_plot_default);

% computing explained variance
explVar = dpca_explainedVariance(firingRatesAverage, W, W, ...
    'combinedParams', combinedParams);

% a bit more informative plotting
dpca_plot(firingRatesAverage, W, W, @dpca_plot_default, ...
    'explainedVar', explVar, ...
    'time', time,                        ...
    'timeEvents', timeEvents,               ...
    'marginalizationNames', margNames, ...
    'marginalizationColours', margColours);

%% Step 2: PCA in each marginalization separately

dpca_perMarginalization(firingRatesAverage, @dpca_plot_default, ...
   'combinedParams', combinedParams);

%% Step 3: dPCA without regularization and ignoring noise covariance

% This is the core function.
% W is the decoder, V is the encoder (ordered by explained variance),
% whichMarg is an array that tells you which component comes from which
% marginalization

tic
[W,V,whichMarg] = dpca(firingRatesAverage, 20, ...
    'combinedParams', combinedParams);
toc

explVar = dpca_explainedVariance(firingRatesAverage, W, V, ...
    'combinedParams', combinedParams);

dpca_plot(firingRatesAverage, W, V, @dpca_plot_default, ...
    'explainedVar', explVar, ...
    'marginalizationNames', margNames, ...
    'marginalizationColours', margColours, ...
    'whichMarg', whichMarg,                 ...
    'time', time,                        ...
    'timeEvents', timeEvents,               ...
    'timeMarginalization', 3, ...
    'legendSubplot', 16);

ax0 = axes('Position',[0 0 1 1],'Visible','off');
text(.02,.8, 'a', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(.02,.61, 'b', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(.02,.4, 'c', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
text(.28,.96, 'd', 'Parent', ax0, 'FontSize', 30, 'Color', 'k', 'FontWeight', 'bold')
print('dPCA_CohMeanCtr','-dpng', '-r400')

% %% Step 4: dPCA with regularization
% 
% % This function takes some minutes to run. It will save the computations 
% % in a .mat file with a given name. Once computed, you can simply load 
% % lambdas out of this file:
% %   load('tmp_optimalLambdas.mat', 'optimalLambda')
% 
% % Please note that this now includes noise covariance matrix Cnoise which
% % tends to provide substantial regularization by itself (even with lambda set
% % to zero).
% 
% optimalLambda = dpca_optimizeLambda(firingRatesAverage, firingRates, trialNum, ...
%     'combinedParams', combinedParams, ...
%     'simultaneous', ifSimultaneousRecording, ...
%     'numRep', 2, ...  % increase this number to ~10 for better accuracy
%     'filename', 'tmp_optimalLambdas.mat');
% 
% Cnoise = dpca_getNoiseCovariance(firingRatesAverage, ...
%     firingRates, trialNum, 'simultaneous', ifSimultaneousRecording);
% 
% [W,V,whichMarg] = dpca(firingRatesAverage, 20, ...
%     'combinedParams', combinedParams, ...
%     'lambda', optimalLambda, ...
%     'Cnoise', Cnoise);
% 
% explVar = dpca_explainedVariance(firingRatesAverage, W, V, ...
%     'combinedParams', combinedParams);
% 
% dpca_plot(firingRatesAverage, W, V, @dpca_plot_default, ...
%     'explainedVar', explVar, ...
%     'marginalizationNames', margNames, ...
%     'marginalizationColours', margColours, ...
%     'whichMarg', whichMarg,                 ...
%     'time', time,                        ...
%     'timeEvents', timeEvents,               ...
%     'timeMarginalization', 3,           ...
%     'legendSubplot', 16);
% 
% %% Step 4: dPCA with regularization
% 
% % setting random number of repetitions for each neuron and condition
% ifSimultaneousRecording = false;  % change this to simulate simultaneous 
%                                  % recordings (they imply the same number 
%                                  % of trials for each neuron)
%                                  
% % This function takes some minutes to run. It will save the computations 
% % in a .mat file with a given name. Once computed, you can simply load 
% % lambdas out of this file:
% %   load('tmp_optimalLambdas.mat', 'optimalLambda')
% 
% % Please note that this now includes noise covariance matrix Cnoise which
% % tends to provide substantial regularization by itself (even with lambda set
% % to zero).
% 
% optimalLambda = dpca_optimizeLambda(firingRatesAverage, firingRates, trialNum, ...
%     'combinedParams', combinedParams, ...
%     'simultaneous', ifSimultaneousRecording, ...
%     'numRep', 2, ...  % increase this number to ~10 for better accuracy
%     'filename', 'tmp_optimalLambdas.mat');
% 
% Cnoise = dpca_getNoiseCovariance(firingRatesAverage, ...
%     firingRates, trialNum, 'simultaneous', ifSimultaneousRecording);
% 
% [W,V,whichMarg] = dpca(firingRatesAverage, 20, ...
%     'combinedParams', combinedParams, ...
%     'lambda', optimalLambda, ...
%     'Cnoise', Cnoise);
% 
% explVar = dpca_explainedVariance(firingRatesAverage, W, V, ...
%     'combinedParams', combinedParams);
% 
% dpca_plot(firingRatesAverage, W, V, @dpca_plot_default, ...
%     'explainedVar', explVar, ...
%     'marginalizationNames', margNames, ...
%     'marginalizationColours', margColours, ...
%     'whichMarg', whichMarg,                 ...
%     'time', time,                        ...
%     'timeEvents', timeEvents,               ...
%     'timeMarginalization', 3,           ...
%     'legendSubplot', 16);
% 
% %% Optional: estimating "signal variance"
% 
% explVar = dpca_explainedVariance(firingRatesAverage, W, V, ...
%     'combinedParams', combinedParams, ...
%     'Cnoise', Cnoise, 'numOfTrials', trialNum);
% 
% % Note how the pie chart changes relative to the previous figure.
% % That is because it is displaying percentages of (estimated) signal PSTH
% % variances, not total PSTH variances. See paper for more details.
% 
% dpca_plot(firingRatesAverage, W, V, @dpca_plot_default, ...
%     'explainedVar', explVar, ...
%     'marginalizationNames', margNames, ...
%     'marginalizationColours', margColours, ...
%     'whichMarg', whichMarg,                 ...
%     'time', time,                        ...
%     'timeEvents', timeEvents,               ...
%     'timeMarginalization', 3,           ...
%     'legendSubplot', 16);
