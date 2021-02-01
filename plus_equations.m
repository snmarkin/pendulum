function p = plus_equations(L,V,FL_active,FL_passive,FV,F,R,...
                 IaV,IaL,IaEMG,Ia,Ib,M_PEND,M_F,M_E,IIL,IIEMG,II)
p = zeros(28,1);
p(1:2) = L; p(3:4) = V; 
p(5:6) = FL_active; p(7:8) = FL_passive; p(9:10) = FV; p(11:12) = F; 
p(13) = R; 
p(14:15) = IaV; p(16:17) = IaL; p(18:19) = IaEMG; p(20:21) = Ia; 
p(22) = Ib; 
p(23) = M_PEND; p(24) = M_F; p(25) = M_E; 
p(26) = IIL; p(27) = IIEMG; p(28) = II; 

