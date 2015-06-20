function p = predict(Beta, X, threshold)
%PREDICT Predict whether the label is 0 or 1 using learned logistic 
%regression parameters theta
%   p = PREDICT(theta, X) computes the predictions for X using a 
%   threshold (i.e., if sigmoid(Beta'*x) >= threshold, predict 1)

m = size(X, 1); % Number of training examples

p = zeros(m, 1);

% Make predictions using learned logistic regression parameters. 
p = sigmoid(X*Beta);

p(p<threshold) = 0;
p(p>=threshold) = 1;

end
