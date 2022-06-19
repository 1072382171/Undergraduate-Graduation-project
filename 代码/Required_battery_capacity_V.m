%% This script simulates the Lyapunov Optimization-based Dynamic Computation Offloading (LODCO) algorithm.
clc, clear
opt = optimset('Display', 'none');

%% basic parameter settings (had better not change those paras)
k = 1e-28;                % effective switched capacitance (a constant decided by the chip architecture)
tau = 0.002;              % the length of time slot (in second)
phi = 0.002;              % the cost of task dropping (in second)
omega = 1e6;              % the bandwidth of MEC server (in Hz)
sigma = 1e-13;            % the noise power of the receiver (in W)
p_tx_max = 1;             % the maximum transmit power of mobile device (in W)
f_max = 1.5e9;            % the maximum CPU-cycle frequency of mobile device (in Hz)
E_max = 0.002;            % the maximum amout of battery output energy (in J)
L = 1000;                 % the input size of the computation task (in bit)
X = 737.5;                % the number of CPU cycles needed on processing one bit of task
W = L * X;                % the number of CPU cycles needed on processing one task
E_H_max = 48e-6;          % the upper bound of the energy arrive at the mobile device (in J)
p_H = E_H_max / (2*tau);  % the average Energy Harvesting (EH) power (in W)
g0 = power(10, -4);       % the path-loss constant
l=1;
cap=zeros(10,1);
%% parameter control
T = 50000;                % the number of time slot (a.k.a. the size of the time horizon)
tau_d = 0.002;            % execution deadline (in second)
d = 50;                   % the distance between the mobile device and the MEC server (in meter)
E_min = 0.02e-3;          % the minimum amout of battery output energy (in J)
V = 1e-5;                 % the weight of penalty (the control parameter introduced by Lyapunov Optimization)
rho = 0.6;                % the probability that the computation task is requested

% the lower bound of perturbation parameter
E_max_hat = min(max(k * W * (f_max)^2, p_tx_max * tau), E_max);

while V<=1e-4
    theta = E_max_hat + V * phi / E_min;
    cap(l)=theta;
    l=l+1;
    V=V+1e-5;
end
figure
plot(1:10,cap(1:10),'r','linewidth',2);
title('required battery capacity vs.V  ');
xlabel('V(J^2*second^-1)*10-4');
ylabel('required battery capacity(mJ)');


