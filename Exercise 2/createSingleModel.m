function [SingleModel, HighestCoeff, HighestCoeffIdx, LowestCoeff, LowestCoeffIdx] = createSingleModel(X, Y, Coeff);
% Create a function scatterSingleModel, which takes as input arguments
%  matrix X of R(n X m) of samples and
%  vector Y of R(n X 1) of outcomes for each sample.
%  vector Coeff of R(n X 1) of the co-efficients or weights of each of the features.
% Return the
%  Single Model that predicts the amount of body fat.
%  HighestCoeff, HighestCoeffIdx, LowestCoeff, LowestCoeffIdx for the highest/lowest coefficients.

% Single model that predicts the amount of body fat
SingleModel = X * Coeff;

% Features having the highest/lowest coefficients
% Take abs values to account for negative co-relations.
AbsCoeff = abs(Coeff);
[HighestCoeff, HighestCoeffIdx] = max(AbsCoeff);
[LowestCoeff, LowestCoeffIdx] = min(AbsCoeff);

end