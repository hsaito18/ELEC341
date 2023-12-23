a=8;b=4;c=8;d=1;e=6;f=4;g=2;h=9;
s=tf('s');

%------------------%amplifier tf
zeta=d/10;
wn=a*b*c*d;
amp_dcgain=b;
amptf=tf(wn^2,[1 2*wn*zeta wn^2])*amp_dcgain;

%------------------motor
Rw=0.2;
Lw=0.5e-3;
Jm=(100+b)*1e-3*1e-4;
Kb=( (600+10*c)*2*pi/60 ); %speed per volt
Km=1/Kb; %torque per amp;
iNL = ( 250+(10*a) ) * 10^-3; %no load current
wNL = 12*Kb;
Bm = Km*iNL/wNL;

electf= tf(1, [Lw Rw]);%amps per volt
%motortf=tf(1, [Jm Bm]); %speed per torque (no load)
%--------------------------load
Jl=(a+b+c)*1e-6;
Bl=(d+e+f)*1e-6;
Kl1=2*1e-3;
Kl2=3*g*1e-3;
Kl=( (1/Kl1) + (1/Kl2) )^-1;

amat = zeros(2);
amat(1,:) = [0 1];
amat(2,:) = [(-Kl)/(Jl+Jm) (-Bl-Bm)/(Jl+Jm)];

bmat = [0;-1/(Jl+Jm)];

cmat = [0 -1];
dmat = [0];

pmat = (s*eye(2)-amat)^-1;
rotortf = cmat*pmat*bmat+dmat; %rotor speed/torque

[num den] = ss2tf(amat,bmat,cmat,dmat);
rotortf = tf(num,den);

%full system OLtf amptf*electf*Km*rotortf*H

%----------------------
CF = 100+10*a;
H = 2*CF/(s+2*CF);
checkGH(84816420, amptf*feedback(electf*Km*rotortf,Km)*H/s)

q1_tf = amptf*feedback(electf*Km*rotortf,Km)*H/s;




