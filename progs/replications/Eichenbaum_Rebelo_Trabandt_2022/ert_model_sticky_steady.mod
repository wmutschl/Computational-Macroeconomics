% =========================================================================
% Computes the steady-state of the sticky-price New Keynesian Model of
% Eichenbaum, Rebelo, and Trabandt (2022, JEDC): "Epidemics in the New
% Keynesian model".
% This illustrates using the include directive of Dynare's preprocessor.
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: May 18, 2023
% =========================================================================

@#include "ert_model_sticky.mod"

%-------------------------------------------------------------------------%
% compute initial pre-infection steady-state
%-------------------------------------------------------------------------%
initval;
y = y_ss;
k = k_ss;
n = n_ss;
w = w_ss;
rk = rk_ss;
x = x_ss;
c = c_ss;
s = s_ss;
i = i_ss;
r = r_ss;
ns = ns_ss;
ni = ni_ss;
nr = nr_ss;
cs = cs_ss;
ci = ci_ss;
cr = cr_ss;
tau = tau_ss;
lambtilde = lambtilde_ss;
lamtau = lamtau_ss;
lami = lami_ss;
lams = lams_ss;
lamr = lamr_ss;
dd = dd_ss;
pop = pop_ss;
pbreve = pbreve_ss;
mc = mc_ss;
rr = rr_ss;
Rb = Rb_ss;
pie = pie_ss;
Kf = Kf_ss;
F = F_ss;
end;
resid;
steady;