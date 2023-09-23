%%%%%%%%%%%%%%%%%%%%
% Homework 2 Question 4
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

% Params
ts = 750; % (ms);
zeta = 0.2155; % from Q1

sig = 3/(ts/1000);
wns = sig/zeta;

wns = 4/(zeta * ts/1000);

s = tf('s');

G = K * wns^2/(s^2 + 2*zeta*wns*s + wns^2);

Q4.Ts = ts;
Q4.wns = wns;
Q4.G = G;
