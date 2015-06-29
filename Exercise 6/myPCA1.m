function [signals,PC,V,NmostPC,NmostV] = myPCA1(X, desiredVariancePercentage)
%% Implement the PCA algorithm according to the lecture slides.
%  Use the covariance method to compute the eigenvectors & eigenvalues of your data.

% Principal Component Analysis (PCA)
% • Algorithm:
% 1. Stack N feature vector column-wise in matrix X0 (dimfeat x N)
[m,n] = size(X);

% 2. De-mean X0 subtracting to each column the mean of the columns: you obtain X
meanAcrossDimension = mean(X,2);
Xdemean = X - repmat(meanAcrossDimension,1,n);

% 3. Diagonalize X:
%       • Option 2: Compute eigenvectors of the (dimfeat x dimfeat covariance matrix) X*XT
%                   C =XXT/(nobs-1) = V?VT = V?T?VT Principal components are the columns of VT
% Compute Covariance matrix of Xdemean
CovarianceX = (Xdemean'*Xdemean)/(n-1);

% Find the eigenvectors and eigenvalues
[PC, V] = eig(CovarianceX);

% 4. Order eigenvalues in decreasing order 
% sort the variances in decreasing order

% Find np
B = diag(V);
%V = sort(V, 'descend');
[B,I] = sort(B, 'descend');
desiredSSMDeformationCoveringModes = desiredVariancePercentage * sum(B);
np = 0;
npLambdaSum = 0;
for i=1:n
    npLambdaSum = npLambdaSum + B(i);
    if(npLambdaSum >= desiredSSMDeformationCoveringModes)
        break;
    end
    np = np +1;
end

NmostPC = [];
NmostV = [];

for j=1:np
    NmostPC = [NmostPC, PC(:,I(j))];
    NmostV = [NmostV, B(j)];
end

% 6. Project the data onto the principal components Y=XTV to yield the data representation in the new base space.
% Project the original data
%signals = (X*PC)';
signals = X*NmostPC;

end
