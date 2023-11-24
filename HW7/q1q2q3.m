%%%%%%%%%%%
% Solves questions 1, 2, 3 for HW7 in ELEC 341.
% Author: Henrique Saito
%%%%%%%%%%%

% Params
CF = 10 * G_sn; % (Hz)
Ncalc = 50; % (%)
Nw = G_sn;

% HW6 Params
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

Q1.Gp = Gp;
Q1.Hs = Hs;

s = tf('s');

period = 1/CF;
Ntot = (50 + 50)/100;
Dh = CF/(Ntot*s + CF);
Kh = 1/dcgain(Hs);
GH = Gp*Hs*Kh*Dh;
Ku = 28.4; % from root locus
K = 28.4/2;

Gcl = feedback(K*Gp, Hs*Kh*Dh);

Q2.w = -1*pole(Dh);
Q2.Ess = (1-0.727)*100; % from step response plot

cRaw = ones(Nw-1,1);
tot = 1;
for n = 1:Nw-1
    val = exp(-4*n/(Nw-1));
    cRaw(n) = val;
    tot = tot + val;
end % for
cs = ones(size(cRaw));
Nws = 0;
for n = 1:Nw-1
    cs(n) = cRaw(n)/tot;
    Nws = Nws + cs(n)*n;
end % for

Ntot = Ntot + Nws;
Dh = CF/(Ntot*s + CF);

Q3.Nt = Ntot;
Q3.w = -1*pole(Dh);


