%%%%%%%%%%%%%%%%%%%%
% Homework 3 Question 3
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

% Parameters
Rw = A_sn/3; % (Ohm)
Lw = B_sn / 1000; % (H)

Jr = C_sn / 10000; % (Nms^-2)
Br = D_sn / 1000; % (Nms)

Km = 50 * G_sn / 1000; % (Vs);
Km2 = 50 * G_sn / 1000; % (Vs);

% Converting to electrical

Cr = Jr;
Rr = 1/Br;

s = tf('s');

p1 = s * Cr + 1/Rr;
p1frac = p1/Km2;
p2 = s*Lw + Rw;
term1 = p1frac*p2;

tf1 = 1/(term1 + Km);
tf2 = tf1*p1/Km2;
Q3.G = tf1;
Q4.G = tf2;