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
E_H_max =48e-6;          % the upper bound of the energy arrive at the mobile device (in J)
p_H = E_H_max /(2*tau);  % the average Energy Harvesting (EH) power (in W)

g0 = power(10, -4);       % the path-loss constant

%% parameter control
T = 20000;                % the number of time slot (a.k.a. the size of the time horizon)
tau_d = 0.002;            % execution deadline (in second)
d = 40;                   % the distance between the mobile device and the MEC server (in meter)
E_min = 0.02e-3;          % the minimum amout of battery output energy (in J)
V = 1.6e-4;               % the weight of penalty (the control parameter introduced by Lyapunov Optimization)
rho = 0.6;                % the probability that the computation task is requested

% the lower bound of perturbation parameter
E_max_hat = min(max(k * W * (f_max)^2, p_tx_max * tau), E_max);
theta = E_max_hat + V * phi / E_min;

%% allocate storage for valuable results
B = zeros(T, 1);          % the battery energy level (in J)
B_hat = zeros(T, 1);      % the virtual battery energy level ($B_hat = B - theta$)
e = zeros(T, 1);          % the amout of the harvested and stored energy (in J)
B_ME = zeros(T, 1);         
B_hat_ME = zeros(T, 1);    
e_ME = zeros(T, 1);         
B_SE = zeros(T, 1);         
B_hat_SE = zeros(T, 1);     
e_SE = zeros(T, 1);    
B_DY = zeros(T, 1);         
B_hat_DY = zeros(T, 1);     
e_DY = zeros(T, 1);    
chosen_mode = zeros(T, 1);% {1: local, 2: remote, 3: drop, 4: no task request}
f = zeros(T, 1);          % the CPU-cycle frequency of local execution (in Hz)
p = zeros(T, 1);          % the transmit power of computation offloading (in W)
cost = zeros(T, 3);       % execution delay for mobile execution, MEC server execution and final choice, respectively (in second)
E = zeros(T, 3);          % energy consumption for mobile execution, MEC server execution and final choice, respectively (in J)
E_ME=zeros(T, 1);
E_SE=zeros(T, 1);
E_DY=zeros(T,1);
cost_LO=zeros(T, 2);
cost_ME = zeros(T, 2); 
cost_SE=zeros(T,2);
cost_DY=zeros(T,2);
com=zeros(10,1);
com_ME=zeros(10,1);
com_SE=zeros(10,1);
com_DY=zeros(10,1);
l=1;
ACT_NUM=0;
%% simulation begin

 t = 1;
