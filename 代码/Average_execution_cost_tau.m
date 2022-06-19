%% E_min=0.02mJ V=1e-4
Average_cost=zeros(16,1);
Average_cost_ME=zeros(16,1);
Average_cost_SE=zeros(16,1);
Average_cost_DY=zeros(16,1);


%  tau=0.2
Average_cost(1,1)=3.480847725235698e-04;
Average_cost_ME(1,1)=0.001202900000000;
Average_cost_SE(1,1)=6.338489271536913e-04;
Average_cost_DY(1,1)=6.338489271536913e-04;

%  tau=0.4
Average_cost(2,1)=2.136230891599039e-04;
Average_cost_ME(2,1)=0.001195600000000;
Average_cost_SE(2,1)=4.338498832963279e-04;
Average_cost_DY(2,1)=4.338498832963279e-04;

%  tau=0.6
Average_cost(3,1)=1.828551012042042e-04;
Average_cost_ME(3,1)=9.005900475112823e-04;
Average_cost_SE(3,1)=3.740026750652657e-04;
Average_cost_DY(3,1)=3.347610180563073e-04;

%  tau=0.8
Average_cost(4,1)=1.839527500661399e-04;
Average_cost_ME(4,1)=8.129437875543123e-04;
Average_cost_SE(4,1)=3.601503404000351e-04;
Average_cost_DY(4,1)=3.159411494675396e-04;

%   tau=1
Average_cost(5,1)=1.882476490251769e-04;
Average_cost_ME(5,1)=7.399968479079494e-04;
Average_cost_SE(5,1)=3.643995105318286e-04;
Average_cost_DY(5,1)=3.128705075334596e-04;

% tau=1.2
Average_cost(6,1)=1.890715654976923e-04;
Average_cost_ME(6,1)=7.144727454666109e-04;
Average_cost_SE(6,1)=3.637368022627588e-04;
Average_cost_DY(6,1)=3.096694917120760e-04;

% tau=1.4
Average_cost(7,1)=1.858845849180528e-04;
Average_cost_ME(7,1)=6.855055154096986e-04;
Average_cost_SE(7,1)=3.512909746892011e-04;
Average_cost_DY(7,1)=2.983706688534086e-04;

%tau=1.6
Average_cost(8,1)=1.859228996752176e-04;
Average_cost_ME(8,1)=6.765062912048842e-04;
Average_cost_SE(8,1)=3.567202925082885e-04;
Average_cost_DY(8,1)=3.008421156993474e-04;

%tau=1.8
Average_cost(9,1)=1.870480490016175e-04;
Average_cost_ME(9,1)=6.723757901758381e-04;
Average_cost_SE(9,1)=3.583540505503588e-04;
Average_cost_DY(9,1)=3.013001482690959e-04;

%  tau=2
Average_cost(10,1)=1.855294185853106e-04;
Average_cost_ME(10,1)=6.700753168532634e-04;
Average_cost_SE(10,1)=3.511999231234694e-04;
Average_cost_DY(10,1)=2.951068703802677e-04;

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
xlabel('Deadline(ms)')
ylabel('Average Execution Cost')






