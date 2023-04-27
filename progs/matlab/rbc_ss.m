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
% Version: April 26, 2023
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
k_n = ((ALPHA*a)/rk)^(1/(1-ALPHA));
if k_n <= 0
    error_indicator = 1;
end
w = (1-ALPHA)*a*k_n^ALPHA;
iv_n = DELTA*k_n;
y_n = a*k_n^ALPHA;
c_n = y_n - iv_n;
if c_n <= 0
    error_indicator = 1;
end
if (ETAC == 1 && ETAL == 1)
    % closed-form expression for l
    n = GAMMA/PSI*c_n^(-1)*w/(1+GAMMA/PSI*c_n^(-1)*w);
else
    % no closed-form solution and we therefore use a fixed-point algorithm
    if error_indicator == 0
        n0 = SS.n;
        [n,~,exitflag] = fsolve(@findN,n0,optimset('Display','off','TolX',1e-12,'TolFun',1e-12));
        if exitflag <= 0
            error_indicator = 1;
        end
    else
        n = NaN;
    end
end
c  = c_n*n;
iv = iv_n*n;
k  = k_n*n;
y  = y_n*n;
uc = GAMMA*c^(-1);
ul = -PSI/(1-n);
fn = (1-ALPHA)*a*(k/n)^ALPHA;
fk = ALPHA*a*(k/n)^(ALPHA-1);

% write to output structure
SS.y = y;
SS.c = c;
SS.k = k;
SS.n = n;
SS.a = a;
SS.rk = rk;
SS.w = w;
SS.iv = iv;
SS.uc = uc;
SS.ul = ul;
SS.fn = fn;
SS.fk = fk;

%% Auxiliary function used in optimization
% note that some variables are not explicitly declared as input arguments but get their value from above,
% i.e. the scope of some variables spans multiple functions
function error = findN(N)
    error = w*GAMMA*c_n^(-ETAC) - PSI*(1-N)^(-ETAL)*N^ETAC;
end

end