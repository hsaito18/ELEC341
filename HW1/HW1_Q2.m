%%%%%%%%%%%%%%%%%%%%
% Homework 1 Question 2
%
% This is a script to solve Q2 of Homework 1.
%
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

save_student_number; 
%% Parameters
R1 = 10 * A_sn; % Ohm
L1 = B_sn * 1e-3; % H
C1 = C_sn * 1e-6; % F
R2 = D_sn * 10; % Ohm
L2 = E_sn * 1e-3; % H
C2 = F_sn * 1e-6; %F

zR1 = R1;
zL1 = s * L1;
zC1 = 1 / (C1 * s);
zR2 = R2;
zL2 = s * L2;
zC2 = 1 / (C2 * s);

yR1 = 1/zR1;
yL1 = 1/zL1;
yC1 = 1/zC1;
yR2 = 1/zR2;
yL2 = 1/zL2;
yC2 = 1/zC2;
yR3 = yR2;
yL3 = yL2;
yC3 = yC2;


Y = [yR2+yL2, -yL2, -yR2, 0, 0, 0; -yL2, yL2+yC2, 0, 0, -yC2, 0; -yR2, 0, yR2 + yR3, -yR3, 0, 0; 0, 0, -yR3, yR3 + yL3 + yR1 + yL1, -yL3, -yR1; 0, -yC2, 0, -yL3, yC2 + yL3 + yC3, 0; 0, 0, 0, -yR1, 0, yR1 + yC1];
Y_inv = inv(Y);

Y_inv_v4 = Y_inv(4,3);
Y_inv_v6 = Y_inv(6,3);

tf = yL1*Y_inv_v4 + yR1 * (Y_inv_v4 - Y_inv_v6)

Q2.G = tf;