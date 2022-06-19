%% E_min=0.02mJ V=1e-4
Ratio=zeros(10,1);
Ratio_ME=zeros(10,1);
Ratio_SE=zeros(10,1);
Ratio_DY=zeros(10,1);


% d=20
Ratio(1,1)=0;
Ratio_ME(1,1)=0.121789009892759;
Ratio_SE(1,1)=0.010557818605038;
Ratio_DY(1,1)=0.006318064677031;

% d=30
Ratio(2,1)=0;
Ratio_ME(2,1)=0.126714620274339;
Ratio_SE(2,1)=0.044831047172968;
Ratio_DY(2,1)=0.024171963867514;

% d=40
Ratio(3,1)=0;
Ratio_ME(3,1)=0.123162528029233;
Ratio_SE(3,1)=0.107715306037705;
Ratio_DY(3,1)=0.050577194585167;

% d=50
Ratio(4,1)=0;
Ratio_ME(4,1)=0.119039651999331;
Ratio_SE(4,1)=0.192738832190062;
Ratio_DY(4,1)=0.073448218169650;

% d=60
Ratio(5,1)=0;
Ratio_ME(5,1)=0.121991978609626;
Ratio_SE(5,1)=0.307904411764706;
Ratio_DY(5,1)=0.087984625668449;

%d=70
Ratio(6,1)=0;
Ratio_ME(6,1)=0.123273026315789;
Ratio_SE(6,1)=0.411430921052632;
Ratio_DY(6,1)=0.093009868421053;

% d=80
Ratio(7,1)=0;
Ratio_ME(7,1)=0.119788219722038;
Ratio_SE(7,1)=0.514146260754467;
Ratio_DY(7,1)=0.094060225016545;


figure
plot(1:7,Ratio(1:7),'r','linewidth',2)
hold on
plot(1:7,Ratio_ME(1:7),'b','linewidth',2)
hold on
plot(1:7,Ratio_SE(1:7),'g','linewidth',2)
hold on
plot(1:7,Ratio_DY(1:7),'k','linewidth',2)
hold on
legend('LODCO','Mobile Execution','MEC Server Execution','Dynamic Offloading')
xlabel('Distance form the mobile device to the MEC server(m)')
ylabel('Ratio of dropped tasks')






