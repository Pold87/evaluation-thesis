function [ likImg, mymax, argmax ] = bayes_likelihood ( I_all, actual, cov_hists )

% Iterate over texton distribution maps and find most likely position for a
% certrain texton histogram

mymax = - Inf;
argmax = [0, 0];
likImg = zeros(size(I_all, 1), size(I_all, 2));

for i = 1:size(I_all, 1)
    for j = 1:size(I_all, 2)
        
        expected = I_all(i, j, :);
        
        expected = reshape(expected, [1 19]);
        total_prob = mvnpdf(actual, expected, cov_hists);
        
        if (total_prob > mymax)
            mymax = total_prob;
            argmax = [i, j];
        end

        likImg(i, j) = total_prob;
        
    end
end

end