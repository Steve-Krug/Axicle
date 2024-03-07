
dt = 0.001;
T = 0.0:dt:120;
tau = 20;
alpha = tau / (tau + dt);
    
gyro_weight = ones(length(T),1) * alpha;
acc_weight = zeros(length(T),1);

for i = 2:length(gyro_weight)

        gyro_weight(i) = alpha * gyro_weight(i-1);
        acc_weight(i) = alpha * acc_weight(i-1) + (1-alpha);

end

plot(T, acc_weight, T, gyro_weight)
grid on

function [T, gyro_weight] = tauweight(tau)

    dt = 0.01;
    T = 0.0:dt:20;
    alpha = tau / (tau + dt);
    
    gyro_weight = ones(length(T),1);
    acc_weight = zeros(length(T),1);

    for i = 2:length(gyro_weight)

        gyro_weight(i) = alpha * gyro_weight(i-1)
        %acc_weight(i) = 1 - gyro_weight(i);

    end

end