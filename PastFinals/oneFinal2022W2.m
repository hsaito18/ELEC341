clear all; clc; close all;
addpath '..';
ssn2;

xfDS222(SN);
[t,v] = getFigData(1);
Tp = 16.6 / 1000;
tau = getTimeConstant(t,v) / 1000;
Tr = getRiseTime(t,v) / 1000;
plotSettleLines(v)
Ts = 28.3/1000;
peak = (2.25678 + 2.25724)/2;
OS = peak/v(end)-1;
[wnp, wnr, wns, zeta, beta] = getOmegaNs(Tp,Tr,Ts,OS);
wn = wnp;
s = tf('s');
Ga = wn^2/(s^2+2*zeta*wn*s + wn^2) * v(end);
Ga_ans = 7.352e4/(s^2 + 147.1*s + 4.231e4);

K_s = 100000;
G_s = s + (A_sn * 25);
H1 = s/15 + B_sn;
H2 = s^2 + (C_sn * 50 * s) + D_sn*E_sn*5000;
x1s = 1/(1+H1);
x2s = 1/(1+H2);
Hs = K_s*x1s*G_s*x2s;

J1 = F_sn * 2e-6;
J2 = G_sn * 2e-5;
J3 = H_sn * 2e-4;
Bg = D_sn;
Bp = E_sn * 20;
Bm = (E_sn+F_sn)*1e-6;
Jm = G_sn * 3e-6;
Km = (C_sn + D_sn)*1e-2;
Lw = B_sn*10/1000;
Rw = A_sn/2;

Jt = J1 + Jm + J2/3^2 + J3/3^2/3^2;
Bt = Bm + Bg/3^2 + (Bp+Bg)/3^2/3^2;
Kt = 0;

A = [[-Rw/Lw, -Km/Lw];
     [Km/Jt, -Bt/Jt]];
B = [1/Lw; 0];
C = [0, 1];
D = 0;
M = statespace(A,B,C,D);
Gm = M(1);
Gs = M(1)*Ga_ans;
Gs_ans = 2.353e4/(2.658e-5*s^4 + 0.8153*s^3 + 166.1*s^2 + 4.104e4*s + 1.932e6);

GH = Gs * 1/3 * Hs;
GH_ans = (1.176e10 + 5.293e12)/(2.658e-5 * s^7 + 0.8447*s^6 + 1099*s^5 + 1.203e6 * s^4 + 4.48e8*s^3 + 9.235e10*s^2 + 1.251e13 * s + 4.803e14);

Ns = D_sn;
Nd = D_sn + E_sn;
CF = C_sn * 20;

Nshat = generateWSCoefficients(Ns);
Ndhat = generateWSCoefficients(Nd);

Kf = 1/dcgain(Hs)/3;
Nt = 1+Nshat;
Df = CF/(Nt*s + CF);

H = Hs*1/3*Kf*Df;
Nd = 0.5 + Ndhat;
invNd = 1/Nd;
p = -1*invNd*CF;
Dp = -p/(s*(s-p));
Dp = 116.93/(s*(s+116.93));
Gol = Dp*Gs*H;
K0 = margin(Gol);
[gm, pm , wxo] = margin(Gol*K0);
pdy = K0 * Dp * Gs* H;
zero = -wxo;
[oz1, oz2, PM] = optimizeDoubleZero(zero, pdy, 0.1, deg2rad(1));
Dz = (s-oz1)*(s-oz2)/(oz1*oz2);
D = Dz * Dp;
K = 6.419;
Gol = K * D * Gs * H;

Kp = (1/(p) - (oz1+oz2)/(oz1*oz2))*K;
Kd = (1/(p)^2 - (oz1+oz2-p)/(p*(oz1*oz2)))*K;
Ki = K;

Kmaster = 1;