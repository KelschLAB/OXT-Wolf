function [confusion_matrix, correct_or_not] = odor_response_classifier(data, shuffle_labels)
%% Odor response classifier
% Input:
%   data: struct with binned spike counts for odor trials 
%       data.(odor) is a matrix with dimensions: units x time x trials
%       data.time is a vector spcifying the time bins
%
% Output:
%   confusion_matrix: is a 5x5 (because five odors) matrix containing the
%   classifier performance. The diagonal contains the number of trials the
%   predicted label matched the true label, while the off-diagonal entries
%   contain the number of false predictions.
%
%   correct_or_not: a vector specifying if the prediction was correct or
%   not for every trial (leave-one-out cross-validation)
%% preprocessing

% reshape data into cell
if isfield(data,'flower')
    pop_vec{1,1} = data.C57BL6_1;
    pop_vec{1,2} = data.C57BL6_2;
    pop_vec{1,3} = data.CD1;
    pop_vec{1,4} = data.flower;
    pop_vec{1,5} = data.peanut;
else
    error('wrong input')
end

% time bins for averaging the response
response_bins = 11:20;

% reshape 
for od = 1:size(pop_vec,2)
    vector{od}=nan(size(pop_vec{1},3),size(pop_vec{1},1));
    for tr=1:size(pop_vec{1},3)
        vector{od}=squeeze(sum(pop_vec{od}(:,response_bins,:),2))';
    end
end

%% classifier

Trials_all=[];labels=[];
for od=1:size(vector,2)
    Trials_all=[Trials_all;vector{od}];
    labels=[labels;ones(size(vector{od},1),1).*od];
end

% for control: if 1 shuffles labels
if shuffle_labels
    rand_v = randperm(length(labels));
    labels = labels(rand_v);
end

% z-score within unit
for k = 1:size(Trials_all,2)
    Trials_all(:,k) = (Trials_all(:,k)-mean(Trials_all(:,k)))/std(Trials_all(:,k));
end
Trials_all(isnan(Trials_all)) = 0;

%%% leave-one-out cross-validation
confusion_matrix = zeros(size(vector,2));

for leave_out = 1:size(Trials_all,1)

    % training set
    train_label=labels;
    train_label(leave_out)=[];
    
     % test set
    test_label=labels(leave_out);

    % fit svm
    train_mat_all = Trials_all; train_mat_all(leave_out,:) = [];
    SVMdl = fitcecoc(train_mat_all,train_label);
    
    % predict left out trial
    clust = predict(SVMdl,Trials_all(leave_out,:));

    % compare to true label
    confusion_matrix(test_label,clust) = confusion_matrix(test_label,clust)+1;
    correct_or_not(leave_out) = clust==test_label;

end


end