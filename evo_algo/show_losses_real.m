clear, clc;

tolerated_error = 80;

width = 1920;
height = 1080;

texton_hists_path = '/home/pold/Downloads/histograms_flight.csv'
pos_path = '/home/pold/Downloads/positions.csv'

hists = load(texton_hists_path);
pos = csvread(pos_path);
pos(:, 3) = [];

hists = hists(1:700, :)
pos = pos(1:700, :)

% Loss per position
losses = zeros(size(hists, 1), 1);

use_expected = 1

for num = 1:size(hists, 1)
    num
    h = hists(num, :);
    losses = losses + compare_hist_to_all_others(num, hists, pos, ...
        use_expected, tolerated_error);
end


%%
map_name = 'e'
base_path = 'e'

%pos = pos + 150

I = make_heatmap(width, height, map_name, pos, losses, tolerated_error, [], ...
    base_path);