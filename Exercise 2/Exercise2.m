
%% =========== Machine Learning in Medical Imaging - Exercise 2 %% =========== 
% Goal: Linear Classifier and SVM.


%% =========== Part 1: Ordinary Least Squares =============
%  We start this exercise by first loading and extracting each column of the dataset. 
%  The data set bodyfat contains several body measurements that can be done using a scale and a tape measure.
%  These can be used to predict the body fat percentage (body.fat column).
%  Measuring body fat requires a special apparatus, if our resulting model fits well, we have a low-cost alternative.
%  The measurements are age, weight, height, BMI, neck, chest, abdomen, hip, thigh, knee, ankle, bicep, forearm, and wrist [?].

% =========== Loading and Visualizing the Dataset =============
X = load('bodyfat.csv');
y = bodyfat(:,2); % siri - Percent body fat from Siri's (1956) equation
X = X(:,3:end);
% age = bodyfat(:,3);           %  Age (years)
% weight = bodyfat(:,4);        %  Weight (lbs)
% height = bodyfat(:,5);        %  Height (inches)
% neck = bodyfat(:,6);          %  Neck circumference (cm)
% chest = bodyfat(:,7);         %  Chest circumference (cm)
% abdomen = bodyfat(:,8);       %  Abdomen 2 circumference (cm)
% hip = bodyfat(:,9);           %  Hip circumference (cm)
% thigh = bodyfat(:,10);        %  Thigh circumference (cm)
% knee = bodyfat(:,11);         %  Knee circumference (cm)
% ankle = bodyfat(:,12);        %  Ankle circumference (cm)
% biceps = bodyfat(:,13);       %  Biceps (extended) circumference (cm)
% forearm = bodyfat(:,14);      %  Forearm circumference (cm)
% wrist = bodyfat(:,15);        %  Wrist circumference (cm)

% Displaying the dataset.


% =========== Part 1 a: Ordinary Least Squares (OLS) estimate of the coefficients Bˆ (including the intercept). =============
%  Call the function olsfit.m
%  to return the ordinary least squares (OLS) estimate of the coefficients Bˆ (including the intercept).
Coeff = olsfit(X, y);

% =========== Part 1 b i: Multiple models that predict the amount of body fat =============
% Call the function 


% =========== Part 1 b ii: Scatter plot for each of the multiple models predicting body fat =============
% Call the function 


% =========== Part 1 c i: Single model that predicts the amount of body fat =============
% Call the function 


% =========== Part 1 c ii: Features having the highest/lowest coefficients =============
% Call the function 



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


