function n = rbc_ces_helper_function(n0,PSI,ETAL,ETAC,GAMMA,c_n,w)
% function n = rbc_ces_helper_function(n0,PSI,ETAL,ETAC,GAMMA,c_n,w)
% =========================================================================
% helper function for Dynare's steady_state_model block to compute 
% steady-state labor of the RBC model with CRRA utility
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: April 17, 2023
% =========================================================================
if ETAC == 1 && ETAL == 1
    % close-form expression
    n = GAMMA/PSI*c_n^(-1)*w/(1+GAMMA/PSI*c_n^(-1)*w);
else
    % use numerical optimizer
    n = fsolve(@(x) w*GAMMA*c_n^(-ETAC) - PSI*(1-x)^(-ETAL)*x^ETAC ,...
               n0, optimset('Display','Final','TolX',1e-12,'TolFun',1e-12));
end