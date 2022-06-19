%% E_min=0.02mJ V=1e-4
Average_completion=zeros(10,1);
Average_completion_ME=zeros(10,1);
Average_completion_SE=zeros(10,1);
Average_completion_DY=zeros(10,1);


% tau=0.2
Average_completion(1,1)=5.787426594456227e-04;
Average_completion_ME(1,1)=1.515313534307246e-04;
Average_completion_SE(1,1)=1.515313534307246e-04;
Average_completion_DY(1,1)=NaN;

%  tau=0.4
Average_completion(2,1)=3.573487607224890e-04;
Average_completion_ME(2,1)=NaN;
Average_completion_SE(2,1)=2.019352845423033e-04;
Average_completion_DY(2,1)=2.019352845423033e-04;

%  tau=0.6
Average_completion(3,1)=3.069841370002589e-04;
Average_completion_ME(3,1)=5.365720992259703e-04;
Average_completion_SE(3,1)=2.267361142661901e-04;
Average_completion_DY(3,1)=2.444374217182262e-04;

%  tau=0.8
Average_completion(4,1)=3.077676929331435e-04;
Average_completion_ME(4,1)=6.554536387914853e-04;
Average_completion_SE(4,1)=2.417647413957577e-04;
Average_completion_DY(4,1)=2.709941009880134e-04;

%   tau=1
Average_completion(5,1)=3.145849749752287e-04;
Average_completion_ME(5,1)=7.717043503842302e-04;
Average_completion_SE(5,1)=2.571179031236311e-04;
Average_completion_DY(5,1)=3.033982870124180e-04;

% tau=1.2
Average_completion(6,1)=3.109729695685728e-04;
Average_completion_ME(6,1)=8.546991218693201e-04;
Average_completion_SE(6,1)=2.659955285102268e-04;
Average_completion_DY(6,1)=3.239380336793065e-04;

%  tau=1.4
Average_completion(7,1)=3.075522583025362e-04;
Average_completion_ME(7,1)=9.094623640922683e-04;
Average_completion_SE(7,1)=2.728921947416252e-04;
Average_completion_DY(7,1)=3.398443998056456e-04;

%  tau=1.6
Average_completion(8,1)=3.088163768378334e-04;
Average_completion_ME(8,1)=9.538098179751469e-04;
Average_completion_SE(8,1)=2.771582647317410e-04;
Average_completion_DY(8,1)=3.626250624478491e-04;

% tau=1.8
Average_completion(9,1)=3.104789592524152e-04;
Average_completion_ME(9,1)=9.833443875063438e-04;
Average_completion_SE(9,1)=2.872110279218533e-04;
Average_completion_DY(9,1)=3.812256328719147e-04;

% tau=2
Average_completion(10,1)=3.097319175046922e-04;
Average_completion_ME(10,1)=0.001013409300791;
Average_completion_SE(10,1)=2.930859163948485e-04;
Average_completion_DY(10,1)=3.925705365502456e-04;

figure
plot(1:10,Average_completion(1:10),'r','linewidth',2)
hold on
plot(1:10,Average_completion_ME(1:10),'b','linewidth',2)
hold on
plot(1:10,Average_completion_SE(1:10),'g','linewidth',2)
hold on
plot(1:10,Average_completion_DY(1:10),'k','linewidth',2)
hold on
legend('LODCO','Mobile Execution','MEC Server Execution','Dynamic Offloading')
xlabel('Deadline(ms)')
ylabel('Average completion time of the executed tasks(s)')






