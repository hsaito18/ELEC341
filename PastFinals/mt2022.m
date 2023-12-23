ssn2;
s = tf('s');

M1 = A_sn/1000;
B1 = B_sn/100;
M2 = C_sn/1000;
K2 = D_sn;
M3 = E_sn*3/1000;
K23 = F_sn;
B23 = G_sn/500;
M2_ = M2/2^2;
K23_ = K23/2^2;
B23_ = B23/2^2;
M3_ = M3/2^2;
K2_ = K2/2^2;

M12 = M1 + M2_;

R1 = 1/B1;
C1 = M12;
L1 = 1/K2_;

L2 = 1/K23_;
R2 = 1/B23_;
C2 = M3;

zR1 = R1;
zC1 = 1/(s*C1);
zL1 = s*L1;
zL2 = s*L2;
zR2 = R2;
zC2 = 1/(s*C2);

zA = 1/(1/zL2 + 1/zR2);
zB = zA + zC2;
zTot = 1/(1/zL1 + 1/zR1 + 1/zC1 + 1/zB);

Q1.G = zTot/s;
