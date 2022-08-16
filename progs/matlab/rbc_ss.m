%rbc_model_ss.m
function [SS,error_indicator] = rbc_ss(params,use_closed_form)
error_indicator = 0; % initialize no error
if nargin < 1
    use_closed_form = 1;
end

% read-out parameters
alph  = params.alph;
betta = params.betta;
delt  = params.delt;
gam   = params.gam;
pssi  = params.pssi;
rhoA  = params.rhoA;
etaC  = params.etaC;
etaL  = params.etaL;

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
if (etaC == 1 && etaL == 1) && use_closed_form
    L = gam/pssi*C_L^(-1)*W/(1+gam/pssi*C_L^(-1)*W); % closed-form expression for L
else
    % No closed-form solution and we therefore use a fixed-point algorithm
    if error_indicator == 0
        options = optimset('Display','off','TolX',1e-12,'TolFun',1e-12);
        L0 = 1/3;
        [L,~,exitflag] = fsolve(@findL,L0,options);
        if exitflag <= 0
            error_indicator = 1;
        end
    else
        L = NaN;
    end
end
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


%% Auxiliary function used in optimization
% note that some variables are not explicitly declared as input arguments but get their value from above,
% i.e. the scope of some variables spans multiple functions
function error = findL(L)            
    error = W*gam*C_L^(-etaC) - pssi*(1-L)^(-etaL)*L^etaC;
end

end