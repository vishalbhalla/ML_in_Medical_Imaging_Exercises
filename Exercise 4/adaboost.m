n = 1000;   % number of data points
T = 1;    % number of iterations

% Generate the training and testing set
[X_train, Y_train] = generate_data(n);
[X_test, Y_test] = generate_data(n);

% Strong classifier
F_train = zeros(n,1);   % evaluated on the training set
F_test = zeros(n,1);    % evaluated on the testing set

% Training and testing errors 
error_train = zeros(T,1);
error_test = zeros(T,1);

% Initialization of the weights
W = ones(n,1) / n; 

for i=1:T
    % Weak classifier optimization
    [d, t, polarity] = best_stump(X_train, Y_train, W);
    % Evaluation of the weak classifier
    f = polarity * (2*(X_train(:,d) > t) - 1);
    
    % TODO: compute alpha
    alpha = 0;
    % TODO: update the weights
    W = W;
    
    % Update the strong classifier and compute the error
    F_train = F_train + alpha * f;
    error_train(i) = sum(Y_train.*F_train<0) / length(Y_train);
    
    % Same for the test data
    f = polarity * (2*(X_test(:,d) > t) - 1);
    F_test = F_test + alpha * f;
    error_test(i) = sum(Y_test.*F_test<0) / length(Y_test);
end

% TODO: add you plots here

