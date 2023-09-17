%%%%%%%%%%%%%%%%%%%%
% Homework 1 Question 1
%
% This is a script to solve Q1 of Homework 1.
%
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

%% Parameters
R1 = 10 * A_sn; % Ohm
L1 = B_sn * 1e-3; % H
C1 = C_sn * 1e-6; % F
R2 = D_sn * 10; % Ohm
L2 = E_sn * 1e-3; % H
C2 = F_sn * 1e-6; %F

s = tf('s');

zR1 = R1;
zL1 = s * L1;
zC1 = 1 / (C1 * s);
zR2 = R2;
zL2 = s * L2;
zC2 = 1 / (C2 * s);


%% OpAmp 1
z1 = (zC1 * zR1) / (zC1 + zR1);
z2_inv = 1/zR1 + 1/zC1 + 1/zL1;
z2 = 1/z2_inv;

tf1 = -z2/z1;

%% OpAmp 2
z3 = (zL2 * zR2) / (zL2 + zR2);
z4 = (zC2 * zR2) / (zC2 + zR2);

tf2 = -z4/z3;

tf = tf1*tf2;
Q1.G = tf;

