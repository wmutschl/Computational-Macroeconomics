%% Declare Variables and Parameters
var Y C K L A R W I UC UL fL fK;
varexo eps_A;
parameters alph betta delt gam pssi rhoA;

%% Calibration of parameters (simple)
alph = 0.35;
betta = 0.9901;
delt = 0.025;
gam = 1;
pssi = 1.7333;
rhoA = 0.9;

%% Calibration of parameters (advanced)
Abar  = 1;
K_o_Y = 10;    % avg capital productivity
I_o_Y = 0.25;  % avg investment ouput ratio
alph  = 0.35;  % cobb douglas
gam   = 1;     % normalize
Lbar  = 8/24;
rhoA  = 0.9;
delt = I_o_Y / K_o_Y;
betta = 1/(alph/K_o_Y+1-delt);
Rbar = 1/betta+delt-1;
K_o_L = ((alph*Abar)/Rbar)^(1/(1-alph));
Kbar = K_o_L*Lbar;
Ybar = Kbar/K_o_Y;
Ibar = delt*Kbar;
Wbar = (1-alph)*Abar*K_o_L^alph;
Cbar = Ybar - Ibar;
pssi = gam*(Cbar/Lbar)^(-1)*Wbar*(Lbar/(1-Lbar))^(-1);

%% Model Equations
model;
UC  = gam*C^(-1);
UL  = -pssi/(1-L);
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
L = gam/pssi*C_L^(-1)*W/(1+gam/pssi*C_L^(-1)*W);
C = C_L*L;
I = I_L*L;
K = K_L*L;
Y = Y_L*L;
UC  = gam*C^(-1);
UL  = -pssi/(1-L);
fL  = (1-alph)*A*(K/L)^alph;
fK  = alph*A*(K/L)^(alph-1);
end;

steady;
