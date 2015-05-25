
%% =========== Machine Learning in Medical Imaging - Exercise 3 %% =========== 
% Goal: Evaluation Measures.


%% =========== Part 1: Classification - Confusion Matrix =============
% Define the vectors for the ground truth and the predicted class for each sample.
groundTruth = [1,2,3,2,2,2,1,1,1,2,3,1,1,2,2,1,1,3,3,1,1];
Predictions = [1,2,3,3,1,2,1,1,1,2,1,2,1,1,3,3,1,1,2,3,1];

% =========== Part 1 a: Ordinary Least Squares (OLS) estimate of the coefficients Bˆ (including the intercept). =============
%  Call the function confusion_matrix with the ground truth and the predicted class for each sample.
%  return a k × k matrix, where k indicates the number of classes present in the ground truth.
confMat = confusion_matrix(groundTruth, Predictions);

% =========== Part 1 b: One vs All =============
% Call the function one_vs_all with index of the class of interest and a single k × k matrix confusion_matrix
% to get a single 2 × 2 confusion matrix.
idxClassOfInterest = 2;
confMat2by2 = one_vs_all(idxClassOfInterest, confMat);

% =========== Part 1 c: Performance Measures =============
% For any number of classes calculate the following 6 measures based on a confusion matrix:
% Sensitivity, specificity, positive predictive value, negative predictive value, accuracy, and F1 measure.
[sensitivity, specificity, PPV, NPV, accuracy, F1_Measure] = performanceMeasures(confMat2by2);


% =========== Part 1 d: P =============
% Create one 2 × 2 confusion matrices for each logistic regression model you trained in the previous exercise.



%% =========== Part 2: ROC and Precision-Recall Curve =============

groundTruth = [1,2,3,2,2,2,1,1,1,2,3,1,1,2,2,1,1,3,3,1,1];
Predictions = [0.6,0.2,0.3,0.5,0.9,0.8,0.6,0.3,0.1,0.2,0.1,0.5,0.8,0.1,0.3,0.7,0.8,0.2,0.4,0.4,0.5,0.4];

% =========== Part 2 a: Threshold Confusion Matrix =============
% The function threshold_confusion_matrix expects a vector containing the ground truth and
% a vector of containing the predicted probabilities for each sample.
% For each unique threshold the function should return a 2 × 2 confusion matrix.


% =========== Part 2 b:Construct ROC and Precision-Recall Curve. =============
% Based on the list of confusion matrices obtained by threshold_confusion_matrix
% Derive all the performance measures you already implemented.
% Construct a ROC and precision-recall curve for the different logistic regression models created for the South African Heart Disease data set.
% Which model performs best?



%% =========== Part 3: Validation =============
% Train and test the classifier on two disjoint sets.

% =========== Part 3 a: Stratified Cross-Validation =============
% Perform 10-fold stratified cross-validation on the SAheart data set using logistic regression and 
% for each fold obtain a ROC and precision-recall curve.


