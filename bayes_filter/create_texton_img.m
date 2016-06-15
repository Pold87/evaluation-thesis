clear, clc;

hists = load('/home/pold/paparazzi/mat_train_hists_texton.csv');
pos = csvread('/home/pold/paparazzi/cyberzoo_pos_optitrack.csv', 1);
pos(:, [1, 4]) = [];

pos = round(pos);
pos(:, 1) = pos(:, 1) - min(pos(:, 1)) + 1;
pos(:, 2) = pos(:, 2) - min(pos(:, 2)) + 1;

figure
texton = 21;

width = 610;
height = 680;

I = zeros(width, height);

% Create texton image or heatmap (unfiltered)
for i = 1:length(pos)
   I(pos(i, 1), pos(i, 2)) = hists(i, texton);
end

Ib = imgaussfilt(I, 10);

imagesc(Ib)

colormap jet

figure
texton = 20;

width = 610;
height = 680;

I = zeros(width, height);

% Create texton image or heatmap (unfiltered)
for i = 1:length(pos)
   I(pos(i, 1), pos(i, 2)) = hists(i, texton);
end

I = I / sum(I(:));

Ib = imgaussfilt(I, 10);
Ib = Ib / sum(Ib(:));

imagesc(Ib)

colormap jet

