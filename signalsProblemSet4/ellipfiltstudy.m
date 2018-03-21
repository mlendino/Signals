%% Michael Lendino
%Problem 5-6

%okay lets begin
clc;
close all;

%% Question 5
%display the filter order 2*n
filterOrder = 2*n;
%use zplane() to obtain pole-zero plot
zplane(b,a);
title('Analog Filter Transfer Function Poles and Zeros');
figure;
subplot(2,1,1);
%credit to ali rahman for informing me about mag2dB (we are given H)
%graphing magnitude of H on dB scale
plot(f, mag2db(abs(H)));
ylim([-100 10]);
ylabel('Magnitude of H (dB)');
hold on;
%dashed line for stopband region
plot(f, ones(size(f))*-rs, 'b--');
%used same color because both of the dashed lines are in the passband
%region
plot(f, zeros(size(f)), 'r--');
plot(f, ones(size(f))*-rp, 'r--');
hold off
title('Magnitude Frequency Response');
subplot(2,1,2);
%graphing the angle of H unwrapped in degrees with the frequency axis
%linear in Hertz from DC to fNyq
plot(f, unwrap(angle(H))*(180/pi));
xlabel('Frequency (Hz)');
ylabel('Phase (Degrees');
title('Frequency Response');

%time for the digital filter, display order=2*nd below
filterOrder = 2*nd;
figure;
%use zplane() to obtain pole-zero plot
zplane(bd,ad);
title('Digital Filter Transfer Function Poles and Zeros');
figure;
subplot(2,1,1);
plot(f, mag2db(abs(Hd)));
ylim([-100 10]);
ylabel('Magnitude of Hd (dB)');
hold on;
plot(f, ones(size(f))*-rs, 'b--');
%used same color because both of the dashed lines are in the passband
plot(f, zeros(size(f)), 'r--');
plot(f, ones(size(f))*-rp, 'r--');
hold off
title('Magnitude Frequency Response');
subplot(2,1,2);
plot(f, unwrap(angle(Hd))*(180/pi));
xlabel('Frequency (Hz)');
ylabel('Phase (Degrees)');
title('Frequency Response');
%% Question 6
%givens
fsamp = 150e6;
f0 = 20e6;
tau = 0.2e-6;
fNyq = fsamp/2
%creating the z,p,k values, as given in the problem statement
z1 = [0.8*exp((pi/6)*1j); 0.8*exp(-(pi/6)*1j)];
p1 = [0.9*exp((3*pi/4)*1j); 0.9*exp(-(3*pi/4)*1j)];
k1=1;
t = 0:50;
x = exp(-t./tau).*cos(2*pi*f0.*t);
%finding the transfer function from the z,p,k values
[b1,a1] = zp2tf(z1,p1,k1);
figure;
%using impz() to compute the impulse response
impz(b1,a1,51);

equal = linspace(0,fNyq,1000);
%using freqz() to compute the frequency response at 1000 equally spaced
%points from DC to the Nyquist Bandwidth
freqResp = freqz(b1,a1, equal, fsamp);

figure;
subplot(2,1,1);
%plotting the frquency response-magnitude response in dB
plot(equal, mag2db(abs(freqResp)));
ylabel('Magnitude (dB)');
title('Frequency Response Magnitude Response');
subplot(2,1,2);
%plotting the phase response unwrapped in degrees, frequency axis in Hz
plot(equal,unwrap(angle(freqResp))*(180/pi));
xlabel('Frequency (Hz)');
ylabel('Phase (Degrees)');
title('Phase Response Unwrapped');
%using filter to compute the first 51 samples of the output signal y(t)
y = filter(b1,a1,x);

figure;
subplot(2,1,1);
%stem plot for x[n]
stem(t,x);
title('Discrete Plots for x[n] and y[n]');
ylabel('x[n]');
subplot(2,1,2);
%stem plot for y[n]
stem(t,y);
xlabel('Discrete Samples n');
ylabel('y[n]');

figure;
subplot(2,1,1);
%continuous time plot for x(t)
plot(t,x);
title('Continuous Plots for x(t) and y(t)');
ylabel('x(t)');
subplot(2,1,2);
%continous time plot for y(t)
plot(t,y);
xlabel('Time (s)');
ylabel('y(t)');