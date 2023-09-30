%%%%%%%%%%%%%%%%%%%%
% Homework 3 Question 2
% Author: Henrique Saito
%%%%%%%%%%%%%%%%%%%%

% Must run question 1 to load system values.
% HW3_Q1; % Uncomment this if running without running Q1 first.

tf_v1 = V(2);
tf_d1 = tf_v1/s;
tf_k1 = -1*tf_d1*K1;

tf_v3 = V(4);
tf_v2 = V(3);
tf_d3 = tf_v3/s;
tf_d2 = tf_v2/s;
tf_d3d2 = tf_d3 - tf_d2;
tf_k32 = -1 * tf_d3d2 * K32;

Q2.G1 = tf_k1;
Q2.G32 = tf_k32;

[f t3] = step(tf_k1);

figure(3); clf; hold on; grid on;
plot(t3, f(:,1), 'k-',  'Linewidth', 3);

title('Separating Spring Force');
ylabel('Force (N)');
legend('Spring K1', 'Location', 'East');
set(gca, 'FontSize', 14);
