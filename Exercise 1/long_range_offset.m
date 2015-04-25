function [X] = long_range_offset(Ii, a, w)
% =========== Part 2 e: (i) Long Range Features - long_range_offset=============
% We propose to compute now the same kind of features but on longer range.
% Input arguments
% an integral image Ii
% a side of patches a
%  an offset vector w = [u,v]
% Returns the feature vector x(i; j) = [x1(i, j), x2(i, j)] as a cell array X of size 12
% where:
%  x1(i, j) = uw(i, j) - u5(i, j), where uw(i, j) is the mean over the patch of side a centered on the pixel (i+u, j+v)
%  x2(i, j) is the binarised version of x1(i, j): if x1(i, j) >=0 then x2(i, j) = 1, else x2(i, j) = 0

X = size(1,2);

u = w(1);
v = w(2);

% The size a of patches or kernels must always be an odd number a = 2r+1. 
% The centre of the patch/kernel is then clearly defined as the pixel (r+1, r+1).
x = (a-1)/2;
y = x;

uw = mean_patch(Ii, a, x+u, y+v);
u5 = mean_patch(Ii, a, x, y); 

X(1) = uw - u5;
if X(1)>=0
    X(2)=1;
else
    X(2)=0;

end