% = Activity 1 = %

fprintf('\n == Activities 1 and 2 == \n');

% Game reward matrices

A = [17,19;4,4;0,0];
B = [7,5;0,10;10,0];

% Equilibrium computation
 
E = LemkeHowson(A, B);

fprintf('Equilibrium strategy for agent 1: (%.1f, %.1f, %.1f)\n', E{1}(1),E{1}(2),E{1}(3));
fprintf('Equilibrium strategy for agent 2: (%.1f, %.1f)\n\n', E{2}(1),E{2}(2));

%Answer
%There is a pure(deterministic) equilibrium, both players find that doing
%the first action maximizes the reward taking into consideration they don't
%know eachother's action. It is an unique equilibrium.
% Equilibrium strategy for agent 1: (1.0, 0.0, 0.0)
% Equilibrium strategy for agent 2: (1.0, 0.0)

% = Activity 2 = %

fprintf('\n == Activities 3 to 5 == \n');

% Game reward matrices

A = [-1000,5;-5,-10];
B = [-100,-5;5,-10];

% Equilibrium computation
 
E = LemkeHowson(A , B);

fprintf('Equilibrium strategy for agent 1: (%.1f, %.1f)\n', E{1}(1),E{1}(2));
fprintf('Equilibrium strategy for agent 2: (%.1f, %.1f)\n', E{2}(1),E{2}(2));

%Answer

% Equilibrium strategy for agent 1: (1.0, 0.0)
% Equilibrium strategy for agent 2: (0.0, 1.0)
% The other equilibrium is: 
% Equilibrium strategy for agent 1: (0.0, 1.0)
% Equilibrium strategy for agent 2: (1.0, 0.0)
% There is a mixed equilibrium, and it is not unique.

% Compute value of equilibrium

V1 = E{1}'*A*E{2};
V2 = E{1}'*B*E{2};

fprintf('The value of the computed equilibrium for agent 1 is %.2f\n', V1);
fprintf('The value of the computed equilibrium for agent 2 is %.2f\n', V2);

% The value of the computed equilibrium for agent 1 is 5.00
% The value of the computed equilibrium for agent 2 is -5.00

% Non-deterministic equilibrium:

E{1} = [15./90;75./90];
E{2} = [15./990;975./990];

V1 = E{1}'*A*E{2};
V2 = E{1}'*B*E{2};

fprintf('The value of the computed equilibrium for agent 1 is %.2f\n', V1);
fprintf('The value of the computed equilibrium for agent 1 is %.2f\n', V2);

% The value of the computed equilibrium for agent 1 is -9.97
% The value of the computed equilibrium for agent 1 is -9.22
% This result differs from the one in the activity 4. This is expected
% since we are pivoting other equilibria.
