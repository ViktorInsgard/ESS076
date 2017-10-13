%% Exercise 3
l = 0.7;
g = 9.82;
M = 0.5;
L_1 = -60/pi;


VL = @(L_2) L_2./(2*l*M);
HL = @(L_2) sqrt((L_2./(2*l*M)).^2 + g/l + L_1/(l*M));
lambda_1 = @(L_2) VL(L_2) + HL(L_2);
lambda_2 = @(L_2) VL(L_2) - HL(L_2);

figure(1);
L_2 = -10:0.01:10;
plot(L_2, VL(L_2));
hold on;
plot(L_2, HL(L_2));
hold off;
legend('VL', 'HL');
grid on

figure(2);
L_2 = -10:0.01:10;
plot(L_2, lambda_1(L_2));
hold on;
plot(L_2, lambda_2(L_2));
hold off;
legend('\lambda_1', '\lambda_2');
grid on

%%

A = [0 1; (g/l) 0];
B = [0; (-1/(M*l))];
L_1 = -10/(pi/6);
L_2 = -8;
L = [L_1 L_2];

eig(A - B*L)

%%

A = [ 0 1 0 0; (g/l) 0 0 0; 0 0 0 1; 0 0 0 0];
B = [0; (-1/(M*l)); 0; 1/M];
P = [-10 -20 -3 -2];

K = acker(A, B, P)