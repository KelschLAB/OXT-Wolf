function dist = compute_Euclidean_distance_from_baseline(data)
%% Euclidean distance from baseline
% Input:
%   data: struct with binned spike counts for odor trials 
%       data.(odor) is a matrix with dimensions: units x time x trials
%       data.time is a vector spcifying the time bins
%
% Output:
%   dist is the Euclidean distance from baseline
%%

% reshape data into cell
if isfield(data,'flower')
    pop_vec{1,1} = data.C57BL6_1;
    pop_vec{1,2} = data.C57BL6_2;
    pop_vec{1,3} = data.CD1;
    pop_vec{1,4} = data.flower;
    pop_vec{1,5} = data.peanut;
elseif isfield(data,'familiar')
    pop_vec{1,1} = data.familiar;
    pop_vec{1,2} = data.novel;
else
    error('wrong input')
end
% find baseline bins
baseline_bins = 1:find(round(data.time,1)==0);

% create mean baseline population vector for every trial
base_vector = cell(size(pop_vec,1),size(pop_vec,2));
cum_base_vector = [];
for ii = 1:size(base_vector,2)
   base_vector{1,ii} = squeeze(mean(pop_vec{1,ii}(:,baseline_bins,:),2)); 
   
   % cumulative baseline-vector over all conditions
    cum_base_vector = [cum_base_vector, base_vector{1,ii}];
end

% average over cumulative baseline vector
average_base_vector = mean(cum_base_vector,2);

% initialize output
dist = cell(1,size(pop_vec,2));

% distance to baseline for every trial and every bin
for ii = 1:size(pop_vec,2)
    for tr = 1:size(pop_vec{1,ii},3)
        for bin = 1:size(pop_vec{1,ii},2)
            dist{1,ii}(tr,bin) = pdist2(pop_vec{1,ii}(:,bin,tr)',average_base_vector')./sqrt(length(pop_vec{1,ii}(:,bin,tr)'));
        end
    end
end

end