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

%% parameter control
T = 20000;                % the number of time slot (a.k.a. the size of the time horizon)
tau_d = 0.002;            % execution deadline (in second)
d = 50;                   % the distance between the mobile device and the MEC server (in meter)
E_min_1 = 0.02e-3;          % the minimum amout of battery output energy (in J)
E_min_2 = 0.02e-3; 
E_min_3 = 0.04e-3; 
V_1 = 1.6e-4;    % the weight of penalty (the control parameter introduced by Lyapunov Optimization)
V_2 = 1e-5; 
V_3 = 1e-5; 
rho = 0.6;                % the probability that the computation task is requested

% the lower bound of perturbation parameter
E_max_hat = min(max(k * W * (f_max)^2, p_tx_max * tau), E_max);
theta_1 = E_max_hat + V_1 * phi / E_min_1;
theta_2 = E_max_hat + V_2 * phi / E_min_2;
theta_3 = E_max_hat + V_3 * phi / E_min_3;
%% allocate storage for valuable results
B_1 = zeros(T, 1);          % the battery energy level (in J)
B_2 = zeros(T, 1);   
B_3 = zeros(T, 1);   
B_hat_1 = zeros(T, 1);      % the virtual battery energy level ($B_hat = B - theta$)
B_hat_2 = zeros(T, 1);  
B_hat_3 = zeros(T, 1);  
e_1 = zeros(T, 1);          % the amout of the harvested and stored energy (in J)
e_2 = zeros(T, 1); 
e_3 = zeros(T, 1); 
chosen_mode_1 = zeros(T, 1);% {1: local, 2: remote, 3: drop, 4: no task request}
chosen_mode_2 = zeros(T, 1);
chosen_mode_3 = zeros(T, 1);
f_1 = zeros(T, 1);          % the CPU-cycle frequency of local execution (in Hz)
f_2 = zeros(T, 1);  
f_3 = zeros(T, 1);  
p_1 = zeros(T, 1);          % the transmit power of computation offloading (in W)
p_2 = zeros(T, 1); 
p_3 = zeros(T, 1); 
cost_1 = zeros(T, 3);       % execution delay for mobile execution, MEC server execution and final choice, respectively (in second)
cost_2 = zeros(T, 3);
cost_3 = zeros(T, 3);
E_1 = zeros(T, 3);          % energy consumption for mobile execution, MEC server execution and final choice, respectively (in J)
E_2 = zeros(T, 3);   
E_3 = zeros(T, 3);   
%% simulation begin
t = 1;
while t <= T
    disp(['===> Time slot #', num2str(t), ' <==='])
    
    %% initialization
    % generate the task request
    zeta = binornd(1, rho);
    % generate the virtual battery energy level
    B_hat_1(t) = B_1(t) - theta_1;
    B_hat_2(t) = B_2(t) - theta_2;
    B_hat_3(t) = B_3(t) - theta_3;
    %% step 1: get the optimal energy harvesting no matter whether task is requested
    E_H_t = unifrnd(0, E_H_max);
    if B_hat_1(t) <= 0
        e_1(t) = E_H_t;
    end
    if B_hat_2(t) <= 0
        e_2(t) = E_H_t;
    end
    if B_hat_3(t) <= 0
        e_3(t) = E_H_t;
    end    
    
    %% step 2: get the optimal computation offloading strategy (I_m, I_s, I_d, f(t), p(t))
    if zeta == 0
        % chosen mode has to be 4
        disp('no task request generated!')
        chosen_mode_1(t) = 4;
    else
        % chosen_mode is chosen from {1, 2, 3}
        disp('task request generated!')
        % task request exists, generate the channel power gain
        h = exprnd(g0 / power(d, 4));
    
        %% step 2.1: solve the optimization problem $\mathcal{P}_{ME}$ (f(t) > 0)
        % calculate f_L and f_U
        f_L_1 = max(sqrt(E_min_1 / (k * W)), W / tau_d);
        f_U_1 = min(sqrt(E_max / (k * W)), f_max);
        if f_L_1 <= f_U_1
            % the sub-problem is feasible
            disp('mobile execution ($\mathcal{P}_{ME}$) is feasible!')
            
            if B_hat_1(t) < 0
                f_0_1 = (V_1 / (-2 * B_hat_1(t) * k))^(1/3);
            else
                % complex number may exist, which may lead to error
                f_0_1 = -(V_1 / (2 * B_hat_1(t) * k))^(1/3);
            end
            
            if (f_0_1 > f_U_1 && B_hat_1(t) < 0) || (B_hat_1(t) >= 0)
                f_1(t) = f_U_1;
            elseif f_0_1 >= f_L_1 && f_0_1 <= f_U_1 && B_hat_1(t) < 0
                f_1(t) = f_0_1;
            elseif f_0_1 < f_L_1 && B_hat_1(t) < 0
                f_1(t) = f_L_1;
            end
            % check whether f(t) is zero
            if f_1(t) == 0
                disp('Something wrong! f is 0!')
            end
            % calculate the delay of mobile execution
            cost_1(t, 1) = W / f_1(t);
            % calculate the energy consumption of mobile execution
            E_1(t, 1) = k * W * (f_1(t)^2);
            % calculate the value of optimization goal
            J_m_1 = -B_hat_1(t) * k * W * (f_1(t))^2 + V_1 * W / f_1(t);

        else
            % the sub-problem is not fasible because (i) the limited 
            % computation capacity or (ii) time cosumed out of deadline or 
            % (iii) the energy consumed out of battery energy level
            % If it is not feasible, it just means that we cannot choose 
            % 'I_m=1'. It dosen't mean that the task has to be dropped.
            disp('mobile execution ($\mathcal{P}_{ME}$) is not feasible!')
            f_1(t) = 0;
            cost_1(t, 1) = 0;
            E_1(t, 1) = 0;
            % 'I_m=1' can never be chosen if mobile execution goal is inf
            J_m_1 = inf;

        % Attention! We do not check whether the energy cunsumed is larger than
        % battery energy level because the problem $\mathcal{J}_{CO}$ does
        % not have constraint (8).
        end
        
        
            
        %% step 2.2: solve the optimization problem $\mathcal{P}_{SE}$ (p(t) > 0)
        E_tmp = sigma * L * log(2) / (omega * h);% simplify the expression
        p_L_taud = (power(2, L / (omega * tau_d)) - 1) * sigma / h;
        % calculate p_L
        if E_tmp >= E_min_1
            p_L_1 = p_L_taud;
        else
            % calculate p_E_min (use inline function and fsolve)
            y = @(x) x * L - omega * log2(1 + h*x/sigma) * E_min_1;
            % accroding to the function figure, p_L_taud is a positive 
            % number around 0.2
            p_E_min = fsolve(y, 0.2, opt);
            p_L_1 = max(p_L_taud, p_E_min);
        end
        % calculate p_U
        if E_tmp >= E_max
            p_U_1 = 0;
        else
            % caculate p_E_max (use inline function and fsolve)
            y = @(x) x * L - omega * log2(1 + h*x/sigma) * E_max;
            % accroding to the function figure, p_E_max is a large positive
            % number around 20
            p_E_max = fsolve(y, 100, opt);
            p_U_1 = min(p_tx_max, p_E_max);
        end
   
        if p_L_1 <= p_U_1
            % the sub-problem is feasible
            disp('MEC server execution ($\mathcal{P}_{SE}$) is feasible!')
            % calculate p_0
            virtual_battery = B_hat_1(t);
            y = @(x) virtual_battery * log2(1 + h*x/sigma) + ...
                h * (V_1 - virtual_battery*x) / log(2) / (sigma + h*x);
            p_0_1 = fsolve(y, 0.5, opt);

            if (p_U_1 < p_0_1 && B_hat_1(t) < 0) || B_hat_1(t) >= 0
                p_1(t) = p_U_1;
            elseif p_0_1 < p_L_1 && B_hat_1(t) < 0
                p_1(t) = p_L_1;
            elseif p_0_1 >= p_L_1 && p_0_1 <= p_U_1 && B_hat_1(t) < 0
                p_1(t) = p_0_1;
            end
            % check whether p(t) is zero
            if p_1(t) == 0
                disp('Something wrong! p is 0!')
            end
            
            % calculate the delay of MEC server execution
            cost_1(t, 2) = L / (omega * log2(1 + h*p_1(t)/sigma));
            % calculate the energy consumption of MEC server execution
            E_1(t, 2) = p_1(t) * cost_1(t, 2);
            % calculate the value of optimization goal
            J_s_1 = (-B_hat_1(t) * p_1(t) + V_1) * cost_1(t, 2);
        else
            % the sub-problem is not feasible because (i) the limited transmit 
            % power or (ii) time cosumed out of deadline or (iii) the energy 
            % consumed out of battery energy level
            % If it is not feasible, it just means that we cannot choose 
            % 'I_s=1'. It dosen't mean that the task has to be dropped.
            disp('MEC server execution ($\mathcal{P}_{SE}$) is not feasible!')
            p_1(t) = 0;
            cost_1(t, 2) = 0;
            E_1(t, 2) = 0;
            % 'I_s=1' can never be chosen if MEC server execution goal is inf
            J_s_1 = inf;
        % Similarly, we do not check whether the energy cunsumed is larger than
        % battery energy level because the problem $\mathcal{J}_{CO}$ does
        % not have constraint (8).
        end
        
 
       
        %% step 3: choose the best execution mode
        J_d_1 = V_1 * phi;
        disp(['J_m:', num2str(J_m_1)])
        disp(['J_s:', num2str(J_s_1)])
        [~, mode_1] = min([J_m_1, J_s_1, J_d_1]);
        chosen_mode_1(t) = mode_1;
        
    end
    
    
    
    %% case two: step 2: get the optimal computation offloading strategy (I_m, I_s, I_d, f(t), p(t))
    if zeta == 0
        % chosen mode has to be 4
        disp('no task request generated!')
        chosen_mode_2(t) = 4;
    else
        % chosen_mode is chosen from {1, 2, 3}
        disp('task request generated!')
        % task request exists, generate the channel power gain
        h = exprnd(g0 / power(d, 4));
    
        %% step 2.1: solve the optimization problem $\mathcal{P}_{ME}$ (f(t) > 0)
        % calculate f_L and f_U
        f_L_2 = max(sqrt(E_min_2 / (k * W)), W / tau_d);
        f_U_2 = min(sqrt(E_max / (k * W)), f_max);
        if f_L_2 <= f_U_2
            % the sub-problem is feasible
            disp('mobile execution ($\mathcal{P}_{ME}$) is feasible!')
            
            if B_hat_2(t) < 0
                f_0_2 = (V_2 / (-2 * B_hat_2(t) * k))^(1/3);
            else
                % complex number may exist, which may lead to error
                f_0_2 = -(V_2 / (2 * B_hat_2(t) * k))^(1/3);
            end
            
            if (f_0_2 > f_U_2 && B_hat_2(t) < 0) || (B_hat_2(t) >= 0)
                f_2(t) = f_U_2;
            elseif f_0_2 >= f_L_2 && f_0_2 <= f_U_2 && B_hat_2(t) < 0
                f_2(t) = f_0_2;
            elseif f_0_2 < f_L_2 && B_hat_2(t) < 0
                f_2(t) = f_L_2;
            end
            % check whether f(t) is zero
            if f_2(t) == 0
                disp('Something wrong! f is 0!')
            end
            % calculate the delay of mobile execution
            cost_2(t, 1) = W / f_2(t);
            % calculate the energy consumption of mobile execution
            E_2(t, 1) = k * W * (f_2(t)^2);
            % calculate the value of optimization goal
            J_m_2 = -B_hat_2(t) * k * W * (f_2(t))^2 + V_2 * W / f_2(t);

        else
            % the sub-problem is not fasible because (i) the limited 
            % computation capacity or (ii) time cosumed out of deadline or 
            % (iii) the energy consumed out of battery energy level
            % If it is not feasible, it just means that we cannot choose 
            % 'I_m=1'. It dosen't mean that the task has to be dropped.
            disp('mobile execution ($\mathcal{P}_{ME}$) is not feasible!')
            f_2(t) = 0;
            cost_2(t, 1) = 0;
            E_2(t, 1) = 0;
            % 'I_m=1' can never be chosen if mobile execution goal is inf
            J_m_2 = inf;

        % Attention! We do not check whether the energy cunsumed is larger than
        % battery energy level because the problem $\mathcal{J}_{CO}$ does
        % not have constraint (8).
        end
        
        
            
        %% step 2.2: solve the optimization problem $\mathcal{P}_{SE}$ (p(t) > 0)
        E_tmp = sigma * L * log(2) / (omega * h);% simplify the expression
        p_L_taud = (power(2, L / (omega * tau_d)) - 1) * sigma / h;
        % calculate p_L
        if E_tmp >= E_min_2
            p_L_2 = p_L_taud;
        else
            % calculate p_E_min (use inline function and fsolve)
            y = @(x) x * L - omega * log2(1 + h*x/sigma) * E_min_2;
            % accroding to the function figure, p_L_taud is a positive 
            % number around 0.2
            p_E_min = fsolve(y, 0.2, opt);
            p_L_2 = max(p_L_taud, p_E_min);
        end
        % calculate p_U
        if E_tmp >= E_max
            p_U_2 = 0;
        else
            % caculate p_E_max (use inline function and fsolve)
            y = @(x) x * L - omega * log2(1 + h*x/sigma) * E_max;
            % accroding to the function figure, p_E_max is a large positive
            % number around 20
            p_E_max = fsolve(y, 100, opt);
            p_U_2 = min(p_tx_max, p_E_max);
        end
   
        if p_L_2 <= p_U_2
            % the sub-problem is feasible
            disp('MEC server execution ($\mathcal{P}_{SE}$) is feasible!')
            % calculate p_0
            virtual_battery = B_hat_2(t);
            y = @(x) virtual_battery * log2(1 + h*x/sigma) + ...
                h * (V_2 - virtual_battery*x) / log(2) / (sigma + h*x);
            p_0_2 = fsolve(y, 0.5, opt);

            if (p_U_2 < p_0_2 && B_hat_2(t) < 0) || B_hat_2(t) >= 0
                p_2(t) = p_U_2;
            elseif p_0_2 < p_L_2 && B_hat_2(t) < 0
                p_2(t) = p_L_2;
            elseif p_0_2 >= p_L_2 && p_0_2 <= p_U_2 && B_hat_2(t) < 0
                p_2(t) = p_0_2;
            end
            % check whether p(t) is zero
            if p_2(t) == 0
                disp('Something wrong! p is 0!')
            end
            
            % calculate the delay of MEC server execution
            cost_2(t, 2) = L / (omega * log2(1 + h*p_2(t)/sigma));
            % calculate the energy consumption of MEC server execution
            E_2(t, 2) = p_2(t) * cost_2(t, 2);
            % calculate the value of optimization goal
            J_s_2 = (-B_hat_2(t) * p_2(t) + V_2) * cost_2(t, 2);
        else
            % the sub-problem is not feasible because (i) the limited transmit 
            % power or (ii) time cosumed out of deadline or (iii) the energy 
            % consumed out of battery energy level
            % If it is not feasible, it just means that we cannot choose 
            % 'I_s=1'. It dosen't mean that the task has to be dropped.
            disp('MEC server execution ($\mathcal{P}_{SE}$) is not feasible!')
            p_2(t) = 0;
            cost_2(t, 2) = 0;
            E_2(t, 2) = 0;
            % 'I_s=1' can never be chosen if MEC server execution goal is inf
            J_s_2 = inf;
        % Similarly, we do not check whether the energy cunsumed is larger than
        % battery energy level because the problem $\mathcal{J}_{CO}$ does
        % not have constraint (8).
        end
        
 
       
        %% step 3: choose the best execution mode
        J_d_2 = V_2 * phi;
        disp(['J_m:', num2str(J_m_2)])
        disp(['J_s:', num2str(J_s_2)])
        [~, mode_2] = min([J_m_2, J_s_2, J_d_2]);
        chosen_mode_2(t) = mode_2;
        
    end
    
       %% case three: step 2: get the optimal computation offloading strategy (I_m, I_s, I_d, f(t), p(t))
    if zeta == 0
        % chosen mode has to be 4
        disp('no task request generated!')
        chosen_mode_3(t) = 4;
    else
        % chosen_mode is chosen from {1, 2, 3}
        disp('task request generated!')
        % task request exists, generate the channel power gain
        h = exprnd(g0 / power(d, 4));
    
        %% step 2.1: solve the optimization problem $\mathcal{P}_{ME}$ (f(t) > 0)
        % calculate f_L and f_U
        f_L_3 = max(sqrt(E_min_3 / (k * W)), W / tau_d);
        f_U_3 = min(sqrt(E_max / (k * W)), f_max);
        if f_L_3 <= f_U_3
            % the sub-problem is feasible
            disp('mobile execution ($\mathcal{P}_{ME}$) is feasible!')
            
            if B_hat_3(t) < 0
                f_0_3 = (V_3 / (-2 * B_hat_3(t) * k))^(1/3);
            else
                % complex number may exist, which may lead to error
                f_0_3 = -(V_3 / (2 * B_hat_3(t) * k))^(1/3);
            end
            
            if (f_0_3 > f_U_3 && B_hat_3(t) < 0) || (B_hat_3(t) >= 0)
                f_3(t) = f_U_3;
            elseif f_0_3 >= f_L_3 && f_0_3 <= f_U_3 && B_hat_3(t) < 0
                f_3(t) = f_0_3;
            elseif f_0_3 < f_L_3 && B_hat_3(t) < 0
                f_3(t) = f_L_3;
            end
            % check whether f(t) is zero
            if f_3(t) == 0
                disp('Something wrong! f is 0!')
            end
            % calculate the delay of mobile execution
            cost_3(t, 1) = W / f_3(t);
            % calculate the energy consumption of mobile execution
            E_3(t, 1) = k * W * (f_3(t)^2);
            % calculate the value of optimization goal
            J_m_3 = -B_hat_3(t) * k * W * (f_3(t))^2 + V_3 * W / f_3(t);

        else
            % the sub-problem is not fasible because (i) the limited 
            % computation capacity or (ii) time cosumed out of deadline or 
            % (iii) the energy consumed out of battery energy level
            % If it is not feasible, it just means that we cannot choose 
            % 'I_m=1'. It dosen't mean that the task has to be dropped.
            disp('mobile execution ($\mathcal{P}_{ME}$) is not feasible!')
            f_3(t) = 0;
            cost_3(t, 1) = 0;
            E_3(t, 1) = 0;
            % 'I_m=1' can never be chosen if mobile execution goal is inf
            J_m_3 = inf;

        % Attention! We do not check whether the energy cunsumed is larger than
        % battery energy level because the problem $\mathcal{J}_{CO}$ does
        % not have constraint (8).
        end
        
        
            
        %% step 2.2: solve the optimization problem $\mathcal{P}_{SE}$ (p(t) > 0)
        E_tmp = sigma * L * log(2) / (omega * h);% simplify the expression
        p_L_taud = (power(2, L / (omega * tau_d)) - 1) * sigma / h;
        % calculate p_L
        if E_tmp >= E_min_3
            p_L_3 = p_L_taud;
        else
            % calculate p_E_min (use inline function and fsolve)
            y = @(x) x * L - omega * log2(1 + h*x/sigma) * E_min_3;
            % accroding to the function figure, p_L_taud is a positive 
            % number around 0.2
            p_E_min = fsolve(y, 0.2, opt);
            p_L_3 = max(p_L_taud, p_E_min);
        end
        % calculate p_U
        if E_tmp >= E_max
            p_U_3 = 0;
        else
            % caculate p_E_max (use inline function and fsolve)
            y = @(x) x * L - omega * log2(1 + h*x/sigma) * E_max;
            % accroding to the function figure, p_E_max is a large positive
            % number around 20
            p_E_max = fsolve(y, 100, opt);
            p_U_3 = min(p_tx_max, p_E_max);
        end
   
        if p_L_3 <= p_U_3
            % the sub-problem is feasible
            disp('MEC server execution ($\mathcal{P}_{SE}$) is feasible!')
            % calculate p_0
            virtual_battery = B_hat_3(t);
            y = @(x) virtual_battery * log2(1 + h*x/sigma) + ...
                h * (V_3 - virtual_battery*x) / log(2) / (sigma + h*x);
            p_0_3 = fsolve(y, 0.5, opt);

            if (p_U_3 < p_0_3 && B_hat_3(t) < 0) || B_hat_3(t) >= 0
                p_3(t) = p_U_3;
            elseif p_0_3 < p_L_3 && B_hat_3(t) < 0
                p_3(t) = p_L_3;
            elseif p_0_3 >= p_L_3 && p_0_3 <= p_U_3 && B_hat_3(t) < 0
                p_3(t) = p_0_3;
            end
            % check whether p(t) is zero
            if p_3(t) == 0
                disp('Something wrong! p is 0!')
            end
            
            % calculate the delay of MEC server execution
            cost_3(t, 2) = L / (omega * log2(1 + h*p_3(t)/sigma));
            % calculate the energy consumption of MEC server execution
            E_3(t, 2) = p_3(t) * cost_3(t, 2);
            % calculate the value of optimization goal
            J_s_3 = (-B_hat_3(t) * p_3(t) + V_3) * cost_3(t, 2);
        else
            % the sub-problem is not feasible because (i) the limited transmit 
            % power or (ii) time cosumed out of deadline or (iii) the energy 
            % consumed out of battery energy level
            % If it is not feasible, it just means that we cannot choose 
            % 'I_s=1'. It dosen't mean that the task has to be dropped.
            disp('MEC server execution ($\mathcal{P}_{SE}$) is not feasible!')
            p_3(t) = 0;
            cost_3(t, 2) = 0;
            E_3(t, 2) = 0;
            % 'I_s=1' can never be chosen if MEC server execution goal is inf
            J_s_3 = inf;
        % Similarly, we do not check whether the energy cunsumed is larger than
        % battery energy level because the problem $\mathcal{J}_{CO}$ does
        % not have constraint (8).
        end
        
 
       
        %% step 3: choose the best execution mode
        J_d_3 = V_3 * phi;
        disp(['J_m:', num2str(J_m_3)])
        disp(['J_s:', num2str(J_s_3)])
        [~, mode_3] = min([J_m_3, J_s_3, J_d_3]);
        chosen_mode_3(t) = mode_3;
        
    end
    
    %% case one: step 4: according to the chosen execution mode, calculate the real dealy and energy consumption
    if chosen_mode_1(t) == 1
        % mobile execution is chosen
        cost_1(t, 3) = cost_1(t, 1);
        E_1(t, 3) = E_1(t, 1);
    elseif chosen_mode_1(t) == 2
        % MEC server execution is chosen
        cost_1(t, 3) = cost_1(t, 2);
        E_1(t, 3) = E_1(t, 2);
    elseif chosen_mode_1(t) == 3
        % task is dropped, the delay is the task dropping penalty and the 
        % energy consumption is zero
        cost_1(t, 3) = phi;
        E_1(t, 3) = 0;
    else
        % no task is requested, the delay and the energy consumption are
        % both zero
        cost_1(t, 3) = 0;
        E_1(t, 3) = 0;
    end
    
    %% case two: step 4: according to the chosen execution mode, calculate the real dealy and energy consumption
    if chosen_mode_2(t) == 1
        % mobile execution is chosen
        cost_2(t, 3) = cost_2(t, 1);
        E_2(t, 3) = E_2(t, 1);
    elseif chosen_mode_2(t) == 2
        % MEC server execution is chosen
        cost_2(t, 3) = cost_2(t, 2);
        E_2(t, 3) = E_2(t, 2);
    elseif chosen_mode_2(t) == 3
        % task is dropped, the delay is the task dropping penalty and the 
        % energy consumption is zero
        cost_2(t, 3) = phi;
        E_2(t, 3) = 0;
    else
        % no task is requested, the delay and the energy consumption are
        % both zero
        cost_2(t, 3) = 0;
        E_2(t, 3) = 0;
    end
    
    %% case three: step 4: according to the chosen execution mode, calculate the real dealy and energy consumption
    if chosen_mode_3(t) == 1
        % mobile execution is chosen
        cost_3(t, 3) = cost_3(t, 1);
        E_3(t, 3) = E_3(t, 1);
    elseif chosen_mode_3(t) == 2
        % MEC server execution is chosen
        cost_3(t, 3) = cost_3(t, 2);
        E_3(t, 3) = E_3(t, 2);
    elseif chosen_mode_3(t) == 3
        % task is dropped, the delay is the task dropping penalty and the 
        % energy consumption is zero
        cost_3(t, 3) = phi;
        E_3(t, 3) = 0;
    else
        % no task is requested, the delay and the energy consumption are
        % both zero
        cost_3(t, 3) = 0;
        E_3(t, 3) = 0;
    end
    
     %% step 5: update the battery energy level and go to next time slot
    B_1(t + 1) = B_1(t) - E_1(t, 3) + e_1(t);
    B_2(t + 1) = B_2(t) - E_2(t, 3) + e_2(t);
    B_3(t + 1) = B_3(t) - E_3(t, 3) + e_3(t);
    
    t = t + 1;
    
