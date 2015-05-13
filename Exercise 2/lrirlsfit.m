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

while epsConvergence >= 0.001
    % Use the sigmoid function to compute the matrix pi.
    pi = sigmoid(X*B);
    % Now use the computed values to build the Weight Diagonal Matrix.
    w = pi .* (1-pi);
    
    % Now compute the newly estimated co-efficients B using the wlsfit function already provided.
    newB = wlsfit( X, Y, w );
    
    model_new = pi;
    model_old = sigmoid(X*newB);
    
    % Calculate the deviance for both old and new models based on the B parameters.
    DevNewB = -2 * sum(log(model_new));
    DevOldB = -2 * sum(log(model_old));
    
    % Check the convergency criteria based on the co-efficients B.
    epsConvergence = abs(DevNewB - DevOldB)/(abs(DevOldB)+0.1);
    B = newB;
end

% Once we have the newB co-efficient vector which is the maximum likelihood estimate for logistic regression
maxLikelihoodEstimate = newB;

% We can use this to compute the log-likelihood of the model which we calculated earlier.
logLikelihood = -2 * sum(model_new);

end