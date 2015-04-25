function [X] = long_range_two_offsets(Ii, a, w1, w2)
% =========== Part 2 e: (ii) Long Range Features - long_range_two_offsets =============
% Input arguments
% an integral image Ii
% a side of patches a
% a first offset vector w1 = [u1,v1]
% a second offset vector w2 = [u2,v2]
% Returns the difference between the means of the patches centered on (i+u1, j+v1) and on (i+u2, j+v2) and its binary version. 
%  The output is a cell array X of size 1X 2.

X = size(1,2);

u = w1(1);
v = w1(2);

% The size a of patches or kernels must always be an odd number a = 2r+1. 
% The centre of the patch/kernel is then clearly defined as the pixel (r+1, r+1).
x = (a-1)/2;
y = x;

u5 = mean_patch(Ii, a, x, y); 

uw = mean_patch(Ii, a, x+u, y+v);

X(1) = uw - u5;

u = w2(1);
v = w2(2);

uw = mean_patch(Ii, a, x+u, y+v);

X(2) = uw - u5;

end