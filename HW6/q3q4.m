%%%%%%%%%%%
% Solves questions 3 and 4 for HW6 in ELEC 341.
% Author: Henrique Saito
%%%%%%%%%%%

% q1q2.m must be run before q3q4 is run.
% q1q2; % uncomment this for standalone version.

K = 15; % Starting val;

num_items = 35;
GOSs = ones(1,num_items);
Esss = ones(1,num_items);
Ks = linspace(1,num_items, num_items);

for n = 1:num_items
    K_val = Ks(n);
    G_sys = feedback(K_val*Gp, Hs*Kh);
    % peak_val = stepinfo(G_sys).Peak;
    % GOSs(n) = (peak_val-1)*100;
    [y, t] = step(G_sys);
    Esss(n) = (1-y(length(y)))*100;
end

% K = 20.49 from looking at finer and finer graphs.

G_sys = feedback(20.49*Gp, Hs*Kh);
info = stepinfo(G_sys);

Q3.K = 20.49;
Q3.Ts = info.SettlingTime;
Q3.Ess = (1-0.795)*100;

K = Q1.Ku-0.05;
G_sys = feedback(K*Gp, Hs*Kh);
info = stepinfo(G_sys);
[y,t] = step(G_sys);
fv = y(length(y));

Q4.K = Q1.Ku;
Q4.Ess = (1-fv)*100;
Q4.Pos = (info.Peak-fv)/fv * 100;
Q4.Gos = (info.Peak-1)*100;


