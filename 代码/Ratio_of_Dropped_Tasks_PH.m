%% E_min=0.02mJ V=1e-4
Ratio=zeros(10,1);
Ratio_ME=zeros(10,1);
Ratio_SE=zeros(10,1);
Ratio_DY=zeros(10,1);


% P_H=6mW
Ratio(1,1)=0;
Ratio_ME(1,1)=0.237939971574283;
Ratio_SE(1,1)=0.301396204330742;
Ratio_DY(1,1)=0.140372878521863;

%  P_H=7mW
Ratio(2,1)=0;
Ratio_ME(2,1)=0.201323172263630;
Ratio_SE(2,1)=0.268989196884683;
Ratio_DY(2,1)=0.116154425927477;

% P_H=8mW
Ratio(3,1)=0;
Ratio_ME(3,1)=0.180463714740102;
Ratio_SE(3,1)=0.253285343600904;
Ratio_DY(3,1)=0.108479116096091;

% P_H=9mW
Ratio(4,1)=0;
Ratio_ME(4,1)=0.162004175365344;
Ratio_SE(4,1)=0.234405010438413;
Ratio_DY(4,1)=0.095699373695198;

% P_H=10mW
Ratio(5,1)=0;
Ratio_ME(5,1)=0.146378018318068;
Ratio_SE(5,1)=0.218068276436303;
Ratio_DY(5,1)=0.084929225645296;

%  P_H=11mW
Ratio(6,1)=0;
Ratio_ME(6,1)=0.135727882148473;
Ratio_SE(6,1)=0.206571215757676;
Ratio_DY(6,1)=0.079864272117852;

% P_H=12mW
Ratio(7,1)=0;
Ratio_ME(7,1)=0.121237181607675;
Ratio_SE(7,1)=0.194922262652994;
Ratio_DY(7,1)=0.074263976182600;

% P_H=13mW
Ratio(8,1)=0;
Ratio_ME(8,1)=0.110886587522102;
Ratio_SE(8,1)=0.179085627683759;
Ratio_DY(8,1)=0.066094131514692;

% P_H=14mW
Ratio(9,1)=0;
Ratio_ME(9,1)=0.103206081639398;
Ratio_SE(9,1)=0.176417121137002;
Ratio_DY(9,1)=0.063708477937531;



figure
plot(1:9,Ratio(1:9),'r','linewidth',2)
hold on
plot(1:9,Ratio_ME(1:9),'b','linewidth',2)
hold on
plot(1:9,Ratio_SE(1:9),'g','linewidth',2)
hold on
plot(1:9,Ratio_DY(1:9),'k','linewidth',2)
hold on
legend('LODCO','Mobile Execution','MEC Server Execution','Dynamic Offloading')
title('Ratio of dropped tasks vs.P_H')
xlabel('EH power(mW)')
ylabel('Ratio of dropped tasks')






