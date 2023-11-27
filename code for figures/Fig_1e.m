%% Reproduce Fig. 1e from deposited dataset
%  David Wolf, 11/2023
%
%% load dataset

clear; clc;

% paths need to be updated
load('C:\Users\David\Documents\GitHub\OXT-Wolf\data\Fig1_AON_data.mat'); 
addpath(genpath('C:\Users\David\Documents\GitHub\OXT-Wolf\'));

% the data.(odor) contains the binned spike counts (100 ms bins) for the
% different odors and trials (dimensions: unit x time x trials)

shuffle_labels = false;
[confusion_matrix, correct_or_not] = odor_response_classifier(data,shuffle_labels);

f = figure;
imagesc(confusion_matrix);
ylabel('actual');
xlabel('predicted');
title('AON');
colorbar
axis = gca;
axis.XTick = 1:5;
axis.YTick = 1:5;
axis.XTickLabel = {'C57BL6#1','C57BL6#2','CD1','ylang ylang','peanut butter'};
axis.YTickLabel = {'C57BL6#1','C57BL6#2','CD1','ylang ylang','peanut butter'};
set(get(axis, 'XLabel'), 'FontSize', 6);
set(get(axis, 'YLabel'), 'FontSize', 6);
set(axis, 'FontSize', 6);
set(axis, 'FontName', 'Arial');
set(get(axis, 'Title'), 'FontSize', 8);
colormap('pink');
axis.CLim = [0 20];
f.Units = 'centimeters';
f.Position = [3 3 8.3 5.6];

%%% compare to classifier trained with shuffled labels
shuffle_labels = true;
[~, correct_or_not_shuffle] = odor_response_classifier(data,shuffle_labels);
contingency_table = table([nnz(correct_or_not);nnz(correct_or_not_shuffle)],...
    [nnz(~correct_or_not);nnz(~correct_or_not_shuffle)],'VariableNames',{'correct','not'},'RowNames',{'true','shuffle'});
[h,p,stats] = fishertest(contingency_table);


