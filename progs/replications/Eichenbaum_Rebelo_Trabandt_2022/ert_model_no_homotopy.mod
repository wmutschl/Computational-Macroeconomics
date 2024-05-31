% =========================================================================
% Illustrates that the scenario "The impact of an epidemic" in the New
% Keynesian Model of Eichenbaum, Rebelo, and Trabandt (2022, JEDC):
% "Epidemics in the New Keynesian model" has convergence issues due to the
% large change in the infection probability of random meetings (pi3).
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: May 18, 2023
% =========================================================================

@#include "ert_model_histval.mod"

% use set_param_value to update the parameters in the M_ structure
set_param_value('pi1',2.568436063602094e-07);
set_param_value('pi2',1.593556989906377e-04);
set_param_value('pi3',0.499739472034583);

% run perfect foresight simulation (feel free to abort it using CTRL+C)
perfect_foresight_solver(maxit=20); % higher maxit does not help