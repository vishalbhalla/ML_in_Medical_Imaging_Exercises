function [MultipleModelsBeta, MultipleModelsX, MultipleModelsY, ScatterPlots] = multipleFeatureModelsLogReg(X, Y, Coeff)
% Create a function multipleModelsLogReg, which takes as input arguments
%  matrix X of R(n X m) of samples and
%  vector Y of R(n X 1) of outcomes for each sample.
%  vector Coeff of R(n X 1) of the co-efficients or weights of each of the features.
% Returns the
%  Multiple models created from single feature of interest from the matrix
%  that predict the odds of suffering from myocardial infarction.
%  Scatter plot for each of the multiple models predicting the odds of suffering from myocardial infarction.

MultipleModelsBeta = {};
MultipleModelsX = {};
MultipleModelsY = {};
ScatterPlots = {};
[n,m] = size(X);

% Extract the Coeff of the first term in advance.
CoeffOne = Coeff(1);

% Start the for loop from index 2, to not consider the intercept term.
for i=2:m
    % Extract the coulmn for the single feature of interest from the matrix X and its corresponding weight from Coeff;
    XFeature = X(:,i);
    CoeffFeature = Coeff(i);
    CoeffFeature = [CoeffOne; CoeffFeature];
    MultipleModelsBeta = [MultipleModelsBeta; CoeffFeature];
    
    % Add intercept term to XFeature
    XFeature = [ones(n, 1) XFeature];
    MultipleModelsX = [MultipleModelsX; XFeature];
    
    % Single Feature Model - Call the sigmoid function for Maximum Likelihood Estimate (MLE) for Logistic Regression.
    SingleFeatureModel = sigmoid(XFeature*CoeffFeature);

    % Classify the points to 0 or 1 based on the probability value less or greater than 0.5
    %SingleFeatureModel(SingleFeatureModel<0.5) = 0;
    %SingleFeatureModel(SingleFeatureModel>=0.5) = 1;
    
    % Scatter plot for the Single Feature Model predicting body fat.
    s = scatter(SingleFeatureModel,Y);
    s.LineWidth = 0.6;
    s.MarkerEdgeColor = 'b';
    s.MarkerFaceColor = [0 0.5 0.5];
    
    MultipleModelsY = [MultipleModelsY; SingleFeatureModel];
    ScatterPlots = [ScatterPlots; s];
end

end

