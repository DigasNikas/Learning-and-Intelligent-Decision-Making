NSTEPS = 1e4;

% = = Initialize the model = = %

M = MDProver;

% = = Initialize the model parameters to be learned = = %

% Pest : Estimation of the transition probabilities. Should be a cell array
%        with 6 elements, one for each action. Each cell element should be
%        a 14 x 14 matrix for the transition probabilities.
Pest = cell(1,6);

for i = 1:6
Pest{i} = eye(14,14);
end
% rest : Estimation of the reward function. Should be a matrix of 14 x 6 
%        elements 
rest = zeros(14,6);

% N    : Counter for the number of visits to each state-action pair. Should 
%        be a matrix of 14 x 6 elements
N = zeros(14,6);

% Q    : Q-function estimate. Should be a matrix of 14 x 6 elements.
Q = zeros(14,6);

% = = Compute optimal Q-function for comparison = = %

Qopt = vi(M);
[~, Popt] = max(Qopt, [], 2);

% = = Simulate trajectories = = %

% EQ   : Error in Q-function. Should be a vector with NSTEP elements.
EQ = zeros(1,NSTEPS);

% EP   : Error in policy. Should be a vector with NSTEP elements.
EP = zeros(1,NSTEPS);

% Select random initial state

X = randi(M.nS);

% Run learning cycle

h = waitbar(0, 'Running, please wait...');

for t = 1:NSTEPS
    
    % Select random action
    A = randi(M.nA);
    
    % . Update variables
    Xnew = find(cumsum(M.P{A}(X,:)) >= rand,1);
    Rnew = M.R(X,A); 
    N(X, A) = N(X, A) + 1;
    
    % . Update transition probabilities and reward

    Pest{A}(X,:) = (1 - 1/N(X,A)) * Pest{A}(X,:);
    Pest{A}(X,Xnew) = Pest{A}(X,Xnew) + 1/N(X,A);
    rest(X,A) = rest(X,A) + (1./N(X,A)) * (Rnew - rest(X,A));
    
    % . Update Q-function
    Q(X, A) = rest(X, A) + M.Gamma * (Pest{A}(X,:) * max(Q,[],2));
    
    % . Update policy
    [~,pol] = max(Q,[],2);
    
    % . Compute error in Q-function and policy
    
    EQ(t) = norm(Q - Qopt);
    EP(t) = norm(pol - Popt);
    
    X = Xnew;
    
    waitbar(t/NSTEPS, h);  
end

close(h);

% = = Plot learning curve = = %

figure(1);
clf;
plot(EQ);
xlabel('N. iterations');
ylabel('Error in Q-function');

figure(2);
clf;
plot(EP);
xlabel('N. iterations');
ylabel('Error in policy');

