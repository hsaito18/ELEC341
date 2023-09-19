%%%%%%%%%%%%%%%%%%%%
% Homework 1 Question 5
%
% This is a script to solve Q5 of Homework 1.
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
% plot(t*1000, v(:,1), 'b-',  'Linewidth', 1);

min_p = -1111;
G_filter = G * (s * (-1)* min_p) /(s - min_p);

[v2, t2] = step(G_filter, time);

diffs = abs(v2 - yt);
max(diffs) / 125