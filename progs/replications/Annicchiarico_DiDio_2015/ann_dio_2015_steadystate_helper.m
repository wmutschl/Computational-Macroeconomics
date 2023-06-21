function [u,pz,Psi,ca_y,y,c,l,k,iv,w] = ann_dio_2015_steadystate_helper(z,Gamma_m,rk,mc,dp,g, DELTA_K,ALPHA,PHI,MU_L,A,VARPHI,PHI_1,PHI_2)
x0(1,1) = 0.2; % l
x0(2,1) = 0.7; % y
x0(3,1) = 0.8; % Psi
x0(4,1) = 6;   % k
x0(5,1) = 0.8; % u

options = optimset('Display','iter','TolX',1e-6);
[ss,fval,exitflag] = fsolve(@obj,x0,options,...
                            z,Gamma_m,rk,mc,dp,g,...
                            DELTA_K,ALPHA,PHI,MU_L,A,VARPHI,PHI_1,PHI_2);

function f = obj(x, z,Gamma_m,rk,mc,dp,g, DELTA_K,ALPHA,PHI,MU_L,A,VARPHI,PHI_1,PHI_2)
l = x(1);
y = x(2);
Psi = x(3);
k = x(4);
u = x(5);

pz = PHI_1*PHI_2*u^(PHI_2-1)/VARPHI; % environmental policy regime in steady-state
WL_C = MU_L*l^(PHI+1); % labor supply in steady-state
iv = k*DELTA_K; % capital accumulation in steady-state
ca = PHI_1*u^PHI_2*y*dp; % abatement cost in steady-state
c = y-iv-g-ca; % aggregate demand in steady-state
w = WL_C*c/l;
ca_y = ca/y;
f(1) = WL_C*c - (1-ALPHA)*Psi*y; % labor demand in steady-state
f(2) = y - (1-Gamma_m)*A*k^ALPHA*l^(1-ALPHA)*dp^(-1); % aggregate supply in steady-state
f(3) = ALPHA*Psi*y/k - rk; % capital demand in steady-state
f(4) = mc - ( Psi + PHI_1*u^PHI_2 + pz*(1-u)*VARPHI ); % overall marginal costs in steady-state
f(5) = z - (1-u)*VARPHI*y*dp; % emissions in steady-state
end

end