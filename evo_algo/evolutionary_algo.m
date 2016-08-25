clear, clc;

% This script calculates the similarities between all histograms. Then, it
% compares the expected similarity to the actual similarity and uses this
% as a loss for a certain position. By iterating over all positions, it can
% assign a loss value to each position. Additionally, it provides an
% overall loss for an image (for a map).

%map_name = 'sparse_board';
map_name = 'mosaic_enlarged';
%map_name = 'splash';

base_path = '/home/pold/Documents/Internship/map_evaluation';
hists_path = sprintf('/home/pold/Documents/Internship/map_evaluation/%s/mat_train_hists_color.csv', ...
    map_name);
pos_path = sprintf('/home/pold/Documents/Internship/map_evaluation/%s/targets.csv', ...
    map_name);

hists = load(hists_path);
pos = csvread(pos_path, 1);
pos(:, [1, 2, 3, 6]) = [];


losses = zeros(size(hists, 1), 1);
tolerated_error = 25;

use_expected = 1;

for num = 1:size(hists, 1)
    h = hists(num, :);
    losses = losses + compare_hist_to_all_others(num, hists, pos, ...
        use_expected, tolerated_error);
end

% Final average loss
mean(losses)

%scatter(pos(:, 1), pos(:, 2), [], losses)
%colormap jet
%%

width = 640;
height = 480;
tolerated_error = 25;
I = make_heatmap(width, height, map_name, pos, losses, tolerated_error, [], base_path);
hold on


%%
k = 458;
pos_k = pos(k, :);
use_expected = 0;
tolerated_error = 25;
figure
sims = compare_hist_to_all_others(k, hists, pos, use_expected, 25);
make_heatmap(width, height, map_name, pos, sims, tolerated_error, pos_k, base_path);
