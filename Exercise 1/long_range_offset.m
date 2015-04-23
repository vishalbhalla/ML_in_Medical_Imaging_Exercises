function [X] = long_range_offset(I, a, w)
% =========== Part 2 e: (i) Long Range Features - long_range_offset=============
% We propose to compute now the same kind of features but on longer range.
% Input arguments
% an integral image ˜ I
% a side of patches a
%  an offset vector w = [u;v]
% Returns the feature vector x(i; j) = [x1(i; j);x2(i; j)] as a cell array X of size 12
% where:
%  x1(i; j) = ?w(i, j) - ?5(i, j), where ?w(i, j) is the mean over the patch of side a centered on the pixel (i+u; j+v)
%  x2(i; j) is the binarised version of x1(i, j): if x1(i, j) >=0 then x2(i, j) = 1, else x2(i, j) = 0

X = {};

end