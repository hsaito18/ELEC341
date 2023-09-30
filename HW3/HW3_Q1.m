%%%%%%%%%%%%%%%%%%%%
% Homework 3 Question 1
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

% Params
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

% Conversion to electrical
C0 = M0; % (F)
C1 = M1; % (F)
C2 = M2; % (F)
C3 = M3; % (F)

R20 = 1/B20; % (R)
R21 = 1/B21; % (R)
R31 = 1/B31; % (R)

L0 = 1/K0; % (H)
L1 = 1/K1; % (H)
L20 = 1/K20; % (H)
L32 = 1/K32; % (H)


s = tf('s');
% Impedance
zC0 = 1/(s*C0);
zC1 = 1/(s*C1);
zC2 = 1/(s*C2);
zC3 = 1/(s*C3);

zR20 = R20;
zR21 = R21;
zR31 = R31;

zL0 = s * L0;
zL1 = s * L1;
zL20 = s * L20;
zL32 = s * L32;

% Admittance
yC0 = 1/zC0;
yC1 = 1/zC1;
yC2 = 1/zC2;
yC3 = 1/zC3;

yR20 = 1/zR20;
yR21 = 1/zR21;
yR31 = 1/zR31;

yL0 = 1/zL0;
yL1 = 1/zL1;
yL20 = 1/zL20;
yL32 = 1/zL32;

Y = [yL0+yC0+yL20+yR20, 0, -yL20-yR20, 0; 0,yL1+yC1+yR31+yR21, -yR21, -yR31; -yL20-yR20, -yR21, yL20+yR20+yC2+yR21+yL32, -yL32; 0, -yR31, -yL32, yL32+yC3+yR31];
Y_inv = inv(Y);

% I vector
I = [1; 0; 0; 0];

% Solve for voltage vector
V = Y_inv * I;
intV = V / s;

% Display the 3 transfer functions that result
% Could have just omitted the ";" from the previous command
Q1.G1 = V(2)/s;
Q1.G3 = V(4)/s;

% Compute voltages
[v t] = step(V);
[d t2] = step(intV);

%%%%%%%%%%%%%%%%
% Plot
%%%%%%%%%%%%%%%%
% Plot all voltages together
figure(1); clf; hold on; grid on;
plot(t, v(:,1), 'k-',  'Linewidth', 3);
plot(t, v(:,2), 'b:',  'Linewidth', 3);
plot(t, v(:,3), 'r--', 'Linewidth', 3);
plot(t, v(:,4), 'g*', 'Linewidth', 3);
title('Node Voltages');
ylabel('Voltage (V)');
legend('Node 1', 'Node 2', 'Node 3','Node 4', 'Location', 'East');
set(gca, 'FontSize', 14);

figure(2); clf; hold on; grid on;
plot(t2, d(:,1), 'k-',  'Linewidth', 3);
plot(t2, d(:,2), 'b:',  'Linewidth', 3);
plot(t2, d(:,3), 'r--', 'Linewidth', 3);
plot(t2, d(:,4), 'g*', 'Linewidth', 3);
title('Distances');
ylabel('Distance (m)');
legend('Node 1', 'Node 2', 'Node 3','Node 4', 'Location', 'East');
set(gca, 'FontSize', 14);
