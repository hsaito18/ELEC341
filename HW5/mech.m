%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mech hw 5 Script
% This is a script to solve the first two questions for HW5.
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

% Params from HW3
M0 = A_sn/5; % (kg)
M1 = B_sn/10; % (kg)
M2 = C_sn/10; % (kg)
M3 = D_sn/5; % (kg)

B20 = E_sn/2; % (Ns/m)
B21 = F_sn/3; % (Ns/m)
B31 = G_sn/4; % (Ns/m)

K0 = A_sn; % (N/m)
K1 = B_sn; % (N/m)
K20 = C_sn; % (N/m)
K32 = D_sn/3; % (N/m)

s = tf('s');

A = [-B20/M0, 0, B20/M0, 0, -1/M0, 0, 1/M0, 0; 
     0, (-B21-B31)/M1, B21/M1, B31/M1, 0, -1/M1, 0, 0; 
     B20/M2, B21/M2, (-B20-B21)/M2, 0,0,0,-1/M2, 1/M2;
     0, B31/M3, 0, -B31/M3, 0, 0, 0, -1/M3;
     K0, 0, 0, 0, 0, 0, 0, 0;
     0, K1, 0, 0, 0, 0, 0, 0;
     -K20, 0, K20, 0, 0, 0, 0, 0;
     0, 0, -K32, K32, 0, 0, 0, 0;];

B = [1/M0;0;0;0;0;0;0;0];

C = [0,0,0,1/s,0,0,0,0;
     0,0,0,0,0,1,0,0];

D = [0;0];

I = eye(size(A));

phi = inv(s*I - A);

M = C*phi*B + D;

Q1.A = A;
Q1.B = B;

Q2.G = M(1);
Q3.G = M(2);