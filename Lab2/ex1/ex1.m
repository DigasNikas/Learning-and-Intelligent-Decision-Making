n = 10000;
w1 = 0.6;
w2 = 0.4;
u1 = -0.2;
u2 = 5;
o1 = 2;
o2 = 3;
s = [];
x = [];
i = 1;
tic;
while i <= n
   u = rand;
   if u <= w1
       x = normrnd(u1,sqrt(o1));
   else 
       x = normrnd(u2,sqrt(o2));
   end
   s = union(s,x);
   i = i+1;
end

h = hist(s,100);
figure;
plot(h);
toc
%Elapsed time is 5.741782 seconds.%