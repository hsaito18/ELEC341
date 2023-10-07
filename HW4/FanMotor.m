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

% Parameters from HW 4
Jg = A_sn * 50 / 1e6; % (Nms^2)
Bg = B_sn * 10 / 1000; % (Nms)
Jf = C_sn / 1000; % (Nms^2)
Bf = D_sn * 20 / 1000; % (Nms)
N = 2;
N_squared = 4;

s = tf('s');

% Admittance Ye
zRw = Rw;
zLw = s*Lw;
zw = zRw + zLw;
ye = 1/zw;

% "Admittance" Ym
Rr = 1/Br;
Cr = Jr;
Rg = 1/(N_squared*Bg);
Cg = N_squared*Jg;
Rf = 1/(N_squared*Bf);
Cf = N_squared*Jf;

zRr = Rr;
zCr = 1/(s*Cr);
zRg = Rg;
zCg = 1/(s*Cg);
zRf = Rf;
zCf = 1/(s*Cf);
invZm = 1/zRr + 1/zCr + 1/zRg + 1/zCg + 1/zRf + 1/zCf;
zm = 1/invZm;
Ym = zm;

G = feedback(ye*Km*Ym, Km);
G2 = feedback(ye, Km*Ym*Km);

Q3.Ye = ye;
Q3.Ym = Ym;
Q3.G = G;

Q4.G = G2;




