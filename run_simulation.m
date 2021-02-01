%RUN THE SIMULATION
    %setup initial conditions for neurons
        x0(1:N) = -60;
        x0(N+N_RGF) = 0.4; x0(N+N_RGE) = 0.4; x0(N+N_PFF:N+N_inE) = 0.4;
        x0(N_Q)= pi2; x0(N_V) = 0.0004; x0(N_V+1:Nplus) = 0.0; 
        x0(Nplus+1:N_FAKE) = 0.1;
        T_flex  = 0; T_ext = 0; t_flex  = 0; t_ext = 0;
        
    %setup initial conditions for mechanics
        extension = 1; stance = 1; 
        qmin = x0(N_Q); qmax = qmin;
        N_step = 0; T_switch = 0; T_lift = T_switch; T_swing = 0; T_step = T_swing;
        
    %setup parameters of external disturbance
        a_F = 0; a_Step = 5; a_Time = [964 1064]; a_On = -1;
      
    %ODE solution
        time = 0:0.1:time_max;
        Mmass=zeros(N_FAKE,N_FAKE);
        for i=1:N_V
            Mmass(i,i)=1;
        end;
        options = odeset('Mass',Mmass);
        [t,x] = ode15s('DF',time,x0);
