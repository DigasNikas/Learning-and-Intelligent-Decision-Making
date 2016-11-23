n = 10000;
w = 0.1;
w1 = 0.6;
w2 = 0.4;
u1 = -0.2;
u2 = 5;
o1 = 2;
o2 = 3;
i = 1;
s = [];
z(1) = 0.6;
tic;
while i <= n
    z1 = normrnd(z(i),w);
    pz1 = w1*(normpdf(z1,u1,sqrt(o1)))+w2*(normpdf(z1,u2,sqrt(o2)));
    pz = w1*(normpdf(z(i),u1,sqrt(o1)))+w2*(normpdf(z(i),u2,sqrt(o2)));
    y = min(1, (pz1/pz)*(normpdf(z(i),z1,w)/normpdf(z1,z(i),w)));
    if rand < y
        z(i+1) = z1;
    else 
        z(i+1) = z(i);
    end
    s = union(s,z1);
    i = i+1;
end 

h = hist(s,50);
figure;
plot(h)
toc

%Elapsed time is 6.071561 seconds.%
        