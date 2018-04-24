%Michael Lendino
%Problem 5d

%okay lets begin
clc;
clear all;
%% unit step response
numH1 = [0 1 2];
numH2 = [0 -1 2];
denom = [1 4.8 4];
%s=tf(num,den) returns a 'transfer function object'; here we create one for
%each of the above systems
H1 = tf(numH1, denom);
H2 = tf(numH2, denom);
%Now we compute the unit step response [y,t] = step(s) generates the values
%of the unit step response y at times t (it automatically determines a set
%of reasonable times)
[yH1, tH1] = step(H1);
[yH2, tH2] = step(H2);
%Use step to compute the unit step response of each system and superimpose
%them
figure
plot(yH1,tH1,yH2,tH2)
xlabel('Time (s)')
ylabel('Unit Step Response')
title('Unit Step Response of H1(s) and H2(s) in y at times t')
legend('H1(s)', 'H2(s)')
grid on;
