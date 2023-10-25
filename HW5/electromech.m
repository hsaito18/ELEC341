%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% electromech hw 5 Script
% This is a script to solve the last two questions for HW5.
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

Rw = A_sn/3; % (Ohm)
Lw = B_sn / 1000; % (H)

Jr = C_sn / 10000; % (Nms^2)
Br = D_sn / 1000; % (Nms)

Km = 50 * G_sn / 1000; % (Vs);
Km2 = 50 * G_sn / 1000; % (Vs);

% New Params
N = 5*2*pi; % rad/m
Js = A_sn * 20 / 1e6; % Nms^2
Mn = B_sn / 2; % kg
Bn = C_sn / 2; % Ns/m

Mt = M0+Mn+(Js+Jr)*N^2;

s = tf('s');

A = [(-B20-Bn-Br*N^2)/Mt, 0, B20/Mt, 0, -1/Mt, 0, 1/Mt, 0, Km/Mt*N; 
     0, (-B21-B31)/M1, B21/M1, B31/M1, 0, -1/M1, 0, 0, 0; 
     B20/M2, B21/M2, (-B20-B21)/M2, 0,0,0,-1/M2, 1/M2, 0;
     0, B31/M3, 0, -B31/M3, 0, 0, 0, -1/M3, 0;
     K0, 0, 0, 0, 0, 0, 0, 0, 0;
     0, K1, 0, 0, 0, 0, 0, 0, 0;
     -K20, 0, K20, 0, 0, 0, 0, 0, 0;
     0, 0, -K32, K32, 0, 0, 0, 0, 0;
     -Km*N/Lw, 0, 0, 0, 0, 0, 0, 0, -Rw/Lw];

B = transpose([0,0,0,0,0,0,0,0,1/Lw]);

C = [0,0,0,0,0,0,1,0,0];
D = [0];

B_2 = transpose([-(M0+Mn)/Mt, -1, -1, -1, 0, 0 ,0 ,0 ,0]*9.81);

Q4.G = tf(ss(A,B,C,D));
Q5.G = tf(ss(A,B_2,C,D));

superG = Q4.G*120 + Q5.G;
S = stepinfo(superG);
Q6.pv = -S.Peak;
