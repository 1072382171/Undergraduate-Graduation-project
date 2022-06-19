%% E_min=0.02mJ V=1e-4
Average_completion=zeros(10,1);
Average_completion_ME=zeros(10,1);
Average_completion_SE=zeros(10,1);
Average_completion_DY=zeros(10,1);


% p=0.1
Average_completion(1,1)=2.179621072792108e-04;
Average_completion_ME(1,1)=4.916666666666679e-04;
Average_completion_SE(1,1)=1.758581637515094e-04;
Average_completion_DY(1,1)=1.702700910819426e-04;

% p=0.2
Average_completion(2,1)=2.323396362064859e-04;
Average_completion_ME(2,1)=6.514271175993484e-04;
Average_completion_SE(2,1)=2.076555281945172e-04;
Average_completion_DY(2,1)=2.322496177877673e-04;

% p=0.3
Average_completion(3,1)=2.635747769133101e-04;
Average_completion_ME(3,1)=8.329177100542171e-04;
Average_completion_SE(3,1)=2.453210088723696e-04;
Average_completion_DY(3,1)=3.175520002370485e-04;

%  p=0.4
Average_completion(4,1)=2.814199905520453e-04;
Average_completion_ME(4,1)=9.385332721537080e-04;
Average_completion_SE(4,1)=2.736515621135775e-04;
Average_completion_DY(4,1)=3.607816926856235e-04;

%  p=0.5
Average_completion(5,1)=3.138413707710233e-04;
Average_completion_ME(5,1)=0.001018046564516;
Average_completion_SE(5,1)=2.928922130248555e-04;
Average_completion_DY(5,1)=3.999753803318284e-04;

%  p=0.6
Average_completion(6,1)=3.407225436124586e-04;
Average_completion_ME(6,1)=0.001073320622854;
Average_completion_SE(6,1)=3.086337171938563e-04;
Average_completion_DY(6,1)=4.239851718337640e-04;

%  p=0.7
Average_completion(7,1)=3.671776772199127e-04;
Average_completion_ME(7,1)=0.001124882287938;
Average_completion_SE(7,1)=3.202127880673646e-04;
Average_completion_DY(7,1)=4.417496568673837e-04;

%  p=0.8
Average_completion(8,1)=4.084042658034559e-04;
Average_completion_ME(8,1)=0.001170173085589;
Average_completion_SE(8,1)=3.321326574838048e-04;
Average_completion_DY(8,1)=4.720346796651293e-04;

%  p=0.9
Average_completion(9,1)=4.451886483953954e-04;
Average_completion_ME(9,1)=0.001210761996899;
Average_completion_SE(9,1)=3.428925515283447e-04;
Average_completion_DY(9,1)=4.909612628249095e-04;

%  p=1.0
Average_completion(10,1)=4.932147609387955e-04;
Average_completion_ME(10,1)=0.001242918193723;
Average_completion_SE(10,1)=3.471180070580021e-04;
Average_completion_DY(10,1)=5.125518769074237e-04;

figure
plot(1:10,Average_completion(1:10),'r','linewidth',2)
hold on
plot(1:10,Average_completion_ME(1:10),'b','linewidth',2)
hold on
plot(1:10,Average_completion_SE(1:10),'g','linewidth',2)
hold on
plot(1:10,Average_completion_DY(1:10),'k','linewidth',2)
legend('LODCO','Mobile Execution','MEC Server Execution','Dynamic Offloading')
xlabel('Computation task request probability¡¤10^-1')
ylabel('Average completion time of the executed tasks(s)')






