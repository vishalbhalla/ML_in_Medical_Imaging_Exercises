function [X] = lbp(Ii, a, x, y)
% =========== Part 2 d: Local Binary Patterns =============
% With a similar approach, implement a function lbp.m (for Local Binary Patterns) taking
% Input arguments
%  an integral image Ii
%  the side of the patches a
% that extracts the binary feature vector
% x(i, j) = [x1(i, j),  ... , x4(i, j), x6(i, j), ...  , x9(i, j)]
% X of size 1X 8, where xn(i, j) = 1 if ?n(i, j)  ?5(i, j) and xn(i, j) = 0 if ?n(i, j) < ?5(i, j).
Xmean = size(1,9);

% Call the function mean_features.m to getthe average of the intensities over each of the patches Pn(i, j).
Xmean = mean_features(Ii, a, x, y);

% Extract the fifth element for comparison and remove it from the array.
u5 = Xmean(5);
X = Xmean([1:4, 6:end]);

% Set all the elements less than the P5 i.e. its mean u5 to zero.
X(X<u5) = 0;
X(X>=u5) = 1;

end