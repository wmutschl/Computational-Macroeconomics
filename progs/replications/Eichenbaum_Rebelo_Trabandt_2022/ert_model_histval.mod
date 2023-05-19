% =========================================================================
% Includes the scenario "The impact of an epidemic" into the New Keynesian
% Model of Eichenbaum, Rebelo, and Trabandt (2022, JEDC): "Epidemics in the
% New Keynesian model" by specifying an initial condition such that
% infections break out at time 0.
% This mod file also includes some pretty printing of the initial matrices
% created by Dynare.
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: May 18, 2023
% =========================================================================

@#include "ert_model_initval.mod"

%-------------------------------------------------------------------------%
% use histval for initial condition that infections break out at time 0
%-------------------------------------------------------------------------%
histval;
% infections break out at time 0
i(0) = varepsilon;            i_flex(0) = varepsilon;
s(0) = 1-varepsilon;          s_flex(0) = 1-varepsilon;

% most variables set at pre-infection steady-state
y(0) = y_ss;                  y_flex(0) = y_ss;
k(0) = k_ss;                  k_flex(0) = k_ss;
n(0) = n_ss;                  n_flex(0) = n_ss;
w(0) = w_ss;                  w_flex(0) = w_ss;
x(0) = x_ss;                  x_flex(0) = x_ss;
c(0) = c_ss;                  c_flex(0) = c_ss;
r(0) = r_ss;                  r_flex(0) = r_ss;
rk(0) = rk_ss;                rk_flex(0) = rk_ss;
ns(0) = ns_ss;                ns_flex(0) = ns_ss;
ni(0) = ni_ss;                ni_flex(0) = ni_ss;
nr(0) = nr_ss;                nr_flex(0) = nr_ss;
cs(0) = cs_ss;                cs_flex(0) = cs_ss;
ci(0) = ci_ss;                ci_flex(0) = ci_ss;
cr(0) = cr_ss;                cr_flex(0) = cr_ss;
dd(0) = dd_ss;                dd_flex(0) = dd_ss;
mc(0) = mc_ss;                mc_flex(0) = mc_ss;
rr(0) = rr_ss;                rr_flex(0) = rr_ss;
Rb(0) = Rb_ss;                Rb_flex(0) = Rb_ss;
tau(0) = tau_ss;              tau_flex(0) = tau_ss;
pop(0) = pop_ss;              pop_flex(0) = pop_ss;
pie(0) = pie_ss;              pie_flex(0) = pie_ss;
lami(0) = lami_ss;            lami_flex(0) = lami_ss;
lams(0) = lams_ss;            lams_flex(0) = lams_ss;
lamr(0) = lamr_ss;            lamr_flex(0) = lamr_ss;
lamtau(0) = lamtau_ss;        lamtau_flex(0) = lamtau_ss;
pbreve(0) = pbreve_ss;        pbreve_flex(0) = pbreve_ss;
lambtilde(0) = lambtilde_ss;  lambtilde_flex(0) = lambtilde_ss;
% recursive pricing variables have different steady-states
F(0) = F_ss;                  F_flex(0) = F_flex_ss;
Kf(0) = Kf_ss;                Kf_flex(0) = Kf_flex_ss;
end;

perfect_foresight_setup(periods=500);

% have a look at how variables for perfect foresight algorithm are initialized
fprintf('\n\nINITIALIZATION OF PERFECT FORESIGHT ALGORITHM: oo_.steady_state\n')
disp(array2table(oo_.steady_state', 'VariableNames',M_.endo_names));
fprintf('\n\nINITIALIZATION OF PERFECT FORESIGHT ALGORITHM: M_.endo_histval\n')
disp(array2table(M_.endo_histval', 'VariableNames',M_.endo_names));
fprintf('\n\nINITIALIZATION OF PERFECT FORESIGHT ALGORITHM: oo_.endo_simul\n')
disp(array2table(oo_.endo_simul(:,[1:3 options_.periods+2])',...
                 'VariableNames',M_.endo_names,...
                 'RowNames',["t=0","t=1","t=2",("t="+string(options_.periods+2))]'));
fprintf('\n\nINITIALIZATION OF PERFECT FORESIGHT ALGORITHM: oo_.exo_simul\n')
oo_.exo_simul
