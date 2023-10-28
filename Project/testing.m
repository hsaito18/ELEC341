part1;

voltage_G = V(1) * M(1) / s * Na;

regular_G = M(2);

close all;

time = linspace(0,1,1000);
[t,y1] = step(voltage_G, time);
[t2, y2] = step(regular_G, time);

plot(t, y1, 'r-');
title('Electro vs Mech');
hold on;

plot(t, y2, 'bo');