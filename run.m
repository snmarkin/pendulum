clear all;

%indices
global N N_RGF N_RGE N_PFF N_PFE N_inRGF N_inRGE N_MnF N_MnE N_inabE N_inE
global N_Q N_V N_OUT Npl Nplus
global N_FAKE
%neuron parameters
global C
global ENa EK Eleak EsynE EsynI 
global gNaP gKdr gL gsynE gsynI 
global V12_m_p k_m_p V12_h_p k_h_p k_h_p2 tau_h_p V12_n k_n 
global V12_out Kout threshold 
%weights of connections
global cRG cPF cIn
global aRR aR aRP aMn aInabE aInabE_Mn
global bR bRP bInab bIn
global wIa_RGF wII_RGF wIa_PFF wII_PFF wII_InF wIa_InF wIa_MnF
global wIa_RGE wIb_RGE wIa_PFE wIb_PFE wIa_InE wIb_InE wIa_MnE wIa_InabE wIb_InabE
%matrices of connections
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
global T_flex T_ext t_flex t_ext extension

global ds pre_step time_max time_init

%drive modulation
    ds = 1.4;           %range 0.7 - 3.5(normal walking, 1.4-basic rythm), 0(SCI) 
%learning
    k_IaF = 1.0;
    k_II = 1.0;
    k_IaE = 1.0;
    k_Ib = 1.0;
    init_inx();
    init_neurons();
%setup some basic parameters
    pre_step = 0;
    time_init = -1;
    time_max = 8000;
%setup the plotting parameters
    nf = 0;
    t0 = 6000; %t0=6550;
%set parameters of the biomechanical system
    set_biomechanics;
%network initialization
    set_connections;
    [a, b, w, dr] = init_connections();
%run
    run_simulation;
    x(:,N_Q) = max(x(:,N_Q),0.0); x(:,N_Q) = min(x(:,N_Q),pi);     %angle restrictions
    set(gcf,'DefaultAxesFontSize',10);
%plot

    plot_results;
    plot_pendulum;
    %plot_pendulum_pol;
