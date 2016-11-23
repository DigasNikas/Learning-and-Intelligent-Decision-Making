% Load MDP

lab4mdp;

% Compute optimal policy

Q = vi(M);

[~, Pol] = max(Q, [], 2);

% Run simulation

for sim = 1:100
    
    % X = <Uncomment and add initial state>;
    
    for t = 1:1000
        
        A = Pol(X);
        
        % <Add your code here. You should:
        %   - Generate a new state from X, A
        %   - Compute the corresponding reward
        %   - Update your reward averager for the initial state
    end    
end