function likelihood_ratio_test()
% Create a model which considers multiple features by starting with the null model and adding one additional feature at a time. 
% To determine which feature to add, use the p-value as returned by the likelihood-ratio test.
% Extended models with one additional feature, where
%  the p-value is greater than 0.05, should not be considered.
%  In each step choose the model with the smallest p-value.
% Continue until all features have been selected or the model cannot be improved significantly any more.


end