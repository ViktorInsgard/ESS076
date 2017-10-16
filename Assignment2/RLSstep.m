function [ theta_hat, P ] = RLSstep(theta_hat_old, P, y, phi, lambda)
P = (1/lambda)*(P - (P*(phi*phi')*P) / ...
    (lambda + phi'*P*phi));
K = P*phi;
epsilon = y - phi'*theta_hat_old;
theta_hat = theta_hat_old + K*epsilon;
end
