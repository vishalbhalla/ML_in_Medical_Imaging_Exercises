function [sensitivity, specificity, PPV, NPV, accuracy, F1_Measure] = performanceMeasures(confusionMatrix)
%% The 2 × 2 confusion matrix as returned by one_vs_all is an input parameter to this function.
% Calculate the following 6 measures based on a confusion matrix:
% sensitivity, specificity, positive predictive value, negative predictive value, accuracy, and F1 measure.
% Note: The performance measure should be calculated with respect to the class of interest as defined in the call to one_vs_all.

TP = confusionMatrix(1,1);
TN = confusionMatrix(2,2);
FP = confusionMatrix(1,2);
FN = confusionMatrix(2,1);

% =========== Part 1 c i: Sensitivity / True positive rate / Recall =============
sensitivity = TP/(TP+FN);

% =========== Part 1 c ii: Specificity / True negative rate =============
specificity = TN/(TN+FP);

% =========== Part 1 c iii: Positive Predictive Value (PPV) / Precision =============
PPV = TP/(TP+FP);

% =========== Part 1 c iv: Negative Predictive Value(NPV) =============
NPV = TN/(TN+FN);

% =========== Part 1 c v: Accuracy =============
accuracy = (TP+TN)/(TP+FP+TN+FN);

% =========== Part 1 c vi: F1 Measure =============
F1_Measure = (2 * PPV * sensitivity)/(PPV + sensitivity);


end

