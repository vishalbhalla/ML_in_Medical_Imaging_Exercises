
%% =========== Machine Learning in Medical Imaging - Exercise 3 %% =========== 
% Goal: Evaluation Measures.


%% =========== Part 1: Classification - Confusion Matrix =============
% Define the vectors for the ground truth and the predicted class for each sample.
groundTruth = [1,2,3,2,2,2,1,1,1,2,3,1,1,2,2,1,1,3,3,1,1]';
Predictions = [1,2,3,3,1,2,1,1,1,2,1,2,1,1,3,3,1,1,2,3,1]';

% =========== Part 1 a: Confusion Matrix =============
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


% =========== Part 1 d: Confusion Matrices for each Logistic Regression Model. =============
% Create one 2 × 2 confusion matrices for each logistic regression model you trained in the previous exercise.

% =========== Part 1 d (i) : Load the Data. =============

% Load the file from the sub directory data excluding the Header Row containing the column names.
X = csvread(fullfile('E:\TUM\Courses\Summer Semester 2015\Machine Learning in Medical Imaging\Exercises\ML_in_Medical_Imaging_Exercises\Exercise 2\data', 'SAHeartNumeric.csv'),1,0);
Y = X(:,10);
X = X(:,1:9);

% Add intercept term to X
[n,m] = size(X);
X = [ones(n, 1) X];


% =========== Part 1 d (ii) : Get the Co-efficient weights. =============
% Call the function lrirlsfit to get the maximum likelihood estimate (MLE) of the coefficients
[Coeff, Cost] = lrirlsfit(X, Y);


% =========== Part 1 d (iii) : Multiple Models each considering a single feature. =============
% Call the function multipleFeatureModelsLogReg
[MultipleModelsBeta, MultipleModelsX, MultipleModelsY, ScatterPlots] = multipleFeatureModelsLogReg(X, Y, Coeff);

NoOfSingleFeatureModels = size(MultipleModelsBeta,1);
lstconfMat = {};
threshold = 0.4;

for i=1:NoOfSingleFeatureModels
    % Classify the points to 0 or 1 based on the probability value less or greater than 0.5
    YPredClassify = MultipleModelsY{i};
    YPredClassify(YPredClassify<threshold) = 0;
    YPredClassify(YPredClassify>=threshold) = 1;
    
    confMat = confusion_matrix(Y, YPredClassify);
    lstconfMat = [lstconfMat ; confMat];
end


%% =========== Part 2: ROC and Precision-Recall Curve =============
% This task is for a binary classifier so let the classes be represented by 0 and 1.
groundTruth = [1,0,0,1,0,0,1,1,0,1,0,0,1,1,0,0,1,1,0,1,0,1]';
Predictions = [0.6,0.2,0.3,0.5,0.9,0.8,0.6,0.3,0.1,0.2,0.1,0.5,0.8,0.1,0.3,0.7,0.8,0.2,0.4,0.4,0.5,0.4]';
thresholdVec = [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
totalThresholds = size(thresholdVec,2);

% =========== Part 2 a: Threshold Confusion Matrix =============
% The function threshold_confusion_matrix expects a vector containing the ground truth and
% a vector of containing the predicted probabilities for each sample.
% For each unique threshold the function should return a 2 × 2 confusion matrix.

for i=1:NoOfSingleFeatureModels

lstconfMat2by2 = {};
sensitivityVec = zeros(1, totalThresholds);
specificityVec = zeros(1, totalThresholds);
PPVVec = zeros(1, totalThresholds);
NPVVec = zeros(1, totalThresholds);
accuracyVec = zeros(1, totalThresholds);
F1_MeasureVec = zeros(1, totalThresholds);

for t=1:totalThresholds
    confMat2by2 = threshold_confusion_matrix(groundTruth, Predictions, thresholdVec(t));
    lstconfMat2by2 = [lstconfMat2by2 ; confMat2by2];
    [sensitivityVec(t), specificityVec(t), PPVVec(t), NPVVec(t), accuracyVec(t), F1_MeasureVec(t)] = performanceMeasures(lstconfMat2by2{t});
end

% for t=1:totalThresholds
%     YPredClassify = MultipleModelsY{i};
%     confMat2by2 = threshold_confusion_matrix(Y, YPredClassify, thresholdVec(t));
%     lstconfMat2by2 = [lstconfMat2by2 ; confMat2by2];
% 
%     % =========== Part 2 b:Construct ROC and Precision-Recall Curve. =============
%     % =========== Part 2 b i: Performance Measures =============
%     % Based on the list of confusion matrices obtained by threshold_confusion_matrix
%     % Derive all the performance measures already implemented.
%     [sensitivityVec(t), specificityVec(t), PPVVec(t), NPVVec(t), accuracyVec(t), F1_MeasureVec(t)] = performanceMeasures(lstconfMat2by2{t});
% end

    % =========== Part 2 b ii: Construct a ROC and precision-recall curve =============
    % Construct a ROC and precision-recall curve for the different logistic regression models created for the South African Heart Disease data set.
    % Which model performs best?

    % a. ROC
    % False positive rate = 1 - Specificity
    figure(1);
    plot(1 - specificityVec, sensitivityVec);
    title('ROC');

    % Precision-Recall curve
    % Precision = Positive predictive value (PPV)
    % Recall = Sensitivity !!
    figure(2);
    plot(PPVVec, sensitivityVec);
    title('Precision-Recall curve');

end


%% =========== Part 3: Validation =============

% Train and test the classifier on two disjoint sets.
% Split beforehand the dataset and labels (X,Y) in 2 disjoint subsets: (XCrossval, YCrossval) & (XTest, YTest)
% Cross Val = 80% & Test = 20%
% XCrossval = X(1:(4*n/5),:);
% YCrossval = Y(1:(4*n/5),:);
% XTest = X((4*n/5)+1:n,:);
% YTest = Y((4*n/5)+1:n,:);

XCrossval = X(1:400,:);
YCrossval = Y(1:400,:);
XTest = X(401:n,:);
YTest = Y(401:n,:);

% =========== Part 3 a: Stratified Cross-Validation =============
% Perform 10-fold stratified cross-validation on the SAheart data set using logistic regression and 
% for each fold obtain a ROC and precision-recall curve.
K = 10;
thresholdCol = 7;
threshold = 0.1 * thresholdCol;
% k-fold Stratified Cross Validation
%[lstBeta, sensitivityVec, specificityVec, PPVVec, NPVVec, accuracyVec, F1_MeasureVec] = stratified_cross_validation(XCrossval, YCrossval, K, thresholdVec);
[lstBeta, sensitivityVec, specificityVec, PPVVec, NPVVec, accuracyVec, F1_MeasureVec] = stratifiedCrossValidation(XCrossval, YCrossval, K, thresholdVec);

% Calculate best performance measure of all these measures.
[bestAccuracy, IdxBestAccuracy] = max(accuracyVec(:,thresholdCol));

 % Pick the Beta of the fold that resulted in the best performance value.
BetaBestPerfValue = lstBeta{IdxBestAccuracy};

% Use XTest and the best Beta from 2 to make new predictions YPred2
% Calculate the predicted values.
YPred2 = predict(BetaBestPerfValue, XTest, threshold);

% Compare the new predictions YPred2 against Ytest to compute the final performance scores
fprintf('Testing Set Accuracy: %f\n', mean(double(YPred2 == YTest)) * 100);

