%%%%%%%%%%%%%%%%%%%%
% Project Part 1
%
% This is a script to solve Part 1 of the ELEC 341 Project.
% Note: All variables cleared when this is run
%
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

clear all; clc;
addpath '..'
save_student_number

s = tf('s');

% Parameters
FV = 15.9; % (V)
Tr = 0.72/1000; % (s)
Tp = 1.6/1000; % (s)
Ts = 4.65/1000; % (s)
peak = 19.9; % (V)

pos = abs(peak - FV)/FV * 100;

zeta = sqrt((log(pos/100)^2)/(pi^2+log(pos/100)^2));
beta = sqrt(1-zeta^2);

wnp = pi/(beta*Tp);
wnr = 1/(beta*Tr)*(pi-atan(beta/3));
wns = 1/(zeta*Ts)*log(50/beta);
wn = (wnp+wns+wnr)/3;
wn = 2.5e3;

Kdc = FV;

G = Kdc*wn^2/(s^2+2*zeta*wn*s + wn^2);

% Sensor Block Diagram Calculations
G1 = A_sn*7/(s + B_sn*800);
G2 = C_sn*8/(s + D_sn*700);
G3 = 10^5/(s+E_sn*600);
G4 = F_sn*50/(s+G_sn*500);
H1 = 4/(s+H_sn*5);

G5 = 1+G3*G4*H1;
Hs = (G1*G2 + G2*G3/G5)/(1+G2*G3*H1/G5);
[zeroes, gain] = zero(Hs);
Hs = Hs/gain;

Q1.Tr = Tr;
Q1.Tp = Tp;
Q1.Ts = Ts;
Q1.Pos = pos;

Q2.G = G;

Q3.Kdc = gain;
Q3.D = Hs;

p1Submit;




