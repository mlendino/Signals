%Michael Lendino
%Problem 4d

%okay lets begin
clc;
clear all;
%% Convolution
h = [2, -1, 2, 3, -1]
x = [-2, 4, 1, 1]
y = conv(h,x)
stem(-3:1:4, y)
xlabel('Discrete Variable n')
ylabel('Convolution')
title('Convolution of h and x')
legend('y = h*x') 
grid on