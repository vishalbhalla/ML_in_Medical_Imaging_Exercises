function logLikelihood = logRegLogLikelihood(Beta, X, Y)
% Calculate the Log-Likelihood of the model for Logistic Regression.

logLikelihood = 0;
m = length(Y); % number of training examples

JSig = sigmoid(X*Beta);

J1Term = (Y)' * log(JSig);
J2Term = (1-Y)' * log(1 - JSig);

logLikelihood = J1Term + J2Term;
logLikelihood = (-1/m) * logLikelihood;

% =============================================================

end
