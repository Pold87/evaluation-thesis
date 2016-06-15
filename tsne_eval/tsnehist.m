clc, clear;

% Load data
hists = load('/home/pold/paparazzi/mat_train_hists_texton.csv');
%hists = load('/home/pold/paparazzi/mat_train_hists.csv');
pos = csvread('/home/pold/paparazzi/cyberzoo_pos_optitrack.csv', 1);
pos(:, [1, 4]) = [];
pos(:, 1) = pos(:, 1) - min(pos(:, 1));
pos(:, 2) = pos(:, 2) - min(pos(:, 2));

ind = randperm(size(hists, 1));

hists = hists(ind(1:625),:);
pos = pos(ind(1:625), :);

dist = zeros(length(pos), 1);
for i = 1:length(pos)
   dist(i) = norm(pos(i, :)); 
end

dist = dist / max(dist);

% Set parameters
no_dims = 2;
initial_dims = 33;
perplexity = 10;
% Run t−SNE
mappedX = tsne(hists, [], no_dims, initial_dims, perplexity);

%%

% Plot results
scatter(mappedX(:,1), mappedX(:,2), [], pos(:, 1), '+'), colorbar;