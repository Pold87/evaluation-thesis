function [ I ] = make_heatmap( width, height, map_name, pos, ...
    losses, tolerated_error, pos_k, base_path )
%MAKE_HEATMAP Summary of this function goes here
%   Detailed explanation goes here

I = zeros(height, width);
offset = 0;

for p = 1:length(pos)
    
    cur_pos = pos(p, :);
    disp(cur_pos)
    
    if (cur_pos(2) <= height) && (0 < cur_pos(2)) && (cur_pos(1) < width) && (0 < cur_pos(1))
        
        int16(cur_pos(2))
        
        int16(cur_pos(1))
        I(int16(cur_pos(1)), int16(cur_pos(2))) = ...
            I(int16(cur_pos(1)), int16(cur_pos(2))) + losses(p);
    end
end

I = imgaussfilt(I, tolerated_error);

%background_path = sprintf('%s/%s.png', base_path, map_name);
%Background = imread(background_path);

%iptsetpref('ImshowAxesVisible','on');
%figure(1)
%imshow(Background);
%hold on
heat = image(I, 'CDataMapping', 'scaled');
set(heat, 'AlphaData', 1.0);
colorbar
colormap jet

if (~isempty(pos_k))
   hold on
   pos_k(2)
   pos_k(1)
   scatter(pos_k(1) + offset, pos_k(2) + offset, 25, 'filled');
   
end

end

