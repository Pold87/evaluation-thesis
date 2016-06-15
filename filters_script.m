clear, clc;

F = makeLMfilters;

M = reshape(F, [25 48])';

mmax = max(M, [], 2);
max_mat = mmax * ones(1, size(M, 2));

mmin = min(M, [], 2);
min_mat = mmin * ones(1, size(M, 2));

S = (M - min_mat) ./ (max_mat - min_mat);

%mmean = mean(M');

% Export matrix M to a file using a precision of six decimal places and the conventional line terminator for the PC platform:

dlmwrite('textons_malik.csv', S, 'precision', '%.3f')
%csvwrite('textons_malik.csv', S);

