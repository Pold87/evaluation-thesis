function [ ] = save_post( Background, Prior, Likelihood, Posterior, zs, t , x1, x2, tmax)
%PLOT_PRI_LI_POST Summary of this function goes here
%   Detailed explanation goes here
figure;
bImg = imshow(Background);
hold on
postImg = image(x1, x2, Posterior, 'CDataMapping', 'scaled');
colormap jet
set(postImg, 'AlphaData', 0.6);
hold on 
a = 100
c = 1
scatter(zs(:, 1), zs(:, 2), a, [0.0, 1.0, 0.0],'filled')
labelPosterior = sprintf('Posterior (t = %d)', t);
%title(labelPosterior)
figname = sprintf('pics/for_pres_%04d.png', t);
saveas(gcf, figname, 'png')

end

