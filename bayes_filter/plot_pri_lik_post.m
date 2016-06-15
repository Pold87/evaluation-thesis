function [ ] = plot_pri_lik_post( Background, Prior, Likelihood, Posterior, zs, t , x1, x2, tmax)
%PLOT_PRI_LI_POST Summary of this function goes here
%   Detailed explanation goes here

% show overlayed images
subplot(tmax, 3, (t - 1) * 3 + 1)
imshow(Background);
hold on
priorImg = image(x1, x2, Prior, 'CDataMapping', 'scaled');
colormap jet
set(priorImg, 'AlphaData', 0.6);
labelPrior = sprintf('Prior (t = %d)', t);
title(labelPrior)
% axis equal
subplot(tmax, 3, (t - 1) * 3 + 2)
imshow(Background);
hold on
likImg = image(x1, x2, Likelihood, 'CDataMapping', 'scaled');
colormap jet
set(likImg, 'AlphaData', 0.6);
hold on
scatter(zs(:, 1), zs(:, 2), '+')
labelLikelihood = sprintf('Likelihood (t = %d)', t);
title(labelLikelihood)
% axis equal
subplot(tmax, 3, (t - 1) * 3 + 3)
imshow(Background);
hold on
postImg = image(x1, x2, Posterior, 'CDataMapping', 'scaled');
colormap jet
set(postImg, 'AlphaData', 0.6);
labelPosterior = sprintf('Posterior (t = %d)', t);
title(labelPosterior)

end

