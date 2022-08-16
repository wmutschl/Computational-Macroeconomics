%% Declare Variables and Parameters
var Y C K L A R W I UC UL fL fK;
varexo eps_A;
parameters alph betta delt gam pssi rhoA etaC etaL;

%% Calibration of parameters (simple)
alph = 0.35;
betta = 0.9901;
delt = 0.025;
gam = 1;
pssi = 1.7333;
rhoA = 0.9;
etaC = 2;
etaL = 1.5;


%% Model Equations
model;
UC  = gam*C^(-etaC);
UL  = -pssi*(1-L)^(-etaL);
fL  = (1-alph)*A*(K(-1)/L)^alph;
fK  = alph*A*(K(-1)/L)^(alph-1);

UC = betta*UC(+1)*(1-delt+R(+1));
W = - UL/UC;
W = fL;
R = fK;
Y = A*K(-1)^alph*L^(1-alph);
K = (1-delt)*K(-1) + I;
Y = C + I;
log(A) = rhoA*log(A(-1)) + eps_A;
end;

%% Steady State
steady_state_model;
A = 1;
R = 1/betta+delt-1;
K_L = ((alph*A)/R)^(1/(1-alph));
W = (1-alph)*A*K_L^alph;
I_L = delt*K_L;
Y_L = A*K_L^alph;
C_L = Y_L - I_L;
L0 = 1/3;
L = rbc_ces_helper_function(L0,pssi,etaL,etaC,gam,C_L,W);
C = C_L*L;
I = I_L*L;
K = K_L*L;
Y = Y_L*L;
UC  = gam*C^(-etaC);
UL  = -pssi*(1-L)^(-etaL);
fL  = (1-alph)*A*(K/L)^alph;
fK  = alph*A*(K/L)^(alph-1);
end;

steady;
