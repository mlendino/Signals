%% Michael Lendino
%Problem 1c-h; 2d

%okay lets begin
clc;
clear all;

%% Question 1c
%use ss2tf to convert the state space realizations back to a transfer
%function and verify that the original H(z) is returned
b = [.2 .4 .5];
a = [1 .2 -.3];
[A,B,C,D] = tf2ss(b,a)
%% Question 1d
%Obtain A', B', C', D'; apply ss2tf to check that H(z) has not changed
a1 = transpose(A);
b1 = transpose(C);
c1 = transpose(B);
d1 = transpose(D);
[b11,a11] = ss2tf(a1,b1,c1,d1)
[b2,a2] = ss2tf(A,B,C,D)
%% Question 1e
%Now call tf2ss with H(z), return value matches both of the realizations
tf2ss(b,a)
%% Question 1f
%Start with the {A,B,C,D} realization from what tf2ss returned from H(z)
%and apply the following transformations A'=TAT^-1 B'=TB C'=CT^-1 D'=D; and
%use the symbolic toolbox to compute the transfer function
T = [ 3 7; 2 5];

A2 = T*A*inv(T);
B2 = T*B;
C2 = C*inv(T);
D2 = D;

[b22,a22] = ss2tf(A2,B2,C2,D2)

%% Question 1g
%So far we have three state space realizations A, A^T, and TAT^-1.  Compute
%the eigenvalues of each and the poles of H and check that they match
eigA = eig(A)
eigAT = eig(a1)
eigTAT1 = eig(A2)
[z,p,k] = tf2zp(b,a)
%% Question 1h 
%Take A, use the symbolic toolbox to compute z(zI-A)^-1, then iztrans to
%compute its inverse transform, which is A^n; then substitute n= 10 into
%this formula and compute A^n directly and compare/
syms z
test1 = z*inv((z*eye(2)-A));
A_n= iztrans(test1);

syms f(n)
f(n) = A_n;
ATen = double(f(10))
maxAbsError = max(max(abs(ATen - A^10)/(A^10)))
%% Question 2d
%computing e^At using matrix functional calculus
L = 5;
syms M t Y;
f = [exp(-5*t); t*exp(-5*t); t^(2)*exp(-5*t); exp(3*t); exp((-2+1j*6)*t); exp((-2-1j*6)*t)];
M = [1 -5 25 -125 625 -3125; 0 1 -10 75 -500 3125; 0 0 2 -30 300 -2500; 1 3 9 27 81 243; 1 (-2+1j*6)  (-2+1j*6)^2 (-2+1j*6)^3 (-2+1j*6)^4 (-2+1j*6)^5; 1 (-2-1j*6) (-2-1j*6)^2 (-2-1j*6)^3 (-2-1j*6)^4 (-2-1j*6)^5];
r = M*f

k = 0:L;
eAt = sum(r.*Y.^k)