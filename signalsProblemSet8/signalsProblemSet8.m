%Michael Lendino
%Problem Set 8

%okay lets begin
clc;
clear all;
%% Question 1
% a) x is ARMA
% b) innovations
% c) and d) see other paper
%% Draw the pole zero plot for the filter (input v, output x)
b = [1 0.4 0.3];
a = [1 -0.9 0.81];
[z,p,k] = tf2zp(b,a);
zplane(z,p)
title('Pole Zero Plot for the Filter')
grid on;
%% Generate N=10000 samples of v and then apply the filter to generate N samples of x
N = 10000;
V = sqrt(3)*randn(N,1);
X = filter(b,a,V);
%% m_0 = 5, use time averaging to ESTIMATE r_x(m) for m in [0,5]
for ii = 1:1:6
    rx(ii) = rEstimate(X,ii);
end
%% Generate the correlation matrix for x_M(n) involve r_x(m) for |m| <= m_0
R = toeplitz(rx);
%% Check that the correlation matrix is positive definite by computing its eigenvalues
eigenvalueR = eig(R);
%% Estimate Power Spectral Density 
[s_est, w] = pwelch(X, hamming(512), 256, 512);
%% 
Vw = exp(-2.*1j.*w) + (0.4).*exp(-1j.*w) + 0.3;
Xw = exp(-2.*1j.*w) + (-0.9).*exp(-1j.*w) + 0.81;
Hw = Vw./Xw;
Sxw = 3*abs(Hw).^2;
%normalize s_est and the actual Sxw so that they each avg value 1
s_est = s_est/mean(s_est);
Snorm = Sxw./mean(Sxw);
%superimpose graphs of them
figure;
grid on;
plot(w, s_est)
xlim([0,pi])
title('Approximated and Exact Power Spectral Density')
xlabel('Normalized Digital Radian Frequency')
hold on;
plot(w, Snorm)
legend('Approximate','Exact')
hold off;
%% Compare the angles of the poles of the filter H with the value w where Sxw has a peak
angp1 = angle(p(1)); % =1.0472
[peak, wpeak] = max(Sxw);
wpeak = w(wpeak); % =1.0308, which doesn't exactly match, but it's close
%% Question 10
%matrix A represents a collection of noisy measurements with underlying
%statistical properties we want to extract; we realize that each column
%viewed as a standalone random vector has the same correlation matrix R
%found above
v1 = X(6:end);
v2 = flip(X(1:6));
A = toeplitz(v2,v1);
%computing the singular values of A
sigma = svd(A);
%vector of values
values = sort((sigma.^2)./(N - 5))
sortEigen = sort(eigenvalueR)
%comparing the vector of values above to the eigenvalues of R
sortEigen - values;
%checking that the left singular values of A are the eigenvalues of R by
%taking U in the below line of code to be one of the singular values
[U,S,V] = svds(A);
%elementwise division of R*u over u, we see that all of the entries are
%ideally equal to the eigenvalues of R, put down there for reference again.
div = (R*U)./U
eigenvalueR

