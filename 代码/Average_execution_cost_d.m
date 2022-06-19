%% E_min=0.02mJ V=1e-4
Average_cost=zeros(16,1);
Average_cost_ME=zeros(16,1);
Average_cost_SE=zeros(16,1);
Average_cost_DY=zeros(16,1);


%  d=20
Average_cost(1,1)=6.937793885419751e-05;
Average_cost_ME(1,1)=7.156250641865191e-04;
Average_cost_SE(1,1)=8.015116431034232e-05;
Average_cost_DY(1,1)=7.838207527269847e-05;

% d=30
Average_cost(2,1)=9.794320678627579e-05;
Average_cost_ME(2,1)=7.121978247549603e-04;
Average_cost_SE(2,1)=1.494843018365856e-04;
Average_cost_DY(2,1)=1.395197059270263e-04;

% d=40
Average_cost(3,1)=1.367759692681561e-04;
Average_cost_ME(3,1)=7.046217490023635e-04;
Average_cost_SE(3,1)=2.442055903635463e-04;
Average_cost_DY(3,1)=2.195157143183325e-04;

% d=50
Average_cost(4,1)=2.009009031743159e-04;
Average_cost_ME(4,1)=7.078125393031422e-04;
Average_cost_SE(4,1)=3.749243682874513e-04;
Average_cost_DY(4,1)=3.192028163913706e-04;

% d=60
Average_cost(5,1)=2.971041898221442e-04;
Average_cost_ME(5,1)=7.107142157090086e-04;
Average_cost_SE(5,1)=5.255277324499065e-04;
Average_cost_DY(5,1)=4.165387512503838e-04;

% d=70
Average_cost(6,1)=4.076639377847878e-04;
Average_cost_ME(6,1)=7.264713251883550e-04;
Average_cost_SE(6,1)=6.639584513860626e-04;
Average_cost_DY(6,1)=4.992024326551178e-04;

% d=80
Average_cost(7,1)=4.973978884970390e-04;
Average_cost_ME(7,1)=7.180260522416572e-04;
Average_cost_SE(7,1)=7.732900262482902e-04;
Average_cost_DY(7,1)=5.512804405509938e-04;


figure
plot(1:7,Average_cost(1:7),'r','linewidth',2)
hold on
plot(1:7,Average_cost_ME(1:7),'b','linewidth',2)
hold on
plot(1:7,Average_cost_SE(1:7),'g','linewidth',2)
hold on
plot(1:7,Average_cost_DY(1:7),'k','linewidth',2)
hold on
legend('LODCO','Mobile Execution','MEC Server Execution','Dynamic Offloading')
xlabel('Distance form the mobile device to the MEC server(m)')
ylabel('Average Execution Cost')






