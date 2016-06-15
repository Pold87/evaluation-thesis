clear, clc;

hists = load('/home/pold/paparazzi/mat_train_hists_texton.csv');
pos = csvread('/home/pold/paparazzi/cyberzoo_pos_optitrack.csv', 1);
pos(:, [1, 4]) = [];

%set(0,'DefaultFigureVisible', 'off');


k = 10;

for num = 1:length(pos)
    
    h = hists(num, :);
    
    dists = zeros(size(num, 1), 1);
    
    % Determine distances (or rather similarity)
    for i = 1:length(hists)
        dists(i) = norm(h - hists(i, :));
    end
    
    [dists_s, order] = sort(dists);
    sortedpos = pos(order,:);
    
    dists_s
    
    dists = dists / sum(dists);
    dists_s = dists_s / sum(dists_s);
    
    scatter(sortedpos(1:k, 1), sortedpos(1:k, 2), [], 1 - dists_s(1:k))
    xlim([-100 600])
    ylim([-400 400])
    figname = sprintf('pics/dists_%04d', num);
    saveas(gcf, figname, 'png')
    
    colormap jet
end




