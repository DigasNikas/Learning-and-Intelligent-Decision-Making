% == Initial definitions for the MDP lab == %

% States

nS = 14;

% Actions

nA = 6;

N = 1;
S = 2;
E = 3;
W = 4;
C = 5;
I = 6; 

% Transition probability matrix

P = cell(1, 6);

P{N} = [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.3, 0.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.3, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.2; ...
        0.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3];
    
% P{S} = <Uncommend and add your code here>

P{E} = [0.3, 0.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.3, 0.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.3, 0.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.3, 0.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.3, 0.0, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.3, 0.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.3, 0.0, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.8, 0.0; ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0];

% P{W} = <Uncommend and add your code here>
% P{C} = <Uncommend and add your code here>
% P{I} = <Uncommend and add your code here>

% Reward function

% ORE_REWARD    = <Uncommend and add your code here>
% METAL_REWARD  = <Uncommend and add your code here>
% STONE_REWARD  = <Uncommend and add your code here>
% ENERGY_REWARD = <Uncommend and add your code here>
% DAMAGE_REWARD = <Uncommend and add your code here>

R = zeros(nS, nA);

% Energy use 
R(:, N:C) = ENERGY_REWARD;

% Volcano damage
R(10, :) = R(10, :) + 0.9 * DAMAGE_REWARD;

% Collection rewards

% <Add your code here>

M = struct('nS', nS, 'nA', nA, 'P', {P}, 'R', R, 'Gamma', 0.9);