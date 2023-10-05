%%%%%%%%%%%%%%%%%%%%
% Homework 4 Q1 and 2 Script
% This is a script to solve the first two problems in HW4.
%
% Note: All variables cleared when this is run
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

clear all; clc;
addpath 'C:\Users\hsait\Documents\Projects\ELEC341'
save_student_number

s = tf('s');

% Params
G1 = 1/(s+A_sn);
G2 = 10/(s+B_sn);
G3 = 10/(s+C_sn);
G4 = 10/(s+D_sn);
G5 = 1/(s+E_sn);

H1 = 100/(s+F_sn);
H2 = 1000/(s+G_sn);

% Simplifications
% For Q1.G11
G7 = G2*H1*G4;
G8 = (G3+G7)*G5*H2;
tf1 = G2*G1/(G1*G8 + 1);

% For Q1.G12
G9 = G5*H2*-1*G1;
G10 = G9/(1-G3*G9);
G13 = G4*G10*G2;
G14 = -1*G13/(1-G13*H1);
tf2 = G14;

% For Q1.G21

Q1.G11 = tf1;
Q1.G12 = tf2;
Q1.G21 = tf1;
Q1.G22 = tf1;
