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

lambda = 0.8;

theta_hat = zeros(n+m, N);
phi = zeros(n+m, N);
P = zeros(n+m, n+m, N);
P_0 = 0.01*eye(n+m);
theta_0 = [0; 0; 1 ; 1];
y = zeros(1,N);
u = zeros(1,N);
r = pulseSignal(50, 50, N);%ones(1,N);

% controller parameters
T = zeros(n_t,N);
S = zeros(n_s,N);
R = zeros(n_r,N);

% RLS equations
[theta_hat(:,1), P(:,:,1)] = ...
        RLSstep(theta_0, P_0, 0, phi(:,1), lambda);
    
T(:,1) = 0.1761 / theta_0(n+1);
S(1,1) = (-1.3205 - theta_0(1)) / theta_0(n+1);
S(2,1) = (0.4966 - theta_0(2)) / theta_0(n+1);
R(1,1) = 1;
R(2,1) = theta_0(n+2) / theta_0(n+1); 


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
    
    T(:,k) = 0.1761 / theta_hat(n+1,k);
    S(1,k) = (-1.3205 - theta_hat(1,k)) / theta_hat(n+1,k);
    S(2,k) = (0.4966 - theta_hat(2,k)) / theta_hat(n+1,k);
    R(1,k) = 1;
    R(2,k) = theta_hat(n+2,k)/ theta_hat(n+1,k); 
    
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