function [Coeff] = olsfit(X, Y) 
% Create a function olsfit which takes as input parameters 
%  a matrix X of R(n X m) of samples and 
%  a vector Y of R(n X 1) of outcomes for each sample.
% Return the ordinary least squares (OLS) estimate of the coefficients Bˆ (including the intercept).

Coeff = 0;

%Definition (Ordinary Least Squares Estimate)
Coeff = inv(X'*X)* X' * Y;

end