% == Initial definitions for the MDP lab == %

% States

nS = 2;

% Actions

nA = 3;

% Observations

nZ = 3;

% Transition probability matrix

P = cell(1, nA);

P{1} = [0.5, 0.5; 0.5, 0.5];
    
P{2} = [0.5, 0.5; 0.5, 0.5];

P{3} = [1.0, 0.0; 0.0, 1.0];

% Transition probability matrix

O = cell(1, nA);

O{1} = [0.0, 0.0, 1.0; 0.0, 0.0, 1.0];
    
O{2} = [0.0, 0.0, 1.0; 0.0, 0.0, 1.0];

O{3} = [0.9, 0.1, 0.0; 0.1, 0.9, 0.0];

% Reward function

R = zeros(nS, nA);

R = [1.0, -1.0, 0.0; -1.0, 1.0, 0.0];

M = struct('nS', nS, 'nA', nA, 'nZ', nZ, 'P', {P}, 'O', {O}, 'R', R, 'Gamma', 0.99);

% Use VI to compute the optimal Q-function and policy

[Q, t] = vi(M);
Q

% Activity 2: Optimal Policy
% Q =
% 
%   100.0000   98.0000   99.0000
%    98.0000  100.0000   99.0000

% Beliefs

b = [0:.1:1;1:-.1:0]';

b1 = [1:-.2:0;0:.2:1]';

% Optimal action at each belief

Qopt = [4.4105, 2.4105, 3.7895; 2.4105, 4.4105, 3.7895];

figure(1);
clf;
plot([0, 1], Qopt);
grid on;
xlabel('P[X = Clubs]');
ylabel('V^*');

% Compute action by heuristics

% Most Likely State
    [mBelief,k] = max(b1,[],2);
    [mPolicy, policy] = max(Q, [],2);
    MLS = zeros(size(k), 1);
for i=1:size(k)
    MLS(i) = policy(k(i));
end

% MLS =
% 
%      1
%      1
%      1
%      2
%      2
%      2
     
%Action Voting
    Max = max(b1,[],2);
    Aux = zeros(nS,nA);
for i=1:size(Q,1)
    Aux(i,policy(i)) = 1;
end
    K = b1*Aux;
    [maxAV, AV] = max(K,[],2);
    
%     AV =
% 
%      1
%      1
%      1
%      2
%      2
%      2

 %Qmdp
    T = b1*Q;
    [maxQmdp, Qmdp] = max(T,[],2);
    
%     Qmdp =
% 
%      1
%      1
%      1
%      2
%      2
%      2

% As nossas heuristicas são baseadas no MDP, e por isto não realizam a
% acção peak que recolhe informação sobre o estado, uma vez que o MDP tem
% toda a informação sobre o estado que precisa.
