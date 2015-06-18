function SSM=trainSSModel(images,landmarks,desiredVariancePercentage)

    % Align shapes and build point distribution model
    % The output PDM is a 3D-array of vertex coordinates with shapes in x/y representation
    % The PDM has the dimensions <nrVertices x 2 x nrTrainingShapes>
    PDM=pointDistributionModel(landmarks);

    % EXERCISE 1 - Build statistical shape model
    % fill the function statisticalShapeModel.m
    SSM=statisticalShapeModel(PDM,desiredVariancePercentage);

    % EXERCISE 2 - visualize the modes of variation
    % fill the function visualizeShapeModesOfVariation.m
    visualizeShapeModesOfVariation(SSM);
    
end

%%

function pdm=pointDistributionModel(landmarks)
   
    %Center all points around first pointset
    numVert=size(landmarks,1);
    numShapes=size(landmarks,3);
    mean1=mean(landmarks(:,:,1),1);
    landmarks(:,:,:)=landmarks(:,:,:)-repmat(mean1,[numVert 1 numShapes]);
   
    %Initialize pdm
    pdm=zeros(size(landmarks));
    pdm(:,:,1)=landmarks(:,:,1);

    figure();
    plot(pdm(:,1,1),pdm(:,2,1),'r.');
    axis equal;
    title('Registering training shapes...');
    hold on;
    
    %Align the remaining pointsets
    for i=1:numShapes
        [T_dummy movedPoints] = alignEqualDistance(landmarks(:,:,1),landmarks(:,:,i));
        pdm(:,:,i)=movedPoints;
        plot(pdm(:,1,i),pdm(:,2,i),'b.');
        drawnow;
    end
    hold off;
end


