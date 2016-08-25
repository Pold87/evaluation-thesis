clear, clc;

tolerated_error = 80;

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


I = make_heatmap(width, height, map_name, pos, losses, tolerated_error, [], ...
    base_path);