function segmentImageASM(I,pxSpacing,SSM,AAM,optionsAAMOptimizer, optionsAAM)

    %%  INITIALIZATION
    %
    [initShapeOffsetY initShapeOffsetX] = SelectPosition(I,SSM.meanShape(:,2)/pxSpacing(2),SSM.meanShape(:,1)/pxSpacing(1));
    T_init = eye(3); 
    T_init(1:2,3) = [initShapeOffsetX initShapeOffsetY].*pxSpacing;
    initShape = transformPointCloud2D(SSM.meanShape,T_init);

    nrVertices = size(SSM.meanShape,1);
    nrCtrlPts = optionsAAMOptimizer.searchWindowSize(1) * optionsAAMOptimizer.searchWindowSize(2);

    %% SEGMENTATION
    % create ctrl point offsets
    cx = linspace(-optionsAAMOptimizer.searchWindowSize(1)/2, optionsAAMOptimizer.searchWindowSize(1)/2, optionsAAMOptimizer.nrControlPointsInWindow(1));
    cy = linspace(-optionsAAMOptimizer.searchWindowSize(2)/2, optionsAAMOptimizer.searchWindowSize(2)/2, optionsAAMOptimizer.nrControlPointsInWindow(2));

    currentShape = initShape;

        hFig = figure();
        hImg = imagescPhysical(I, pxSpacing);
        hold on;
        hCurrentShape = plot(currentShape(:,1),currentShape(:,2),'r.');
        hprojectedShapeVector = 0;
        T_current = T_init;


    % optimization loop
    for iteri=1:optionsAAMOptimizer.maxIter
        tic
        hBestCtrlPts = zeros(nrVertices,1); % handles of selected ctrl points
        oldShape = currentShape;
        
        % for each vertex of shape j
        for iterv=1:nrVertices 
            v = currentShape(iterv,:); % current vertex coordinates
            figure(hFig); hv = plot(v(1),v(2),'g*'); drawnow;
            % reduce the size of the ctrl point range by factor "windowSizeDecayRate"
            cxReduced = cx * (optionsAAMOptimizer.windowSizeDecayRate)^(iteri-1);
            cyReduced = cy * (optionsAAMOptimizer.windowSizeDecayRate)^(iteri-1);
            % calculate positions of ctrl points (where candidate patches will be tested)
            cxAtv = cxReduced+v(1);
            cyAtv = cyReduced+v(2);
            [Cx Cy] = meshgrid(cxAtv,cyAtv);
            ctrlPts = [Cx(:) Cy(:)];
            nrCtrlPts = size(ctrlPts,1);

            hCtrlPts = plot(ctrlPts(:,1),ctrlPts(:,2),'b.');drawnow;

            dM = zeros(nrCtrlPts,1); % container for ctrl point distances (cost function)
            for iterc = 1:nrCtrlPts % for each ctrl point patch p
                c = ctrlPts(iterc,:);
                % interpolate an image patch at that position
                imgPatch = getImagePatchAtPoint( ...
                    I, ...
                    pxSpacing, ...
                    c, ...
                    optionsAAM.patchResolution, ...
                    optionsAAM.patchSizeMM);    
                imgPatch = imgPatch(:);

                % EMPTY from here
                meanPatch = AAM(iterv).meanPatch;
                thisPatchCostFunction = costFct_CorrelationWithMeanPatch(meanPatch,imgPatch);
                % EMPTY 'til here

                dM(iterc) = thisPatchCostFunction(1,2);
            end 

            % identify optimal ctrl-point-patch
            [dMSorted, dMIdx] = sort(dM,'descend');
            bestCtrlPoint = dMIdx(1);

            % replace vertex coordinate with best ctrl-point coordinates
            currentShape(iterv,:) = ctrlPts(bestCtrlPoint,:); 

            hBestCtrlPts(iterv) = plot(currentShape(iterv,1),currentShape(iterv,2),'g.');drawnow; % plot the best control point, store the handle

            delete(hv); % delete the green dot indicating the current vertex
            delete(hCtrlPts); % delete the blue grid indicating locations of current control points
        end
        delete(hBestCtrlPts);

%         % register currentShape to new vertex candidates before SSM
%         % regularization to compensate for rigid shape displacements
%         %[T_oldToNew ptsMovedEqualDistance] = alignEqualDistance(currentShape,oldShape);
%         T_oldToNew = umeyama2D(currentShape',oldShape');
%         T_current = T_oldToNew * T_current

        % identify closest legal shape through least-squares mapping into SSM space
        % first transform into origin (the SSM space is de-meaned)
        currentShapeVector = pointsXYToShapeVector(transformPointCloud2D(currentShape,T_current^-1));
        currentSSMweights = ssmLeastSquaresMapping(SSM,currentShapeVector);
        disp('Current shape weights:');
        disp(currentSSMweights');
        currentSSMweights = clampValues(currentSSMweights,-3,3);
        disp('Clamped shape weights:');
        disp(currentSSMweights');       
        projectedShapeVector = SSM.meanShapeVector + SSM.eigenvecs * currentSSMweights;

        % update the vertex positions with legal-shape vertices
        currentShape = transformPointCloud2D(shapeVectorToXY(projectedShapeVector),T_init);

        delete(hCurrentShape);
        hCurrentShape = plot(currentShape(:,1),currentShape(:,2),'r.');

        disp(['Iteration ' int2str(iteri) ' of ' optionsAAMOptimizer.maxIter ' finished.']);
        toc
    end
    midbrainLines = [1:nrVertices 1];
    plot(currentShape(midbrainLines,1),currentShape(midbrainLines,2),'r-');
    plot(initShape(:,1),initShape(:,2),'g.');
    plot(initShape(midbrainLines,1),initShape(midbrainLines,2),'g-');
	title('green: initial shape; red: final shape');
end

%% helper functions
% function sv = pointsXYToShapeVector(xy)
% convert xy-coordinates to shape vector, i.e. just append the
% y-coordinates after the x-coordinates into one row vector
function sv = pointsXYToShapeVector(xy)
    nrVertices = size(xy,1);
    sv = zeros(2*nrVertices,1);
    sv(1:nrVertices) = xy(:,1);
    sv((nrVertices+1):end) = xy(:,2);
end

% function xy = shapeVectorToXY(sv)
% convert a shape vector to xy-coordinates
function xy = shapeVectorToXY(sv)
    nrVertices = length(sv)/2;
    xy = zeros(nrVertices,2);
    xy(:,1) = sv(1:nrVertices);
    xy(:,2) = sv((nrVertices+1):end);
end

function y = clampValues(x,xmin,xmax)
    y = max(x,xmin);
    y = min(y,xmax);
end

%% COST FUNCTIONS
% implement the cost functions here
function c = costFct_CorrelationWithMeanPatch(meanPatch,testPatch)
    meanPatch = meanPatch(:);
    testPatch = testPatch(:);

    c = corrcoef(mat2gray(testPatch),mat2gray(meanPatch));
    %             dM(iterc) = ...
    %                 sqrt( (imgPatch-meanPatchVector)' * ...
    %                 (AAM(iterv).cov)^-1 * ...
    %                 (imgPatch-meanPatchVector) );
end

function c = costFct_MahalanobisDistanceToMeanPatch(meanPatch,testPatch,covMatrix)
    % calculate Mahalanobis distance of patch to AAM(j)
	% (definition dM_i = sqrt( (x_i-mu)' S^-1 (x_i-mu) ), with S=covariance matrix
    c = ...
        sqrt( (testPatch-meanPatchVector)' * ...
        covMatrix^-1 * ...
        (testPatch-meanPatchVector) );
end
