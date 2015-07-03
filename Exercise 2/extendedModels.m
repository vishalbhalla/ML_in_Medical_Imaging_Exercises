function [finalModel] = extendedModels(pValueDStats, X, Y, Coeff)
%EXTENDEDMODELS 

%pvalSorted = sortrows(pValueDStats,1);

[nullFeatureModel, scatterPlot] = nullFeatureModelLogReg(X, Y, Coeff);

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
    
    % Single Feature Model - Call the sigmoid function for Maximum Likelihood Estimate (MLE) for Logistic Regression.
    SingleFeatureModel = sigmoid(XFeature*CoeffFeature);

    % Classify the points to 0 or 1 based on the probability value less or greater than 0.5
    SingleFeatureModel(SingleFeatureModel<0.5) = 0;
    
    % Scatter plot for the Single Feature Model predicting body fat.
    s = scatter(SingleFeatureModel,Y);
    s.LineWidth = 0.6;
    s.MarkerEdgeColor = 'b';
    s.MarkerFaceColor = [0 0.5 0.5];
    
    MultipleModels = [MultipleModels; SingleFeatureModel];
    ScatterPlots = [ScatterPlots; s];
end


end

