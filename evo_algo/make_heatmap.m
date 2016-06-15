function [ I ] = make_heatmap( width, height, map_name, pos, ...
    losses, tolerated_error, pos_k )
%MAKE_HEATMAP Summary of this function goes here
%   Detailed explanation goes here

I = zeros(height, width);
offset = 80;

for p = 1:length(pos)
    
    cur_pos = pos(p, :);
    
    if (cur_pos(2) <= height - offset) && (cur_pos(1) < width - offset)
        I(int16(cur_pos(2) + offset), int16(cur_pos(1)) + offset) = ...
            I(int16(cur_pos(2) + offset), int16(cur_pos(1)) + offset) + losses(p);
    end
end

I = imgaussfilt(I, tolerated_error);

background_path = sprintf(...
    '/home/pold/Documents/Internship/map_evaluation/%s.png', map_name);
Background = imread(background_path);

iptsetpref('ImshowAxesVisible','on');
figure(1)
imshow(Background);
hold on
heat = image(I, 'CDataMapping', 'scaled');
set(heat, 'AlphaData', 0.8);
colorbar
colormap jet

if (~isempty(pos_k))
   hold on
   pos_k(2)
   pos_k(1)
   scatter(pos_k(1) + offset, pos_k(2) + offset, 25, 'filled');
   
end

end

