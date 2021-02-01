function out = init_neurons()
%indices
global N N_RGF N_RGE N_PFF N_PFE N_MnF N_MnE 
%neuron parameters
global C
global ENa EK Eleak EsynE EsynI EleakMn
global gNaP gKdr gL gsynE gsynI gLMn

global V12_m_p k_m_p V12_h_p k_h_p k_h_p2 tau_h_p V12_n k_n 
global V12_out Kout threshold 

%1. GENERAL NEURON PARAMETERS
    C = 20;                             %membrane capacitance
    EK = -80; ENa = 55;                 %Na and K reversal potentials
    Eleak(1:N) = -60;                   %Leak reversal potential
    EsynE = -10;                        %Excitory synapse reversal potentials
    EsynI = -70;                        %Inhibitory synapse reversal potentials
    gsynE = 10.0;                       %maximal conductance for excitory synapse
    gsynI = 10.0;                       %maximal conductance for inhibitory synapse
    gKdr(1:N) = 0.0;                    %maximal conductance for Kdr curent
    V12_n = -44.5; k_n = -5;            %half-voltage and slope for Kdr activation
    gNaP(1:N) = 0.0;                    %maximal conductance for NaP curent
    V12_m_p = -47.1; k_m_p = -3.1;      %half-voltage and slope for NaP activation
    V12_h_p = -51.0; k_h_p =  4.0;      %half-voltage and slope for NaP inactivation
    tau_h_p = 600; k_h_p2 = k_h_p*2;    %time constant for NaP inactivation
    gL(1:N) = 1.60;                     %maximal conductance of Leak curent
%2. OUTPUT FUNCTION PARAMETERS  
    Kout(1:N) = -8.0;                   %slope
    V12_out(1:N) = -30.0;               %half-voltage
    threshold = -50;
%3. SPECIFIC NEURON PARAMETERS
    Eleak(1:4) = -64;                  %Leak reversal potential (RG- and PF- level)
    Eleak(N_MnF:N_MnE) = -64;          %Leak reversal potential (motoneurons)
    gKdr(N_RGF:N_PFE) = 4.5;           %maximal conductance for Kdr curent (RG- and PF- level)
    gKdr(N_MnF:N_MnE) = 4.5;           %maximal conductance for Kdr curent (motoneurons)
    gNaP(N_RGF:N_RGE) = 3.5;           %maximal conductance for NaP curent (RG-level)
    gNaP(N_PFF:N_PFE) = 0.5;           %maximal conductance for NaP curent (PF-level)
    gNaP(N_MnF:N_MnE) = 0.3;           %maximal conductance for NaP curent (motoneurons)
    Kout(N_MnF:N_MnE) = -3.0;          %slope of output function (motoneurons)
%4. FINAL SETTING
    gL = gL/C;
    gKdr = gKdr/C;
    gNaP = gNaP/C;
    gsynE = gsynE/C;
    gsynI = gsynI/C;
    
    Kout = Kout';
    V12_out = V12_out';
    Eleak = Eleak';
    gNaP = gNaP'; gNaP = sparse( gNaP );
    gKdr = gKdr'; gKdr = sparse( gKdr );
    gL = gL';

out = 1;