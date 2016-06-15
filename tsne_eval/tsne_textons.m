clc, clear;

% Load data
patches = load('/home/pold/Documents/Internship/treXton/img_patches.csv');
ind = randperm(size(patches, 1));
patches = patches(ind,:);

% Set parameters
no_dims = 2;
initial_dims = 25;
perplexity = 50;
% Run t−SNE
mappedX = tsne(patches, [], no_dims, initial_dims, perplexity);
% Plot results
scatter(mappedX(:,1), mappedX(:,2));