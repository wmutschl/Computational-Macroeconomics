% =========================================================================
% Replicates Figures 7 and 8 of
% Eichenbaum, Rebelo, and Trabandt (2022, JEDC):
% "Epidemics in the New Keynesian model"
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: May 18, 2023
% =========================================================================

@#include "ert_model_histval.mod"

% calibation targets for shares of pi-terms in T-function in SIR model
pi3_shr_target = 2/3;                  % share of T_0 jump due general infections
pi1_shr_target = 0;                    % share of T_0 jump due to consumption-based infections
pi2_shr_target = (1-pi3_shr_target);   % share of T_0 jump due to work-based infections
[pi1_final,pi2_final,pi3_final] = ert_model_go_calibrate_pi(250,varepsilon,pir,pid,pi1_shr_target,pi2_shr_target,RplusD_target,c_ss,n_ss);

% use set_param_value to update the parameters in the M_ structure
% changes in pi1 and pi2 are very small, so no need for homotopy
set_param_value('pi1',pi1_final);
set_param_value('pi2',pi2_final);

% homotopy over pi3 (otherwise the simulation does not converge)
pi3_steps = [pi3_final/3:0.02:pi3_final,pi3_final];
set_param_value('pi3',pi3_final/3); % set initial pi3 to one third of final value

% re-run perfect_foresight_solver for increasing values of pi3 taking
% previous simulation as initial guess for perfect foresight solver
for pi3_j = pi3_steps
    fprintf('pi3 = %f\n',pi3_j);
    set_param_value('pi3',pi3_j);
    perfect_foresight_solver(maxit=100);
end

% create figures
plot_also_flex_price_model = false;
ert_model_plot_agg_results("supply",M_,oo_,plot_also_flex_price_model);
ert_model_plot_by_type_results("supply",M_,oo_);