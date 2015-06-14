function confMat2by2 = threshold_confusion_matrix(groundTruth, Predictions, threshold)
% The function threshold_confusion_matrix
% expects a vector containing the ground truth and 
% a vector of containing the predicted probabilities for each sample.
% For each unique threshold the function should return a 2 × 2 confusion matrix.
% The implementation should iterate over the predictions only a single time,
% i.e. its complexity should be O(n).

totalLabels = size(groundTruth,2);
confMat2by2 = zeros(2,2);

for ctRow=1:totalLabels % Rows indicate Prediction values.
    % groundTruthClassNoCol will contain a binary value, i.e. 1 for positive and 0 for negative.
    groundTruthClassNoCol = groundTruth(ctRow);
    
    if(groundTruthClassNoCol) % First column for True Positive and False Negative.
        if(Predictions(ctRow)>threshold) % True Positive
            confMat2by2(1,1) = confMat2by2(1,1) + 1;
        else % False Negative
            confMat2by2(2,1) = confMat2by2(2,1) + 1;
        end
    else % Second column for False Positive and True Negative.
        if(Predictions(ctRow)>threshold) % False Positive
            confMat2by2(1,2) = confMat2by2(1,2) + 1;
        else % True Negative
            confMat2by2(2,2) = confMat2by2(2,2) + 1;
        end
    end
    
end

end
