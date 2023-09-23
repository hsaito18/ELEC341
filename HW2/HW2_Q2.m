%%%%%%%%%%%%%%%%%%%%
% Homework 2 Question 2
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

% Params
tr = 135; % ms
zeta = 0.2155; % from Q1
K = 28;

wnr = 1.8/(tr /1000); % approximation

s = tf('s');

G = K * wnr^2/(s^2 + 2*zeta*wnr*s + wnr^2);

Q2.Tr = tr;
Q2.wnr = wnr;
Q2.G = G;