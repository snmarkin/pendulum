%BIOMECHANICAL PARAMETERS
        pi2 = pi/2;
        g = 0.00981;        %gravity
    %pendulum parameters
        Ls = 300;           %pendulum's lenght
        ms = 300;           %pendulum's mass
        Cms = Ls/2;         %pendulum's center of mass
        Is = ( ms*Ls^2 )/3; %pendulum's moment of inertia
        
        VIS = 0.002;       %viscosity in the joint
    %ground reaction force
        eGRF = 585;
    %muscle parameters
        a1 = [60 60];
        a2 = [7 7];
        a12 = a1.*a2; 
        aa = 2*a12;
        L2 = a1.*a1+a2.*a2; 
        L0 = sqrt(L2);
        Fmax = [72.5 37.7];         %muscles' maximal forces
        Lopt = [68 68];             %muscles' optimal lengths
        beta = 2.3; omega = 1.26; ro = 1.62;            %length active component
        av1 = 0.17; bv1 = [-0.69 -0.69]; bv2 = 0.18;    %velocity active component
    %feedback parameters
    %Ia afferents
        Lrest = L0-0.40;            %resting length for primary affetents
        kV_Ia = [6.2 6.2]; pV_Ia = [0.6 0.6];           %velocity component
        kL_Ia = [2.0 2.0];                              %length component
        kEMG_Ia = [0.06 0.06]; C_Ia = [0.026 0.026];    %EMG+const components
    %II afferent
        Lrest_II = L0(1)-1.95;      %resting length for secondary afferents
        kL_II = 1.5;                                    %length component
        kEMG_II = 0.06; C_II = 0.00;                    %EMG+const components
    %Ib afferent
        Fconst_Ib = 0.09*Fmax(2);   %originaly was 0.26/2.9
        Fmax = -Fmax;
    %pre-calculations
        DEN = Is;
        MUL = ms*Cms*g;
