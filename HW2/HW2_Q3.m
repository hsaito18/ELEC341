%%%%%%%%%%%%%%%%%%%%
% Homework 2 Question 3
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

% Params
tp = 370; % (ms)
zeta = 0.2155; % from Q1

wnp = pi/(tp/1000);

s = tf('s');

G = K * wnp^2/(s^2 + 2*zeta*wnp*s + wnp^2);

Q3.Tp = tp;
Q3.wnp = wnp;
Q3.G = G;