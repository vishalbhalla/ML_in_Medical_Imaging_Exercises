function [signals,PC,V] = myPCA(input_data)
%% Implement the PCA algorithm according to the lecture slides.
%  Use the SVD method to compute the eigenvectors & eigenvalues of your data.

% Principal Component Analysis (PCA)
% • Algorithm:
% 1. Stack N feature vector column-wise in matrix X0 (dimfeat x N)
[m,n] = size(input_data);
X0 = input_data;

% 2. De-mean X0 subtracting to each column the mean of the columns: you obtain X
meanAcrossDimension = mean(X0,2);
X = X0 - repmat(meanAcrossDimension,1,n);

% 3. Diagonalize X:
%       • Option 1: Use SVD svd(XT/sqrt(nobs-1))=U?VT with ?=diag(?1,…,?dim)
% Construct the matrix Y
Y = input_data' / sqrt(n-1);
[U,S,PC] = svd(Y);

%       • Option 2: Compute eigenvectors of the (dimfeat x dimfeat covariance matrix) X*XT
%                   C =XXT/(nobs-1) = V?VT = V?T?VT Principal components are the columns of VT

% 4. Order eigenvalues in decreasing order (not necessary for svd), and 

% 5. Find out how many components are needed to keep a certain percentage of the total summed variance.
[a,b] = size(S);

% 6. Project the data onto the principal components Y=XTV to yield the data representation in the new base space.
% calculate the variances
% Project the original data
signals = PC' * X;
%signals = (X'*PC)';

end

