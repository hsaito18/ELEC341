%%%%%%%%%%%%%%%%%%%%
% Homework 1 Question 4
%
% This is a script to solve Q4 of Homework 1.
%
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%
clf;
a1DSPlot(19177062, 1)

sigma = Q3.sigma;

Kdc = 3.6125;

G = Kdc * (25 * sigma^2)/(s^2 - 2*sigma*s + 25*sigma^2);

time = linspace(0, 1, 1000);

[v, t] = impulse(G, time);

figure(1); hold on; grid on;
plot(t*1000, v(:,1), 'b-',  'Linewidth', 1);

min_p = -91.5;
G_filter = G * s*91.5/(s - min_p);

[v2, t2] = step(G_filter, time);
plot(t2*1000, v2, 'r.', 'Linewidth', 3);

Q4.p = min_p;
Q4.err = 38;