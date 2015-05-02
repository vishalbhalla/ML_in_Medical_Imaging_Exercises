function [MultipleModels, ScatterPlots] = createMultipleModelsScatter(X, Y, Coeff);
% Create a function createMultipleModelsScatter, which takes as input arguments
%  matrix X of R(n X m) of samples and
%  vector Y of R(n X 1) of outcomes for each sample.
%  vector Coeff of R(n X 1) of the co-efficients or weights of each of the features.
% Returns the
%  Multiple models created from single feature of interest from the matrix X that predict the amount of body fat
%  Scatter plot for each of the multiple models predicting body fat.

% Multiple models that predict the amount of body fat
MultipleModels = {};
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

    % Add intercept term to XFeature
    XFeature = [ones(n, 1) XFeature];

    % Single Feature Model
    SingleFeatureModel = XFeature * CoeffFeature;

    % Scatter plot for the Single Feature Model predicting body fat.
    s = scatter(SingleFeatureModel,Y);
    s.LineWidth = 0.6;
    s.MarkerEdgeColor = 'b';
    s.MarkerFaceColor = [0 0.5 0.5];
    
    MultipleModels = [MultipleModels; SingleFeatureModel];
    ScatterPlots = [ScatterPlots; s];
end

end