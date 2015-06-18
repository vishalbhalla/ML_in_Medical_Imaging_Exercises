
clear all
close all
load('./midbrainImagesAndLandmarks.mat');
pxSpacing = [0.221881 0.247166]; % pixelSpacing - obtained through a previous calibration of US image acquisition 
landmarksXY_PixelSpace = landmarksXY;
% landmarksXY will from now on contain coordinates in [mm] space
landmarksXY(:,1,:) = landmarksXY_PixelSpace(:,1,:) * pxSpacing(1);
landmarksXY(:,2,:) = landmarksXY_PixelSpace(:,2,:) * pxSpacing(2);

figure(1);
i=20;
showImageAndLandmarks(I_midbrain_cropped(:,:,i),pxSpacing,landmarksXY(:,:,i));

%% VISUALIZE DATASET
figure(1)
for i=1:3%size(I_midbrain_cropped,3)
    % EMPTY showImageAndLandmarks
    subplot(1,3,i);
    showImageAndLandmarks(I_midbrain_cropped(:,:,i),pxSpacing,landmarksXY(:,:,i));
    pause(0.2)
end
mtitOutputParams = mtit(1,'Three example images and landmarks from the dataset.');
%clear mtitOutputParams;

%% SPLIT TRAINING AND TEST SET
trainSet=1:25;
testSet =26:30;
I_trainingSet = I_midbrain_cropped(:,:,trainSet);
landmarksXY_trainingSet = landmarksXY(:,:,trainSet);

%% EXERCISE 1&2 - TRAIN SSM MODEL
desiredVariancePercentage = .95;
SSM = trainSSModel(I_trainingSet,landmarksXY_trainingSet,desiredVariancePercentage);

%% TRAIN AND VISUALIZE AAM MODEL
optionsAAM.patchSizeMM = [6 6]; % patch extent in mm in x/y direction
optionsAAM.patchResolution = 0.2; % isotropic resolution (in [mm]) of interpolated image patch
AAM = trainAAModel(I_trainingSet,pxSpacing,landmarksXY_trainingSet,optionsAAM);
    

% VISUALIZATION:
% visualizes the vertices of the mean shape and the learned
% mean apperances for each vertex. 

% plot vertices of ssm mean-shape and vertex-wise aam mean-appearances
figure();
plot(SSM.meanShape(:,1),SSM.meanShape(:,2),'r.');
axis equal;
hold on;

for j=1:size(landmarksXY,1)
    v = SSM.meanShape(j,:);

    % (zero-centered) grid coordinates of patch
    px = (-optionsAAM.patchSizeMM(1)/2:optionsAAM.patchResolution:optionsAAM.patchSizeMM(1)/2)';
    py = (-optionsAAM.patchSizeMM(2)/2:optionsAAM.patchResolution:optionsAAM.patchSizeMM(2)/2)';
    
    % grid coordinates for image patch p at ssm vertex/landmark v
    pxAtv = px+v(1);
    pyAtv = py+v(2);
    [Px Py] = meshgrid(pxAtv,pyAtv);
    hi=imagesc(pxAtv,pyAtv,AAM(j).meanPatch);
    colormap gray;
    plot(v(1),v(2),'g.');
end
hold off;
title('Mean appearance per vertex (stored in AAM).');

%% SEGMENTATION STEP - TEST ASM MODEL
% when the figure opens, place the average shape into the image 
optionsAAMOptimizer.searchWindowSize = [8 8];
optionsAAMOptimizer.nrControlPointsInWindow = [5 5];
optionsAAMOptimizer.maxIter = 5;
optionsAAMOptimizer.windowSizeDecayRate = 0.8;

idxTest = testSet(1);
testImg = I_midbrain_cropped(:,:,idxTest);

segmentImageASM(testImg,pxSpacing,SSM,AAM,optionsAAMOptimizer,optionsAAM);