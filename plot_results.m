% Npl(13)               ground force moment
% q = x(:,N_Q);         angle
% Npl(1)   Npl(2)   flexor-extensor lengths
% Npl(11)  Npl(12)  flexor-extensor forces
% mnF = x(:,N_OUT-2); mnE = x(:,N_OUT-1); 
nf=nf+1;
start = t0+30;
%ground reaction
line(1:time_max*10+1) = 0;
xlabel('Time, ms ', 'FontSize',12,'FontWeight','Bold');
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,0.15*x(:,Npl(13)),'k-','LineWidth',2.);
hold on;
text(start,28,'GRF','FontSize',14);
%angle
line(1:time_max*10+1) = 40+pi2;
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,40*(x(:,N_Q)-pi2)+40,'g-','LineWidth',2.);
hold on;
text(start,58,'Angle','FontSize',14,'Color','g');
%extensor length and force
shiftE=75;
line(1:time_max*10+1) = shiftE;
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,-x(:,Npl(12))+shiftE,'r-','LineWidth',2.);
hold on;
figure(nf),plot(time,5*(x(:,Npl(2))-L0(2))+shiftE,'b-','LineWidth',2.);
hold on;
text(start,103,'Force-E','FontSize',14,'Color','r');
text(start,95,'Length-E','FontSize',14,'Color','b');
%flexor length and force
shiftF =115; 
line(1:time_max*10+1) = shiftF;
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,-x(:,Npl(11))+shiftF,'r-','LineWidth',2.);
hold on;
figure(nf),plot(time,5*(x(:,Npl(1))-L0(2))+shiftF,'b-','LineWidth',2.);
hold on;
text(start,155,'Force-F','FontSize',14,'Color','r');
text(start,147,'Length-F','FontSize',14,'Color','b');
%motoneurons
shiftMnE=165;
line(1:time_max*10+1) = shiftMnE;
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;figure(nf),plot(time,30*x(:,N_V+N_MnE)+shiftMnE,'k-','LineWidth',2.);
hold on;
text(start,180,'Mn-E','FontSize',14);
shiftMnF=190;
line(1:time_max*10+1) = shiftMnF;
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;figure(nf),plot(time,30*x(:,N_V+N_MnF)+shiftMnF,'k-','LineWidth',2.);
hold on;
text(start,210,'Mn-F','FontSize',14);
set(gca,'TickDir','out');
set(gca,'TickLength',[0.02 1]);
set(gca,'YTickLabel','0|pi/2|0(L0)|0(L0)|0|0')
set(gca,'YTick',[ 0 40+pi2 shiftE shiftF shiftMnE shiftMnF ]);
axis([t0 time_max -25 220]);
% Npl(14) Npl(15)   flexor-extensor Ia velocity component
% Npl(16) Npl(17)   flexor-extensor Ia length components
% Npl(18) Npl(19)   flexor-extensor Ia EMG components
% Npl(20) Npl(21)   flexor-extensor Ia feedback
% Npl(22)           Ib feedback
% Npl(28)           II feedback
nf=nf+1;
%extensor Ib 
line(1:time_max*10+1) = 0;
xlabel('Time, ms ', 'FontSize',12,'FontWeight','Bold');
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,14*x(:,Npl(22)),'r-','LineWidth',2.);
hold on;
text(start,4.5,'Ib-E','FontSize',14,'Color','r');
% text(5520,-1,'stance','FontSize',13);
% text(5920,-1,'swing','FontSize',13);
%extensor Ia
shiftIaE=6;
line(1:time_max*10+1) = shiftIaE;
xlabel('Time, ms ', 'FontSize',12,'FontWeight','Bold');
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,14*x(:,Npl(21))+shiftIaE,'r-','LineWidth',2.);
hold on;
text(start,11.5,'Ia-E','FontSize',14,'Color','r');
shiftE=15;
line(1:time_max*10+1) = shiftE;
xlabel('Time, ms ', 'FontSize',12,'FontWeight','Bold');
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,1*(x(:,Npl(2))-L0(2))+shiftE,'b-','LineWidth',2.);
hold on;
figure(nf),plot(time,80*x(:,Npl(4))+shiftE,'g-','LineWidth',2.);
hold on;
figure(nf),plot(time,5*x(:,N_V+N_MnE)+shiftE,'k-','LineWidth',2.);
hold on;
text(start,22.5,'E velocity','FontSize',14,'Color','g');
text(start,20.5,'E length','FontSize',14,'Color','b');
text(start,18.5,'E EMG','FontSize',14,'Color','k');
%flexor II
shiftIIF=25;
line(1:time_max*10+1) = shiftIIF;
xlabel('Time, ms ', 'FontSize',12,'FontWeight','Bold');
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,14*x(:,Npl(28))+shiftIIF,'r-','LineWidth',2.);
hold on;
text(start,29,'II-F','FontSize',14,'Color','r');
shiftIaF=31;
line(1:time_max*10+1) = shiftIaF;
xlabel('Time, ms ', 'FontSize',12,'FontWeight','Bold');
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,14*x(:,Npl(20))+shiftIaF,'r-','LineWidth',2.);
hold on;
text(start,36.5,'Ia-F','FontSize',14,'Color','r');
shiftF=40;
line(1:time_max*10+1) = shiftF;
xlabel('Time, ms ', 'FontSize',12,'FontWeight','Bold');
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,1*(x(:,Npl(1))-L0(1))+shiftF,'b-','LineWidth',2.);
hold on;
figure(nf),plot(time,80*x(:,Npl(3))+shiftF,'g-','LineWidth',2.);
hold on;
figure(nf),plot(time,5*x(:,N_V+N_MnF)+shiftF,'k-','LineWidth',2.);
hold on;
text(start,47.5,'F velocity','FontSize',14,'Color','g');
text(start,45.5,'F length','FontSize',14,'Color','b');
text(start,43.5,'F EMG','FontSize',14,'Color','k');
set(gca,'TickDir','out');
set(gca,'TickLength',[0.02 1]);
set(gca,'YTickLabel','0|0|0|0|0|0')
set(gca,'YTick',[ 0 shiftIaE shiftE shiftIIF shiftIaF shiftF]);
axis([t0 time_max -2 49]);
nf=nf+1;
%extensor Ib 
line(1:time_max*10+1) = 0;
xlabel('Time, ms ', 'FontSize',12,'FontWeight','Bold');
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,14*x(:,Npl(22)),'r-','LineWidth',2.);
hold on;
text(start,4.5,'Ib-E','FontSize',14,'Color','r');
text(5520,-1,'stance','FontSize',13);
text(5920,-1,'swing','FontSize',13);
%extensor Ia
shiftIaE=6;
line(1:time_max*10+1) = shiftIaE;
xlabel('Time, ms ', 'FontSize',12,'FontWeight','Bold');
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,14*x(:,Npl(21))+shiftIaE,'r-','LineWidth',2.);
hold on;
text(start,9.5,'Ia-E','FontSize',14,'Color','r');
%flexor II
shiftIIF=12;
line(1:time_max*10+1) = shiftIIF;
xlabel('Time, ms ', 'FontSize',12,'FontWeight','Bold');
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,14*x(:,Npl(28))+shiftIIF,'r-','LineWidth',2.);
hold on;
text(start,16,'II-F','FontSize',14,'Color','r');
%flexor Ia
shiftIaF=18;
line(1:time_max*10+1) = shiftIaF;
xlabel('Time, ms ', 'FontSize',12,'FontWeight','Bold');
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,14*x(:,Npl(20))+shiftIaF,'r-','LineWidth',2.);
hold on;
text(start,23,'Ia-F','FontSize',14,'Color','r');
shiftinE=24;
line(1:time_max*10+1) = shiftinE;
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,7*x(:,6+N_V)+shiftinE,'k','LineWidth',2.);
hold on;
text(start,29,'inRG-E','FontSize',14,'Color','k');
shiftE=30;
line(1:time_max*10+1) = shiftE;
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,7*x(:,5+N_V)+shiftE,'k','LineWidth',2.);
hold on;
text(start,35,'inRG-F','FontSize',14,'Color','k');
shiftinF=36;
line(1:time_max*10+1) = shiftinF;
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,7*x(:,2+N_V)+shiftinF,'k-','LineWidth',2.);
hold on;
text(start,41,'RG-E','FontSize',14,'Color','k');
shiftF=42;
line(1:time_max*10+1) = shiftF;
figure(nf),plot(time,line,'k-','LineWidth',1.);
hold on;
figure(nf),plot(time,7*x(:,1+N_V)+shiftF,'k-','LineWidth',2.);
hold on;
text(start,46,'RG-F','FontSize',14,'Color','k');
set(gca,'TickDir','out');
set(gca,'TickLength',[0.02 1]);
set(gca,'YTickLabel','0|0|0|0|0|0')
set(gca,'YTick',[ 0 shiftIaE shiftIIF shiftIaF shiftinE shiftE shiftinF shiftF ]);
axis([t0 time_max -2 49]);
