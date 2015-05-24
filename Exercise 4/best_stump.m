function [ dimension, threshold, polarity] = best_stump( X, Y, W )
%BEST_STUMP Finds the best decision stump
%   Input:
%       - X: the Nx2 feature matrix
%       - Y: the Nx1 label vector
%       - W: the Nx1 weight vector
%   Output:
%       - dimension: the feature dimension used for the decision (1 or 2)
%       - threshold: the best threshold value
%       - polarity: the polarity of the decision (-1 or 1)
minE = 1000;
for d=1:2
    for t=min(X(:,d)):max(X(:,d))
        for p = [-1 1]
            f = p * (2*(X(:,d) > t) - 1);
            e = W' * (Y ~= f);
            if (e < minE)
                minE = e;
                dimension = d;
                threshold = t;
                polarity = p;
            end
        end
    end
end
end