function [ B ] = wlsfit( X, Y, w )
%WLSFIT Computes the Weighted Least Squared Fit
%   X is a n-by-(m+1) data matrix where each row contains one sample comprised
%   of m features and the first column contains only 1 to account for the
%   intercept.
%   Y is a vector of size n which contains the continuous outputs for each sample.
%   w is a vector of size n which contains the weights associated with each sample.
%   B contains the estimated m+1 coefficients, where B(0) denotes the
%   intercept.

if (numel(X) == 0)
    error('Empty data matrix X');
end
if (numel(Y) == 0)
    error('Empty output vector Y');
end
if (numel(w) == 0)
    error('Empty weights vector w');
end
if (size(Y, 2) ~= 1)
    error('Y must be a vector');
end
if (size(w, 2) ~= 1)
    error('w must be a vector');
end
if (size(X, 1) ~= size(Y, 1))
   error('Dimensions of matrix X and vector Y are not consistent');
end
if (size(X, 1) ~= size(w, 1))
    error('Dimensions of matrix X and weight vector w are not consistent');
end

% Copied from glmfit
[~, num_features] = size(X);
yw = Y .* w;
xw = X .* w(:,ones(1,num_features));
% No pivoting, no basic solution.  We've removed dependent cols from x, and
% checked the weights, so xw should be full rank.
[Q,R] = qr(xw,0);
B = R \ (Q'*yw);

end