while t <= T
    disp(['===> Time slot #', num2str(t), ' <==='])
    
    %% initialization
    % generate the task request
    zeta = binornd(1, rho);
    % generate the virtual battery energy level
    B_hat(t) = B(t) - theta;
    B_hat_ME(t) = B_ME(t) - theta;
    B_hat_SE(t) = B_SE(t) - theta;
    B_hat_DY(t) = B_DY(t) - theta;
    %% step 1: get the optimal energy harvesting no matter whether task is requested
    E_H_t = unifrnd(0, E_H_max);
    if B_hat(t) <= 0
        e(t) = E_H_t;
    end

    if B_hat_ME(t) <= 0
        e_ME(t) = E_H_t;
    end
    
    if B_hat_SE(t) <= 0
        e_SE(t) = E_H_t;
    end
    
    if B_hat_DY(t) <= 0
        e_SE(t) = E_H_t;
    end   
    
 
    %% step 2: get the optimal computation offloading strategy (I_m, I_s, I_d, f(t), p(t))
    if zeta == 0
        % chosen mode has to be 4
        disp('no task request generated!')
        chosen_mode(t) = 4;
        
    else
        % chosen_mode is chosen from {1, 2, 3}
        disp('task request generated!')
        % task request exists, generate the channel power gain
        h = exprnd(g0 / power(d, 4));
        ACT_NUM=ACT_NUM+1;
        

        %% Step2.1.1:Mobile Excution 
          
        f_U_ME=min(f_max,sqrt(min(B_ME(t),E_max)/(k*W)));
        if (W/f_U_ME)<=tau_d
            cost_ME(t, 1) =W/f_U_ME ; 
            cost_ME(t, 2)=1;
            E_ME(t, 1)=k*W*(f_U_ME)^2;
        else
            cost_ME(t,1)=phi;
        end
                  
        
        %% step2.1.2:MEC Server Excution
        tmp=sigma*L*log(2)/(omega*h);
        if tmp<min(B_SE(t),E_max)
            y = @(x) x * L - omega * log2(1 + h*x/sigma) *min(B_SE(t),E_max);
            PP=fsolve(y,20,opt);
            P_U_SE=min(p_tx_max,PP); 
            delay=L/(omega*log2(1+(h*P_U_SE)/sigma));
        if L/(omega*log2(1+(h*P_U_SE)/sigma))<tau_d
            cost_SE(t,1)=L/(omega*log2(1+(h*P_U_SE)/sigma));
            E_SE(t,1)=P_U_SE*L/(omega*log2(1+(h*P_U_SE)/sigma));
            cost_SE(t,2)=1;
        else
            cost_SE(t,1)=phi;
        end  
        
        else
             cost_SE(t,1)=phi;
             delay=phi;
        end

        %% step2.2.3:Dynamic Offloading(GD)
        if  delay<tau_d||(W/f_U_ME)<tau_d
            cost_DY(t,2)=1;
            if delay<=(W/f_U_ME)
                
                cost_DY(t,1)=delay;
                
                E_DY(t,1)=P_U_SE*delay;
                
            else
                cost_DY(t,1)=(W/f_U_ME);
                E_DY(t,1)=k*W*(f_U_ME)^2;
                
            end
        else
             cost_DY(t,1)=phi;
        end
         
        
        
        %% step 2.1: solve the optimization problem $\mathcal{P}_{ME}$ (f(t) > 0)
        % calculate f_L and f_U
        f_L = max(sqrt(E_min / (k * W)), W / tau_d);
        f_U = min(sqrt(E_max / (k * W)), f_max);
        if f_L <= f_U
            % the sub-problem is feasible
            disp('mobile execution ($\mathcal{P}_{ME}$) is feasible!')
            
            if B_hat(t) < 0
                f_0 = (V / (-2 * B_hat(t) * k))^(1/3);
            else
                % complex number may exist, which may lead to error
                f_0 = -(V / (2 * B_hat(t) * k))^(1/3);
            end
            
            if (f_0 > f_U && B_hat(t) < 0) || (B_hat(t) >= 0)
                f(t) = f_U;
            elseif f_0 >= f_L && f_0 <= f_U && B_hat(t) < 0
                f(t) = f_0;
            elseif f_0 < f_L && B_hat(t) < 0
                f(t) = f_L;
            end
            % check whether f(t) is zero
            if f(t) == 0
                disp('Something wrong! f is 0!')
            end
            
            % calculate the delay of mobile execution
            cost(t, 1) = W / f(t);
            % calculate the energy consumption of mobile execution
            E(t, 1) = k * W * (f(t)^2);
            % calculate the value of optimization goal
            J_m = -B_hat(t) * k * W * (f(t))^2 + V * W / f(t);
        else
            % the sub-problem is not fasible because (i) the limited 
            % computation capacity or (ii) time cosumed out of deadline or 
            % (iii) the energy consumed out of battery energy level
            % If it is not feasible, it just means that we cannot choose 
            % 'I_m=1'. It dosen't mean that the task has to be dropped.
            disp('mobile execution ($\mathcal{P}_{ME}$) is not feasible!')
            f(t) = 0;
            cost(t, 1) = 0;
            E(t, 1) = 0;
            % 'I_m=1' can never be chosen if mobile execution goal is inf
            J_m = inf;
        % Attention! We do not check whether the energy cunsumed is larger than
        % battery energy level because the problem $\mathcal{J}_{CO}$ does
        % not have constraint (8).
        end
        
        %% step 2.2: solve the optimization problem $\mathcal{P}_{SE}$ (p(t) > 0)
        E_tmp = sigma * L * log(2) / (omega * h);
        p_L_taud = (power(2, L / (omega * tau_d)) - 1) * sigma / h;
        % calculate p_L
        if E_tmp >= E_min
            p_L = p_L_taud;
        else
            % calculate p_E_min (use inline function and fsolve)
            y = @(x) x * L - omega * log2(1 + h*x/sigma) * E_min;
            % accroding to the function figure, p_L_taud is a positive 
            % number around 0.2
            p_SE = fsolve(y, 0.2, opt);
            p_L = max(p_L_taud, p_SE);
        end
        % calculate p_U
        if E_tmp >= E_max
            p_U = 0;
        else
            % caculate p_E_max (use inline function and fsolve)
            y = @(x) x * L - omega * log2(1 + h*x/sigma) * E_max;
            % accroding to the function figure, p_E_max is a large positive
            % number around 20
            p_E_max = fsolve(y, 100, opt);
            p_U = min(p_tx_max, p_E_max);
        end
        
        if p_L <= p_U
            % the sub-problem is feasible
            disp('MEC server execution ($\mathcal{P}_{SE}$) is feasible!')
            % calculate p_0
            virtual_battery = B_hat(t);
            y = @(x) virtual_battery * log2(1 + h*x/sigma) + ...
                h * (V - virtual_battery*x) / log(2) / (sigma + h*x);
            p_0 = fsolve(y, 0.5, opt);

            if (p_U < p_0 && B_hat(t) < 0) || B_hat(t) >= 0
                p(t) = p_U;
            elseif p_0 < p_L && B_hat(t) < 0
                p(t) = p_L;
            elseif p_0 >= p_L && p_0 <= p_U && B_hat(t) < 0
                p(t) = p_0;
            end
            % check whether p(t) is zero
            if p(t) == 0
                disp('Something wrong! p is 0!')
            end
            
            % calculate the delay of MEC server execution
            cost(t, 2) = L / (omega * log2(1 + h*p(t)/sigma));
            % calculate the energy consumption of MEC server execution
            E(t, 2) = p(t) * cost(t, 2);
            % calculate the value of optimization goal
            J_s = (-B_hat(t) * p(t) + V) * cost(t, 2);
        else
            % the sub-problem is not feasible because (i) the limited transmit 
            % power or (ii) time cosumed out of deadline or (iii) the energy 
            % consumed out of battery energy level
            % If it is not feasible, it just means that we cannot choose 
            % 'I_s=1'. It dosen't mean that the task has to be dropped.
            disp('MEC server execution ($\mathcal{P}_{SE}$) is not feasible!')
            p(t) = 0;
            cost(t, 2) = 0;
            E(t, 2) = 0;
            % 'I_s=1' can never be chosen if MEC server execution goal is inf
            J_s = inf;
        % Similarly, we do not check whether the energy cunsumed is larger than
        % battery energy level because the problem $\mathcal{J}_{CO}$ does
        % not have constraint (8).
        end
        
        %% step 3: choose the best execution mode
        J_d = V * phi;
        disp(['J_m:', num2str(J_m)])
        disp(['J_s:', num2str(J_s)])
        [~, mode] = min([J_m, J_s, J_d]);
        chosen_mode(t) = mode;
    end
    
    %% step 4: according to the chosen execution mode, calculate the real dealy and energy consumption
    if chosen_mode(t) == 1
        % mobile execution is chosen
        cost(t, 3) = cost(t, 1);
        E(t, 3) = E(t, 1);
    elseif chosen_mode(t) == 2
        % MEC server execution is chosen
        cost(t, 3) = cost(t, 2);
        E(t, 3) = E(t, 2);
    elseif chosen_mode(t) == 3
        % task is dropped, the delay is the task dropping penalty and the 
        % energy consumption is zero
        cost(t, 3) = phi;
        E(t, 3) = 0;
    else
        % no task is requested, the delay and the energy consumption are
        % both zero
        cost(t, 3) = 0;
        E(t, 3) = 0;
    end
    
    %% step 5: update the battery energy level and go to next time slot
    B(t + 1) = B(t) - E(t, 3) + e(t);
    B_ME(t + 1) = B_ME(t) - E_ME(t, 1) + e_ME(t);
    B_SE(t + 1) = B_SE(t) - E_SE(t, 1) + e_SE(t);
    B_DY(t + 1) = B_DY(t) - E_DY(t, 1) + e_DY(t);
    t = t + 1;
