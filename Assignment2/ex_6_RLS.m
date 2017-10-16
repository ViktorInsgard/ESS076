clear

% lägg till alla filer: !git add -A
% spara till git:       !git commit -m "kommentar"
% upp på nät:           !git push

theta = [-1.607; .6065; 0.1065; 0.0902]; % real parameters

n = 2; % number of delayed y signals
m = 2; % number of delayed u signals
assert(length(theta) == n+m);
n_t = 1;
n_s = 2;
n_r = 2; 

N = 90; % simulation length

lambda = 0.9;

theta_hat = zeros(n+m, N);
phi = zeros(n+m, N);
P = zeros(n+m, n+m, N);
P_0 = 1*eye(n+m);
theta_0 = [0; 0; 1 ; 1];
y = zeros(1,N);
%u = zeros(1,N);
u = ones(1,N);
r = ones(1,N);

% controller parameters
T = zeros(n_t,N);
S = zeros(n_s,N);
R = zeros(n_r,N);

% RLS equations
P(:,:,1) = (1/lambda)*(P_0 - (P_0*(phi(:,1)*phi(:,1)')*P_0) / ...
    (lambda + phi(:,1)'*P_0*phi(:,1)));
K = P(:,:,1)*phi(:,1);
epsilon = y(1) - phi(:,1)'*theta_0;
theta_hat(:,1) = theta_0 + K*epsilon;

T(:,1) = (1 - 1.3205 + 0.4966) / (theta_0(n+1) + theta_0(n+2));

V = ([1 theta_0(n+1) 0; ...
    theta_0(1) theta_0(n+2) theta_0(n+1); ...
    theta_0(2) 0 theta_0(n+2)]) \ ...
    [(-1.3025 - theta_0(1)); (0.4966 - theta_0(2)); 0];

R(2,1) = V(1);
S(1,1) = V(2); 
S(2,1) = V(3);

for k=2:N
     
    % Adjust y values in phi
    phi(2:n,k) = phi(1:n-1,k-1);
    phi(1,k) = -y(k-1);
    % Adjust u values in phi
    phi(n+2:n+m,k) = phi(n+1:n+m-1,k-1);
    phi(n+1,k) = u(k-1);
     
     y(k) = theta'*phi(:,k);
     
    P(:,:,k) = (1/lambda)*(P(:,:,k-1) - ...
        (P(:,:,k-1)*phi(:,k-1)*phi(:,k-1)'*P(:,:,k-1)) / ...
        (lambda + phi(:,k-1)'*P(:,:,k-1)*phi(:,k-1)));
    K = P(:,:,k)*phi(:,k);
    epsilon = y(k) - phi(:,k)'*theta_hat(:,k-1);
    theta_hat(:,k) = theta_hat(:,k-1) + K*epsilon;
    
    T(:,1) = (1 - 1.3205 + 0.4966) / (theta_hat(n+1,k) + theta_hat(n+2,k));

    V = ([1 theta_hat(n+1,k) 0; ...
    theta_hat(1,k) theta_hat(n+2,k) theta_hat(n+1,k); ...
    theta_hat(2,k) 0 theta_hat(n+2,k)]) \ ...
    [(-1.3025 - theta_hat(1,k)); (0.4966 - theta_hat(2,k)); 0];

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