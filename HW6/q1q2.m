% Params
Hs_gain = 5/F_sn;
Gp_gain = 3/G_sn;
Hs_pole = -15*E_sn;
Gp_p1 = -3*B_sn;
Gp_p2 = -A_sn;
Gp_p3 = (-1+1i)*2*D_sn;
Gp_p4 = (-1-1i)*2*D_sn;
Gp_zero = -5*C_sn;

Kh = 1/Hs_gain;

Gp_mod = zpk(Gp_zero, [Gp_p1, Gp_p2, Gp_p3, Gp_p4], 1);
Gp_mod_k = dcgain(Gp_mod);
Gp_k_e = Gp_gain/Gp_mod_k;
Gp = Gp_mod * Gp_k_e;

Hs_mod = zpk([], Hs_pole, 1);
Hs_mod_k = dcgain(Hs_mod);
Hs_k_e = Hs_gain/Hs_mod_k;
Hs = Hs_mod * Hs_k_e;

GH = Gp*Hs*Kh;
Ku = 36.1;

K = Ku/2;

Gcl = feedback(K*Gp, Hs*Kh);

Q1.Kh = Kh;
Q1.GH = GH;
Q1.Ku = Ku;

Q2.Gcl = Gcl;
Q2.Ts = 0.4840;
Q2.Ess = 100-77.5;
Q2.Pos = (1.1174-0.775)/(0.775)*100;
Q2.Gos = (1.1174-1)*100;