end

%% step 6: evaluate the simulation results
accumulated = 0;
accumulated_ME = 0;
accumulated_SE = 0;
accumulated_DY = 0;
average_cost = zeros(T, 1);
average_cost_ME = zeros(T, 1);
average_cost_SE = zeros(T, 1);
average_cost_DY = zeros(T, 1);
num=0;
num_ME=0;
num_SE=0;
num_DY=0;
D_num=0;
D_num_ME=0;
D_num_SE=0;
D_num_DY=0;
ACT_E=0;
ACT_E_ME=0;
ACT_E_SE=0;
ACT_E_DY=0;
for t = 1: T
    accumulated = accumulated + cost(t, 3);
    accumulated_ME = accumulated_ME + cost_ME(t, 1);
    accumulated_SE = accumulated_SE + cost_SE(t, 1);
    accumulated_DY = accumulated_DY + cost_DY(t, 1);

    average_cost(t) = accumulated / t;
    average_cost_ME(t) = accumulated_ME / t;
    average_cost_SE(t) = accumulated_SE / t;
    average_cost_DY(t) = accumulated_DY / t;
    
    if cost(t,3)~=0
        num=num+1;
        ACT_E=ACT_E+cost(t, 3);
    end
    
    if cost_ME(t,2)==1
        num_ME=num_ME+1;
        ACT_E_ME=ACT_E_ME+cost_ME(t,1);
    end    
    
    if cost_SE(t,2)==1
        num_SE=num_SE+1;
        ACT_E_SE=ACT_E_SE+cost_SE(t,1);
    end  
    
    if cost_DY(t,2)==1
        num_DY=num_DY+1;
        ACT_E_DY=ACT_E_DY+cost_DY(t,1);
    end  
    
