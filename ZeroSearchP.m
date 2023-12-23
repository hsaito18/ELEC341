function [z1,z2,max] = ZeroSearchP(K,GH,Xfreq,rad_Inc,angle_Inc)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% K = Gain
% GH = open loop transfer function containing your pole partial dynamics (Dp)
% Xfreq = phase cross-over frequency
% rad_Inc = increment of radius checked
% angle_Inc = increment of angle checked
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
format long
s = tf('s');
stop = 1;
radius = Xfreq+1;
radiusmax = radius;
switcher = 1;
startswitch = 1;
max = 0;
angle = 150;
while stop == 1
while switcher == 1
[Pm1,~,~] = PmFind(radius,angle,K,GH)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Runs once at beginning
if startswitch == 1
max = Pm1;
startswitch = 2;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Pm1 >= max
max = Pm1;
anglemax = angle;
angle = angle - angle_Inc;
else
angle = anglemax;
switcher = 2;
end
end
while switcher == 2
[Pm1,z1,z2] = PmFind(radius,angle,K,GH)
if Pm1 >= max
max = Pm1;
anglemax = angle;
angle = angle + angle_Inc;

else
angle = anglemax;
switcher = 3;
end
end

while switcher == 3
if Pm1 >= max
max = Pm1;
radiusmax = radius;
radius = radius + rad_Inc;

else
radius = radiusmax;
switcher = 4;
end
end
while switcher == 4
[Pm1,~,~] = PmFind(radius,angle,K,GH)
if Pm1 >= max
max = Pm1;
radiusmax = radius;
radius = radius - rad_Inc;
else
radius = radiusmax;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STOP CHECK
[Pm1,z1,z2] = PmFind(radius,angle,K,GH);
[Pm3,~,~] = PmFind(radius,angle-angle_Inc,K,GH)
[Pm4,~,~] = PmFind(radius,angle+angle_Inc,K,GH)
[Pm5,~,~] = PmFind(radius-rad_Inc,angle,K,GH)
[Pm6,~,~] = PmFind(radius+rad_Inc,angle,K,GH)

if Pm3 < Pm1 && Pm4 < Pm1 && Pm5 < Pm1 && Pm6 < Pm1
stop = 0;
max = Pm1;
break;
else
switcher = 1;
end
end
end
end

function [Pm,z1,z2] = PmFind(radius,angle,K,GH)
x = radius * cosd(angle); % real part
y = radius * sind(angle); % imaginary part
z1 = x+y*1i;
z2 = x-y*1i;
Dz = ((s-z1)*(s-z2))/(z1*z2); %Zero dynamics of PID controller
[~,Pm,~,~]= margin(K*Dz*GH); % calc PM

end
end