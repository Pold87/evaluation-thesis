clear, clc;

hists = load('/home/pold/paparazzi/mat_train_hists_texton.csv');

zerocols = find(var(hists) == 0);
hists(:, zerocols) = [];

pos = csvread('/home/pold/paparazzi/cyberzoo_pos_optitrack.csv', 1);
pos(:, [1, 4]) = [];

pos = round(pos);
pos(:, 1) = pos(:, 1) - min(pos(:, 1)) + 1;
pos(:, 2) = pos(:, 2) - min(pos(:, 2)) + 1;

width = 610;
height = 680;

num_textons = size(hists, 2);

I = zeros(width, height);
I_all = zeros(width, height, num_textons);

% Create texton image or heatmap for all images (filtered + unfiltered)
for texton = 1:num_textons
    for i = 1:length(pos)
        I(pos(i, 1), pos(i, 2)) = hists(i, texton);
    end
    I = I / sum(I(:));
    Ib = imgaussfilt(I, 10);
    Ib = Ib / sum(Ib(:));
    I_all(:, :, texton) = Ib;
end

% I need an image P(T_1 | Pos) for all Pos
% Input is an actual histogram

%%

sigma = 0.008;

% Image containing the likelihood of this texton histogram
likImg = zeros(size(I));

cur_hist = 6;

cov_hists = cov(hists);

Prior = 0.7 * ones(size(I_all, 1), size(I_all, 2));
%set(0,'DefaultFigureVisible', 'off');

for cur_hist = 30:100
    
    % transition model
    Prior = Prior + 0.00001;
    
    Prior = Prior / sum(Prior(:));
    
    figure
    imagesc(Prior)
    colormap jet
    
    % Likelihood
    actual = hists(cur_hist, :);
    [Likelihood, mymax, argmax] = bayes_likelihood(I_all, actual, cov_hists);
    
    argmax
    
    % Normalize Likelihood
    Likelihood = Likelihood/ sum(Likelihood(:));
    
    figure
    imagesc(Likelihood)
    colormap jet
    
    % Posterior
    Posterior = Likelihood .* Prior;
    
    [~, post_argmax_j] = max(Posterior(:));
    
    PT = Posterior';
    
    [~, post_argmax_i] = max(PT(:));
    
    post_argmax_j = mod(post_argmax_j, width);
    post_argmax_i = mod(post_argmax_i, height);
    
    if (post_argmax_j == 0)
       post_argmax_j = width
    end
    
    if (post_argmax_i == 0)
       post_argmax_i = height
    end
    
    post_argmax_j
    post_argmax_i
    
    % Set Prior for next round
    Prior = Posterior / sum(Posterior(:));
    
    figure
    imagesc(Posterior)
    colormap jet
    
    hold on
    scatter(pos(cur_hist, 2), pos(cur_hist, 1))
    hold on
    scatter(post_argmax_i, post_argmax_j)
    
    figname = sprintf('pics/fullybayes_norm_%04d', cur_hist);
    saveas(gcf, figname, 'png');
    
end


