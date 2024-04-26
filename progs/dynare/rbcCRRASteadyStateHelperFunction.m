function n = rbcCRRASteadyStateHelperFunction(n0,PSI,ETAL,ETAC,GAMMA,c_n,w)
% function n = rbcCRRASteadyStateHelperFunction(n0,PSI,ETAL,ETAC,GAMMA,c_n,w)
% -------------------------------------------------------------------------
% helper function for Dynare's steady_state_model block to compute 
% steady-state labor of the RBC model with CRRA utility
% minimizes the residual in the labor market clearing equation
% -------------------------------------------------------------------------
% INPUTS:
%   n0 : initial guess for numerical optimizer
%   PSI, ETAL, ETAC, GAMMA: model parameters
%   c_n, w: already computed steady-state relationships (in steady_state_model block)
% OUTPUTS:
%   n : numerically optimized value for steady-state labor
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: April 25, 2024
% -------------------------------------------------------------------------
if ETAC == 1 && ETAL == 1
    % closed-form expression
    n = GAMMA/PSI*c_n^(-1)*w/(1+GAMMA/PSI*c_n^(-1)*w);
else
    % use numerical optimizer
    n = fsolve(@(x) w*GAMMA*c_n^(-ETAC) - PSI*(1-x)^(-ETAL)*x^ETAC , n0, optimset('Display','Final','TolX',1e-12,'TolFun',1e-12));
end