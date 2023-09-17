%%%%%%%%%%%%%%%%%%%%
% Homework 1 Question 3
%
% This is a script to solve Q3 of Homework 1.
%
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

% An envelope has the form: y = FV +- K * exp(sigma * t); sigma < 0
% Can tell the FV is 0.

%% Parameters
K = 168;
sigma = -0.00915;
%%%%%%

clf;

a1DSPlot(19177062, 1)

t = linspace(0, 1000, 100);
pos_env =  K * exp(sigma .* t);
neg_env = -K * exp(sigma .* t);

h1 = figure(1);
figure(h1);
ax = gca; hold on;
plot(t, pos_env, 'r', 'LineWidth', 1.0)
plot(t, neg_env , 'r', 'LineWidth', 1.0)

Q3.K = K;
Q3.sigma = sigma * 1000;






