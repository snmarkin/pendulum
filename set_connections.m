%WEIGHTS OF CONNECTIONS
    %input drives
        cRG = 0.08;         %supra-spinal drive to RG-level
        cPF = 0.40;         %supra-spinal drive to PF-level
        cIn = 0.18;         %drive to In-E interneuron
    %connections between neurons
    %excitatory
        aRR = 0.0;          %self-excitation RG neurons
        aR = 0.41;          %excitation from RG basic neurons to corresponding interneurons
        aRP = 0.7;          %excitation from RG basic neurons to corresponding PF neurons
        aMn = [1.95 1.30];  %excitation from PFs to Mns
        
        aInabE = 0.35;      %excitation from RG to InabE 
        aInabE_Mn = 0.82;   %excitation from InabE to Mn
    %inhibitory
        bR = 2.20;          %inhibition weight at RG level
        bRP = 6.60;         %inhibition weight from  RG to PF level
        bInab = 0.55;       %inhibition from In to Inab-E
        bIn = 2.80;         %inhibition from InRgE to In
    %afferent feedbacks
    %Ia-II flexor feedbacks
        wIa_RGF = 0.06;     %Ia afferent to flexor RG main neuron
        wIa_PFF = 0.19;     %Ia afferent to flexor RG main neuron
        wIa_InF = 0.27;     %Ia afferent to flexor RG interneuron
        wIa_MnF = 0;

        kIa_II = 0.58;
        wII_RGF = kIa_II*wIa_RGF;        %secondary afferent to flexor RG main neuron
        wII_PFF = kIa_II*wIa_PFF;        %secondary afferent to flexor RG main neuron
        wII_InF = kIa_II*wIa_InF;        %secondary afferent to flexor RG interneuron
    %Ia-Ib extensor feedbacks
        wIa_RGE = 0.06;     %Ia afferent to extensor RG main neuron
        wIa_PFE = 0.10;     %Ia afferent to extensor RG main neuron
        wIa_InE = 0.44;     %Ia afferent to extensor RG interneuron
        wIa_InabE = 0.16;   %Ia afferent to InabE interneuron
        wIa_MnE = 0;

        kIa_Ib = 1.1;
        wIb_RGE = kIa_Ib*wIa_RGE;         %Ib afferent to extensor RG main neuron
        wIb_PFE = kIa_Ib*wIa_PFE;         %Ib afferent to extensor RG main neuron
        wIb_InE = kIa_Ib*wIa_InE;         %Ib afferent to extensor RG interneuron 
        wIb_InabE = kIa_Ib*wIa_InabE;     %Ib afferent to InabE interneuron 

%MODIFY WEIGHTS OF CONNECTIONS
    %input drives
        cRG = ds*cRG;
        cPF = ds*cPF;
        
    %afferent feedbacks
    %Ia-II flexor feedbacks
        wIa_RGF = k_IaF*wIa_RGF;
        wIa_PFF = k_IaF*wIa_PFF;
        wIa_InF = k_IaF*wIa_InF;
        wIa_MnF = k_IaF*wIa_MnF;

        wII_RGF = k_II*wII_RGF;
        wII_PFF = k_II*wII_PFF;
        wII_InF = k_II*wII_InF;

    %Ia-Ib extensor feedbacks
        wIa_RGE = k_IaE*wIa_RGE;
        wIa_PFE = k_IaE*wIa_PFE;
        wIa_InE = k_IaE*wIa_InE;
        wIa_InabE = k_IaE*wIa_InabE;
        wIa_MnE = k_IaE*wIa_MnE;

        wIb_RGE = k_Ib*wIb_RGE;
        wIb_PFE = k_Ib*wIb_PFE;
        wIb_InE = k_Ib*wIb_InE;
        wIb_InabE = k_Ib*wIb_InabE;
