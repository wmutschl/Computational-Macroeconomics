% Two-country New-Keynesian DSGE model with Zero-Lower-Bound on interest
% rates and endogenous discount factor
%
% Deterministic Simulation:
% temporary monetary policy shock surprise
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: May 10, 2023
% =========================================================================

@#include "nk2co_common.mod"

shocks;
  var eps_rH;
  periods 1;
  values 0.0015; % 15 basis points
end;

perfect_foresight_setup(periods=100);
perfect_foresight_solver;

do_plots('Temporary Monetary Policy Shock in HOME',21,oo_,M_);