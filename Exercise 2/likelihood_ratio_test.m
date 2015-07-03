function [pValue, D] = likelihood_ratio_test(MultipleModelsBeta, MultipleModelsX, MultipleModelsY, nullFeatureModelBeta, nullFeatureModelX, nullFeatureModelY);
%% The function likelihood_ratio_test implements the likelihood-ratio test which takes as input parameters
%  full model and the reduced model.
%  It applies the log-likelihood over them.
%  It returns the p-value and the test statistic D of the likelihood-ratio test.

[m,n] = size(MultipleModelsY);

% Apply log-likelihood over each of the models.
logLikelihoodmodelFull = logRegLogLikelihood(MultipleModelsBeta, MultipleModelsX, MultipleModelsY);
logLikelihoodmodelReduced = logRegLogLikelihood(nullFeatureModelBeta, nullFeatureModelX, nullFeatureModelY);

% Calculate the Test Statistic of the likelihood-ratio test.
D = -2 * log(logLikelihoodmodelReduced/logLikelihoodmodelFull);

% Degree of Freedom (df) is equal to the difference in the number of features considered.
df = 1; %size(fullModel,2) - size(reducedModel,2);

% Calculate the p-value.
pValue = gammainc(D/2, df/2, 'upper');

end