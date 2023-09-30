%%%%%%%%%%%%%%%%%%%%
% Homework 2 Question 6
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

% Params
tr = 355 - 39; % (ms)
zeta = Q5.zeta;
K = 264;

wn1 = (4.44*zeta - 1.15)/(tr/1000);
wn1 = 12;

s = tf('s');

G = K * wn1^2/(s^2 + 2*zeta*wn1*s + wn1^2);

Q6.Tr1 = tr;
Q6.wn1 = wn1;
Q6.G = G;
