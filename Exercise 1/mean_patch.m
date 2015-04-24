function [mean] = mean_patch(Ii, a, x, y)
% =========== Part 2 b: Mean Patch =============
% Input Arguments
%  an integral image Ii
%  the side of the patches a
%   the coordinates (a,b) of this patch
% Returns the feature vector as the mean of intensities of I over the patch of side a centered on (a,b).
% Note: In the configuration of the Figure 1, the sum of intensities of I over the gray rectangle is given by
% sum(I(y,x)) = Ii(y2+1,x2+1) - Ii(y2+1,x1) - Ii(y1,x2+1)+ Ii(y1,x1)

mean = 0;

% Determine starting and ending rows and columns.
row = floor(x - (a-1)/2);
col = floor(y - (a-1)/2);

x1 = col;
y1 = row;
x2 = col + a;
y2 = row + a;

mean = abs((Ii(y2+1,x2+1) - Ii(y2+1,x1) - Ii(y1,x2+1)+ Ii(y1,x1))/a);

end
