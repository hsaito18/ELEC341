%%%%%%%%%%%%%%%%%%%%
% Homework 4 Q1 and 2 Script
% This is a script to solve the first two problems in HW4.
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

s = tf('s');

% Params
G1 = 1/(s+A_sn);
G2 = 10/(s+B_sn);
G3 = 10/(s+C_sn);
G4 = 10/(s+D_sn);
G5 = 1/(s+E_sn);

H1 = 100/(s+F_sn);
H2 = 500/(s+G_sn);

% Simplifications
% For Q1.G11
G7 = G2*H1*G4;
G8 = (G3+G7)*G5*H2;
tf1 = G2*G1/(G1*G8 + 1);

% For Q1.G12
G9 = G5*H2*-1*G1;
G10 = G9/(1-G3*G9);
G13 = G4*G10*G2;
G14 = -1*G13/(1-G13*H1);
tf2 = G14;

% For Q1.G21
G15 = G2*H1*G4;
G16 = G15 + G3;
G17 = G1*G16*G5;
G18 = G17/(1+G17*H2);
tf3 = G18;

% For Q1.G22
G19 = H1*G2;
G20 = -1*H2*G1;
G23 = G3*G20;
G24 = G19*G20;
G25 = G5/(1-G23*G5);
G26 = G4*G25;
G27 = -1*G26/(1-G26*G24);
tf4 = G27;

Q1.G11 = tf1;
Q1.G12 = tf2;
Q1.G21 = tf3;
Q1.G22 = tf4;

% For Q2.G1
G30 = G3 + G4*H1*G2;
tf5 = G1*G2*(1+G4*G5*H2)/(1+G5*H2*G1*G30);

% For Q2.G2
G31 = G2*H1*G1*H2*G5;
G32 = G3*G1*H2*G5;
G33 = G31*G4 + G32;
tf6 = G5*(G33/(H2*G5) - G4)/(1 + G33);

Q2.G1 = tf5;
Q2.G2 = tf6;


