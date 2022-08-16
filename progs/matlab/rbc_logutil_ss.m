function [SS,error_indicator] = rbc_logutil_ss(params)
error_indicator = 0; % initialize no error

% read-out parameters
alph  = params.alph;
betta = params.betta;
delt  = params.delt;
gam   = params.gam;
pssi  = params.pssi;
rhoA  = params.rhoA;

% compute steady-state
A = 1;
R = 1/betta+delt-1;
K_L = ((alph*A)/R)^(1/(1-alph));
if K_L <= 0
    error_indicator = 1;
end
W = (1-alph)*A*K_L^alph;
I_L = delt*K_L;
Y_L = A*K_L^alph;
C_L = Y_L - I_L;
if C_L <= 0
    error_indicator = 1;
end
L = gam/pssi*C_L^(-1)*W/(1+gam/pssi*C_L^(-1)*W); % closed-form expression for L

C = C_L*L;
I = I_L*L;
K = K_L*L;
Y = Y_L*L;
UC  = gam*C^(-1);
UL  = -pssi/(1-L);
fL  = (1-alph)*A*(K/L)^alph;
fK  = alph*A*(K/L)^(alph-1);

% write to output structure
SS.Y = Y;
SS.C = C;
SS.K = K;
SS.L = L;
SS.A = A;
SS.R = R;
SS.W = W;
SS.I = I;
SS.UC = UC;
SS.UL = UL;
SS.fL = fL;
SS.fK = fK;
end