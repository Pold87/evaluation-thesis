clc, clear all;

%hists = load('/home/pold/paparazzi/mat_train_hists_texton.csv');
%pos = csvread('/home/pold/paparazzi/cyberzoo_pos_optitrack.csv', 1);
%knn = csvread('/home/pold/paparazzi/knn.csv');
%knn = csvread('/home/pold/Downloads/knn.csv');
k = 2;
knn = [150, 150, 300, 300 ]
knn = round(knn);
%knn = (knn / 2);
%knn = knn + 200;

%%
%pos(:, [1, 4]) = [];
%pos(:, 1) = pos(:, 1) - min(pos(:, 1));
%pos(:, 2) = pos(:, 2) - min(pos(:, 2));
%pos = pos / 2;

Cyberzoo = imread('/home/pold/Documents/Internship/draug/img/cyberzoo_small.png');

tmax = 1;
x1 = 1:800; x2 = 1:800;

Prior = 0.7 * ones(800, 800);

%set(0,'DefaultFigureVisible', 'off');

all_pos = zeros(tmax, 2);

for t = 1:tmax
    zs = reshape(knn(t, :), [2 k])';
    zs
    ws = [0.5 0.5];
    ws = ws(1:k);
    % transition model
    Prior = Prior + 0.0000001;
    
    % sensor model
    [Likelihood, Posterior, pos] = pri_lik_post(Prior, zs, ws, x1, x2);
    % plot_pri_lik_post(Cyberzoo, Prior, Likelihood, Posterior, zs, t, x1, x2, tmax);

    all_pos(t, :) = pos;
    save_post(Cyberzoo, Likelihood, Likelihood, Likelihood, zs, t, x1, x2, tmax);
    
    Prior = Posterior / sum(Posterior(:));
end

csvwrite('knn_offline_preds.csv', all_pos);

