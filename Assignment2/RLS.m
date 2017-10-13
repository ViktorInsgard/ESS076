theta = [.1065; 0.0902; -1.607; .6065]; % real parameters

n = 2; % number of delayed y signals
m = 2; % number of delayed u signals
assert(length(theta) == n+m);

N = 100; % simulation length

lambda = 0.9;

theta_hat = zeros(n+m, N);
phi = zeros(n+m, N);
P = zeros(n+m, n+m, N);
P_0 = 1*eye(n+m);
theta_0 = zeros(n+m,1);
y = zeros(1,N);
u = mvnrnd(0,2,N);


P(:,:,1) = (1/lambda)*(P_0 - (P_0*(phi(:,1)*phi(:,1)')*P_0) / ...
    (lambda + phi(:,1)'*P_0*phi(:,1)));
K = P(:,:,1)*phi(:,1);
epsilon = y(1) - phi(:,1)'*theta_0;
theta_hat(:,1) = theta_0 + K*epsilon;
for k=2:N
    % Adjust y values in phi
    phi(2:n,k) = phi(1:n-1,k);
    phi(1,k) = -y(k-1);
    % Adjust u values in phi
    phi(n+2:n+m,k) = phi(n+1:n+m-1,k);
    phi(n+1,k) = u(k-1);
    
    y(k) = theta'*phi(:,k);
    
    P(:,:,k) = (1/lambda)*(P(:,:,k-1) - ...
        (P(:,:,k-1)*phi(:,k-1)*phi(:,k-1)'*P(:,:,k-1)) / ...
        (lambda + phi(:,k-1)'*P(:,:,k-1)*phi(:,k-1)));
    K = P(:,:,k)*phi(:,k);
    epsilon = y(k) - phi(:,k)'*theta_hat(:,k-1);
    theta_hat(:,k) = theta_hat(:,k-1) + K*epsilon;
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