end
%% step 6: evaluate the simulation results
% 1. the battery energy level vs. time slot
figure
plot(1:T, B_1(1:T),'r');
hold on
plot(1:T, B_2(1:T),'g');
hold on
plot(1:T, B_3(1:T),'b');
%hold on
%plot(1:T, repmat(theta_1 + E_H_max, [T, 1]), 'k')
title('Evolution of battery energy level')
legend('V=1.6e-4 J^2/second£¬E_m=0.02mJ','V=1e-5 J^2/second£¬E_m=0.02mJ','V=1e-5 J^2/second£¬E_m=0.04mJ')
xlabel('time slot')
ylabel('battery energy level $B_t$', 'Interpreter','latex')

% 2.case one the average execution cost vs. time slot
accumulated = 0;
average_cost_1 = zeros(T, 1);
request_num = 0;
for t = 1: T
    accumulated = accumulated + cost_1(t, 3);
    if cost_1(t, 3) ~= 0
        % there exists task request
        request_num = request_num + 1;
    end
    average_cost_1(t) = accumulated / t;
end

% 2.case two the average execution cost vs. time slot
accumulated = 0;
average_cost_2 = zeros(T, 1);
request_num = 0;
for t = 1: T
    accumulated = accumulated + cost_2(t, 3);
    if cost_2(t, 3) ~= 0
        % there exists task request
        request_num = request_num + 1;
    end
    average_cost_2(t) = accumulated / t;
end
% 2.case three the average execution cost vs. time slot
accumulated = 0;
average_cost_3 = zeros(T, 1);
request_num = 0;
for t = 1: T
    accumulated = accumulated + cost_3(t, 3);
    if cost_3(t, 3) ~= 0
        % there exists task request
        request_num = request_num + 1;

    end
    average_cost_3(t) = accumulated / t;
end
%%
figure
plot(1:T, average_cost_1,'r','linewidth',2);
hold on
plot(1:T, average_cost_2,'g','linewidth',2);
hold on
plot(1:T, average_cost_3,'b','linewidth',2);
title('Evolution of average execution cost')
legend('V=1.6e-4 J^2/second£¬E_m=0.02mJ','V=1e-5 J^2/second£¬E_m=0.02mJ','V=1e-5 J^2/second£¬E_m=0.04mJ')
xlabel('time slot')
ylabel('average execution cost $\frac{1}{T} \sum_{t=0}^{T-1} cost^t$', 'Interpreter','latex')

