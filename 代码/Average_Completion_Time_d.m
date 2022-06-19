%% E_min=0.02mJ V=1e-4
Average_completion=zeros(10,1);
Average_completion_ME=zeros(10,1);
Average_completion_SE=zeros(10,1);
Average_completion_DY=zeros(10,1);


%  d=20
Average_completion(1,1)=1.153511328526021e-04;
Average_completion_ME(1,1)=0.001077480242686;
Average_completion_SE(1,1)=1.133442519078175e-04;
Average_completion_DY(1,1)=1.184339919228618e-04;

% d=30
Average_completion(2,1)=1.638394225263897e-04;
Average_completion_ME(2,1)=0.001074030887377;
Average_completion_SE(2,1)=1.679234708171399e-04;
Average_completion_DY(2,1)=1.896283636359417e-04;

%  d=40
Average_completion(3,1)=2.296247280586856e-04;
Average_completion_ME(3,1)=0.001072021639818;
Average_completion_SE(3,1)=2.320432898330297e-04;
Average_completion_DY(3,1)=2.862458589513012e-04;

% d=50
Average_completion(4,1)=3.361233113172426e-04;
Average_completion_ME(4,1)=0.001073995896502;
Average_completion_SE(4,1)=2.995323695077084e-04;
Average_completion_DY(4,1)=4.178454611617499e-04;

%  d=60
Average_completion(5,1)=4.964976434193586e-04;
Average_completion_ME(5,1)=0.001074827209191;
Average_completion_SE(5,1)=3.791566641311072e-04;
Average_completion_DY(5,1)=5.702954672476234e-04;

%d=70
Average_completion(6,1)=6.704998976723483e-04;
Average_completion_ME(6,1)=0.001081645859091;
Average_completion_SE(6,1)=4.573381343747909e-04;
Average_completion_DY(6,1)=7.001585504671680e-04;

% d=80
Average_completion(7,1)=8.229614303392437e-04;
Average_completion_ME(7,1)=0.001077492579402;
Average_completion_SE(7,1)=5.169079729208774e-04;
Average_completion_DY(7,1)=7.991606986594647e-04;



figure
plot(1:7,Average_completion(1:7),'r','linewidth',2)
hold on
plot(1:7,Average_completion_ME(1:7),'b','linewidth',2)
hold on
plot(1:7,Average_completion_SE(1:7),'g','linewidth',2)
hold on
plot(1:7,Average_completion_DY(1:7),'k','linewidth',2)
hold on
legend('LODCO','Mobile Execution','MEC Server Execution','Dynamic Offloading')
xlabel('Distance form the mobile device to the MEC server(m)')
ylabel('Average completion time of the executed tasks(s)')






