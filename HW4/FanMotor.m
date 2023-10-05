%%%%%%%%%%%%%%%%%%%%
% Homework 4 Q3 and 4 Script
% This is a script to solve the last two problems in HW4.
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

% Parameters from HW 3
Rw = A_sn/3; % (Ohm)
Lw = B_sn / 1000; % (H)

Jr = C_sn / 10000; % (Nms^-2)
Br = D_sn / 1000; % (Nms)

Km = 50 * G_sn / 1000; % (Vs or Nm/A);

s = tf('s');

% Admittance Ye
zRw = Rw;
zLw = s*Lw;
zw = zRw + zLw;
ye = 1/zw;


Q3.Ye = ye;
Q3.Ym = ye;
Q3.G = ye;

Q4.G = ye;




