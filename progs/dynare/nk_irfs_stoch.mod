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
var eps_nu   = 0.25^2; % 25 basis points
var eps_zeta = 0.5^2;  % initial shock is set to -0.5 percentage points
                       % note: there needs to be a minus before eps_z!
end;

%----------------------------------------------------------------
% generate IRFs
%----------------------------------------------------------------
stoch_simul(order=1,irf=30) hat_y      hat_c      hat_iv
                            hat_h      hat_k      hat_rnom_ann  
                            hat_w      hat_rk_ann hat_pi_ann                            
                            hat_rreal_ann hat_mc nu hat_a hat_zeta;