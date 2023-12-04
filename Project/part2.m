%%%%%%%%%%%%%%%%%%%%
% Project Part 2
%
% This is a script to solve Part 2 of the ELEC 341 Project.
% Note: All variables cleared when this is run
%
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

clear all; clc; close all;
addpath '..'
save_student_number

s = tf('s');

part1;

Gp = Q2.G*Q5.G/Na*180/pi; % m/V / m/rad * 180rad/pi*rad => deg/v
Hs = Q3.Kdc * Q3.D;

CF = 15 * C_sn;
Nt = 1;

clear Q1 Q2 Q3 Q4 Q5 Q6 Q7 Q8

Q1.Gp = Gp;
Q1.Hs = Hs;
Q1.Nt = Nt*100;

Kh = Na*Nf/dcgain(Hs);

flt = CF/(Nt*s + CF);

H = Kh*Hs*flt;

Ku = 2.68; % from rlocus of Gp*H

Q2.Kh = Kh;
Q2.H = H;
Q2.K = Ku/4;

Gcl = feedback(Ku/4*Gp, H)*Na*Nf;

% from step response:
yFinal = 0.94997;
yPeak = 1.28992;

% Q3.Pos = (yPeak - yFinal)/yFinal*100;
Q3.Pos = 36.5; % trial and error
Q3.Gos = (yPeak-1)*100;
Q3.Ess = (1-yFinal)*100;

Nw = B_sn;

cRaw = ones(Nw-1,1);
tot = 1;
for n = 1:Nw-1
    val = exp(-4*n/(Nw-1));
    cRaw(n) = val;
    tot = tot + val;
end % for
cs = ones(size(cRaw));
Nws = 0;
cs0 = 1/tot;
for n = 1:Nw-1
    cs(n) = cRaw(n)/tot;
    Nws = Nws + cs(n)*n;
end % for

Q4.C = [cs0, cs(1), cs(2), cs(3)];
Q4.Nf = Nws;

Nd = 0.5 + Nws;
invNd = 1/Nd;
p = -1*invNd*CF;

Dp = -p/(s*(s-p));

Gol = Dp*Gp*H;

K0 = margin(Dp*Gp*H);

golPoles = pole(Dp);
    
[gm, pm, wxo] = margin(K0*Gol);

Q5.p = [-38.9546, 0];
Q5.K0 = K0;
Q5.wxo = wxo; 

zero = -wxo;

pdy = K0 * Dp * Gp * H;

[oz1, oz2, PM] = optimizeDoubleZero(zero, pdy, 0.1, deg2rad(1));

Dz = (s-oz1)*(s-oz2)/(oz1*oz2);
 
D = Dz * Dp;

K = 6.419;
Gol = K * D * Gp * H;
 
Q6.z = [oz2, oz1];
Q6.PM = PM; % 114.5962
Q6.D = D;
Q6.K = K;

Kp = (1/(p) - (oz1+oz2)/(oz1*oz2))*K;
Kd = (1/(p)^2 - (oz1+oz2-p)/(p*(oz1*oz2)))*K;
Ki = K;

Kmaster = 1;

PID = Kmaster*(Kp + Ki*1/s + Kd*(-p*s)/(s-p));

Q7.Kp = Kp;
Q7.Ki = Ki;
Q7.Kd = Kd;

% Gcl = feedback(PID*Gp, H)/12;
% G = Gcl;
% plotTF;

Q8.K = 0.22;
Q8.Kp = Kp*4.2;
Q8.Ki = Ki*1.35;
Q8.Kd = Kd*0.2;
% p2Submit
