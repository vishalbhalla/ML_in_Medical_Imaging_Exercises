
%% =========== Machine Learning in Medical Imaging - Exercise 2 %% =========== 
% Goal: Linear Classifier and SVM.


%% =========== Part 1: Ordinary Least Squares =============
%  We start this exercise by first loading and extracting each column of the dataset. 
%  The data set bodyfat contains several body measurements that can be done using a scale and a tape measure.
%  These can be used to predict the body fat percentage (body.fat column).
%  Measuring body fat requires a special apparatus, if our resulting model fits well, we have a low-cost alternative.
%  The measurements are age, weight, height, BMI, neck, chest, abdomen, hip, thigh, knee, ankle, bicep, forearm, and wrist [?].

% =========== Loading and Visualizing the Dataset =============
%X = load(bodyfat.csv');

% Load the file from the sub directory data excluding the Header Row containing the column names.
X = csvread(fullfile('data', 'bodyfat.csv'),1,0);

Y = X(:,1);               %  body.fat - Percent body fat from Siri's (1956) equation
X = X(:,2:end);           %  Extract all features, excluding the outcomes in the first column.
% age = X(:,2);           %  Age (years)
% weight = X(:,3);        %  Weight (lbs)
% height = X(:,4);        %  Height (inches)
% neck = X(:,5);          %  BMI
% neck = X(:,6);          %  Neck circumference (cm)
% chest = X(:,7);         %  Chest circumference (cm)
% abdomen = X(:,8);       %  Abdomen 2 circumference (cm)
% hip = X(:,9);           %  Hip circumference (cm)
% thigh = X(:,10);        %  Thigh circumference (cm)
% knee = X(:,11);         %  Knee circumference (cm)
% ankle = X(:,12);        %  Ankle circumference (cm)
% biceps = X(:,13);       %  Biceps (extended) circumference (cm)
% forearm = X(:,14);      %  Forearm circumference (cm)
% wrist = X(:,15);        %  Wrist circumference (cm)

% Displaying the dataset.

% Add intercept term to X
[n,m] = size(X);
X = [ones(n, 1) X];

% =========== Part 1 a: Ordinary Least Squares (OLS) estimate of the coefficients B� (including the intercept). =============
%  Call the function olsfit.m
%  to return the ordinary least squares (OLS) estimate of the coefficients B� (including the intercept).
Coeff = olsfit(X, Y);

% =========== Part 1 b i: Multiple models that predict the amount of body fat =============
% =========== Part 1 b ii: Scatter plot for each of the multiple models predicting body fat =============
% Call the function createMultipleModelsScatter
[MultipleModels, ScatterPlots] = createMultipleModelsScatter(X, Y, Coeff);


% =========== Part 1 c i: Single model that predicts the amount of body fat alongwith =============
% =========== Part 1 c ii: Features having the highest/lowest coefficients =============
% Call the function createSingleModel
[SingleModel, HighestCoeff, HighestCoeffIdx, LowestCoeff, LowestCoeffIdx] = createSingleModel(X, Y, Coeff);


%% =========== Part 2: Logistic Regression =============

% =========== Part 2 a:  =============
% Call the function lrirlsfit to get the maximum likelihood estimate (MLE) of the coefficients
[maxLikelihoodEstimate, logLikelihood] = lrirlsfit(X, Y);

% =========== Part 2 b i: Logistic Regression Model for the SAheart data set. =============
% Call the function to get a model that contains only the intercept (null model), i.e. no features are considered.


% =========== Part 2 b ii: Multiple Models each considering a single feature. =============
% Call the function 


% =========== Part 2 b iii: Likelihood Ratio Test =============
% Call the function likelihood_ratio_test


% =========== Part 2 b iv: p-value of the likelihoodratio test =============


% =========== Part 2 b v: Model which considers multiple features, incrementally by one. =============
% Call the function 



%% =========== Part 3: Kernel Ridge Regression =============
% 


% =========== Part 3 a: Kernel Ridge Fit =============
% Call the function kernel_ridge_fit to get the mean squared error on the training samples.
[meanSqError, EstVecAlpha] = kernel_ridge_fit(X, Y, kernel);

% =========== Part 3 b: Kernel Ridge Predict =============
% Call the function kernel_ridge_predict to get the predicted values and the mean squared error on the training samples.
[YPred, meanSqError] = kernel_ridge_predict(XTrain, EstVecAlpha, XTest, YTest, kernel);

% =========== Part 3 c: Kernel Ridge Regression to the Aqua-all.csv data set. =============
% Apply the implementation of kernel ridge regression to the Aqua-all.csv data set.
% The first column denotes the outcome y, the remaining columns the features.

% =========== Part 3 c i: Plot Mean Squared Training Error from kernel_ridge_fit =============
% Plot the mean squared training error of the first 100 samples obtained from kernel_ridge_fit


% =========== Part 3 c ii: Plot Mean Squared Test Error from kernel_ridge_fit =============
% Use the remaining 97 samples to test all models trained above and plot the mean squared test error obtained from kernel_ridge_predict.


