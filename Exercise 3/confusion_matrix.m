function confMat = confusion_matrix(groundTruth, Predictions)
% The function confusion_matrix expects two arguments: 
%  A vector containing the ground truth for each sample, and
%  A vector containing the predicted class for each sample.
% Returns 
%  A k × k matrix, where k indicates the number of classes present in the ground truth.

totalLabels = size(groundTruth,1);
totalClasses = unique(groundTruth);
k = size(totalClasses,1);
confMat = zeros(k,k);

for ctRow=1:totalLabels % Iterate over Prediction and Ground Truth values.
    predicttedClassNoRow = Predictions(ctRow);
    groundTruthClassNoCol = groundTruth(ctRow);
        
    % Update the corresponding row and column value in the Confusion Matrix.
    
    % If one of the classes is zero, assign it as the last class of the Confusion Matrix.
    if(predicttedClassNoRow == 0)
        predicttedClassNoRow = k;
    end
    if(groundTruthClassNoCol == 0)
        groundTruthClassNoCol = k;
    end
    
    confMat(predicttedClassNoRow,groundTruthClassNoCol) = confMat(predicttedClassNoRow,groundTruthClassNoCol) + 1;

end

end