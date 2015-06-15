n = 1000;   % number of data points
%T = 1;    % number of iterations
T = 100;    % number of iterations

% Generate the training and testing set
[X_train, Y_train] = generate_data(n);
[X_test, Y_test] = generate_data(n);

% Strong classifier
F_train = zeros(n,1);   % evaluated on the training set
F_test = zeros(n,1);    % evaluated on the testing set

% Training and testing errors 
error_train = zeros(T,1);
error_test = zeros(T,1);


%% 1. Compute parameter alpha & updated weights w within the boosting loop.

% Initialization of the weights
W = ones(n,1) / n; 

for i=1:T
    % Weak classifier optimization
    [d, t, polarity] = best_stump(X_train, Y_train, W);
    % Evaluation of the weak classifier
    f = polarity * (2*(X_train(:,d) > t) - 1);
    
    % TODO: compute alpha
    alpha = 0;
    
    % Calculate the error rate.
    epsilon = sum(W.*(f~=Y_train))/sum(W);
    
    alpha = 0.5 * log((1-epsilon)/epsilon);
    
    % TODO: update the weights
    weightComponent = exp(-alpha.*Y_train.*f);
    Z = sum(W.*weightComponent);
    W = (W.*weightComponent)./Z;
    
    % Update the strong classifier and compute the error
    F_train = F_train + alpha * f;
    error_train(i) = sum(Y_train.*F_train<0) / length(Y_train);
    
    % Same for the test data
    f = polarity * (2*(X_test(:,d) > t) - 1);
    F_test = F_test + alpha * f;
    error_test(i) = sum(Y_test.*F_test<0) / length(Y_test);
end

% TODO: add you plots here

%% 2. Plot the testing set Xtest, displaying the points with a different color for each label
% (e.g. red for Y = -1, blue for Y = +1). 
% Use two different plots: one with the true labels Ytest, and 
% One with the labels predicted by your boosted classifier (F), and
% Compare the two plots.

%% 2a. Plot with the true labels Y_test.

blue = X_test(Y_test==1,:);
red = X_test(Y_test==-1,:);

% Show the data
figure(1);
plot(blue(:,1),blue(:,2),'b*');
hold on;
plot(red(:,1),red(:,2),'r*');
axis equal;
title('Test Data classified with the true labels');

hold on;


%% 2b. Plot with the labels predicted by boosted classifier (F).


%% 3. Plot the evolution of the training error and testing error during 100 iterations and report what you observe.

