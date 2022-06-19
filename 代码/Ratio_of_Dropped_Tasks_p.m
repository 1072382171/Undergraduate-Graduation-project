%% E_min=0.02mJ V=1e-4
Ratio=zeros(10,1);
Ratio_ME=zeros(10,1);
Ratio_SE=zeros(10,1);
Ratio_DY=zeros(10,1);


% p=0.1
Ratio(1,1)=0;
Ratio_ME(1,1)=0;
Ratio_SE(1,1)=0.003460207612457;
Ratio_DY(1,1)=0;

% p=0.2
Ratio(2,1)=0;
Ratio_ME(2,1)=0.021044624746450;
Ratio_SE(2,1)=0.050963488843813;
Ratio_DY(2,1)=0.009634888438134;

% p=0.3
Ratio(3,1)=0;
Ratio_ME(3,1)=0.059368281792624;
Ratio_SE(3,1)=0.123366958822557;
Ratio_DY(3,1)=0.034727964279808;

%  p=0.4
Ratio(4,1)=0;
Ratio_ME(4,1)=0.083229967749938;
Ratio_SE(4,1)=0.147606053088564;
Ratio_DY(4,1)=0.048375093029025;

%  p=0.5
Ratio(5,1)=0;
Ratio_ME(5,1)=0.104853205512283;
Ratio_SE(5,1)=0.178250449370881;
Ratio_DY(5,1)=0.063810665068904;

%  p=0.6
Ratio(6,1)=0;
Ratio_ME(6,1)=0.120109643658111;
Ratio_SE(6,1)=0.192208655203921;
Ratio_DY(6,1)=0.072015948168453;

%  p=0.7
Ratio(7,1)=0;
Ratio_ME(7,1)=0.139665205833752;
Ratio_SE(7,1)=0.207917235433580;
Ratio_DY(7,1)=0.084273295495366;

%  p=0.8
Ratio(8,1)=0;
Ratio_ME(8,1)=0.155690878272333;
Ratio_SE(8,1)=0.227509573733442;
Ratio_DY(8,1)=0.095486220101701;

%  p=0.9
Ratio(9,1)=0;
Ratio_ME(9,1)=0.172094313453537;
Ratio_SE(9,1)=0.242163661581137;
Ratio_DY(9,1)=0.105131761442441;

%  p=1.0
Ratio(10,1)=0;
Ratio_ME(10,1)=0.186500000000000;
Ratio_SE(10,1)=0.262350000000000;
Ratio_DY(10,1)=0.114950000000000;

figure
plot(1:10,Ratio(1:10),'r','linewidth',2)
hold on
plot(1:10,Ratio_ME(1:10),'b','linewidth',2)
hold on
plot(1:10,Ratio_SE(1:10),'g','linewidth',2)
hold on
plot(1:10,Ratio_DY(1:10),'k','linewidth',2)
legend('LODCO','Mobile Execution','MEC Server Execution','Dynamic Offloading')
xlabel('Computation task request probability¡¤10^-1')
ylabel('Ratio of dropped tasks')






