% == Initial definitions for the MDP lab == %

% States

nS = 3;

% Actions

nA = 2;

% Transition probability matrix

P = cell(1, 2);

% P{1} = <Uncomment and add your code here>
    
% P{2} = <Uncomment and add your code here>

% Reward function

R = zeros(nS, nA);

% <Add your code here>

M = struct('nS', nS, 'nA', nA, 'P', {P}, 'R', R, 'Gamma', 0.99);

% Run VI multiple times

Tave = 0;

for i = 1:1000
    [Q, t] = vi(M);

    Tave = Tave + t;
end

Tave = Tave / 1000;