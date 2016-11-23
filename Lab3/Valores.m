% Problem specification

a = 1;
b = 2;

P{a} = [0 1 0;0 1 0;0 0 1];
P{b} = [0 0 1;0 1 0;0 0 1];
r = [0 1;2 2;0 0];

gm = 0.9;

% Value iteration

V = [0 0 0]';
quit = false;

tic;
i = 0;
while (~quit)
    Qa = r(:, a) + gm * P{a} * V;
    Qb = r(:, b) + gm * P{b} * V;
    
    Vnew = max(Qa, Qb);    
    quit = norm(V-Vnew) < 1e-10;
    
    i = i + 1;
    V = Vnew;
end
t = toc;

% Results
fprintf('%.3f seconds.\n\n', t);
fprintf('Optimal value function:\n');
disp(V)