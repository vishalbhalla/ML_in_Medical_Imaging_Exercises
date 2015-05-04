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
% Number of training examples.
[n,m] = size(XTrain);
YPred = zeros(n,1);

% Predict whether the label is 0 or 1 using learned logistic regression parameters theta
% Computes the predictions for XTrain using a 
% threshold at 0.5 (i.e., if sigmoid(theta'*XTrain) >= 0.5, predict 1)

% Assuming the Kernel function passed is sigmoid.

YPred = sigmoid(XTrain*kernel);
for i = 1:m;
    if(p(i)<=0.5)
        YPred(i) = floor(p(i)); % p(i) = 0
    else
        YPred(i) = ceil(p(i));  % p(i) = 1
    end;
end;

% =========================================================================

end