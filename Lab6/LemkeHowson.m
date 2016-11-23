function [nashEqbm] = LemkeHowson(A, B, varargin)
% LEMKEHOWSON   Sample Nash equilibrium for 2-player games
%
%   E = LEMKEHOWSON(A, B) computes a sample mixed strategy Nash equilibrium
%   in a bimatrix game using the Lemke-Howson complementary pivoting 
%   algorithm, where A and B are the payoff matrices for the row and 
%   colymn player, respectively. It returns a 2 x 1 cell array E, where 
%   E{1} and E{2} are vectors containing the mixed strategies for the row
%   and column players, respectively.
%   strategies for the row and column player, respectively.
%
%   E = LEMKEHOWSON(A, B, k0) takes as additional input an initial pivot in
%   the set {1,...,m+n} (default = 1).
%
%   E = LEMKEHOWSON(A, B, k0, maxPivots) additionally allows the 
%   specification of the maximum number of pivoting steps before 
%   termination (default = 500000).
    
    % Parse input arguments

    if any(size(A) ~= size(B))
        error('Matrix dimensions must agree.');
    end

    [m, n] = size(A);    
    size_  = [m, n];

    if nargin > 2
        k0 = varargin{1};
        
        if (k0 < 1) || (k0 > m + n)
            error('Invalid initial pivot.');
        end
    else
        k0 = 1;
    end

    if nargin > 3
        maxPivots = varargin{2};

        if maxPivots < 1
            error('Maximum pivots parameter must be a positive integer.');
        end
    else
        maxPivots = 5e5;
    end

    % Scale payoffs to be strictly positive
    
    minVal = min( min(min(A)), min(min(B)) );
    
    if minVal <= 0
        A = A + ones(size(A)) * (1 - minVal);
        B = B + ones(size(A)) * (1 - minVal);
    end

    % Build Tableaus
    Tab = cell(2, 1);
    Tab{1} = [B',     eye(n), ones(n,1)];
    Tab{2} = [eye(m), A,      ones(m,1)];

    % Declare row labels
    rowLabels = cell(2,1);
    rowLabels{1} = m+1:m+n;
    rowLabels{2} = 1:m;

    % Do complementary pivoting
    k = k0;
    if k0 <= m
        player = 1;
    else
        player = 2;
    end

    % Pivoting loop
    numPiv = 0;
    while numPiv < maxPivots

        numPiv = numPiv+1;

        % Use correct Tableau
        LP = Tab{player};
        [m_, ~] = size(LP);

        % Find pivot row (variable exiting)
        max_ = 0;
        ind = -1;
        for i = 1:m_
            t = LP(i,k) / LP(i, m+n+1);
            if t > max_
                ind = i;
                max_ = t;
            end
        end

        if max_ > 0
            Tab{player} = pivot(LP, ind, k);
        else
            break;
        end

        % swap labels, set entering variable
        temp = rowLabels{player}(ind);
        rowLabels{player}(ind) = k;
        k = temp;

        % If the entering variable is the same
        % as the starting pivot, break
        if k == k0
            break;
        end

        % update the tableau index
        if player == 1
            player = 2;
        else
            player = 1;
        end

    end

    if numPiv == maxPivots
        error(['Maximum pivot steps (' num2str(maxPivots) ') reached!']);
    end

    % Extract the Nash equilibrium
    nashEqbm = cell(2,1);

    for player = 1:2

        x = zeros(size_(player), 1);
        rows = rowLabels{player};
        LP = Tab{player};

        for i = 1:length(rows)
            if player == 1 && rows(i) <= size_(1)
                x(rows(i)) = LP(i,m+n+1) / LP(i,rows(i));
            elseif player == 2 && rows(i) > size_(1);
                x(rows(i)-size_(1)) = LP(i,m+n+1) / LP(i,rows(i));
            end
        end

        nashEqbm{player} = x/sum(x);

    end

end

function B = pivot(A, r, s)
% PIVOT Pivots a table on a given row and column
%
%   B = PIVOT(A, i, j) pivots table A on row i, column j.
    
    [m, ~] = size(A);
    B = A;
    
    for i = 1 : m
        if i == r
            continue;
        else
            B(i,:) = A(i,:) - A(i,s) / A(r,s) * A(r,:);
        end
    end
    
end