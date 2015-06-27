function ROC_PR_Curve(Predictions, groundTruth, thresholdVec)
%ROC_PR_CURVE Summary of this function goes here
%   Detailed explanation goes here

totalThresholds = size(thresholdVec,2);

% =========== Part 2 a: Threshold Confusion Matrix =============
% The function threshold_confusion_matrix expects a vector containing the ground truth and
% a vector of containing the predicted probabilities for each sample.
% For each unique threshold the function should return a 2 × 2 confusion matrix.
lstconfMat2by2 = {};

for t=1:totalThresholds
    confMat2by2 = threshold_confusion_matrix(groundTruth, Predictions, thresholdVec(t));
    lstconfMat2by2 = [lstconfMat2by2 ; confMat2by2];
end

% =========== Part 2 b:Construct ROC and Precision-Recall Curve. =============
% =========== Part 2 b i: Performance Measures =============
% Based on the list of confusion matrices obtained by threshold_confusion_matrix
% Derive all the performance measures already implemented.
sensitivityVec = zeros(1, totalThresholds);
specificityVec = zeros(1, totalThresholds);
PPVVec = zeros(1, totalThresholds);
NPVVec = zeros(1, totalThresholds);
accuracyVec = zeros(1, totalThresholds);
F1_MeasureVec = zeros(1, totalThresholds);

for t=1:totalThresholds
    [sensitivityVec(t), specificityVec(t), PPVVec(t), NPVVec(t), accuracyVec(t), F1_MeasureVec(t)] = performanceMeasures(lstconfMat2by2{t});
end

% =========== Part 2 b ii: Construct a ROC and precision-recall curve =============
% Construct a ROC and precision-recall curve for the different logistic regression models created for the South African Heart Disease data set.
% Which model performs best?

% a. ROC
% False positive rate = 1 - Specificity
figure;
plot(1 - specificityVec, sensitivityVec);
title('ROC');

% Precision-Recall curve
% Precision = Positive predictive value (PPV)
% Recall = Sensitivity !!
figure;
plot(PPVVec, sensitivityVec);
title('Precision-Recall curve');

end

