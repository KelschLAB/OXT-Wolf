%% Reproduce Fig. 1f from deposited dataset
%  David Wolf, 11/2023
%
%% load dataset

clear; clc;
load('C:\Users\David\Documents\GitHub\OXT-Wolf\data\Fig1_AON_data_smooth.mat'); % for plotting (but not statistical inference) of the Euclidean distance from baseline, the population vectors were smoothed with a sliding window across 3 time bins
addpath(genpath('C:\Users\David\Documents\GitHub\OXT-Wolf\'));

% the data.(odor) contains the binned spike counts (100 ms bins) for the
% different odors and trials (dimensions: unit x time x trials)
dist = compute_Euclidean_distance_from_baseline(data);

% y values for plotting
y_mean = zeros(5,numel(data.time));
y_sem = zeros(5,numel(data.time));
for cond = 1:size(y_mean,1)
    y_mean(cond,:) = mean(dist{1,cond}(:,:));
    y_sem(cond,:) = sem(dist{1,cond}(:,:));
end

% colors for plotting
lineProps.width = 1; 
lineProps.col = {[0.22,0.19,0.52],...
    [0,0.55,0.82],...
    [0.66,0.15,0.51],...
    [0.69,0.80,0.12],...
    [0.84,0.71,0.43]};

f = figure('name','Population Vector temporal evolution');
mseb(data.time,y_mean,y_sem,lineProps,1);
xlabel('relative time (s)');
ylabel({'Euclidean distance', ...
    'from baseline'});
ylim([.9*min(min(y_mean)), 1.1*max(max(y_mean))]);
xlim([-1 2.5]);
title('AON')
legend({'#1','#2', ...
    'CD1', 'ylang ylang', 'peanut'})
legend('Location','eastoutside')
box('off')
axis = gca;
set(get(axis, 'XLabel'), 'FontSize', 6);
set(get(axis, 'YLabel'), 'FontSize', 6);
set(axis, 'FontSize', 6);
set(axis, 'FontName', 'Arial');
set(get(axis, 'Title'), 'FontSize', 8);
f.Units = 'centimeters';
f.Position =  [3 3 6 3];

%%% source data for statistical tests are provided with the manuscript 