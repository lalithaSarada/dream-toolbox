function [S] = bananashaped(x)
% Hyperbolic shaped posterior probability distribution

    Extra.cmat = eye(10); 
    Extra.cmat(1,1) = 100;     % Target covariance
    Extra.imat = inv(Extra.cmat);                           % Inverse of target covariance
    Extra.bpar = [0.1];                                     % "bananity" of the target, see bananafun.m

% Each line is one parameter combination
x(:,2) = x(:,2) + Extra.bpar*x(:,1).^2 - 100*Extra.bpar;

% Compute the SSR
S = -0.5 * (x * Extra.imat) * x';	