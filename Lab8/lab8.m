clear all;
clc;

EPS     = 1e-10;
MAXITER = 20000;
LBD     = 0.03;

load data;

rng(seed);

% = Plot the data = %

% Indices of positive samples
accepted = find(data.accepted);

% Indices of negative samples
rejected = find(~data.accepted);

f = figure(1);
clf;

plot(data.math(accepted), data.physics(accepted), '+');
hold on;
plot(data.math(rejected), data.physics(rejected), 'o');

grid on;
xlabel('Grade in the Math exam');
ylabel('Grade in the Physics exam');
legend('Accepted', 'Rejected');

% = Train logistic regression = %
% 
% Model:
%   P(+ | x) = 1 / (1 + exp(X * W))
%
% Training method: 
%   Newton's method

% . Build dataset

X = [ones(size(data.math, 1), 1), data.math, data.physics];
Y = data.accepted;

[M, nW] = size(X);

% . Build sigmoid function

g = @(z) 1.0 ./ (1.0 + exp(-z));
G = @(z) min(1, max(z, 0));

% . Initialize weights

wlr = zeros(nW, 1);
% . Initiate Newton's method

quit = false;
i = 0;

% . Run Newton's method

while (~quit)
    
    % Logistic classifier
    h = g(X * wlr);
    
    % Gradient
    grad = ((h - Y)' * X)./M;
    
    % Hessian
    Hess = (X' * (diag(h) * diag(1 - h)) * X)./M;
    
    % Update
    wnew = wlr - (Hess^(-1))*grad';
    
    % Stopping condition
    
    err = norm(wlr - wnew);
    
    if err < EPS
        quit = true;
    end
    
    wlr = wnew;
    i = i + 1;
end

fprintf('Newton''s method concluded in %i iterations.\n', i);
disp(wlr);

% Newton's method concluded in 7 iterations.

% . Plot decision boundary, w' * X = 0

boundary(f, wlr, 'Boundary LR');


% = Train Online SVM = %
% 
% Input:
%   Data set {X, Y}
%   Regularization term LBD
%   Number of iterationr MAXITER
%
% Training method: 
%   Stochastic Gradient Descent SGD
%
% (Single-sample) reward function:
%
%   J_w(x,y) = -lbd/2 * norm(w)^2 + R(w, (x,y))
%
% with
%   
%   R(w, (x,y)) = min{1, y * (x' * w)}

% . Initialize weights

waux = zeros(nW - 1, 1);

% . Adjust training data

% Set labels in {-1, +1}

Yaux = zeros(M,1);
Yaux(accepted) = 1;
Yaux(rejected) = -1;

% Normalize inputs

Xaux = (X(:, [2,3]) - ones(M, 1) * mean(X(:, [2,3])))./(ones(M, 1)*std(X(:, [2,3]),1));

% . Run subgradient

for i = 1:MAXITER

    % Select random sample
    m = ceil(M * rand);
    
    % Compute step-size
    step = 1 / (LBD * i);
    
    % Subgradient update 
    if Yaux(m) * waux' * Xaux(m,:)' < 1
        waux = waux + step * (Yaux(m) * Xaux(m,:)' - LBD * waux);
    else
        waux = waux - step * LBD * waux;
    end
       
    % Normalize

    aux  = min(1, 1/sqrt(LBD) / norm(waux));
    waux = waux * aux;
end

% . Compute unnormalized weights

wsvm = zeros(nW, 1);

wsvm = [-(mean(X(:,2))/std(X(:,2),1)) - (mean(X(:,3))/std(X(:,3),1)), waux(1)/std(X(:,2),1), waux(2)/std(X(:,3),1)]';

disp(wsvm);

% . Plot decision boundary, w' * X = 0

boundary(f, wsvm, 'Boundary SVM');

% The result of this SVM is most probabluy wron(due some mistake in code).
% The svm decision line should be closer to the Logistic Regression one.
