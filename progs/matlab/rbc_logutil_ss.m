function [SS,PARAMS,error_indicator] = rbc_logutil_ss(SS,PARAMS)
% [SS,PARAMS,error_indicator] = rbc_logutil_ss(SS,PARAMS)
% =========================================================================
% computes the steady-state of the RBC model with log utility analytically
% and stored into structures
% =========================================================================
% INPUTS
%   - SS     : structure with initial steady state values, fieldnames are variable names (usually empty, but might be useful for initial values or to update endogenous parameters)
%	- params : structure with values for the parameters, fieldnames are parameter names
% ----------------------------------------------------------------------
% OUTPUTS
%   - SS     : structure with computed steady state values, fieldnames are variable names
%	- params : structure with updated values for the parameters, fieldnames are parameter names
%   - error_indicator: 0 if no error when computing the steady-state
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: April 17, 2023
% =========================================================================
error_indicator = 0; % initialize no error

% read-out parameters
ALPHA = PARAMS.ALPHA;
BETA  = PARAMS.BETA;
DELTA = PARAMS.DELTA;
GAMMA = PARAMS.GAMMA;
PSI   = PARAMS.PSI;
RHOA  = PARAMS.RHOA;

% compute steady-state analytically
a = 1;
rk = 1/BETA+DELTA-1;
k_n = ((ALPHA*a)/rk)^(1/(1-ALPHA));
if k_n <= 0 % here we can impose our non-negativity constraints to rule out certain steady-states
    error_indicator = 1;
end
w = (1-ALPHA)*a*k_n^ALPHA;
iv_n = DELTA*k_n;
y_n = a*k_n^ALPHA;
c_n = y_n - iv_n;
if c_n <= 0
    error_indicator = 1;
end
n = GAMMA/PSI*c_n^(-1)*w/(1+GAMMA/PSI*c_n^(-1)*w); % closed-form expression for n

c  = c_n*n;
iv = iv_n*n;
k  = k_n*n;
y  = y_n*n;
uc = GAMMA*c^(-1);
un = -PSI/(1-n);
fn = (1-ALPHA)*a*(k/n)^ALPHA;
fk = ALPHA*a*(k/n)^(ALPHA-1);

% write to output structure
SS.y  = y;
SS.c  = c;
SS.k  = k;
SS.n  = n;
SS.a  = a;
SS.rk = rk;
SS.w  = w;
SS.iv = iv;
SS.uc = uc;
SS.un = un;
SS.fn = fn;
SS.fk = fk;

end