
s = tf('s');
A_sn = 8;
B_sn = 4;
C_sn = 8;
D_sn = 1;
E_sn = 6;
F_sn = 4;
G_sn = 2;
H_sn = 9;
SN = 84816420;

Kb=( (600+10*C_sn)*2*pi/60 ); %speed per volt
Km=1/Kb; %torque per amp;
iNL = ( 250+(10*A_sn) ) * 10^-3; %no load current
wNL = 12*Kb;
Bm = Km*iNL/wNL;
Jr = (100 + B_sn)/1000/100/100;

CF = 100+(10*A_sn);
Jl = (A_sn + B_sn + C_sn)*1e-6;
Bl = (D_sn + E_sn + F_sn)*1e-6;
Kl1 = 2e-3;
Kl2 = 3*G_sn*1e-3;

Kamp = B_sn;
wn = A_sn*B_sn*C_sn*D_sn;
zeta = D_sn/10;

% Mech
Bt = Bm + Bl;
Jt = Jl+Jr;
Kt = 1/(1/Kl1 + 1/Kl2);

Ym = getSimpleYm(Bt,Jt,Kt);

Ga = Kamp * wn^2/(s^2 + 2*zeta*wn*s + wn^2);
CF = 100+10*A_sn;
H = 2*CF/(s+2*CF); % WHY ???
Ye = 1/(s*Lw + Rw);
Gp = Ga * Ye * Km * Ym * 1/s;
GH = Ga*feedback(Ye*Km*Ym, Km)*H/s;
