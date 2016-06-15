clear, clc;

% This script calculates the similarities between all histograms. Then, it
% compares the expected similarity to the actual similarity and uses this
% as a loss for a certain position. By iterating over all positions, it can
% assign a loss value to each position. Additionally, it provides an
% overall loss for an image (for a map).

hists = load('/home/pold/Documents/Internship/map_evaluation/mat_train_hists_color.csv');
pos = csvread('/home/pold/Documents/Internship/map_evaluation/targets.csv', 1);
pos(:, [1, 2, 3, 6]) = [];

% Must be coupled to histogram
fixed = 31;
fixed_pos = pos(fixed, :);
h = hists(fixed, :);

losses = zeros(size(hists, 1), 1);
tolerated_error = 30;

losses = compare_hist_to_all_others(fixed, hists, pos);

% Final average loss
mean(losses)

%scatter(pos(:, 1), pos(:, 2), [], losses)
%colormap jet
%%

width = 640;
height = 480;
I = zeros(height, width);

for p = 1:length(pos)
    
    cur_pos = pos(p, :);
    
    if (cur_pos(2) <= height - 80) && (cur_pos(1) < width - 80)
        I(int16(cur_pos(2) + 80), int16(cur_pos(1)) + 80) = losses(p);
    end
end

fil = ones(200, 200) / 40000;

I = imgaussfilt(I, tolerated_error);
%I = imfilter(I, fil);
%I = imgaussfilt(I, 20);

x1 = 640;
x2 = 480;

%background_path = '/home/pold/Documents/Internship/map_evaluation/sparse_board.png';
%background_path = '/home/pold/Documents/Internship/map_evaluation/dali.png';
background_path = '/home/pold/Documents/Internship/map_evaluation/mosaic_enlarged.png';
Background = imread(background_path);

figure(1)
imshow(Background);
hold on
heat = image(I, 'CDataMapping', 'scaled');
set(heat, 'AlphaData', 0.8);
colormap jet

%imagesc(I)

%colormap jet
