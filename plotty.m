%%%%%%%%%%%%%%%%
% Plots vectors v and t.
%%%%%%%%%%%%%%%%
% Plot all voltages together
figure(1); clf; hold on; grid on;
plot(t, v, 'k-',  'Linewidth', 3);
title('Node Voltage');
ylabel('Voltage (V)');
legend('Node 1', 'Location', 'East');
set(gca, 'FontSize', 14);
