function [Coeff] = olsfit(X, y) 
% Create a function olsfit which takes a matrix X of R(n X m) of samples and a vector y of R(n X 1) of outcomes for each sample.
% The function should return the ordinary least squares (OLS) estimate of the coefficients Bˆ (including the intercept).

Coeff = 0;
[n,m] = size(X);

% Add intercept term to X
X = [ones(n, 1) X];

%Definition (Ordinary Least Squares Estimate)
Coeff = inv(X'*X)* X' * y;

end