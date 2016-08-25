clear, clc;

% This script calculates the mean loss and the losses per histogram for all
% files (to find the best map).

%%% SETTING %%%
tolerated_error = 25;

% Use expected value (based on ideal similarity) or just use distance
use_expected = 1;

N_maps = 46; % Number of maps

base_path = '/home/pold/mount/tosh/VOLKER_MASTER/numbers';
map_names = 1:N_maps;

%%% END SETTINGS %%%

% Iterate over maps
for map_name = map_names
    
    color_hists_path = sprintf('%s/%05d/mat_train_hists_color.csv', base_path, map_name);
    texton_hists_path = sprintf('%s/%05d/mat_train_hists_texton.csv', base_path, map_name);
    pos_path = sprintf('%s/%05d/targets.csv', base_path, map_name);
    
    % For colors
    % hists = load(color_hists_path);
    
    % For textons
    hists = load(texton_hists_path);
    
    pos = csvread(pos_path, 1);
    pos(:, [1, 2, 3, 6]) = [];
    
    % Loss per position
    losses = zeros(size(hists, 1), 1);
    
    for num = 1:size(hists, 1)
        h = hists(num, :);
        losses = losses + compare_hist_to_all_others(num, hists, pos, ...
            use_expected, tolerated_error);
    end
    
    % Save losses to CSV file
    fn = sprintf('%s/%05d/losses_texton.csv', base_path, map_name);
    csvwrite(fn, losses)
    
    % Final average loss
    mean_loss = mean(losses);
    M = [map_name, mean_loss];
    dlmwrite('mean_loss_textons.csv', M, '-append');
    
end
