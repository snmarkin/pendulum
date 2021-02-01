function dx = DF(t,x)
%indices
global N N_MnF N_MnE 
global N_Q N_V Npl Nplus
global N_FAKE
%neuron parameters
global ENa EK Eleak EsynE EsynI
global gNaP gKdr gL 
global V12_m_p k_m_p V12_h_p k_h_p k_h_p2 tau_h_p V12_n k_n 
global V12_out Kout threshold 
%connections matrices
global a b w dr
%muscle model
global Fmax  Lopt beta omega ro av1 bv1 bv2
%feedback
global Lrest kEMG_Ia kV_Ia kL_Ia pV_Ia C_Ia 
global Lrest_II kL_II kEMG_II C_II 
global Fconst_Ib 
%dynamics
global MUL DEN VIS eGRF L2 a12 aa 
global a_F a_Step a_Time a_On
%kinematics
global qmax qmin stance T_switch T_lift T_step T_swing N_step
global T_flex T_ext t_flex t_ext extension N_RGE N_RGF

dx = 0.0*x;
vol = x(1:N); 
%NEURON OUTPUTS
    y = ((1+exp((vol-V12_out)./Kout)).^(-1));
    for i = 1:N
        if vol(i)<= threshold
            y(i)=0.0;
        end;       
        j = N_V+i;
        dx(j) = -x(j)+y(i); %PLUS EQUATIONS for neuron outputs
    end;
%BIOMECHANICS
    x(N_Q) = max(x(N_Q),0.0); x(N_Q) = min(x(N_Q),pi);     %angle restrictions
    %calculate muscle forces
    gamma = [x(N_Q) pi-x(N_Q)];
    L = sqrt(L2-aa.*cos(gamma));                            %muscle lenght
    h =a12.*sin(gamma)./L;                                  %arm
    V = [x(N_V)*h(1) -x(N_V)*h(2)];                         %muscle velocity

    Lnorm = L./Lopt;
    FL_active = exp(-(abs((Lnorm.^beta-1))/omega).^ro);
    FL_passive = 3.5*log(exp((Lnorm-1.4)./0.05)+1.0)...
               - 0.02*(exp(-18.7*(Lnorm-0.79))-1.0);
    FL_passive = FL_passive.*max(Lnorm-1,0.0);
    FV = zeros(1,2);
    for i = 1:2
        if V(i) <= 0.0
            FV(i) = (bv1(i)-av1*V(i))/(V(i)+bv1(i));
        else
            FV(i) = (bv2-(-5.34*Lnorm(i)*Lnorm(i)...
                   + 8.41* Lnorm(i)-4.7)*V(i))/(V(i)+bv2);
        end
    end;
    mn = [y(N_MnF) y(N_MnE)];
    F = Fmax.*(mn.*FL_active.*FV+FL_passive);
    %define onset of both stance and swing phases
    if x(N_V) >= 0.00001 && T_switch < t && stance == 0                         %switch to stance
        stance = 1; 
        qmin = x(N_Q);
        T_switch = t;
        T_swing = t-T_lift;
    end
    if x(N_V) <= -0.00001 && T_switch < t && stance == 1 &&  x(N_Q) > qmin+0.01 %switch to swing
        stance = 0; 
        qmax = x(N_Q);
        T_switch = t;
        T_step = t-T_lift;
        T_lift = t;
        N_step = N_step+1;
    end

    %define onset of both extension and flexion phases
    if y( N_RGE ) > 0.2 && t_flex < t-100 && extension == 0  && t > 1000                      %switch to extension
        extension = 1; 
        t_ext = t;
        T_flex = t_ext-t_flex;
    end
    if y( N_RGF ) > 0.2 && t_ext < t-100 && extension == 1 && t > 1000                       %switch to flexion
        extension = 0; 
        t_flex = t;
        T_ext = t_flex-t_ext;
    end
    
%FEEDBACKS
    d = (L-Lrest)./Lrest;
    IaV = kV_Ia.*sign(V).*abs(V./Lrest).^pV_Ia;
    IaL = max(kL_Ia.*d,0.0);
    IaEMG = kEMG_Ia.*mn;
    Ia = max(IaV+IaL+IaEMG+C_Ia,0.0);

    d_II = (L(1)-Lrest_II)/Lrest_II;
    IIL = max(kL_II*d_II,0.0);
    IIEMG = kEMG_II*mn(1);
    II = IIL+IIEMG+C_II;

    Ib = -1/Fmax(2)*max(-F(2)-Fconst_Ib,0.0);

    f(1) = Ia(1); f(2) = Ia(2); f(3) = Ib; f(4) = II;
    feedback = sparse(f);
%NEURONS
    hp = x(N+1:2*N);
    %Kdr
    n_inf = (1+exp((vol-V12_n)/k_n)).^(-1);
    %NaP activation
    mp_inf = (1+exp((vol-V12_m_p)/k_m_p)).^(-1);
    hp_inf = (1+exp((vol-V12_h_p)/k_h_p)).^(-1);
    tau_inf = tau_h_p*(cosh((vol-V12_h_p)/k_h_p2)).^(-1);
    %NaP inactivation
    dx(N+1:2*N) = (-hp+hp_inf)./tau_inf;
%DIFFERENTIAL EQUATIONS for membrane potentials
    ye =  sparse(y(1:N)); 
    yi = sparse(ye);
    rp = gNaP.*mp_inf.*hp.*(vol-ENa)+gKdr.*n_inf.^4.*(vol-EK); 
    r = dr.*(vol-EsynE)+gL.*(vol-Eleak)+...
        (a*ye+w*feedback').*(vol-EsynE)+(b*yi).*(vol-EsynI); 
    dx(1:N) = -rp-r;
%LAGRANGE EQUATION
    M_F = F(1)*h(1);                %flexor muscle torque
    M_E = -F(2)*h(2);               %extensor muscle torque
    M_PEND = MUL*cos(x(N_Q));       %pendulum torque
    R_GRF = 0;                      %ground reaction torque
    if stance
       R_GRF = -eGRF*cos(x(N_Q));
    end;
    R_ADD = 0;
    if N_step > 0 && N_step == a_Step
        if a_On < 0 && t-T_lift >= a_Time( 1 ) && t-T_lift <= a_Time( 2 )
            a_On = T_lift;
        end
    end
    if a_On >= 0 && t-a_On >= a_Time( 1 ) && t-a_On <= a_Time( 2 )
            R_ADD = a_F;
    end
    dx(N_Q) = x(N_V); 
    dx(N_V) = (M_PEND+M_F+M_E+R_GRF+R_ADD)/DEN-VIS*x(N_V); 
    
%PLUS EQUATIONS for biomechanics
    p0 = x(Npl(1):Npl(28));
    dx(Npl(1):Npl(28)) = -p0...
                         +plus_equations(L,V,FL_active,FL_passive,FV,F,R_GRF,...
                          IaV,IaL,IaEMG,Ia,Ib,M_PEND,M_F,M_E,IIL,IIEMG,II);
%PLUS... BS for stability
dx(Nplus+1:N_FAKE) = -100.0*x(Nplus+1:N_FAKE)+0.1;
