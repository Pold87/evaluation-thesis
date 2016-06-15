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
fixed = 100
fixed_pos = pos(fixed, :);
h = hists(fixed, :);

tolerated_error = 30;

width = 640;
height = 480;

I_all = zeros(height, width);
cov_hists = eye(2) * tolerated_error ^ 2;
I_all = make_ideal_sim(I_all, fixed_pos, cov_hists);

%%

%background_path = '/home/pold/Documents/Internship/map_evaluation/sparse_board.png';
%background_path = '/home/pold/Documents/Internship/map_evaluation/dali.png';
background_path = '/home/pold/Documents/Internship/map_evaluation/mosaic_enlarged.png';
Background = imread(background_path);

figure(1)
image(Background);
hold on
heat = image(I_all, 'CDataMapping', 'scaled');
set(heat, 'AlphaData', 0.8);
colormap jet
%imagesc(I)
%