end

Averave=average_cost(T);
Averave_ME=average_cost_ME(T);
Averave_SE=average_cost_SE(T);
Averave_DY=average_cost_DY(T);

ACT_E=ACT_E/num;
ACT_E_ME=ACT_E_ME/num_ME;
ACT_E_SE=ACT_E_SE/num_SE;
ACT_E_DY=ACT_E_DY/num_DY;

D_num=ACT_NUM-num;
D_num_ME=ACT_NUM-num_ME;
D_num_SE=ACT_NUM-num_SE;
D_num_DY=ACT_NUM-num_DY;

D_num=D_num/ACT_NUM;
D_num_ME=D_num_ME/ACT_NUM;
D_num_SE=D_num_SE/ACT_NUM;
D_num_DY=D_num_DY/ACT_NUM;

%% »­Í¼
figure
plot(1:T, average_cost,'r','linewidth',2);
hold on
plot(1:T, average_cost_ME,'b','linewidth',2);
hold on
plot(1:T, average_cost_SE,'g','linewidth',2);
hold on
plot(1:T,average_cost_DY,'k','linewidth',2);
title('Envolution of average execution cost')
xlabel('time slot')
ylabel('average execution cost $\frac{1}{T} \sum_{t=0}^{T-1} cost^t$', 'Interpreter','latex')

