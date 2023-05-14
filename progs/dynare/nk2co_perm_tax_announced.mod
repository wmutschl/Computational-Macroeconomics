% =========================================================================
% Two-country New-Keynesian DSGE model with Zero-Lower-Bound on interest
% rates and endogenous discount factor
%
% Deterministic Simulation:
% pre-announced permanent tax increase from 0% to 10% in t=5,...
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: May 10, 2023
% =========================================================================

@#include "nk2co_common.mod"
taxval = 0.1; % increase in tax rate

initval;
  eps_tauH = 0;
end;
steady;
ys0 = oo_.steady_state; % store initial steady-state

endval;
  eps_tauH = taxval;
end;
steady;
ys1 = oo_.steady_state; % store terminal steady-state

shocks;
  var eps_tauH;
  periods 1:5; % first 5 periods no tax increase
  values 0;
end;

perfect_foresight_setup(periods=100); % prepare perfect foresight simulation
endo_simul_init = oo_.endo_simul;    % store initial value matrix for endogenous
exo_simul_init = oo_.exo_simul;      % store initial value matrix for exogenous

perfect_foresight_solver; % run solver

do_plots('Pre-Announced Permanent Tax Increase in HOME',40,oo_,M_);