%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Review of Op-Amp Analysis
% 
% I'm just trying to recreate (functionality wise) the opamp.m script.
% Note: All variables cleared when this is run.
% 
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; clc;

% Parameters

R1 = 200;
R2 = 500;
L = 1;
C = 1e-3;


s = tf('s');

zc = 1/(s*C);
zr2 = R2;
zr1 = R1;
zl = s * L;

zf = (zc * zr2) / (zc + zr2);
zi = zr1 + zl;

xfer = minreal(1 + zf/zi);

figure(1); clf;
impulse(1 + zf/zi);
grid on;

figure(2)
bode(xfer);
grid on;


