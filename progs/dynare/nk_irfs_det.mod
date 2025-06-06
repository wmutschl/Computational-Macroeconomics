% =========================================================================
% illustration of impulse response functions computed by deterministic
% simulations with perfect_foresight_solver in the baseline New Keynesian
% model with monopolistic competition, Calvo price frictions, and
% investment adjustment costs.
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: June 13, 2023
% =========================================================================
@#include "nk.mod"

%----------------------------------------------------------------
%  unit shock to technology
%---------------------------------------------------------------
steady;% start at steady-state
shocks;
var eps_a;    periods 1; values 1;
var eps_mu; periods 1; values 0;
var eps_r;   periods 1; values 0;
end;
perfect_foresight_setup(periods=50);
perfect_foresight_solver(maxit=100);
tit = 'eps_a';
nk_irfs_det_do_plots;
sgtitle('unit shock to technology');

%----------------------------------------------------------------
%  contractionary monetary policy shock of 25 basis points
%---------------------------------------------------------------
steady;% start at steady-state
shocks;
var eps_a;    periods 1; values 0;
var eps_mu; periods 1; values 0;
var eps_r;   periods 1; values 0.25;
end;
perfect_foresight_setup(periods=50);
perfect_foresight_solver(maxit=100);
tit = 'eps_nu';
nk_irfs_det_do_plots;
sgtitle('contractionary monetary policy shock of 25 basis points')

%----------------------------------------------------------------
%  initial preference shifter shock is set to -0.5 percentage points
%---------------------------------------------------------------
steady;% start at steady-state
shocks;
var eps_a;    periods 1; values 0;
var eps_mu; periods 1; values 0.5; % note that in the mod file the sign in front of eps z is a minus
var eps_r;   periods 1; values 0;
end;
perfect_foresight_setup(periods=50);
perfect_foresight_solver(maxit=100);
tit = 'eps_mu';
nk_irfs_det_do_plots;
sgtitle('initial preference shifter shock is set to -0.5 percentage points');