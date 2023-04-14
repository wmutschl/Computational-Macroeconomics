% =========================================================================
% simulate an ARMA(1,1) model
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: April 14, 2023
% =========================================================================

% =========================================================================
% Declare endogenous variables
% =========================================================================
var
  x        ${X}$           (long_name='ARMA(1,1) Process')
;

% =========================================================================
% Declare exogenous variables
% =========================================================================
varexo
  e        ${\varepsilon}$ (long_name='White Noise Process')
;

% =========================================================================
% Declare parameters
% =========================================================================
parameters
  THETA  ${\theta}$  (long_name='AR parameter')
  PHI    ${\phi}$    (long_name='MA parameter')
;

% =========================================================================
% Calibrate parameter values
% =========================================================================
THETA = 0.4;
PHI   = 0.4;

% =========================================================================
% Model equations
% =========================================================================
model;
[name='ARMA(1,1)']
x - THETA*x(-1) = e - PHI*e(-1);
end;

% =========================================================================
% Steady State Model
% =========================================================================
steady_state_model;
x = 0;
end;

% =========================================================================
% Declare settings for shocks
% =========================================================================
shocks;
var e = 1;
end;

% =========================================================================
% Computations
% =========================================================================
steady;
check;

stoch_simul(order=1,periods=200,irf=0);
% stoch_simul stores simulated values for x in two places:
%   - a variable x in the workspace
%   - a variable endo_simul in the structure oo_
% the underlying shocks (that were drawn from the normal distribution) are in
%   - a variable exo_simul in the structure oo_

% =========================================================================
% Plotting
% =========================================================================
figure;
subplot(2,1,1);
plot(x(51:end));% get rid of the initial 50 periods
title('$x_t$','Interpreter','latex');
subplot(2,1,2);
plot(oo_.exo_simul(51:end));
title('$\varepsilon_t$','Interpreter','latex');

% Note that both x and exo_simul are equal whenever PHI=THETA
if PHI == THETA
    disp(isequal(x,oo_.exo_simul))
end