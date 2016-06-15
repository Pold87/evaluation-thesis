function [ Likelihood, Posterior, pos ] = pri_lik_post( Prior, zs, ws, x1, x2)
%PRI_LIK_POST Summary of this function goes here
%   Detailed explanation goes he
% returns
% pos is the arg max (MAP estimate)

kalman = 0;

if kalman
    zs = mean(zs);
    ws = 1;
end
Likelihood = myGMM (x2, x1, zs, ws );
Likelihood = reshape(Likelihood, length(x2), length(x1));
Posterior = Likelihood .* Prior;
[maxValue] = max(Posterior(:));
[rowsOfMaxes, colsOfMaxes] = find(Posterior == maxValue);
pos = [rowsOfMaxes(1) colsOfMaxes(1)];


end

