function [ X, Y ] = generate_data(N)
%GENERATE_DATA Generates a labeled dataset
%   This function generates a set of 2D points and the corresponding labels
%   according to a distribution defined in 'distribution.mat'
%   Input:
%       - N: the number of points to generate
%   Output:
%       - X: 2D points (Nx2)
%       - Y: the label vector (Nx1)

load('distribution.mat');
X = randi([1 100], N, 2);
P = zeros(N,1);
for i=1:N
    P(i) = p(X(i,1),X(i,2));
end
Y = 2*(randi([0 1000], N, 1)/1000 > P)-1;

end

