function [X] = mean_features(I, a)
% =========== Part 2 b: Mean Patch =============
% We take a patch of side a centered on the pixel (i, j) of interest and we consider its 8 neighbouring patches
% By using mean_patch.m and a loop over the patch indexes, implement a function mean_features.m taking as input arguments
%  an integral image ˜I
%  the side of the patches a
%   the coordinates (a,b) of this patch
% Returns the feature vector as the mean of intensities of I over the patch of side a centered on (a,b).
% Note: In the configuration of the Figure 1, the sum of intensities of I over the gray rectangle is given by
% I(y,x) = ˜I(y2+1,x2+1) - ˜I(y2+1,x1) - ˜I(y1,x2+1)+ ˜I(y1;x1)

X = {};

end
