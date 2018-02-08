%okay lets begin
clc;
clear all;
%superimpose sketch of x(t)
t = 0:0.0101:1;
%note that T=1 so it doesnt show up in the exponent, and also defines the
%bounds on which we graph the signal
x = exp(-2*pi*t);
%evaluating each point in t at x(t) and plotting x(t) 

%creating symbolic variable to use for the FS approx
syms m
a = (1 - exp(-2*pi))/(2*pi + j*2*pi*m)*exp(j*m*2*pi*t);
%using symsum to return the sum of the series with the terms that Re{c}
%specifies, where m is the symbolic value, up to the 5th harmonic, hence
% given by -5 and 5 for n; citing Kevin Lin for showing me how to use
% symsum
approximateX = symsum(real(a), m, -5, 5);
%plotting the sketch of x(t) and the APPROXIMATION using the series terms
plot(t, [x.', approximateX.'])
figure(1)
%title the graph
title('Sketch of Signal x(t) Versus the Series Terms Up to the Fifth Harmonic ')
%labelling the x and y-axis on the graph
xlabel('Time t (sec)')
ylabel('Signal x(t)')
legend('x(t) = exp(-2*pi*t) ', 'Approximation of x(t)') 
grid on

%next, we compute the maximum magnitude of the imaginary part
maximumImaginary = max(imag(approximateX))

%now we want a stem plot of the magnitude of c_n for n in [5,5], T=1
%creating our indices
n = -5:5;
%magnitude of fourier coefficients
cn = abs((1 - exp(-2*pi))./(2*pi + j*2*pi.*n));
figure(2)
%using stem() to create stem plot on the discrete interval for n in [-5,5]
%and plotting magnitude of fourier coefficients
stem(n,cn)
%labelling x and y axes and giving it a title
xlabel('n')
ylabel('Magnitude of the Fourier Coefficients')
title('Magnitude of Fourier Coefficients of x(t)')
