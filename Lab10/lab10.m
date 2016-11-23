NSTEPS = 1e4;
STEP   = 0.2;

% = = Initialize the model = = %

M = MDProver;

%                          %
% ---> PART I : TD(0) <--- %
%                          %

% = = Initialize policy = = %

Pol = [2, 4, 2, 2, 4, 2, 2, 4, 4, 2, 4, 5, 3, 2];

% = = Initialize V function = = %

% V : Estimate for Vpi. Should be a matrix of 14 x 1 elements.

V = zeros(14,1);

% = = Simulate trajectories = = %

% Select random initial state
X = randi(M.nS);

% Run learning cycle

h = waitbar(0, 'Running, please wait...');

for t = 1:NSTEPS
    
    % . Select action using policy

    A = Pol(X);
    

    % . Select variables

    Xnew = find(cumsum(M.P{A}(X,:)) >= rand,1);
    Rnew = M.R(X,A); 
    

    % . Update V
    
    V(X) = V(X) + STEP * (Rnew + M.Gamma * V(Xnew) - V(X));


    % . Update state X - randomly reset if goal is reached
    
    if (X == 12)
        X = randi(M.nS);
    else
        X = Xnew;
    end
    
    waitbar(t/NSTEPS, h);  
end

close(h);

%                                %
% ---> PART II : Q-learning <--- %
%                                %

% = = Initialize Q function = = %

% Q : Q-function estimate. Should be a matrix of 14 x 6 elements. 
Q = zeros(14,6);

% = = Simulate trajectories = = %

% Select random initial state
X = randi(M.nS);

% Run learning cycle

h = waitbar(0, 'Running, please wait...');

for t = 1:NSTEPS
    
    % . Select random action
    
    A = randi(M.nA);
    

    % . Update variables
    
    Xnew = find(cumsum(M.P{A}(X,:)) >= rand,1);
    Rnew = M.R(X,A);
    

    % . Update Q

    Q(X,A) = Q(X,A) + STEP * (Rnew + M.Gamma * max(Q(Xnew, :) - Q(X,A)));
   

    % . Update state X
    
    X = Xnew;

    waitbar(t/NSTEPS, h);  
end

close(h);

% Resposta
% Q-Learning devolve no final de N iterções aquela que é a Optimal
% Q-Function. A nossa Q-Learning faz uso de uma política random e no final
% chegamos a uma Q-Function que origina a politica representada na Fig2, que por sua vez é a
% política utilizada no TD(0). Assim podemos concluir, com a ajuda do
% Q-Learning, que a política na fig2 é uma política óptima.




