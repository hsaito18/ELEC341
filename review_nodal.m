%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Review of Nodal Analysis
% 
% I'm just trying to recreate (functionality wise) the nodal.m script.
% Note: All variables cleared when this is run.
% 
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; clc;

% Parameters
R1 = 200;
R2 = 500;
R3 = 300;
L1 = 1;
L2 = 2;
C1 = 1e-3;
C2 = 2e-3;

I = 5;

% Solving

s = tf('s');
yR1 = 1/R1;
yR2 = 1/R2;
yR3 = 1/R3;
yL1 = 1/(s * L1);
yL2 = 1/(s * L2);
yC1 = s*C1;
yC2 = s*C2;

Y = [yR1+yL1+yC1+yR3  -yR3            0
     -yR3              yR3+yR2+yC2   -yR2
     0                -yR2           yR2+yL2
     ];

I_vec = [0; I; 0];

V = inv(Y) * I_vec

[v, t] = step(V);

%%%%%%%%%%%%%%%%
% Plot
%%%%%%%%%%%%%%%%
% Plot all voltages together
figure(1); clf; hold on; grid on;
plot(t, v(:,1), 'k-', 'Linewidth', 3);
plot(t, v(:,2), 'b:', 'Linewidth', 3);
plot(t, v(:,3), 'r--', 'Linewidth', 3);
title('Node Voltages');
ylabel('Voltage (V)');
legend('Node 1', 'Node 2', 'Node 3', 'Location', 'East');
set(gca, 'FontSize', 14);
% Re-Plot voltage at node 1 by itself
figure(2); clf; hold on; grid on;
plot(t, v(:,1), 'k-', 'Linewidth', 3);
plot(t, v(:,3), 'r--', 'Linewidth', 3);
title('Node 1&3 Voltages');
ylabel('Voltage (V)');
legend('Node 1', 'Node 3', 'Location', 'East');
set(gca, 'FontSize', 14);

