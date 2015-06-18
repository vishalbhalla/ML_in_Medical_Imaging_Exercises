% function imgPatch = getImagePatchAtPoint(I,pixelSpacing,p,patchRes,patchSize)
%
% This function returns a quadratic image patch from an input image I, at a
% given point p.
% The point coordinates are assumed in physical coordinates (i.e. in [mm]),
% w.r.t. to the image origin (which is I(1,1) in MATLAB).
% The length of the quadratic and the resolution of the patch can be specified 
% in [mm].
%
% inputs:
%   I ... input image
%   pxSpacing ... a 2-element vector [sp_x sp_y] with the spacing in 
%                 x-direction (MATLAB columns) and y-direction (MATLAB
%                 rows)
%   p ... point coordinates in image (in mm)
%   patchRes ... desired (isotropic) resolution of the patch (in [mm])
%   patchSize ... a 2-vector [sx sy] with desired size of the patch in x- 
%                 and y-direction (in [mm])

function imgPatch = getImagePatchAtPoint(I,pxSpacing,p,patchRes,patchSize)
    
    imgSize = size(I);
    imgrows = (0:(imgSize(1)-1))*pxSpacing(2);
    imgcols = (0:(imgSize(2)-1))*pxSpacing(1);
    [Ix Iy] = meshgrid(imgcols,imgrows);
    
    % (zero-centered) grid coordinates of patch for sampling vertices later
    px = (-patchSize(1)/2:patchRes:patchSize(1)/2)';
    py = (-patchSize(2)/2:patchRes:patchSize(2)/2)';

    % grid coordinates for image patch p at vertex/landmark v
    pxAtP = px+p(1);
    pyAtP = py+p(2);
    [Px Py] = meshgrid(pxAtP,pyAtP);
    % linear interpolation of image patch at v using MATLAB's interp2
    imgPatch = interp2(Ix,Iy,I,Px,Py);
    
end