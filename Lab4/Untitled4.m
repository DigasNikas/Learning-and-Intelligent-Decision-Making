n = 10;

D = eye(n);
D = D * 0.4;

v(1:n-1) = 0.6;

D2 = diag(v, -1);


P{1} = D + D2;
P{1}(1,1) = 1;

D2 = diag(v, 1);


P{2}= D + D2;
P{2}(n,n)=1;