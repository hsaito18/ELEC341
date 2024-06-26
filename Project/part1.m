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
Tr = 0.72; % (s)
Tp = 1.6; % (s)
Ts = 4.65; % (s)
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
Na = 3/100/(2*pi); % m/rad
Jf = C_sn/3/100/100/1000 * 3; % kg-m^2
Bf = D_sn/1000 * 3; % Nms
Nf = 10 * 100*pi/180; % rad/m
Bt = E_sn/1000 * 3; % Nms
Kt = F_sn*30/1000 * 3; % Nm
Nt = 0.1; % m/rad sinx = x approx?
Bl = G_sn/5 * 3; % Ns/m
Kl = H_sn*15 * 3; % N/m


J1 = Jr + Js;

M1 = Mm + Ms;

Jt = J1 + Na^2*M1 + Na^2*Nf^2*Jf;

Bf_ = Bf*Na^2*Nf^2;
Bs_ = Bs*Na^2;

Ba = Bm + Bf_ + Bs_;

Kt_ = Kt*Na^2*Nf^2;
Bt_ = Bt*Na^2*Nf^2;
Kl_ = Kl*Na^2*Nf^2*Nt^2;
Bl_ = Bl*Na^2*Nf^2*Nt^2;

%%%%%
Ra = 1/Ba;
Rt = 1/Bt_;
Rl = 1/Bl_;
Ct = Jt;
Lt = 1/Kt_;
Ll = 1/Kl_;

zRa = Ra;
zRt = Rt;
zRl = Rl;
zCt = 1/(s*Ct);
zLt = s*Lt;
zLl = s*Ll;

yRa = 1/zRa;
yRt = 1/zRt;
yRl = 1/zRl;
yCt = 1/zCt;
yLt = 1/zLt;
yLl = 1/zLl;

Y = [yRa + yCt + yRt + yLt, -yRt-yLt;
     -yRt-yLt, yRt+yLt+yRl+yLl];
I_vec = [1;0];
V = inv(Y)*I_vec;
% R0 = 1/Ba;
% R1 = 1/Bt_;
% R2 = 1/Bt_;
% R3 = 1/Bt_;
% R4 = 1/Bl_;
% R5 = 1/Bl_;
% R6 = 1/Bl_;
% 
% L1 = 1/Kt_;
% L2 = 1/Kt_;
% L3 = 1/Kt_;
% L4 = 1/Kl_;
% L5 = 1/Kl_;
% L6 = 1/Kl_;
% 
% C1 = Jt;
% I = 1; %!!!
% 
% zR0 = R0;
% zR1 = R1;
% zR2 = R2;
% zR3 = R3;
% zR4 = R4;
% zR5 = R5;
% zR6 = R6;
% zL1 = s*L1;
% zL2 = s*L2;
% zL3 = s*L3;
% zL4 = s*L4;
% zL5 = s*L5;
% zL6 = s*L6;
% 
% zC1 = 1/(s*C1);
% 
% yR0 = 1/zR0;
% yR1 = 1/zR1;
% yR2 = 1/zR2;
% yR3 = 1/zR3;
% yR4 = 1/zR4;
% yR5 = 1/zR5;
% yR6 = 1/zR6;
% 
% yL1 = 1/zL1;
% yL2 = 1/zL2;
% yL3 = 1/zL3;
% yL4 = 1/zL4;
% yL5 = 1/zL5;
% yL6 = 1/zL6;
% 
% yC1 = 1/zC1;
% 
% Y = [yR0+yC1+yL1+yR1+yL2+yR2+yL3+yR3, -yL1-yR1, -yL2-yR2, -yL3-yR3; 
%     -yL1-yR1, yL1+yR1+yL4+yR4, 0, 0;
%     -yL2-yR2, 0, yL2+yR2+yR5+yL5, 0;
%     -yL3-yR3, 0, 0, yL3+yR3+yR6+yL6];
% I_vec = [I; 0; 0; 0];
% 
% V = inv(Y)*I_vec;
%%%%%

beta1 = -Kl_/(Bl_+Bt_);
beta2 = -1/(Bl_+Bt_);
beta3 = -Bt_/(Bl_+Bt_);

b1 = (Bt_*(beta3-1)-Ba)/Jt;
b2 = (1+beta2*Bt_)/Jt;
b3 = beta1*Bt_/Jt;

A = [-Rw/Lw, -Km/Lw, 0, 0;
     Km/Jt, b1, b2, b3;
     0, Kt_*(beta3-1), Kt_*beta2, Kt_*beta1;
     0, beta3, beta2, beta1];

B = transpose([1/Lw, 0, 0, 0]);

C = [Km, 0, 0, 0;
     0, Na/s, 0, 0;
     0, Na*Nf/s, 0, 0;
     0, (Bt_+Kt_/s)/Na/Nf/Nt, 0, (-Kl_-Bl_*s-Bt_*s-Kt_)/(Na*Nf*Nt)];

D = transpose([0,0,0,0]);

I = eye(size(A));

phi = inv((s*I - A));

M = C*phi*B + D;

testTF = V(1)*M(1)/s*Na;
vt_ = V(2)*M(1);

Q4.G = M(1);

% Q5.G = M(2);
Q5.G = testTF;

% Q6.G = M(3) * 180/pi;
Q6.G = testTF*Nf*180/pi;

% Q7.G = M(4)/3;
Q7.G = ((Bt_+Kt_/s)*V(1)*M(1) + (-Bt_-Kt_/s)*vt_)/(Na*Nt*Nf*3);

Q8.GH = Q2.G*Q6.G/Nf/Na*Q3.Kdc*Q3.D;

% p1Submit;



