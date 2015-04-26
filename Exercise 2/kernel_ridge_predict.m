function [YPred, meanSqError] = kernel_ridge_predict(XTrain, EstVecAlpha, XTest, YTest, kernel);
% Create a function kernel_ridge_predict, which takes as input arguments
%  matrix XTrain of R(n X m) samples used during training,
%  matrix EstVecAlpha of R(n X 1)
%  matrix XTest of R(n X m) samples used for testing,
%  matrix YTest of R(n X 1) of their respective outcomes, and 
%  kernel function. 
% Returns
%  vector of predicted outcomes YPred of R(n X 1) and 
%  the mean squared error on the training samples.


meanSqError = 0;

[n,m] = size(X);

YPred = zeros(size(n));


end