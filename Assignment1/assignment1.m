%% Exercise 5
c = 0 : 0.1 : 10;

figure(1);
plot(c, dfcube(c, 1));
title('Cubic describing function');
grid on;

figure(2);
plot(c, dfsat(c, [1 1]));
title('Saturation describing function');
grid on;

figure(3);
plot(c, dfdeadz(c, [1 1]));
title('Deadzone describing function');
grid on;

figure(4);
subplot(1,2,1)
plot(c, real(dfrelay(c, [1 1])));
title('Relay describing function (real part)');
grid on;

subplot(1,2,2)
plot(c, imag(dfrelay(c, [1 1])));
title('Relay describing function (imaginary part)');
grid on;

figure(5);
plot(c, dfreldz(c, [1 1]));
title('Relay with deadzone describing function');
grid on;

%% Exercise 6

g = tf(30,[1 4 7 1]);
w = [1,2,2.6,3,5,10,20];
c = [2,3,4,5];
figure(1);
dfplot('dfsat',[2,3],c,g,w);
grid on;

%% Exercise 8
c = 0 : 0.1 : 10;
d = 0.2;
h = 1;
figure(1);
plot(c, dfreldz(c, [d, h]));
title('Relay with deadzone describing function');
grid on;

figure(2);
g = tf(90,[1 10 9  0]);
w = [1,2,2.6,3,5,10];
c = [0.2025,1,1.2571,2,3,4,5];
dfplot('dfreldz',[d,h],c,g,w);
grid on;

%% Exercise 10
c = 0 : 0.1 : 10;
d = 0.2;
h = 1;
figure(1);
plot(c, dfreldz(c, [d, h]));
title('Relay with deadzone describing function');
grid on;

figure(2);
K = .25;
g = tf(K*90,[1 10 9  0]);
w = [1,2,2.6,3,5,10];
c = [0.2025,1,1.2571,2,3,4,5];
dfplot('dfreldz',[d,h],c,g,w);
grid on;

%% Exercise 13
c = 0 : 0.1 : 10;
d = 0.2;
h = 1;
figure(1);
plot(c, dfreldz(c, [d, h]));
title('Relay with deadzone describing function');
grid on;

figure(2);
b = 1;
K = .1;
N = 2;
gk = tf([K*N, K*N*b],[1, b*N]);
g = tf(K*90,[1 10 9  0]);
w = [2,2.6,3,5,10];
c = [0.2025,1,1.2571,2,3,4,5];
dfplot('dfreldz',[d,h],c,gk*g,w);
grid on;

%% Exercise 14
figure(1);
k1 = .2;
k2 = 1;
w = [1,3,5,10];
K = 167;
g = tf(K,[1,4,16,0]);
ciplot(k1, k2, g, w);
grid on; axis equal;
