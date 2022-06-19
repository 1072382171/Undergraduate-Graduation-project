%% E_min=0.02mJ p=0.6
Average_cost=zeros(16,1);
Average_cost_ME=zeros(16,1);
Average_cost_SE=zeros(16,1);
Average_cost_DY=zeros(16,1);


% V=1e-5
Average_cost(1,1)=4.679037297086630e-04;
Average_cost_ME(1,1)=7.042926105582667e-04;
Average_cost_SE(1,1)=3.757616440155898e-04;
Average_cost_DY(1,1)=3.176334786583761e-04;

% V=2e-5
Average_cost(2,1)=2.902798715323248e-04;
Average_cost_ME(2,1)=7.177185210226062e-04;
Average_cost_SE(2,1)=3.853696463049859e-04;
Average_cost_DY(2,1)=3.269978883820592e-04;

% V=3e-5
Average_cost(3,1)=2.364889038653420e-04;
Average_cost_ME(3,1)=7.088065238230815e-04;
Average_cost_SE(3,1)=3.786664247400107e-04;
Average_cost_DY(3,1)=3.223431110777214e-04;

% V=4e-5
Average_cost(4,1)=2.222826347176478e-04;
Average_cost_ME(4,1)=7.111498582078473e-04;
Average_cost_SE(4,1)=3.841373474011212e-04;
Average_cost_DY(4,1)=3.236858086204225e-04;

% V=5e-5
Average_cost(5,1)=2.118239815597109e-04;
Average_cost_ME(5,1)=7.142965040231657e-04;
Average_cost_SE(5,1)=3.842223547656718e-04;
Average_cost_DY(5,1)=3.256347666874744e-04;

% V=6e-5
Average_cost(6,1)=2.030609846736479e-04;
Average_cost_ME(6,1)=7.053634958225119e-04;
Average_cost_SE(6,1)=3.775410779273958e-04;
Average_cost_DY(6,1)=3.200624505838079e-04;

% V=7e-5
Average_cost(7,1)=2.021449713048062e-04;
Average_cost_ME(7,1)=7.069855743975801e-04;
Average_cost_SE(7,1)=3.830829629457715e-04;
Average_cost_DY(7,1)=3.248676647340151e-04;

% V=8e-5
Average_cost(8,1)=2.016408928076577e-04;
Average_cost_ME(8,1)=7.154417024859864e-04;
Average_cost_SE(8,1)=3.824069699467001e-04;
Average_cost_DY(8,1)=3.255252842083648e-04;

% V=9e-5
Average_cost(9,1)=2.032278539654567e-04;
Average_cost_ME(9,1)=7.156250641865191e-04;
Average_cost_SE(9,1)=3.851118511805521e-04;
Average_cost_DY(9,1)=3.246837771661426e-04;

% V=1e-4
Average_cost(10,1)=2.010079975198512e-04;
Average_cost_ME(10,1)=7.121978247549603e-04;
Average_cost_SE(10,1)=3.846842959712296e-04;
Average_cost_DY(10,1)=3.251789508233031e-04;

figure
plot(1:10,Average_cost(1:10),'r','linewidth',2)
hold on
plot(1:10,Average_cost_ME(1:10),'b','linewidth',2)
hold on
plot(1:10,Average_cost_SE(1:10),'g','linewidth',2)
hold on
plot(1:10,Average_cost_DY(1:10),'k','linewidth',2)
hold on 
legend('LODCO','Mobile Execution','MEC Server Execution','Dynamic Offloading')
title('Average execution cost vs. V,\rho=0.6 and E_{min}=0.02mJ')
xlabel('V(J¡¤second^-1)¡¤10^-4')
ylabel('Average Execution Cost')






