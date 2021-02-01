function out = init_inx()
%indices
global N N_RGF N_RGE N_PFF N_PFE N_inRGF N_inRGE N_MnF N_MnE N_inabE N_inE
global N_Q N_V N_OUT Npl Nplus
global N_FAKE

    N_RGF = 1;                 % RG-F neuron index
    N_RGE = N_RGF+1;           % RG-E neuron index
    N_PFF = N_RGE+1;           % PF-F neuron index
    N_PFE = N_PFF+1;           % PF-E neuron index
    N_inRGF = N_PFE+1;         % RG-F interneuron index
    N_inRGE = N_inRGF+1;       % RG-E interneuron index
    N_MnF = N_inRGE+1;
    N_MnE = N_MnF+1;           % indices for MnF and MnE
    N_inabE = N_MnE+1;         % In-abE neuron index
    N_inE = N_inabE+1;
    
    N = N_inE;                 % total number of neurons
    N_Q = 2*N+1; N_V = N_Q+1;  % angle and velocity
    N_OUT = N_V+N;             % neuron outputs
    
    Npl = zeros(28,1);         % biomechanical variables
    Npl(1)= N_OUT+1;
    for i = 2:28
        Npl(i) = Npl(i-1)+1;
    end;
    Nplus = Npl(28);
    
    N_FAKE = Nplus+21;

out = N_FAKE;