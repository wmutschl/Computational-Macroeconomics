% =========================================================================
% Combines the sticky-price model equations and the flex-price model
% equations of the New Keynesian Model of Eichenbaum, Rebelo, and Trabandt
% (2022, JEDC): "Epidemics in the New Keynesian model" and uses an
% initval block to compute the steady-state.
% This also illustrates setting macro variables and the include directive
% of Dynare's preprocessor.
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: May 18, 2023
% =========================================================================

@#define FLEX_PRICE_OUTPUT_GAP = 1
@#include "ert_model_sticky.mod"
@#include "ert_model_flex.inc"

%-------------------------------------------------------------------------%
% compute initial pre-infection steady-state
%-------------------------------------------------------------------------%
initval;
% most variables in sticky- and flex-price economies have same steady-state
y = y_ss;                  y_flex = y_ss;
k = k_ss;                  k_flex = k_ss;
n = n_ss;                  n_flex = n_ss;
w = w_ss;                  w_flex = w_ss;
x = x_ss;                  x_flex = x_ss;
c = c_ss;                  c_flex = c_ss;
s = s_ss;                  s_flex = s_ss;
i = i_ss;                  i_flex = i_ss;
r = r_ss;                  r_flex = r_ss;
rk = rk_ss;                rk_flex = rk_ss;
ns = ns_ss;                ns_flex = ns_ss;
ni = ni_ss;                ni_flex = ni_ss;
nr = nr_ss;                nr_flex = nr_ss;
cs = cs_ss;                cs_flex = cs_ss;
ci = ci_ss;                ci_flex = ci_ss;
cr = cr_ss;                cr_flex = cr_ss;
dd = dd_ss;                dd_flex = dd_ss;
mc = mc_ss;                mc_flex = mc_ss;
rr = rr_ss;                rr_flex = rr_ss;
Rb = Rb_ss;                Rb_flex = Rb_ss;
tau = tau_ss;              tau_flex = tau_ss;
pop = pop_ss;              pop_flex = pop_ss;
pie = pie_ss;              pie_flex = pie_ss;
lami = lami_ss;            lami_flex = lami_ss;
lams = lams_ss;            lams_flex = lams_ss;
lamr = lamr_ss;            lamr_flex = lamr_ss;
lamtau = lamtau_ss;        lamtau_flex = lamtau_ss;
pbreve = pbreve_ss;        pbreve_flex = pbreve_ss;
lambtilde = lambtilde_ss;  lambtilde_flex = lambtilde_ss;
% recursive pricing variables have different steady-states
F = F_ss;                  F_flex = F_flex_ss;
Kf = Kf_ss;                Kf_flex = Kf_flex_ss;
end;
resid;
steady;