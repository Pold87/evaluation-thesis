width = 1920;
height = 1080;
map_name = '00004';

base_path = '/home/pold/mount/tosh/VOLKER_MASTER/numbers';
color_hists_path = sprintf('%s/%s/mat_train_hists_color.csv', base_path, map_name);
texton_hists_path = sprintf('%s/%s/mat_train_hists_texton.csv', base_path, map_name);
pos_path = sprintf('%s/%s/targets.csv', base_path, map_name);
losses_path = sprintf('%s/%s/losses.csv', base_path, map_name);
losses_texton_path = sprintf('%s/%s/losses_texton.csv', base_path, map_name);

hists = load(texton_hists_path);
losses = load(losses_texton_path);
pos = csvread(pos_path, 1);
pos(:, [1, 2, 3, 6]) = [];


k = 14;
pos_k = pos(k, :);
use_expected = 1;
tolerated_error = 60;
figure
sims = compare_hist_to_all_others(k, hists, pos, use_expected, tolerated_error);
make_heatmap(width, height, map_name, pos, sims, tolerated_error, pos_k, base_path);