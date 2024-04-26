function [SS,PARAMS,error_indicator] = rbcCRRASteadyState(SS,PARAMS)
% [SS,PARAMS,error_indicator] = rbcCRRASteadyState(SS,PARAMS)
% -------------------------------------------------------------------------
% computes the steady-state of the RBC model with CRRA utility using a
% numerical optimizer to compute steady-state labor
% -------------------------------------------------------------------------
% INPUTS
%   - SS     : structure with initial steady-state values, fieldnames are variable names
%	- PARAMS : structure with values for the parameters, fieldnames are parameter names
% -------------------------------------------------------------------------
% OUTPUTS
%   - SS     : structure with computed steady-state values, fieldnames are variable names
%	- PARAMS : structure with updated values for the parameters, fieldnames are parameter names
%   - error_indicator: 0 if no error occured when computing the steady-state
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: April 26, 2024
% -------------------------------------------------------------------------
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

% compute steady-state analytically as much as possible
a = 1;
rk = 1/BETA+DELTA-1;
k_n = ((ALPHA*a)/rk)^(1/(1-ALPHA));
if k_n <= 0
    error_indicator = 1; % violation of non-negativity constraint
end
w = (1-ALPHA)*a*k_n^ALPHA;
iv_n = DELTA*k_n;
y_n = a*k_n^ALPHA;
c_n = y_n - iv_n;
if c_n <= 0
    error_indicator = 1; % violation of non-negativity constraint
end
if (ETAC == 1 && ETAL == 1)
    % closed-form expression for l available
    n = GAMMA/PSI*c_n^(-1)*w/(1+GAMMA/PSI*c_n^(-1)*w);
else
    % no closed-form solution and we therefore use a numerical optimizer
    if error_indicator == 0
        n0 = SS.n; % initial guess
        % 'findN' is a nested function within this file that calculates a numerical solution for n
        % The function is referenced here using the @ symbol to pass it as a function handle.
        % One could also place the 'findN' function in a separate file findN.m and call it directly.
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

%% Auxiliary function 'findN' used in optimization
% This function computes an error term (residual) based on several parameters and variables.
% Some variables ('w', 'GAMMA', 'c_n', 'ETAC', 'PSI', 'ETAL') are not explicitly passed as input arguments;
% instead, these variables inherit their values from the surrounding scope of the script,
% allowing them to be used directly within this function as if they were local variables.
function residual = findN(N)
    residual = w*GAMMA*c_n^(-ETAC) - PSI*(1-N)^(-ETAL)*N^ETAC;
end

end