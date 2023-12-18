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

% Q1.G = (11*s^3+387*s^2+1786*s + 2302)/(s^4 + 275.3*s^3 + 2463*s^2 + 8556*s + 8156);
G1 = A_sn/(s+B_sn);
G2 = (10*s + C_sn + 30)/(s + D_sn + 30);
H1 = (20*s + E_sn + 20)/(s + F_sn + 20);
H2 = (30*s + G_sn + 10)/(s + H_sn + 10);
G3 = G1/(1+G1*H1);
H3 = H2/(1+H2*G2);
Q1.G = G3/(1+G3*H3);

P = pole(Q1.G);
zeroes = zero(Q1.G);
% Compare P and zeroes.
% If any pair of poles/zeroes are basically the same, remove both.
% Then remove all poles that abs(real(p)) > abs(real(min_p))
zeroes = [-30,zeroes(7), zeroes(8)];
domPoles = [P(6), P(7), P(9)];
Gr = zpk(zeroes, domPoles,1);
Gr = Gr * dcgain(Q1.G)/dcgain(Gr);

Q2.p = domPoles;
Q2.z = zeroes;
Q2.Gr = Gr;

Q3.G2 = getFirstApprox(Q2.Gr);
Q4.err = getMaxError(Q1.G, Q3.G2)*100; 

K=171;

char_eq = 1 + K/(B_sn*s*(s+6)+(s+3)^2);

Q5.K = 171;
Q5.wn = 3;
Q5.Tr1 = (4.44*1-1.15)/(3);
Q5.taue = 2.1*1/3;

M = C_sn;
B = B_sn;
K = D_sn;
N = G_sn/5;
F2 = F_sn;
Kp = K*N^2;
Mp = M*N^2;
B1p = B*N^2;

C = Mp;
L = 1/Kp;
L2 = 1/K;
R2 = 1/B;
R0 = 1/B;
R1 = 1/B1p;

zR0 = R0;
zR1 = R1;
zC = 1/(s*C);
zL = s*L;
zL2 = s*L2;

yR0 = 1/zR0;
yR1 = 1/zR1;
yC = 1/zC;
yL = 1/zL;
yL2 = 1/zL2;

M = [[yR0+yR1+yC+yL, -yL]; [-yL, yR0+yL2+yL]];
I = [[1]; [0]];
V = inv(M)*I;
test = V(1);
Z22 = 1/(1/R2 + 1/(s*L2));
Z1 = s*L + Z22;
Zc = 1/(s*C);
R01 = 1/(1/R0 + 1/R1);
Zfinv = 1/Z1 + 1/Zc + 1/R01;
Zf = 1/Zfinv;

% Let's try statespace.
M3 = 0.00001;
A = [[(-B-B1p)/Mp, 0, -1/Mp, 0]; 
     [0, -B/M3, 1/M3, -1/M3]; 
     [Kp, -Kp, 0, 0];
     [0, K, 0, 0]];
B = [1/Mp;0;0;0];

C = [[1,0,0,0];[1/s,0,0,0]];

D = [0;0];

I = eye(4);

phi = inv(s*I - A);

aaa = C*phi*B + D;


% L_adj = 1/(K*N^2);
% C_adj = M*N^2;
% R_adj = 1/(B*N^2);
% 
% zC = 1/(s*C);
% zL = s*L;
% zR = R;
% zL_adj = s*L_adj;
% zC_adj = 1/(s*C_adj);
% zR_adj = R_adj;
% 
% Z1 = 1/(1/zR + 1/zL);
% Z2 = Z1/N^2 + zL;
% Z3 = 1/(1/Z2 + 1/zC + 1/zR);
% Z4 = 1/(1/R + 1/(Z3*N^2));

Q6.Z1 = 1/aaa(1);

fvG = aaa(2)*F2/N; % Why F2/N and not F2*N ???
Q6.fv = 201.775;


x1Submit
