% Two-country New-Keynesian DSGE model with Zero-Lower-Bound on interest
% rates and endogenous discount factor
%
% Deterministic Simulation:
% pre-announced sequence of temporary monetary policy shocks
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: May 10, 2023
% =========================================================================

@#include "nk2co_common.mod"

shocks;
  var eps_rH;
  periods 4, 5:8;
  values 0.0075, 0.0025;
end;

perfect_foresight_setup(periods=100);
perfect_foresight_solver;

do_plots('Pre-Announced Monetary Policy Shock in HOME',21,oo_,M_);