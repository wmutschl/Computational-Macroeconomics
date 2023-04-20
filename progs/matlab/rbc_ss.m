function [SS,PARAMS,error_indicator] = rbc_ss(SS,PARAMS)
% =========================================================================
% computes the steady-state of the RBC model with CES utility using a
% numerical optimizer to compute steady-state labor
% =========================================================================
% [SS,PARAMS,error_indicator] = rbc_ss(SS,PARAMS)
% ----------------------------------------------------------------------
% INPUTS
%   - SS     : structure with initial steady state values, fieldnames are variable names
%	- params : structure with values for the parameters, fieldnames are parameter names
% ----------------------------------------------------------------------
% OUTPUTS
%   - SS     : structure with computed steady state values, fieldnames are variable names
%	- params : structure with updated values for the parameters, fieldnames are parameter names
%   - error_indicator: 0 if no error when computing the steady-state
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: January 26, 2023
% =========================================================================
error_indicator = 0; % initialize no error

% read-out parameters
ALPHA = PARAMS.ALPHA;
BETA  = PARAMS.BETA;
DELTA = PARAMS.DELTA;
GAMMA = PARAMS.GAMMA;
PSI   = PARAMS.PSI;
RHOA  = PARAMS.RHOA;
ETAC  = PARAMS.ETAC;
ETAL  = PARAMS.ETAL;

% compute steady-state
a = 1;
rk = 1/BETA+DELTA-1;
k_l = ((ALPHA*a)/rk)^(1/(1-ALPHA));
if k_l <= 0
    error_indicator = 1;
end
w = (1-ALPHA)*a*k_l^ALPHA;
iv_l = DELTA*k_l;
y_l = a*k_l^ALPHA;
c_l = y_l - iv_l;
if c_l <= 0
    error_indicator = 1;
end
if (ETAC == 1 && ETAL == 1)
    % closed-form expression for l
    l = GAMMA/PSI*c_l^(-1)*w/(1+GAMMA/PSI*c_l^(-1)*w);
else
    % no closed-form solution and we therefore use a fixed-point algorithm
    if error_indicator == 0
        l0 = SS.l;
        [l,~,exitflag] = fsolve(@findL,l0,optimset('Display','off','TolX',1e-12,'TolFun',1e-12));
        if exitflag <= 0
            error_indicator = 1;
        end
    else
        l = NaN;
    end
end
c  = c_l*l;
iv = iv_l*l;
k  = k_l*l;
y  = y_l*l;
uc = GAMMA*c^(-1);
ul = -PSI/(1-l);
fl = (1-ALPHA)*a*(k/l)^ALPHA;
fk = ALPHA*a*(k/l)^(ALPHA-1);

% write to output structure
SS.y = y;
SS.c = c;
SS.k = k;
SS.l = l;
SS.a = a;
SS.rk = rk;
SS.w = w;
SS.iv = iv;
SS.uc = uc;
SS.ul = ul;
SS.fl = fl;
SS.fk = fk;

%% Auxiliary function used in optimization
% note that some variables are not explicitly declared as input arguments but get their value from above,
% i.e. the scope of some variables spans multiple functions
function error = findL(L)            
    error = w*GAMMA*c_l^(-ETAC) - PSI*(1-L)^(-ETAL)*L^ETAC;
end

end