clear, clc;

% This script calculates the similarities between all histograms. Then, it
% compares the expected similarity to the actual similarity and uses this
% as a loss for a certain position. By iterating over all positions, it can
% assign a loss value to each position. Additionally, it provides an
% overall loss for an image (for a map).

width = 640;
height = 480;

%R <- 100 
%G <- 70
%B <- 200

fixed_pos = [137, 430];

I_all = zeros(height, width);
cov_hists = [5913.9609  181.9713; 181.9713 1920.0197];
I_all = make_ideal_sim(I_all, fixed_pos, cov_hists);

%%

%background_path = '/home/pold/Documents/Internship/map_evaluation/sparse_board.png';
%background_path = '/home/pold/Documents/Internship/map_evaluation/dali.png';
background_path = '/home/pold/Documents/Internship/map_evaluation/beautiful_img.png';
%background_path = '/home/pold/Documents/Internship/map_evaluation/mosaic_enlarged.png';
Background = imread(background_path);

figure(1)
image(Background);
hold on
heat = image(I_all, 'CDataMapping', 'scaled'); colorbar
set(heat, 'AlphaData', 0.8);
colormap jet

saveas(gcf, 'dorota_img.png')
%imagesc(I)
%

%% Contour
%contour(I_all), axis ij