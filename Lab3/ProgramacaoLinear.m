% Problem specification

a = 1;
b = 2;

P{a} = [0 1 0;0 1 0;0 0 1];
P{b} = [0 0 1;0 1 0;0 0 1];
r = [0 1;2 2;0 0];

gm = 0.9;

% Linear program

u = ones(1, 3) / 3;

clear model;
model.obj = u';
model.A = sparse([eye(3)-gm * P{1};eye(3)-gm * P{2}]);
model.sense = '>';
model.rhs = r(:);

clear params;
params.Presolve = 2;
params.TimeLimit = 100;
 
tic;
result = gurobi(model, params);
t = toc;

fprintf('Finished after %.3f seconds.\n\n', t);
fprintf('Optimal value function:\n');
disp(result.x);