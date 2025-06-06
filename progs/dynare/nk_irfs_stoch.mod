% =========================================================================
% illustration of impulse response functions computed by stochastic
% simulations with stoch_simul in the baseline New Keynesian model with
% monopolistic competition, Calvo price frictions, and investment
% adjustment costs.
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: June 13, 2023
% =========================================================================

@#include "nk.mod"

%----------------------------------------------------------------
%  shock variances
%---------------------------------------------------------------
shocks;
var eps_a    = 1^2;    % unit shock to technology
var eps_r   = 0.25^2; % 25 basis points
var eps_mu = 0.5^2;  % initial shock is set to -0.5 percentage points
                       % note: there needs to be a minus before eps_z!
end;

%----------------------------------------------------------------
% generate IRFs
%----------------------------------------------------------------
stoch_simul(order=1,irf=30) hat_y      hat_c      hat_iv
                            hat_lab      hat_k      hat_rnom_an  
                            hat_w      hat_rk_an hat_pi_an                            
                            hat_rreal_an hat_mc hat_a;