%%%%%%%%%%%
% Solves questions 4,5,6 for HW7 in ELEC 341.
% Author: Henrique Saito
%%%%%%%%%%%

% q1q2q3.m must be run before q4q5q6 is run.
% q1q2q3; % uncomment this for standalone version.

GH = Gp*Hs*Kh*Dh;
Ku = 24.5; % from root locus
K = 10.75;
GclP = feedback(K*Gp,Hs*Kh*Dh);

Q4.K = K;
Q4.Ess = (1-0.668)*100;

K = 6.9;
p1 = -A_sn;
Kd = (p1 + 2*CF)/(-2*CF*p1);
D = 1+Kd*(CF*s)/(0.5*s+CF);
GclPD = feedback(K*D*Gp, Hs*Kh*Dh);

Q5.K = K;
Q5.Kd = Kd;
Q5.Ess = (1-0.56)*100;

K = 11.7;
p2 = -3 * B_sn;
Kd = (p2 + 2*CF)/(-2*CF*p2);
D = 1+Kd*(CF*s)/(0.5*s+CF);
GclPD2 = feedback(K*D*Gp, Hs*Kh*Dh);
G = GclPD2;

Q6.K = K;
Q6.Kd = Kd;
Q6.Ess = (1-0.6869)*100;
