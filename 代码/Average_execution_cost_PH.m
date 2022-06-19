%% E_min=0.02mJ p=0.6 V=1.6e-4
Average_cost=zeros(16,1);
Average_cost_ME=zeros(16,1);
Average_cost_SE=zeros(16,1);
Average_cost_DY=zeros(16,1);


% P_H=6mW
Average_cost(1,1)=3.772258125165175e-04;
Average_cost_ME(1,1)=9.005430566160410e-04;
Average_cost_SE(1,1)=5.181140944537471e-04;
Average_cost_DY(1,1)=4.654874603118483e-04;

% P_H=7mW
Average_cost(2,1)=3.115686294504991e-04;
Average_cost_ME(2,1)=8.540975484731036e-04;
Average_cost_SE(2,1)=4.783102694501451e-04;
Average_cost_DY(2,1)=4.227122370814740e-04;

% P_H=8mW
Average_cost(3,1)=2.756773311210270e-04;
Average_cost_ME(3,1)=8.204082713082005e-04;
Average_cost_SE(3,1)=4.583983119809969e-04;
Average_cost_DY(3,1)=4.017094911933190e-04;

% P_H=9mW
Average_cost(4,1)=2.476151385179629e-04;
Average_cost_ME(4,1)=7.891360697522546e-04;
Average_cost_SE(4,1)=4.350772649643096e-04;
Average_cost_DY(4,1)=3.767605727032676e-04;

% P_H=10mW
Average_cost(5,1)=2.310376400202388e-04;
Average_cost_ME(5,1)=7.646339058266762e-04;
Average_cost_SE(5,1)=4.133944092007288e-04;
Average_cost_DY(5,1)=3.553403380334675e-04;

%  P_H=11mW
Average_cost(6,1)=2.151767292652813e-04;
Average_cost_ME(6,1)=7.420906449594881e-04;
Average_cost_SE(6,1)=4.024158585862252e-04;
Average_cost_DY(6,1)=3.440273957586401e-04;

% P_H=12mW
Average_cost(7,1)=2.058757733318060e-04;
Average_cost_ME(7,1)=7.179037454403700e-04;
Average_cost_SE(7,1)=3.866134871721003e-04;
Average_cost_DY(7,1)=3.286812588554712e-04;

% P_H=13mW
Average_cost(8,1)=1.914421485276694e-04;
Average_cost_ME(8,1)=6.812307789106058e-04;
Average_cost_SE(8,1)=3.611338713771298e-04;
Average_cost_DY(8,1)=3.048527125577644e-04;

% P_H=14mW
Average_cost(9,1)=1.889972243339710e-04;
Average_cost_ME(9,1)=6.756688703875234e-04;
Average_cost_SE(9,1)=3.616536367880372e-04;
Average_cost_DY(9,1)=3.034174065265454e-04;


figure
plot(1:9,Average_cost(1:9),'r','linewidth',2)
hold on
plot(1:9,Average_cost_ME(1:9),'b','linewidth',2)
hold on
plot(1:9,Average_cost_SE(1:9),'g','linewidth',2)
hold on
plot(1:9,Average_cost_DY(1:9),'k','linewidth',2)
hold on 
legend('LODCO','Mobile Execution','MEC Server Execution','Dynamic Offloading')
title('Execution vs.P_H')
xlabel('EH power(mW)')
ylabel('Average Execution Cost')