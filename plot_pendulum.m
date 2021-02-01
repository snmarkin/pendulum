% q = x(:,N_Q); q' = x(:,N_V); 
% Npl(3)   Npl(4)   flexor-extensor velocities
nf = nf+1;
figure(nf),plot( x(t0*10+1:time_max*10,N_Q), x(t0*10+1:time_max*10,N_V),'b-','LineWidth',2.);
hold on;
title('Angle versus pendulum velocity');
axis([1.07 2.07 -0.005 0.005]);
