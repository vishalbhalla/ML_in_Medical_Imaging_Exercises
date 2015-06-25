function [nullFeatureModelBeta, nullFeatureModelX, nullFeatureModelY, scatterPlot] = nullFeatureModelLogReg(X, Y, Coeff)
% Create a function nullModelLogReg, which takes as input arguments
%  matrix X of R(n X m) of samples and
%  vector Y of R(n X 1) of outcomes for each sample.
%  vector Coeff of R(n X 1) of the co-efficients or weights of each of the features.
% Return the
%  Single Model that predicts the odds of suffering from myocardial infarction.

[n,m] = size(X);

% Null Feature Model - Call the sigmoid function for Maximum Likelihood Estimate (MLE) for Logistic Regression.
nullFeatureModelBeta = Coeff(1);
nullFeatureModelX = X(:,1);
nullFeatureModelY = sigmoid(X(:,1)*Coeff(1));

% Classify the points to 0 or 1 based on the probability value less or greater than 0.5
%nullFeatureModelY(nullFeatureModelY<0.5) = 0;
%nullFeatureModelY(nullFeatureModelY>=0.5) = 1;

% Scatter plot for the Single Feature Model predicting body fat.
scatterPlot = scatter(nullFeatureModelY,Y);
scatterPlot.LineWidth = 0.6;
scatterPlot.MarkerEdgeColor = 'b';
scatterPlot.MarkerFaceColor = [0 0.5 0.5];

end
