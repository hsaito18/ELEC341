%%%%%%%%%%%%%%%%%%%%
% Project Part 1
%
% This is a script to solve Part 1 of the ELEC 341 Project.
% Note: All variables cleared when this is run
%
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

clear all; clc;
addpath 'C:\Users\hsait\Documents\Projects\ELEC341'
save_student_number

s = tf('s');

% Parameters
FV = 15.9; % (V)
Tr = 0.745; % (ms)
Tp = 1.65; % (ms)
Ts = 3.00; % (ms)
peak = 19.9; % (V)

pos = abs(peak - FV)/FV * 100;




Q1.Tr = Tr;
Q1.Tp = Tp;
Q1.Ts = Ts;
Q1.Pos = pos;

Q2.G = 1/(s+1);