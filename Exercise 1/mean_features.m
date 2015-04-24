function [X] = mean_features(Ii, a, x, y)
% =========== Part 2 c: Mean Patch =============
% We take a patch of side a centered on the pixel (i, j) of interest and we consider its 8 neighbouring patches
% By using mean_patch.m and a loop over the patch indexes, implement a function mean_features.m taking as input arguments
%  an integral image Ii
%  the side of the patches a
% Returns the feature vector
% x(i, j) = [u1(i, j), u2(i, j),  ...  , u9(i, j)]
% as a cell array X of size 1X 9 where un(i, j) is the average of the intensities over the patch Pn(i, j).

X = size(1,9);

u1 = 0; u2 = 0; u3 = 0; u4 = 0; u5 = 0; u6 = 0; u7 = 0; u8 = 0; u9 = 0;

u1 = mean_patch(Ii, a, x-a, y-a);
u2 = mean_patch(Ii, a, x-a, y);
u3 = mean_patch(Ii, a, x-a, y+a);
u4 = mean_patch(Ii, a, x, y-a);
u5 = mean_patch(Ii, a, x, y);
u6 = mean_patch(Ii, a, x, y+a);
u7 = mean_patch(Ii, a, x+a, y-a);
u8 = mean_patch(Ii, a, x+a, y);
u9 = mean_patch(Ii, a, x+a, y+a);

% Combine un(i, j) - the average of the intensities over each of the patch Pn(i, j) as a cell array X of size 1X 9 to get the feature vector
X = [u1, u2, u3, u4, u5, u6, u7, u8, u9];

end
