function [maxLikelihoodEstimate, logLikelihood] = lrirlsfit(X, Y)
% Create a function lrirlsfit, which takes as input arguments
%  matrix X of R(n X m) of samples and
%  vector Y of {0, 1}n of outcomes for each sample.
% Return the
%  maximum likelihood estimate (MLE) of the coefficients B (including the intercept) and
%  the log-likelihood of that model.
% Note: Use the function wlsfit provided by us to compute the WLS fit and initialize ˆB with all zeros.

maxLikelihoodEstimate = 0;
logLikelihood = 0;
epsConvergence = 1;

[n,m] = size(X);
% Initialize the Co-efficient Beta vector to all zeros.
B = zeros(m,1);
newB = B;
model_new = [];
epsConvLimit = 10^-8;

while epsConvergence > epsConvLimit
    % Use the sigmoid function to compute the matrix pi.
    pi = sigmoid(X*B);
    % Now use the computed values to build the Weight Diagonal Matrix.
    w = pi .* (1-pi);
    
    % Now compute the newly estimated co-efficients B using the wlsfit function already provided.
    newB = wlsfit( X, Y, w );
    
%     model_old = pi;
%     model_new = sigmoid(X*newB);
%     
%     % Calculate the deviance for both old and new models based on the B parameters.
%     DevNewB = -2 * sum(log(model_new));
%     DevOldB = -2 * sum(log(model_old));

    DevOldB = -2 * logRegLogLikelihood(B, X, Y);
    DevNewB = -2 * logRegLogLikelihood(newB, X, Y);


    % Check the convergency criteria based on the co-efficients B.
    epsConvergence = abs(DevNewB - DevOldB)/(abs(DevOldB)+0.1);
    B = newB;
end

% The newB co-efficient vector is the maximum likelihood estimate.
maxLikelihoodEstimate = newB;

% Compute the log-likelihood of the model for logistic regression using the new Beta as coefficients.
logLikelihood = logRegLogLikelihood(newB, X, Y);

end