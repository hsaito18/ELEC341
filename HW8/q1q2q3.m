%%%%%%%%%%%
% Solves questions 1, 2, 3 for HW8 in ELEC 341.
% Author: Henrique Saito
%%%%%%%%%%%

% HW 7
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

s = tf('s');

period = 1/CF;
Ntot = (50 + 50)/100;
Kh = 1/dcgain(Hs);

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

Q1.Gp = Gp;
Q1.Hs = Hs;
Q1.H = Hs*Kh*Dh;

p1 = -A_sn;
Kp = -1/p1;
D = (s-p1)/(-p1*s);
K=52;

Gcl = feedback(K*D*Gp, Hs*Kh*Dh);
Gol = K*D*Gp*Hs*Kh*Dh;

Q2.K = K;
Q2.Kp = Kp;
Q2.Pm = 58.6;
Q2.Ts = 348;

p2 = -3 * B_sn;
Kp = -1/p2;
D = (s-p2)/(-p2*s);
K = 25.75;

Gcl = feedback(K*D*Gp, Hs*Kh*Dh);
Gol = K*D*Gp*Hs*Kh*Dh;

Q3.K = K;
Q3.Kp = Kp;
Q3.Pm = 57.6;
Q3.Ts = 890;

Dp = 1/s;
K0 = 105;

partialDynamics = K0*Dp*Gp*Hs*Kh*Dh;

zero = -12.51;

D = (s-zero)/(-zero*s);
Gol = K0*D*Gp*Hs*Kh*Dh;
[gm, pm] = margin(Gol);

K = 49.6;
Gcl = feedback(K*D*Gp, Hs*Kh*Dh);

Q4.K = K;
Q4.Kp = -1/zero;
Q4.Ts = 425;

Dp = (2*CF)/(s+2*CF);
K0 = 22.8;
pdy = K0*Dp*Gp*Hs*Kh*Dh;
[gm, pm, wcp] = margin(pdy);

zero = -44.5;

Kd = (zero + 2*CF)/(-2*CF*zero);
D = 1+Kd*(CF*s)/(0.5*s+CF);
Gol = K0*D*Gp*Hs*Kh*Dh;

K = 11.715;

Gcl = feedback(K*D*Gp, Hs*Kh*Dh);

Q5.K = K;
Q5.Kd = Kd;
Q5.Ess = (1-0.687177)*100;

% G = Gcl;
% plotTF;

