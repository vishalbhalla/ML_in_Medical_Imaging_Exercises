%% EMPTY this function
function ssmWeights = ssmLeastSquaresMapping(ssm,shapeVector)
    ssmWeights = ssm.eigenvecs' * (shapeVector - ssm.meanShapeVector);
end
