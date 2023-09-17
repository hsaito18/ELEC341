%%%%%%%%%%%%%%%%%%%%
% Op-Amp Circuit Tutorial
%
% This is a stand-alone script for solving the Op-Amp RLC circuit problem
% that is used to introduce Matlab in ELEC 341.
%
% Calling Syntax:
% opamp
%
% Note: All variables cleared when this is run
%
% Author: Leo Stocco
%%%%%%%%%%%%%%%%%%%%

clear all; clc;

% Parameters
R1 = 200;
R2 = 500;
L  = 1;
C  = 1e-3;

%%%%%%%%%%%%%%%%
% Solve using tf
%%%%%%%%%%%%%%%%
num = [L*C*R2 L+C*R1*R2 R1+R2];
den = [L*C*R2 L+C*R1*R2 R1];
xfer1 = tf(num, den);

% Simplify
% This function may reduce the accuracy of your TF
% It DOES NOT always preserve DC gain
% Use with caution
xfer1 = minreal(xfer1);

figure(1); clf;
impulse(xfer1);
grid on;

%%%%%%%%%%%%%%%%%
% Solve using zpk
%%%%%%%%%%%%%%%%%
z = roots(num)
p = roots(den)
xfer2 = zpk(z, p, 1);

[y t] = impulse(xfer2);

figure(2); clf;
h = plot(t, y, 'r--');
set(h, 'LineWidth', 3);
grid on;
title('Dotted Red Impulse Response');
xlabel('Time (sec)');
ylabel('OP Voltage (V)');
set(gca, 'FontSize', 14);


%%%%%%%%%%%%%%%%%%%%%
% Solve using algebra
%%%%%%%%%%%%%%%%%%%%%
s = tf('s');
Zr1 = R1;
Zr2 = R2;
Zl  = s*L;
Zc  = 1/(s*C);

Z1 = Zr1+Zl;
Z2 = 1/(1/Zr2 + 1/Zc);
xfer3 = minreal(1 + Z2/Z1);

figure(3); clf;
impulse(xfer3);
grid on;


%%%%%%%%%%%
% Bode Plot
%%%%%%%%%%%
figure(4)
bode(xfer1);
grid on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step Func to Compare Simulink
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab
[ys ts] = step(xfer2);

figure(5);
clf;
plot(ts, ys, 'b-', 'LineWidth', 3);
grid on;
title('Step Response');
xlabel('Time (sec)');
ylabel('OP Voltage (V)');

% For Simulink, FB loop is a voltage divider
vdiv = Z1/(Z1+Z2);                    % Xfer func of Voltage Divider
vdiv = minreal(vdiv);                 % Never a bad idea to clean it up
[numSim denSim] = tfdata(vdiv, 'v');  % vector option, not cell-array


%%%%%%%%%%%%%%%%%%
% Create PNG files
%%%%%%%%%%%%%%%%%%
if 0                % saves you the trouble of commenting out many lines
% Save figures to PNG format
print -dpng -f1 fig1
print -dpng -f2 fig2
print -dpng -f3 fig3
print -dpng -f4 fig4
print -dpng -f5 fig5
end
