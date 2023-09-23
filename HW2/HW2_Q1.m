%%%%%%%%%%%%%%%%%%%%
% Homework 2 Question 1
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

% Params
overshoot = 42;
fv = 28;
pos = abs(overshoot - fv)/fv * 100;

zeta = -1 * log(pos/100)/sqrt(pi^2 + (log(pos/100))^2);


Q1.Pos = pos;
Q1.zeta = zeta;


