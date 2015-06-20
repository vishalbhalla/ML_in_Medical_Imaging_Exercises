
%% Exercise 0 : Implement PCA

% Load the data
load('toydata.mat');

% Create the original plot
scatter3(D(1,:), D(2,:), D(3,:));

% Compute the PCA 
[signals,PC,V] = myPCA(D);

% Create the reduced SVD plot
scatter3(signals(1,:), signals(2,:), signals(3,:));
