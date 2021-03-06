clear

% l�gg till alla filer: !git add -A
% spara till git:       !git commit -m "kommentar"
% upp p� n�t:           !git push

n = 2; % number of delayed y signals
m = 2; % number of delayed u signals
n_t = 1;
n_s = 2;
n_r = 2; 

N = 500; % simulation length

% real parameters
theta = zeros(4,N);
for i=1:N
    if i<250
        theta(:,i) = [-1.607; .6065; 0.1065; 0.0902];
    else
        theta(:,i) = 2*[-1.607; .6065; 0.1065; 0.0902];
    end
end

lambda = 0.9;

theta_hat = zeros(n+m, N);
phi = zeros(n+m, N);
P = zeros(n+m, n+m, N);
P_0 = .01*eye(n+m);
theta_0 = [-1; .5; 1; 1];
y = zeros(1,N);
u = zeros(1,N);
r = pulseSignal(50, 50, N);

% controller parameters
T = zeros(n_t,N);
S = zeros(n_s,N);
R = zeros(n_r,N);
Am = [-1.3205; 0.4966];
Bm = 0.1761;

% RLS step
[theta_hat(:,1), P(:,:,1)] = RLSstep(theta_0, P_0, 0, phi(:,1), lambda);

T(:,1) = (1 + Am(1) + Am(2)) / (theta_0(n+1) + theta_0(n+2));
A = [1 theta_0(n+1) 0;
     theta_0(1) theta_0(n+2) theta_0(n+1);
     theta_0(2) 0 theta_0(n+2)];
b = [(Am(1) - theta_0(1)); (Am(2) - theta_0(2)); 0];
V = A \ b;

R(2,1) = V(1);
S(1,1) = V(2); 
S(2,1) = V(3);

u(1) = T(1,1)*r(1); % Other values are 0;

for k=2:N
     
    % Adjust y values in phi
    phi(2,k) = phi(1,k-1);
    phi(1,k) = -y(k-1);
    % Adjust u values in phi
    phi(4,k) = phi(3,k-1);
    phi(3,k) = u(k-1);
     
    y(k) = theta(:,k)'*phi(:,k);
    
    [theta_hat(:,k), P(:,:,k)] = ...
        RLSstep(theta_hat(:,k-1), P(:,:,k-1), y(k), phi(:,k), lambda);
    
    T(:,k) = (1 + Am(1) + Am(2)) / (theta_hat(3,k) + theta_hat(4,k));
    A = [1 theta_hat(3,k) 0;
         theta_hat(1,k) theta_hat(4,k) theta_hat(3,k);
         theta_hat(2,k) 0 theta_hat(4,k)];
    b = [(Am(1) - theta_hat(1,k)); (Am(2) - theta_hat(2,k)); 0];
    V = A \ b;

    R(2,k) = V(1);
    S(1,k) = V(2); 
    S(2,k) = V(3);
    
    u(k) = T(1,k)*r(k) - S(1,k)*y(k) - S(2,k)*y(k-1) - R(2,k)*u(k-1);
    
end

close all;
figure(1); hold on;
Legend = cell(n+m,1);
for i=1:n+m
    plot(0:N, [theta_0(i), theta_hat(i,:)]);
    Legend{i} = ['\theta_' num2str(i)];
end
legend(Legend);
hold off; grid on;

figure(2); hold on;
plot(1:N, y, 'b-', 1:N, r, 'b:');
plot(1:N, u, 'r-');
legend('y', 'r', 'u');
grid on; hold off;