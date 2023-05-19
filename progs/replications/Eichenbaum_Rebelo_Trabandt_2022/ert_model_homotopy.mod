% =========================================================================
% Illustrates homotopy over a parameter in a perfect foresight context.
% Particularly, this is required to simulate the scenario "The impact of an
% epidemic" in the New Keynesian Model of Eichenbaum, Rebelo, and Trabandt
% (2022, JEDC): "Epidemics in the New Keynesian model".
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: May 18, 2023
% =========================================================================

@#include "ert_model_histval.mod"

% changes in pi1 and pi2 are very small, so no need for homotopy
set_param_value('pi1',2.568436063602094e-07);
set_param_value('pi2',1.593556989906377e-04);

% homotopy over pi3 (otherwise the simulation does not converge)
pi3_final = 0.499739472034583;
pi3_steps = [pi3_final/3:0.02:pi3_final,pi3_final];
set_param_value('pi3',pi3_final/3); % set initial pi3 to one third of final value

% re-run perfect_foresight_solver for increasing values of pi3 taking
% previous simulation as initial guess for perfect foresight solver
for pi3_j = pi3_steps
    fprintf('pi3 = %f\n',pi3_j);
    set_param_value('pi3',pi3_j);
    perfect_foresight_solver(maxit=100);
end