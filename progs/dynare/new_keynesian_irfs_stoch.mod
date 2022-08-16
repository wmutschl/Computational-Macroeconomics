@#include "new_keynesian_common_with_minus_eps_z.inc"

%----------------------------------------------------------------
%  Calibration
%---------------------------------------------------------------
BETA    = 0.99;
RHO_A   = 0.9;
RHO_Z   = 0.5;
RHO_NU  = 0.4;
SIGMA   = 1;
VARPHI  = 5;
THETA   = 0.75;
EPSILON = 9;
PHI_PIE = 1.5;
PHI_Y   = 0.125;
PIESTAR = 1;

%----------------------------------------------------------------
%  Shock Variances
%---------------------------------------------------------------
shocks;
var eps_a  = 1^2;    % unit shock to technology
var eps_nu = 0.25^2; % 25 basis points
var eps_z  = 0.5^2;  % initial shock is set to -0.5 percentage points
                     % note: there needs to be a minus before eps_z!
end;

%----------------------------------------------------------------
% generate IRFs
%----------------------------------------------------------------

stoch_simul(order=1,irf=30) nu ahat zhat
                            yhat what nhat 
                            piehat_an Rhat_an rhat_an mchat;
