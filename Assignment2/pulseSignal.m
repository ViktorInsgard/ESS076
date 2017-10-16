function y = pulseSignal(n_high, n_low, N)
y = zeros(1,N);    
for k=0:N-1
    if mod(k, n_high+n_low) < n_high
        y(k+1) = 1;
    else
        y(k+1) = 0;
    end
end
end