function [f] = boundary(f, w, l)
%BOUNDARY   Adds new decision boundary to data plot
%   BOUNDARY(F, W) adds a new linear decision boundary to the current plot 
%   in figure F. W is a 3-dimensional weight vector, where the component
%   W(1) corresponds to the bias term.
%
%   BOUNDARY(F, W, L) also adds to the current legend the entry L.

% Parse figure handle

if strcmp(get(0,'defaultaxeslinestyleorder'), '-')
    set(0, 'defaultaxeslinestyleorder', {'-', '--', ':', '-.', ...
            '-+', '-o', '-*', '-x', ...
            '--+', '--o', '--*', '--x', ...
            ':+', ':o', ':*', ':x', ...
            '-.+', '-.o', '-.*', '-.x'});
end

try
    figure(f);
    newplot = false;
catch
    fprintf('boundary: invalid figure handle: resetting figure 1.\n');
    newplot = true;
end

% Parse weight vector

try
    w0 = w(1);
    wx = w(2);
    wy = w(3);
catch
    error('boundary: invalid weight vector');
end

% Parse legend

if nargin == 2
    l = 'New plot';
end

% Plot

if newplot

    % Adjust to existing plot
    if wy ~= 0
        xx = [0, 1];
        yy = -w0 / wy - wx * xx / wy;
    elseif wx ~= 0
        yy = [0, 1];
        xx = -w0 / wx - wy * yy / wx;
    else
        error('boundary: invalid weight vector');
    end
    
    plot(xx, yy);
else
    
    % Adjust to existing plot
    a = axis;
    xx = a(1:2);
    yy = -w0 / wy - wx * xx / wy;
    
    plot(xx, yy);
    %axis(a);
    
    % Update legend
    c = get(f, 'Children');
    leg = [];
    
    for i = 1:length(c)
        if isa(c(i), 'matlab.graphics.illustration.Legend')
            leg = c(i);
            break;
        end
    end
    
    if isempty(leg)
        legend(l);
    else
        leg = get(leg, 'String');
        leg = [leg l];
        legend(leg);
    end
end
        