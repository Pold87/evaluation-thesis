t1 = [232,727];

% Flight 1
f1 = [222, 826];
d1 = norm(t1 - f1);
f2 = [181, 783];
d2 = norm(t1 - f2);
f3 = [186, 796];
d3 = norm(t1 - f3);

% Flight 2
t2 = [482,374 ];

fs2 = [459, 223;
    475, 326 ;
    441, 85 ;
    452, 128;
    475, 64]



ds = zeros(size(fs2, 1), 1);
for i = 1:size(fs2, 1)
    ds(i) = norm(fs2(i, :) - t2);
end


t3 = [242, 84]
fs3 = [311, 82;
    286, 74;
    324, 31;
    309, 59]

ds3 = zeros(size(fs3, 1), 1);
for i = 1:size(fs3, 1)
    ds3(i) = norm(fs3(i, :) - t3);
end
