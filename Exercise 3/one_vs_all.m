function [confMat2by2] = one_vs_all(idxClassOfInterest, confusionMatrix)

% The function one_vs_all expects two arguments: 
%  An index of the class of interest and.
%  A k × k confusion matrix, where k indicates the number of classes present in the ground truth, and
% Returns 
%  A single 2 × 2 confusion matrix with respect to the provided class according to the one-vs-all principal.

confMat2by2 = zeros(2,2);

% True Positive
confMat2by2(1,1) = confusionMatrix(idxClassOfInterest, idxClassOfInterest);
% False Positive
confMat2by2(1,2) = sum(confusionMatrix(idxClassOfInterest, :));
% False Negative
confMat2by2(2,1) = sum(confusionMatrix(:, idxClassOfInterest));
% True Negative
confMat2by2(2,2) = trace(confusionMatrix);

% Remove the extra True Positive added to all of the False Positive, False Negative and True Negative above.
confMat2by2(1,2) =  confMat2by2(1,2) - confMat2by2(1,1);
confMat2by2(2,1) =  confMat2by2(2,1) - confMat2by2(1,1); 
confMat2by2(2,2) =  confMat2by2(2,2) - confMat2by2(1,1);

end