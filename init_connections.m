function [a, b, w, dr] = init_connections()
%indices
global N N_RGF N_RGE N_PFF N_PFE N_inRGF N_inRGE N_MnF N_MnE N_inabE N_inE
%neuron parameters
global gsynE gsynI 
%weights of connections
global cRG cPF cIn
global aRR aR aRP aMn aInabE aInabE_Mn
global bR bRP bInab bIn
global wIa_RGF wII_RGF wIa_PFF wII_PFF wII_InF wIa_InF wIa_MnF
global wIa_RGE wIb_RGE wIa_PFE wIb_PFE wIa_InE wIb_InE wIa_MnE wIa_InabE wIb_InabE

ac = zeros(N,N);
bc = zeros(N,N);
cc = zeros(N,4);
d = zeros( N, 1 );
%input drives
    d(N_RGF) = cRG;
    d(N_RGE) = cRG;
    d(N_PFF) = cPF;
    d(N_PFE) = cPF;
    d(N_inE) = cIn;
% Excitatory connections - matrix a
%          RGF   RGE   PFF   PFE   inRGF   inRGE   MnF   MnF   InabE   InE
%           1    2      3    4      5       6       7     8     9      10
% RGF   1  aRR
% RGE   2       aRR
% PFF   3  aRP
% PFE   4       aRP
% inRGF 5   aR
% inRGE 6       aR
% MnF   7              aMn
% MnE   8                   aMn                              aInabEMn
% InabE 9                  aInabE
% InE   10
    ac(N_RGF,N_RGF) = aRR;
    ac(N_RGE,N_RGE) = aRR; 
    ac(N_PFF,N_RGF) = aRP;
    ac(N_PFE,N_RGE) = aRP;
    ac(N_inRGF,N_RGF) = aR;
    ac(N_inRGE,N_RGE) = aR;
    
    ac(N_MnF,N_PFF) = aMn(1); 
    ac(N_MnE,N_PFE) = aMn(2); 
    ac(N_MnE,N_inabE) = aInabE_Mn;
    
    ac(N_inabE,N_PFE) = aInabE;
% Inhibitory connections (CPG)- matrix b
%          RGF   RGE   PFF   PFE   inRGF   inRGE   MnF   MnF   InabE   InE
%           1    2      3    4      5       6       7     8     9      10
% RGF   1                                   bR  
% RGE   2                          bR
% PFF   3                                   bRP
% PFE   4                          bRP
% inRGF 5  
% inRGE 6  
% MnF   7  
% MnE   8  
% InabE 9                                                             bInab
% InE   10                                  bIn
    bc(N_RGF,N_inRGE) = bR;
    bc(N_RGE,N_inRGF) = bR;  
    bc(N_PFF,N_inRGE) = bRP;
    bc(N_PFE,N_inRGF) = bRP;  
    bc(N_inabE,N_inE) = bInab; 
    bc(N_inE,N_inRGE) = bIn; 
% Feedback connctions - matrix c
%           IaF        IaE        IbE        IIF  
%            1          2          3          4    
% RGF   1  aIa_RGF                         aII_RGF
% RGE   2            aIa_RGE    aIb_RGE 
% PFF   3  aIa_PFF                         aII_PFF
% PFE   4            aIa_PFE    aIb_PFE 
% inRGF 5  aIa_inRGF                       aII_inRGF
% inRGE 6            aIa_inRGE  aIb_inRGE
% MnF   7                                                  
% MnE   8            
% InabE 9            aIa_inabE   aIb_inabE
% InE   10
    cc(N_RGF,1) = wIa_RGF;
    cc(N_RGF,4) = wII_RGF;
    cc(N_RGE,2) = wIa_RGE;
    cc(N_RGE,3) = wIb_RGE;
    
    cc(N_PFF,1) = wIa_PFF;
    cc(N_PFF,4) = wII_PFF;
    cc(N_PFE,2) = wIa_PFE;
    cc(N_PFE,3) = wIb_PFE;
    
    cc(N_inRGF,1) = wIa_InF; 
    cc(N_inRGF,4) = wII_InF;
    cc(N_inRGE,2) = wIa_InE;
    cc(N_inRGE,3) = wIb_InE;
    
    cc(N_inabE,2) = wIa_InabE; 
    cc(N_inabE,3) = wIb_InabE;

    cc(N_MnF,1) = wIa_MnF;
    cc(N_MnE,2) = wIa_MnE;
    
a = sparse(gsynE*ac);
dr = sparse(gsynE*d);
w = sparse(gsynE*cc);
b = sparse(gsynI*bc);

