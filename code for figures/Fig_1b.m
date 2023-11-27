%% Reproduce Fig. 1b from deposited dataset
%  David Wolf, 11/2023
%
%% load dataset

clear; clc;
load('C:\Users\David\Documents\GitHub\OXT-Wolf\data\Fig1_AON_data.mat');

% need to be updated
addpath(genpath('C:\Users\David\Documents\GitHub\mseb\'));
addpath(genpath('C:\Users\David\Documents\GitHub\MSTATS\'));

% the data.(odor) contains the binned spike counts (100 ms bins) for the
% different odors and trials (dimensions: unit x time x trials)

%% C57BL/6 #1

% compute the mean and sem for different parts of the session
% y_mean is a matrix of dimension 5 x time; the first row contains the
% average across all 20 trials, the next rows contain the average across
% blocks of 5 consectivue trials (1-5, 6-10, 11-15, 16-20). Accordingly for
% y_sem.
[y_mean, y_sem] = compute_mean_and_sem(data.C57BL6_1);

% plot
f=figure;
cur_lineProps.col = {[.8 .8 .8];[.6 .6 .6];[.4 .4 .4];[.2 .2 .2]};
cur_lineProps.width = 1;
mseb(data.time,y_mean(2:5,:),y_sem(2:5,:),cur_lineProps,1); 
hold on
cur_lineProps.col = {[0.223529411764706,0.192156862745098,0.521568627450980]};
mseb(data.time,y_mean(1,:),y_sem(1,:),cur_lineProps,1);
ylabel('mean firing rate (Hz)');
xlabel('relative time (s)');
title('C57BL/6 #1');
xlim([-.5 2.5]);
ylim([3 12]);
axis = gca;
set(get(axis, 'XLabel'), 'FontSize', 6);
set(get(axis, 'YLabel'), 'FontSize', 6);
set(axis, 'FontSize', 6);
set(axis, 'FontName', 'Arial');
set(get(axis, 'Title'), 'FontSize', 8);
f.Units = 'centimeters';
f.Position =  [3 3 3 3];
   
%% C57BL/6 #2

% compute the mean and sem
[y_mean, y_sem] = compute_mean_and_sem(data.C57BL6_2);

% plot
f=figure;
cur_lineProps.col = {[.8 .8 .8];[.6 .6 .6];[.4 .4 .4];[.2 .2 .2]};
cur_lineProps.width = 1;
mseb(data.time,y_mean(2:5,:),y_sem(2:5,:),cur_lineProps,1);
hold on
cur_lineProps.col = {[0,0.552941176470588,0.823529411764706]};
mseb(data.time,y_mean(1,:),y_sem(1,:),cur_lineProps,1);
ylabel('mean firing rate (Hz)');
xlabel('relative time (s)');
title('C57BL/6 #2');
xlim([-.5 2.5]);
ylim([3 12]);
axis = gca;
set(get(axis, 'XLabel'), 'FontSize', 6);
set(get(axis, 'YLabel'), 'FontSize', 6);
set(axis, 'FontSize', 6);
set(axis, 'FontName', 'Arial');
set(get(axis, 'Title'), 'FontSize', 8);
f.Units = 'centimeters';
f.Position =  [3 3 3 3];

%% CD1

% compute the mean and sem
[y_mean, y_sem] = compute_mean_and_sem(data.CD1);

% plot
f=figure;
cur_lineProps.col = {[.8 .8 .8];[.6 .6 .6];[.4 .4 .4];[.2 .2 .2]};
cur_lineProps.width = 1;
mseb(data.time,y_mean(2:5,:),y_sem(2:5,:),cur_lineProps,1);
hold on
cur_lineProps.col = {[0.658823529411765,0.149019607843137,0.509803921568627]};
mseb(data.time,y_mean(1,:),y_sem(1,:),cur_lineProps,1);
ylabel('mean firing rate (Hz)');
xlabel('relative time (s)');
title('CD1');
xlim([-.5 2.5]);
ylim([3 12]);
axis = gca;
set(get(axis, 'XLabel'), 'FontSize', 6);
set(get(axis, 'YLabel'), 'FontSize', 6);
set(axis, 'FontSize', 6);
set(axis, 'FontName', 'Arial');
set(get(axis, 'Title'), 'FontSize', 8);
f.Units = 'centimeters';
f.Position =  [3 3 3 3];


%% helper functions
function [y_mean, y_sem] = compute_mean_and_sem(odor_data)
    y_mean = cat(1, mean(odor_data,[1 3]),...
        mean(odor_data(:,:,1:5),[1 3]),...
        mean(odor_data(:,:,6:10),[1 3]),...
        mean(odor_data(:,:,11:15),[1 3]),...
        mean(odor_data(:,:,16:20),[1 3])).*10; % convert to firing rate in Hz
    
    y_sem = cat(1, sem(mean(odor_data,3)*10,1),... % convert firing rate to Hz
        sem(mean(odor_data(:,:,1:5),3)*10,1),...
        sem(mean(odor_data(:,:,6:10),3)*10,1),...
        sem(mean(odor_data(:,:,11:15),3)*10,1),...
        sem(mean(odor_data(:,:,16:20),3)*10,1));

end
