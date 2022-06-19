%% E_min=0.02mJ V=1e-4
Average_completion=zeros(10,1);
Average_completion_ME=zeros(10,1);
Average_completion_SE=zeros(10,1);
Average_completion_DY=zeros(10,1);


% P_H=6mW
Average_completion(1,1)=6.307596564108645e-04;
Average_completion_ME(1,1)=0.001351493267397;
Average_completion_SE(1,1)=3.772477129098650e-04;
Average_completion_DY(1,1)=5.788513135807295e-04;

%  P_H=7mW
Average_completion(2,1)=5.218467958303310e-04;
Average_completion_ME(2,1)=0.001286982381196;
Average_completion_SE(2,1)=3.599731228093687e-04;
Average_completion_DY(2,1)=5.382077640354047e-04;

% P_H=8mW
Average_completion(3,1)=4.615005124650991e-04;
Average_completion_ME(3,1)=0.001235437179671;
Average_completion_SE(3,1)=3.492844120188415e-04;
Average_completion_DY(3,1)=5.109557622633149e-04;

% P_H=9mW
Average_completion(4,1)=4.135534672533826e-04;
Average_completion_ME(4,1)=0.001186120716995;
Average_completion_SE(4,1)=3.367741382293298e-04;
Average_completion_DY(4,1)=4.841824225750810e-04;

% P_H=10mW
Average_completion(5,1)=3.847421149379498e-04;
Average_completion_ME(5,1)=0.001148720065990;
Average_completion_SE(5,1)=3.226374384000586e-04;
Average_completion_DY(5,1)=4.610379218079631e-04;

% P_H=11mW
Average_completion(6,1)=3.561644115952682e-04;
Average_completion_ME(6,1)=0.001107135200535;
Average_completion_SE(6,1)=3.187980777850118e-04;
Average_completion_DY(6,1)=4.452732429549315e-04;

% P_H=12mW
Average_completion(7,1)=3.405156687591895e-04;
Average_completion_ME(7,1)=0.001075294081386;
Average_completion_SE(7,1)=3.100431169432325e-04;
Average_completion_DY(7,1)=4.268023206279745e-04;

% P_H=13mW
Average_completion(8,1)=3.223745870635167e-04;
Average_completion_ME(8,1)=0.001040777990361;
Average_completion_SE(8,1)=3.044797361582492e-04;
Average_completion_DY(8,1)=4.081368780342048e-04;

% P_H=14mW
Average_completion(9,1)=3.123404798115534e-04;
Average_completion_ME(9,1)=0.001014961522874;
Average_completion_SE(9,1)=2.972883250487704e-04;
Average_completion_DY(9,1)=3.994659015559982e-04;



figure
plot(1:9,Average_completion(1:9),'r','linewidth',2)
hold on
plot(1:9,Average_completion_ME(1:9),'b','linewidth',2)
hold on
plot(1:9,Average_completion_SE(1:9),'g','linewidth',2)
hold on
plot(1:9,Average_completion_DY(1:9),'k','linewidth',2)
hold on
legend('LODCO','Mobile Execution','MEC Server Execution','Dynamic Offloading')
title('Average completion time vs.P_H ')
xlabel('EH power(mW)')
ylabel('Average completion time of the executed tasks(s)')






