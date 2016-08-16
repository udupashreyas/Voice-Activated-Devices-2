function [J, grad] = lrCostFunction(theta, X, y, lambda)
%LRCOSTFUNCTION Compute cost and gradient for logistic regression with 
%regularization
%   J = LRCOSTFUNCTION(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

J = 0;
grad = zeros(size(theta));


J = (1/m)*sum(-y.*log(sigmoid(X*theta))-(ones(size(y))-y).*log(ones(size(y))-sigmoid(X*theta)));
%disp(size((sigmoid(X*theta))-(ones(size(y))-y)));
%disp(size());
temp = theta;
temp(1) = 0;
J = J + lambda/(2*m) * sum(temp.^2);
beta = sigmoid(X*theta) - y;
grad = (X'*beta)/m;
temp = theta;
temp(1) = 0;
grad = grad + (lambda/m)*temp;

grad = grad(:);

end
