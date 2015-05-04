function [meanSqError, EstVecAlpha] = kernel_ridge_fit(X, Y, kernel)
% Create a function kernel_ridge_fit, hich takes as input arguments
%  matrix X of R(n X m) samples,
%  vector y of R(n X 1) of outcomes for each sample, and 
%  kernel function. 
% Returns
%  the estimated vector EstVecAlpha of R(n X 1) and
%  the mean squared error on the training samples.

meanSqError = 0;
[n,m] = size(X);
EstVecAlpha = zeros(n,1);


end