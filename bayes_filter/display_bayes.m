clc, clear all;

hists = load('/home/pold/paparazzi/mat_train_hists_texton.csv');
pos = csvread('/home/pold/paparazzi/cyberzoo_pos_optitrack.csv', 1);
knn = csvread('/home/pold/paparazzi/knn.csv');

knn = round(knn);
knn = (knn / 2);
knn = knn + 200;

%%
pos(:, [1, 4]) = [];
pos(:, 1) = pos(:, 1) - min(pos(:, 1));
pos(:, 2) = pos(:, 2) - min(pos(:, 2));
pos = pos / 2;

Cyberzoo = imread('/home/pold/Documents/Internship/draug/img/cyberzoo_small.png');

tmax = 300;
x1 = 1:469; x2 = 1:430;

Prior = 0.7 * ones(430, 469);

set(0,'DefaultFigureVisible', 'off');

all_pos = zeros(tmax, 2);

for t = 1:tmax
    zs = reshape(knn(t, :), [2 3])';
    ws = [0.5 0.3 0.2];
    
    % transition model
    Prior = Prior + 0.00001;
    
    % sensor model
    [Likelihood, Posterior, pos] = pri_lik_post(Prior, zs, ws, x1, x2);
%     plot_pri_lik_post(Cyberzoo, Prior, Likelihood, Posterior, zs, t, x1, x2, tmax);

    all_pos(t, :) = pos;
    %save_post(Cyberzoo, Prior, Likelihood, Posterior, zs, t, x1, x2, tmax);
    
    Prior = Posterior / sum(Posterior(:));
end

csvwrite('knn_offline_preds.csv', all_pos);

