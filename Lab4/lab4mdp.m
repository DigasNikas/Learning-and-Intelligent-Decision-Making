% == Initial definitions for the MDP lab == %

% States

nS = 10;

% Actions

nA = 2;

% Transition probability matrix

P = cell(1, 2);
% matrix for 3 States
P{1} = [1,0,0;0.6,0.4,0;0,0.6,0.4];
    
P{2} = [0.4,0.6,0;0,0.4,0.6;0,0,1];

% Matrix for nS states
D = eye(nS);
D = D * 0.4;
v(1:nS-1) = 0.6;
D1 = diag(v, -1);
D2 = diag(v, 1);

P{1} = D + D1;
P{1}(1,1) = 1;

P{2}= D + D2;
P{2}(nS,nS)=1;

% Reward function

R = zeros(nS, nA);

R(nS,: )=1;

M = struct('nS', nS, 'nA', nA, 'P', {P}, 'R', R, 'Gamma', 0.99);

% Run VI multiple times

Tave = 0;

h = waitbar(0,'Please wait...');
for i = 1:1000
    [Q, t] = vi(M);

    Tave = Tave + t;
    waitbar(i/1000, h);
end
close(h);

Tave = Tave / 1000;

% actividade 2
% 0.075 seconds average time
%Optimal value function:
%    95.7490   96.7162
%    96.3938   98.3444
%    99.0166  100.0000

%actividade 4
% n = 10
% average time = 0.088
%
% n = 20
% average time = 0.094.
%
% n = 50
% average time = 0.150
%
% n = 500
% average time = 16.5
%
% podemos concluir que o average time não aumenta linearmente com o numero
% de estados
