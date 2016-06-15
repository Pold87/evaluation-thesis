function [ F ] = myGMM ( x1, x2, zs, ws )

measurement_noise = 100;

%F = mvnpdf([X1(:) X2(:)],mu,Sigma);
F = zeros(length(x1), length(x2)); 

for i = 1:length(x1)
    for j = 1:length(x2)
        
        total = 0;
        for m = 1:length(ws)
            cur_x = normpdf(zs(m, 1), x1(i), measurement_noise);
            cur_y = normpdf(zs(m, 2), x2(j), measurement_noise);
            total = total + ws(m) * cur_x * cur_y;            
        end
        F(i, j) = total;
    end
end