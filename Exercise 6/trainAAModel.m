function AAM = trainAAModel(I_trainingSet,pxSpacing,landmarksXY_trainingSet,optionsAAM)

    nrLandmarks = size(landmarksXY_trainingSet,1);
    nrImages = size(I_trainingSet,3);
    
    %% collect image patches for all vertices j
    patchCollection = cell(nrLandmarks,1);
    
    % EXERCISE 4
    % fill each cell in patchCollection with a stack of n training patches
    % make use of the function "getImagePatchAtPoint"
    % EMPTY from here
    for j=1:nrLandmarks
        tempCollection = [];       
        for i=1:nrImages;
            I = I_trainingSet(:,:,i);
            p = landmarksXY_trainingSet(j,:,i);
            imgPatch = getImagePatchAtPoint( ...
                I, ...
                pxSpacing, ...
                p, ...
                optionsAAM.patchResolution, ...
                optionsAAM.patchSizeMM);    
            tempCollection(:,:,i) = imgPatch;
        end
        patchCollection{j} = tempCollection;
    end
    disp('Patches for AAM training collected.');
    
    %% calculate statistics for each vertex/landmark separately
    AAM = struct;
    tic
    for j=1:nrLandmarks
        thisPatchSet = patchCollection{j};
        AAM(j).meanPatch = squeeze(mean(thisPatchSet,3));

        tempP = thisPatchSet(:,:,1);
        thisPatchSetVectors = zeros(length(tempP(:)),nrImages);
        for p=1:nrImages
            tempP = thisPatchSet(:,:,p);
            thisPatchSetVectors(:,p) = tempP(:);
        end
        [AAM(j).eigenvecs, AAM(j).shapeWeightsInNewBasis, AAM(j).eigenvals] = ...
            princomp(thisPatchSetVectors);
        AAM(j).cov = cov(thisPatchSetVectors');
    end
    disp('AAM model training finished.');
    toc
    % EMPTY to here

end