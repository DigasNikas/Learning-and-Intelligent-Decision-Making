% Problem specification

a = 1;
b = 2;

P{a} = [0 1 0;0 1 0;0 0 1];
P{b} = [0 0 1;0 1 0;0 0 1];
r = [0 1;2 2;0 0];

gm = 0.9;

% Policy iteration

pol = ceil(2 * rand(3, 1));
quit = false;

tic;
i = 0;
while (~quit)
    rpol = [r(1,pol(1)), r(2,pol(2)), r(3,pol(3))]';
    Ppol = [P{pol(1)}(1,:); P{pol(2)}(2,:); P{pol(3)}(3,:);];
    
    Vpol = (eye(3) - gm * Ppol) \ rpol;
    
    Qa = r(:,a) + gm * P{a} * Vpol;
    Qb = r(:,b) + gm * P{b} * Vpol;
    
    [~, polnew] = max([Qa, Qb], [], 2);
    
    quit = all(polnew == pol);
    
    i = i + 1;
    pol = polnew;
end
t = toc;

% Results
fprintf('Finished after %i iterations and %.3f seconds.\n\n', i, t);
fprintf('Optimal value function:\n');
disp(Vpol);    
    