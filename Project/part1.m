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

%% Approximation
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

%% Sensor Block Diagram Calculations
G1 = A_sn*7/(s + B_sn*800);
G2 = C_sn*8/(s + D_sn*700);
G3 = 10^5/(s+E_sn*600);
G4 = F_sn*50/(s+G_sn*500);
H1 = 4/(s+H_sn*5);

G5 = 1+G3*G4*H1;
Hs = (G3/G5 + G1)/(1/G2 + H1*G3/G5);
gain = dcgain(Hs); % mV/deg

Q1.Tr = Tr;
Q1.Tp = Tp;
Q1.Ts = Ts;
Q1.Pos = pos;

Q2.G = G;

Q3.Kdc = gain / 1000; % V/deg
Q3.D = Hs / gain;

%% System Model
% Parameters
Rw = A_sn/2; % R
Lw = B_sn*30/1e6; % H
Km = C_sn/1000; % Nm/A
Mm = (D_sn + E_sn)/1000; % kg
Bm = F_sn/30/1e6; % Nms
Jr = G_sn/15/100/100/1000; % kg-m^2
Js = H_sn/5/100/100/1000; % kg-m^2
Ms = A_sn/4/1000; % kg
Bs = B_sn/3; % Ns/m
Na = 3/100; % m/deg
Jf = C_sn/3/100/100/1000; % kg-m^2
Bf = D_sn/1000; % Nms
Nf = 10 * 100; % deg/m
Bt = E_sn/1000; % Nms
Kt = F_sn*30/1000; % Nm
Nt = 0.1; % m/deg sinx = x approx???
Bl = G_sn/5; % Ns/m
Kl = H_sn*15; % N/m

Bt_ = Na^2*Nf^2*Bt;

J1 = Jr + Js;

M1 = Mm + Ms;

Jt = J1+Na^2*M1 + Na^2*Nf^2*Jf;

alpha = 1/(Nt*Bl + Bt/Nt);
beta = Bt/(Nt*Bl + Bt/Nt);
charlie = -Nt/(Nt*Bl + Bt/Nt);

a1 = -Bm-Na^2*Bs-Na^2*Nf^2*Bf+Na^2*Nf^2*Bt*Nf*Na/Nt*(beta-1);
a2 = -1 + Bt*Na^2*Nf^2*alpha/Nt;
a3 = Bt*Na^2*Nf^2*charlie/Nt;

b1 = Kt*Na*Nf*(1-beta/Nt);
b2 = -Kt/Nt*alpha;
b3 = -Kt/Nt*charlie;

c1 = Kl * alpha;
c2 = Kl*beta*Na*Nf;
c3 = Kl*charlie;

d1 = ((1-beta/Nt)*Bt_*Na*Nf)/Nt;
d2 = (1-Bt_/Nt*alpha)/Nt;
d3 = -Bt_/Nt*charlie/Nt;

A = [-Rw/Lw, -Km/Lw, 0, 0;Km/Jt, a1/J1, a2/J1, a3/J1; 0, b1, b2, b3; 0, c1, c2, c3];

B = [1/Lw;0;0;0];

C = [Km,0,0,0; 0,Na/s,0,0;0,Na*Nf/s,0,0;0,d1,d2,d3];

D = [0;0;0;0];

I = eye(size(A));

phi = inv((s*I - A));

M = C*phi*B + D;

Q4.G = M(1,1);

Q5.G = M(2,1);
p1Submit;



