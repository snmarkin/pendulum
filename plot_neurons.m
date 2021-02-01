%No of neuron output = No of neuron + N_V
nf=nf+1;
figure(nf),plot(time,x(:,1+N_V)+5,'b-','LineWidth',2.);
hold on;
figure(nf),plot(time,x(:,3+N_V)+4,'b--','LineWidth',2.);
hold on;
figure(nf),plot(time,x(:,5+N_V)+3,'b:','LineWidth',2.);
hold on;
figure(nf),plot(time,x(:,2+N_V)+2,'g-','LineWidth',2.);
hold on;
figure(nf),plot(time,x(:,4+N_V)+1,'g--','LineWidth',2.);
hold on;
figure(nf),plot(time,x(:,6+N_V),'g:','LineWidth',2.);
hold on;
grid on;
title('CPG neuron outputs');
set(gca,'YTick',[0 0.25 0.5 0.75 1 1.25 1.5 1.75 2 ...
                 2.25 2.5 2.75 3 3.25 3.5 3.75 4 4.25 4.5 4.75 5 5.25 5.5 5.75 6 ]);
set(gca,'YTickLabel','0||inRGE ||0||PFE ||0||RGE ||0||inRGF ||0||PFF ||0||RGF ||1')
axis([t0 time_max 0 6]);
nf=nf+1;
figure(nf),plot(time,x(:,N+N_V)+3,'g-','LineWidth',2.);
hold on;
figure(nf),plot(time,x(:,N+N_V-1)+2,'g-','LineWidth',2.);
hold on;
figure(nf),plot(time,x(:,N_MnF+N_V)+1,'b-','LineWidth',2.);
hold on;
figure(nf),plot(time,x(:,N_MnE+N_V),'g-','LineWidth',2.);
hold on;
grid on;
set(gca,'YTick',[0 0.25 0.5 0.75 1 1.25 1.5 1.75 2 ...
                 2.25 2.5 2.75 3 3.25 3.5 3.75 4]);
set(gca,'YTickLabel','0||Mn-E||0||Mn-F||0||Inab-E||0||In-E||1')
title('Motoneurons, Iab-E and In-E outputs');
axis([t0 time_max 0 4]);


