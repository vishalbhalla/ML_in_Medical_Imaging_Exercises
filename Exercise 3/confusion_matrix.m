function confMat = confusion_matrix(groundTruth, Predictions)
% The function confusion_matrix expects two arguments: 
%  A vector containing the ground truth for each sample, and
%  A vector containing the predicted class for each sample.
% Returns 
%  A k × k matrix, where k indicates the number of classes present in the ground truth.

totalLabels = size(groundTruth,2);
totalClasses = unique(groundTruth);
k = size(totalClasses,2);
confMat = zeros(k,k);

nxt = 1;
for ctRow=nxt:totalLabels % Rows indicate Prediction values.
    for ctCol=nxt:totalLabels % Cols indicate Ground Truth values.
        predicttedClassNoRow = Predictions(ctRow);
        groundTruthClassNoCol = groundTruth(ctCol);
        
        % Update the corresponding row and column value in the Confusion Matrix.
        confMat(predicttedClassNoRow,groundTruthClassNoCol) = confMat(predicttedClassNoRow,groundTruthClassNoCol) + 1;
        
        nxt = nxt+1;
        break;
    end 
end

end