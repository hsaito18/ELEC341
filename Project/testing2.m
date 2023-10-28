part1;

t = linspace(0,1,2000);

[tm, t1] = step(Q4.G, t);
[da, t2] = step(Q5.G, t);
[qf, t3] = step(Q6.G, t);
[ft, t4] = step(Q7.G, t);


figure(1); clf; hold on; grid on;
plot(t1, tm, 'k-',  'Linewidth', 3);
title('Motor Torque');
ylabel('Torque (Nm)');
set(gca, 'FontSize', 14);

figure(2); clf; hold on; grid on;
plot(t2, da, 'k-',  'Linewidth', 3);
title('Actuator Displacement');
ylabel('Displacement (m)');
set(gca, 'FontSize', 14);

figure(3); clf; hold on; grid on;
plot(t3, qf, 'k-',  'Linewidth', 3);
title('Finger Angle');
ylabel('Angle (deg)');
set(gca, 'FontSize', 14);

figure(4); clf; hold on; grid on;
plot(t4, ft, 'k-',  'Linewidth', 3);
title('Tine Force');
ylabel('Force (N)');
set(gca, 'FontSize', 14);