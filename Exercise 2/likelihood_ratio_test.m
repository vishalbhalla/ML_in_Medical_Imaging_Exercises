function [pValue, D] = likelihood_ratio_test(fullModel, reducedModel)
%% The function likelihood_ratio_test implements the likelihood-ratio test which takes as input parameters
%  full model and the reduced model.
%  It applies the log-likelihood over them.
%  It returns the p-value and the test statistic D of the likelihood-ratio test.

% Apply log-likelihood over each of the models.
modelF = sigmoid(fullModel);
modelR = sigmoid(reducedModel);

% Calculate the deviance for both old and new models based on the B parameters.
logLikelihoodmodelFull = -2 * sum(log(model_new));
logLikelihoodmodelReduced = -2 * sum(log(model_old));

% Calculate the Test Statistic of the likelihood-ratio test.
D = -2 * log(logLikelihoodmodelFull/logLikelihoodmodelReduced);

% Degree of Freedom (df) is equal to the difference in the number of features considered.
df = size(fullModel,2) - size(reducedModel,2);

% Calculate the p-value.
pValue = gammainc(D/2, df/2, 'upper');


end