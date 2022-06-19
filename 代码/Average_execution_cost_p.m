%% E_min=0.02mJ V=1e-4
Average_cost=zeros(16,1);
Average_cost_ME=zeros(16,1);
Average_cost_SE=zeros(16,1);
Average_cost_DY=zeros(16,1);


% p=0.1
Average_cost(1,1)=2.125216546627778e-05;
Average_cost_ME(1,1)=4.774207718962294e-05;
Average_cost_SE(1,1)=1.718908092039862e-05;
Average_cost_DY(1,1)=1.624817032144217e-05;

% p=0.2
Average_cost(2,1)=4.794739044386727e-05;
Average_cost_ME(2,1)=1.359703233082803e-04;
Average_cost_SE(2,1)=6.378641102153347e-05;
Average_cost_DY(2,1)=5.190943365789918e-05;

% p=0.3
Average_cost(3,1)=7.772077649903354e-05;
Average_cost_ME(3,1)=2.661001039972779e-04;
Average_cost_SE(3,1)=1.335914468262778e-04;
Average_cost_DY(3,1)=1.093723199137128e-04;

%  p=0.4
Average_cost(4,1)=1.132281539675215e-04;
Average_cost_ME(4,1)=4.078854609505305e-04;
Average_cost_SE(4,1)=2.089171815386367e-04;
Average_cost_DY(4,1)=1.735532863987956e-04;

%  p=0.5
Average_cost(5,1)=1.575348852350407e-04;
Average_cost_ME(5,1)=5.669368142297107e-04;
Average_cost_SE(5,1)=2.949198195444002e-04;
Average_cost_DY(5,1)=2.474984424240273e-04;

%  p=0.6
Average_cost(6,1)=2.071708626475280e-04;
Average_cost_ME(6,1)=7.156250641865191e-04;
Average_cost_SE(6,1)=3.851118511805521e-04;
Average_cost_DY(6,1)=3.246837771661426e-04;

%  p=0.7
Average_cost(7,1)=2.563876906235133e-04;
Average_cost_ME(7,1)=8.661272128314561e-04;
Average_cost_SE(7,1)=4.700676179942373e-04;
Average_cost_DY(7,1)=4.008580851235834e-04;

%  p=0.8
Average_cost(8,1)=3.270079521015016e-04;
Average_cost_ME(8,1)=0.001047545984823;
Average_cost_SE(8,1)=5.756028587862718e-04;
Average_cost_DY(8,1)=4.968185025051409e-04;

%  p=0.9
Average_cost(9,1)=3.997825450973098e-04;
Average_cost_ME(9,1)=0.001214395985103;
Average_cost_SE(9,1)=6.701688438209037e-04;
Average_cost_DY(9,1)=5.856131840689045e-04;

%  p=1.0
Average_cost(10,1)=4.930772162619554e-04;
Average_cost_ME(10,1)=0.001387533506982;
Average_cost_SE(10,1)=7.783902388000620e-04;
Average_cost_DY(10,1)=6.792451097845075e-04;

figure
plot(1:10,Average_cost(1:10),'r','linewidth',2)
hold on
plot(1:10,Average_cost_ME(1:10),'b','linewidth',2)
hold on
plot(1:10,Average_cost_SE(1:10),'g','linewidth',2)
hold on
plot(1:10,Average_cost_DY(1:10),'k','linewidth',2)
legend('LODCO','Mobile Execution','MEC Server Execution','Dynamic Offloading')
xlabel('Computation task request probability¡¤10^-1')
ylabel('Average Execution Cost')






