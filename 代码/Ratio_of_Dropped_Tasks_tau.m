%% E_min=0.02mJ V=1e-4
Ratio=zeros(10,1);
Ratio_ME=zeros(10,1);
Ratio_SE=zeros(10,1);
Ratio_DY=zeros(10,1);


%  tau=0.2
Ratio(1,1)=0;
Ratio_ME(1,1)=1;
Ratio_SE(1,1)=0.488153628730568;
Ratio_DY(1,1)=0.488153628730568;

%  tau=0.4
Ratio(2,1)=0;
Ratio_ME(2,1)=1;
Ratio_SE(2,1)=0.291318166610907;
Ratio_DY(2,1)=0.291318166610907;

%   tau=0.6
Ratio(3,1)=0;
Ratio_ME(3,1)=0.666498782842273;
Ratio_SE(3,1)=0.226223453370268;
Ratio_DY(3,1)=0.180894820784017;

%   tau=0.8
Ratio(4,1)=0;
Ratio_ME(4,1)=0.524092354023758;
Ratio_SE(4,1)=0.205203279237075;
Ratio_DY(4,1)=0.148987786514974;

% tau=1
Ratio(5,1)=0;
Ratio_ME(5,1)=0.378509358288770;
Ratio_SE(5,1)=0.201871657754011;
Ratio_DY(5,1)=0.129344919786096;

% tau=1.2
Ratio(6,1)=0;
Ratio_ME(6,1)=0.279769736842105;
Ratio_SE(6,1)=0.191611842105263;
Ratio_DY(6,1)=0.110608552631579;

%   tau=1.4
Ratio(7,1)=0;
Ratio_ME(7,1)=0.206072137657181;
Ratio_SE(7,1)=0.178524156187955;
Ratio_DY(7,1)=0.092653871608206;

%tau=1.6
Ratio(8,1)=0;
Ratio_ME(8,1)=0.162361930072253;
Ratio_SE(8,1)=0.183041275641558;
Ratio_DY(8,1)=0.083713977244415;

% tau=1.8
Ratio(9,1)=0;
Ratio_ME(9,1)=0.130550253133040;
Ratio_SE(9,1)=0.179599966802224;
Ratio_DY(9,1)=0.073450078844717;

%  tau=2
Ratio(10,1)=0;
Ratio_ME(10,1)=0.106677796327212;
Ratio_SE(10,1)=0.171786310517529;
Ratio_DY(10,1)=0.062270450751252;

figure
plot(1:10,Ratio(1:10),'r','linewidth',2)
hold on
plot(1:10,Ratio_ME(1:10),'b','linewidth',2)
hold on
plot(1:10,Ratio_SE(1:10),'g','linewidth',2)
hold on
plot(1:10,Ratio_DY(1:10),'k','linewidth',2)
hold on
legend('LODCO','Mobile Execution','MEC Server Execution','Dynamic Offloading')
xlabel('Deadline(ms)')
ylabel('Ratio of dropped tasks')






