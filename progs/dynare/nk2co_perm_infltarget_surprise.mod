% =========================================================================
% Two-country New-Keynesian DSGE model with Zero-Lower-Bound on interest
% rates and endogenous discount factor
%
% Deterministic Simulation:
% inflation target increases permanently from 0% to 2% annually (0.5% quarterly)
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: May 10, 2023
% =========================================================================

@#include "nk2co_common.mod"

PIH = 1.005;
endval;
  piH = 1.005;
end;
steady;

perfect_foresight_setup(periods=500);
perfect_foresight_solver;

do_plots('Increase in Inflation Target',40,oo_,M_);