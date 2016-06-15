function [ I_all ] = make_ideal_sim( I_all, actual, cov_hists )
%MAKE_IDEAL_SIM Summary of this function goes here
%   Detailed explanation goes here

for i = 1:size(I_all, 1)
    for j = 1:size(I_all, 2)
        
        expected = [i, j];
        p = mvnpdf(actual, expected, cov_hists);
        I_all(i, j) = p;
        
    end
end

end

