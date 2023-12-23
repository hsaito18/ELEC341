clear all; clc; close all;
addpath '..';
ssn2;

fxDSPlot221(SN);
[t,v] = getFigData(1);
Tp = 0.05;
tau = getTimeConstant(t,v) / 1000;
Tr = getRiseTime(t,v) / 1000;
plotSettleLines(v)
Ts = 114.1/1000;
peak = 4.258;
OS = peak/3.3333-1;
[wnp, wnr, wns, zeta, beta] = getOmegaNs(Tp,Tr,Ts,OS);
wn = wns;
s = tf('s');
Ga = wn^2/(s^2+2*zeta*wn*s + wn^2) * 3.3333;
Ga_ans = 2.777e4/(s^2 + 70.08*s + 8280);

P1 = B_sn * 25;
P2 = C_sn * 25;
Ks = 3e6;
H1 = 1/(s+P1);
H2 = 1/(s+P2);

He_temp = H1/(H2+1);
He = Ks*He_temp/(1+He_temp)*H2;
He_ans = 3e6/(s^2 + 827*s + 1.708e5);

Rw = A_sn/3;
Lw = B_sn/5;
Km = (C_sn+D_sn)*10^-2;
Ye = 1/(s*Lw + Rw);

Bw = A_sn + B_sn;
Bm = (E_sn+F_sn)*1e-6;
Jm = G_sn*4e-6;
Dp = D_sn/100;
Jp = E_sn*7e-6;
Bp = F_sn*1e-5;
Mt = G_sn/2;
Kt = H_sn/2;
N = 2/Dp;

Jtot = Jp+Jm+Mt/N^2;
Btot = Bp+Bm + Bw/N^2;
Ktot = Kt/N^2;

Ctot = Jtot;
Rtot = 1/Btot;
Ltot = 1/Ktot;
zC = 1/(s*Ctot);
zR = Rtot;
zL = s*Ltot;

yB = 1/Btot;
yJ = 1/(s*Jtot);
yK = s*1/Ktot;

Ym = 1/(Btot + s*Jtot + Ktot/s);

Gm = feedback(Ym*Ye*Km, Km)*1/s;
Gm_ans = 1.866/(s^3 + 5.445*s^2 + 8.288*s + 1.869);

GH = Gm_ans * He_ans * Ga_ans;
Gp = Gm_ans*Ga_ans;

CF = C_sn *20;

Kf = 1/dcgain(He);

Nf = 3;
[Nws, ~] = generateWSCoefficients(Nf);
Nt = Nws + 1;
Df = CF/(Nt *s + CF);

H = He_ans * Kf * Df;

p = -2*CF;
Dp = -p/(s*(s-p));

Gol = Dp*Gp*H;

K0 = margin(Dp*Gp*H);
    
[gm, pm, wxo] = margin(K0*Gol);

zero = -wxo;

pdy = K0 * Dp * Gp * H;

[oz1, oz2, PM] = optimizeDoubleZero(zero, pdy, 0.001, deg2rad(0.1));

Dz = (s-oz1)*(s-oz2)/(oz1*oz2);
 
D = Dz * Dp;

K = 1;
Gol = K*D*Gp*H;
[gm,pm] = margin(Gol);

Kp = (1/(p) - (oz1+oz2)/(oz1*oz2))*K;
Kd = (1/(p)^2 - (oz1+oz2-p)/(p*(oz1*oz2)))*K;
Ki = K;

Kmaster = 1;