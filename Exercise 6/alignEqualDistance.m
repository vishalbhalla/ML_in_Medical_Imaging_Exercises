% function [T_total movedPoints] =
% alignEqualDistance(ptsStatic,ptsMoving,varargin)
%
% This function aligns two 2D shapes (represented as point clouds with correspondences)
% by calculating a vector of pair-wise distances between corresponding points
% and minimizing a weighted sum of mean and standard deviation of this
% vector, thus keeping overall distance low (by minimizing mean distance), 
% while positioning the moving shape such that all vertices of shape A and
% B maintain a roughly equal distance (by minimizing standard deviation).

function [T_total movedPoints] = alignEqualDistance(ptsStatic,ptsMoving,varargin)

    if (nargin>2)
        options = varargin{1};
    else
        options.visualize = 0;
    end

    % first optimize the mean distance
    x0 = [0 0 0];
%     options = optimset('MaxIter',100000);
%     fMean = @(x)calculateMeanDistance(x,ptsStatic,ptsMoving);
%     [xminMean,fmin,ct] = ANMS(fMean, x0,10^-4,10000);
%     %[xmin,fmin,exitflag] = fminsearch(f,x0,options);
%     
%     % then minimize the std distance
%     x0 = xminMean;
    fStd = @(x)calculateWeightedMeanStdDistance(x,ptsStatic,ptsMoving);
    [xminStd,fmin,ct] = ANMS(fStd, x0,10^-4,10000);
    %ct
     
    % process output
    [T_total movedPoints] = pivotPoints(xminStd, ptsStatic, ptsMoving);
end

function c = calculateMeanDistance(params,ptsStatic,ptsMoving)
    [T_total movedPoints] = pivotPoints(params, ptsStatic, ptsMoving);

    distances = sqrt( sum((ptsStatic-movedPoints).^2,2) );
    c = mean(distances);
end

function c = calculateStdDistance(params,ptsStatic,ptsMoving)
    [T_total movedPoints] = pivotPoints(params, ptsStatic, ptsMoving);

    distances = sqrt( sum((ptsStatic-movedPoints).^2,2) );
    c = std(distances);
end

function c = calculateWeightedMeanStdDistance(params,ptsStatic,ptsMoving)
    [T_total movedPoints] = pivotPoints(params, ptsStatic, ptsMoving);

    distances = sqrt( sum((ptsStatic-movedPoints).^2,2) );
    cm = mean(distances);
    cs = std(distances);
    
    c = 0.3*cm+0.7*cs;
end


function [m s] = costFunctionEqualMeanAndStd(pts1, pts2)
    D = sqrt( sum((pts1-pts2).^2,2) );
    m = mean(D);
    s = std(D);
end


function [T_total movedPoints] = pivotPoints(params, ptsStatic, ptsMoving)
    D = ptsStatic;
    S = ptsMoving;

    T_toMeanD = transformationMatrixFrom3DOF([-1*mean(ptsStatic) 0]);
    T_toMeanS = transformationMatrixFrom3DOF([-1*mean(ptsMoving) 0]);
    
    D0 = transformPointCloud2D(D,T_toMeanD);
    S0 = transformPointCloud2D(S,T_toMeanS);

    T_inter = transformationMatrixFrom3DOF(params);
    
    T_total = T_toMeanD * T_inter^-1 * T_toMeanS^-1;

    movedPoints = transformPointCloud2D(S,T_total);
end


function T = transformationMatrixFrom3DOF(p)
    tx = p(1);
    ty = p(2);
    theta = p(3);
    
    R = rotation_to_matrix_2D(deg2rad(theta));
    T = [ R [tx ty]'; [0 0 1] ];        
end


function R = rotation_to_matrix_2D(theta)
    R = [ ...
        cos(theta) -sin(theta); ...
        sin(theta)  cos(theta) ];
end