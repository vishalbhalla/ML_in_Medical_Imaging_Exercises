function [lstBeta, sensitivityVec, specificityVec, PPVVec, NPVVec, accuracyVec, F1_MeasureVec] = crossValidation(X, Y, K, thresholdVec)
%% Cross Validation
% In k-fold cross validation the data is randomly divided into k equal sized subsamples.
% Training is performed k times (folds) where in each fold (k-1) subsamples are used for training and the remaining subsample is used for testing.

% Get the total number of observations using size over the input X matrix.
n = size(X,1);     
totalThresholds = size(thresholdVec,2);

% Divide the data into K partitions and iterate over it.
% Use the data ranging from 1:K-1 as Validation Set and K:n as the training set.
k = n/K;

lstBeta = {};

sensitivityVec = zeros(K,totalThresholds);
specificityVec = zeros(K,totalThresholds);
PPVVec = zeros(K,totalThresholds);
NPVVec = zeros(K,totalThresholds);
accuracyVec = zeros(K,totalThresholds);
F1_MeasureVec = zeros(K,totalThresholds);

c =1;
for i = 1:k:n
    XTrain = [];
    YTrain = [];
    
    XCrossValid = X(i:i+k-1,:);
    YCrossValid = Y(i:i+k-1,:);
    if(i~=1) % Pick preceding values.
       XTrain = [XTrain; X(1:i-1,:)];  
       YTrain = [YTrain; Y(1:i-1,:)];
    end
    
    if(i~=n-k) % Pick proceeding values.
       XTrain = [XTrain; X(i+k:n,:)];
       YTrain = [YTrain; Y(i+k:n,:)];
    end
    
    % Fit the Logistic Regression of Exercise 2.
    [maxLikelihoodBetaEstimate, logLikelihood] = lrirlsfit(XTrain, YTrain);
    
    % For each fold, calculate Beta a add to list of Beta Parameters.
    lstBeta = [lstBeta ; maxLikelihoodBetaEstimate];
    
    %% Compute the confusion matrix and Performance measures.
    
    lstconfMat2by2 = {};
    for t=1:totalThresholds
        % Calculate the predicted values.
        threshold = thresholdVec(t);
        YPredClassify = predict(maxLikelihoodBetaEstimate, XCrossValid, threshold);
        confMat2by2 = threshold_confusion_matrix(YCrossValid, YPredClassify, thresholdVec(t));
        lstconfMat2by2 = [lstconfMat2by2 ; confMat2by2];

        % =========== Part 2 b:Construct ROC and Precision-Recall Curve. =============
        % =========== Part 2 b i: Performance Measures =============
        % Based on the list of confusion matrices obtained by threshold_confusion_matrix
        % Derive all the performance measures already implemented.
        [sensitivityVec(c,t), specificityVec(c,t), PPVVec(c,t), NPVVec(c,t), accuracyVec(c,t), F1_MeasureVec(c,t)] = performanceMeasures(lstconfMat2by2{t});
    end
    
    %% For each fold obtain a ROC and precision-recall curve.
    % a. ROC
    % False positive rate = 1 - Specificity
    figure(1);
    plot(1 - specificityVec(c,:), sensitivityVec(c,:));
    title('ROC for each fold of Cross Validation');
    
    % Precision-Recall curve
    % Precision = Positive predictive value (PPV)
    % Recall = Sensitivity !!
    figure(2);
    plot(PPVVec(c,:), sensitivityVec(c,:));
    title('Precision-Recall curve for each fold of Cross Validation');
    
    c = c+1;
end

end

