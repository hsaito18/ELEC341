%%%%%%%%%%%%%%%%%%%%
% Midterm
%
% This is a script to solve the ELEC 341 Midterm
% Note: All variables cleared when this is run
%
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

clear all; clc;
addpath '..'
save_student_number

s = tf('s');

Q1.G = (11*s^3+387*s^2+1786*s + 2302)/(s^4 + 275.3*s^3 + 2463*s^2 + 8556*s + 8156);

P = pole(Q1.G);
ndp = P(1);
domPoles = [P(2), P(3), P(4)];
zeroes = zero(Q1.G);
Gr = Q1.G*(s-ndp)*(-1/ndp);

Q2.p = transpose(domPoles);
Q2.z = zeroes;
Q2.Gr = minreal(Q1.G);

K=171;

char_eq = 1 + K/(B_sn*s*(s+6)+(s+3)^2);


M = C_sn;
B = B_sn;
K = D_sn;
N = G_sn/5;
F2 = F_sn;

C = M;
R = 1/B;
L = 1/K;
L_adj = 1/(K*N^2);
C_adj = M*N^2;
R_adj = 1/(B*N^2);

zC = 1/(s*C);
zL = s*L;
zR = R;
zL_adj = s*L_adj;
zC_adj = 1/(s*C_adj);
zR_adj = R_adj;

Z1 = 1/(1/zR + 1/zL);
Z2 = Z1/N^2 + zL;
Z3 = 1/(1/Z2 + 1/zC + 1/zR);
Z4 = 1/(1/R + 1/(Z3*N^2));

Q6.Z1 = Z4;
Q6.fv = 0.005;


Q5.K = 171;
Q5.wn = 3;
Q5.Tr1 = (4.44*1-1.15)/(3);
Q5.taue = 1/3;
x1Submit
