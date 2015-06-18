% function h = imagescPhysical(I,pixelSpacing)
% input: 
%   I ... the 2D image
%   pixelSpacing ... a 2-element vector [sp_x sp_y] with the spacing in 
%                    x-direction (MATLAB columns) and y-direction (MATLAB
%                    rows)
function varargout = imagescPhysical(I,pixelSpacing)
    [rows cols] = size(I);

    % range of x-axis in physical [mm] space (x-axis are columns in MATLAB)
    x = [0 pixelSpacing(1)*(cols-1)];
    % range of y-axis (i.e. rows in MATLAB)
    y = [0 pixelSpacing(2)*(rows-1)];

    h = imagesc(x,y,I);
    colormap gray;
    axis ij;
    axis equal;
    axis tight;
    
    if nargout>0
        varargout{1} = h;
    end
end