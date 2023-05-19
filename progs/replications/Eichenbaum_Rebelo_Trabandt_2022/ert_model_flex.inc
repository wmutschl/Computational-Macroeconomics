% =========================================================================
% Stripped down flex-price version of New Keynesian Model of Eichenbaum,
% Rebelo, and Trabandt (2022, JEDC): "Epidemics in the New Keynesian model"
% based on the original Dynare replication files kindly provided by the
% authors (downloaded from Mathias Trabandt'sF homepage)
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: May 18, 2023
% =========================================================================

%-------------------------------------------------------------------------%
% DECLARE ENDOGENOUS VARIABLES FOR THE FLEX-PRICE ECONOMY
%-------------------------------------------------------------------------%
var
y_flex           ${y^{flex}}$                  (long_name='output (flex-price)')
k_flex           ${k^{flex}}$                  (long_name='aggregate capital (flex-price)')
n_flex           ${n^{flex}}$                  (long_name='aggregate labor (flex-price)')
w_flex           ${w^{flex}}$                  (long_name='real wage (flex-price)')
rk_flex          ${r^{k,flex}}$                (long_name='real rental rate of capital (flex-price)')
x_flex           ${x^{flex}}$                  (long_name='investment (flex-price)')
c_flex           ${c^{flex}}$                  (long_name='aggregate consumption (flex-price)')
s_flex           ${s^{flex}}$                  (long_name='susceptible (flex-price)')
i_flex           ${i^{flex}}$                  (long_name='infected (flex-price)')
r_flex           ${r^{flex}}$                  (long_name='recovered (flex-price)')
ns_flex          ${n^{s,flex}}$                (long_name='labor supply of susceptibles (flex-price)')
ni_flex          ${n^{i,flex}}$                (long_name='labor supply of infected (flex-price)')
nr_flex          ${n^{r,flex}}$                (long_name='labor supply of recovered (flex-price)')
cs_flex          ${c^{s,flex}}$                (long_name='consumption of susceptibles (flex-price)')
ci_flex          ${c^{i,flex}}$                (long_name='consumption of infected (flex-price)')
cr_flex          ${c^{r,flex}}$                (long_name='consumption of recovered (flex-price)')
tau_flex         ${\tau^{flex}}$               (long_name='newly infected (flex-price)')
lambtilde_flex   ${\tilde{\lambda}^{b,flex}}$  (long_name='Lagrange multiplier on household budget (flex-price)')
lamtau_flex      ${\lambda^{\tau,flex}}$       (long_name='Lagrange multiplier on transmission function (flex-price)')
lami_flex        ${\lambda^{i,flex}}$          (long_name='Lagrange multiplier on law of motion of infected (flex-price)')
lams_flex        ${\lambda^{s,flex}}$          (long_name='Lagrange multiplier on law of motion of susceptible (flex-price)')
lamr_flex        ${\lambda^{r,flex}}$          (long_name='Lagrange multiplier on law of motion of recovered (flex-price)')
dd_flex          ${d^{flex}}$                  (long_name='deceased (flex-price)')
pop_flex         ${pop^{flex}}$                (long_name='population (flex-price)')
pbreve_flex      ${\breve{p}^{flex}}$          (long_name='inverse price dispersion (flex-price)')
mc_flex          ${mc^{flex}}$                 (long_name='real marginal costs (flex-price)')
rr_flex          ${rr^{flex}}$                 (long_name='real interest rate (flex-price)')
Rb_flex          ${R^{b,flex}}$                (long_name='nominal interest rate (flex-price)')
pie_flex         ${\pi^{flex}}$                (long_name='inflation (flex-price)')
Kf_flex          ${K^{f,flex}}$                (long_name='auxiliary variable 1 in recursive price setting (flex-price)')
F_flex           ${F^{flex}}$                  (long_name='auxiliary variable 2 in recursive price setting (flex-price)')
;

%-------------------------------------------------------------------------%
% FLEX-PRICE MODEL EQUATIONS
%-------------------------------------------------------------------------%
% exactly the same as sticky-price equations but with added "_flex"
% notation and Calvo probability xi_flex set to 0

predetermined_variables k_flex i_flex s_flex r_flex dd_flex pop_flex;

model(differentiate_forward_vars);
#xi_flex = 0;
[name='F1) aggregate supply (flex-price)']
y_flex = pbreve_flex * A * k_flex^(1-alfa) * n_flex^alfa;
[name='F2) marginal costs (flex-price)']
mc_flex = w_flex^alfa * rk_flex^(1-alfa) / ( A * alfa^alfa * (1-alfa)^(1-alfa) );
[name='F3) optimal factor input (flex-price)']
w_flex = mc_flex * alfa * A * n_flex^(alfa-1) * k_flex^(1-alfa);
[name='F4) capital accumulation (flex-price)']
k_flex(+1) = (1-delta) * k_flex + x_flex;
[name='F5) aggregate demand (flex-price)']
y_flex = c_flex + x_flex + g_ss;
[name='F6) aggregate hours (flex-price)']
n_flex = (s_flex * ns_flex) + (i_flex * ni_flex) + (r_flex * nr_flex);
[name='F7) aggregate consumption (flex-price)']
c_flex = (s_flex * cs_flex) + (i_flex * ci_flex) + (r_flex * cr_flex);
[name='F8) transmission function for new infections (flex-price)']
tau_flex = pi1 * (s_flex * cs_flex) * (i_flex * ci_flex) + pi2 * (s_flex * ns_flex) * (i_flex * ni_flex) + pi3 * (s_flex * i_flex);
[name='F9) law of motion susceptible population (flex-price)']
s_flex(+1) = s_flex - tau_flex;
[name='F10) law of motion infected population (flex-price)']
i_flex(+1) = i_flex + tau_flex - (pir + pid) * i_flex;
[name='F11) law of motion recovered population (flex-price)']
r_flex(+1) = r_flex + pir * i_flex;
[name='F12) law of motion deceased population (flex-price)']
dd_flex(+1) = dd_flex + pid * i_flex;
[name='F13) total population (flex-price)']
pop_flex(+1) = pop_flex - pid * i_flex;
[name='F14) first order condition wrt consumption susceptibles (flex-price)']
1 / cs_flex = lambtilde_flex - lamtau_flex * pi1 * (i_flex * ci_flex);
[name='F15) first order condition wrt consumption infected (flex-price)']
1 / ci_flex = lambtilde_flex;
[name='F16) first order condition wrt consumption recovered (flex-price)']
1 / cr_flex = lambtilde_flex;
[name='F17) first order condition wrt hours susceptibles (flex-price)']
theta * ns_flex = lambtilde_flex * w_flex + lamtau_flex * pi2 * (i_flex * ni_flex);
[name='F18) first order condition wrt hours infected (flex-price)']
theta * ni_flex = lambtilde_flex * w_flex;
[name='F19) first order condition wrt hours recovered (flex-price)']
theta * nr_flex = lambtilde_flex * w_flex;
[name='F20) first order condition wrt capital (flex-price)']
lambtilde_flex = betta * ( rk_flex(+1) + 1 - delta ) * lambtilde_flex(+1);
[name='F21) first order condition wrt newly infected (flex-price)']
lami_flex = lamtau_flex + lams_flex;
[name='F22) first order condition wrt susceptibles (flex-price)']
0 = log(cs_flex(+1)) - theta/2 * ns_flex(+1)^2
  + lamtau_flex(+1) * ( pi1 * cs_flex(+1) * i_flex(+1) * ci_flex(+1)
                      + pi2 * ns_flex(+1) * i_flex(+1) * ni_flex(+1)
                      + pi3 * i_flex(+1)
                      )
  + lambtilde_flex(+1) * ( w_flex(+1) * ns_flex(+1) - cs_flex(+1) )
  - lams_flex / betta + lams_flex(+1);
[name='F23) first order condition wrt infected (flex-price)']
0 = log(ci_flex(+1)) - theta/2 * ni_flex(+1)^2
  + lambtilde_flex(+1) * ( w_flex(+1) * ni_flex(+1) - ci_flex(+1) )
  - lami_flex/betta + lami_flex(+1) * (1 - pir - pid) + lamr_flex(+1)*pir;
[name='F24) first order condition wrt recovered (flex-price)']
0 = log(cr_flex(+1)) - theta/2 * nr_flex(+1)^2
  + lambtilde_flex(+1) * ( w_flex(+1) * nr_flex(+1) - cr_flex(+1) )
  - lamr_flex/betta + lamr_flex(+1);
[name='F25) first order condition wrt bonds (flex-price)']
lambtilde_flex = betta * rr_flex * lambtilde_flex(+1);
[name='F26) real interest rate']
rr_flex = Rb_flex / pie_flex(+1);
[name='F27) recursion nonlinear price setting 1 (flex-price)']
Kf_flex = gam * mc_flex * lambtilde_flex * y_flex + betta * xi_flex * pie_flex(+1)^(gam/(gam-1)) * Kf_flex(+1);
[name='F28) recursion nonlinear price setting 2 (flex-price)']
F_flex = lambtilde_flex * y_flex + betta * xi_flex * pie_flex(+1)^(1/(gam-1)) *F_flex(+1);
[name='F29) nonlinear price setting (flex-price)']
Kf_flex = F_flex * ( ( 1 - xi_flex * pie_flex^(1/(gam-1)) ) / (1 - xi_flex) )^(-(gam-1));
[name='F30) inverse price dispersion (flex-price)']
pbreve_flex^(-1) = (1-xi_flex) * ( ( 1 - xi_flex * pie_flex^(1/(gam-1)) ) / (1 - xi_flex) )^gam
                 + xi_flex * pie_flex^(gam/(gam-1)) / pbreve_flex(-1);
[name='F31) Taylor rule (flex-price)']
Rb_flex - STEADY_STATE(Rb_flex) = rpi * log( pie_flex / STEADY_STATE(pie_flex) ) + rx * log( y_flex / y_flex );
end;

%-------------------------------------------------------------------------%
% PRE-INFECTION STEADY-STATE
%-------------------------------------------------------------------------%
% recursion nonlinear price setting (flex-price)
Kf_flex_ss = 1/(1-betta*0 )*gam*mc_ss*lambtilde_ss*y_ss; 
F_flex_ss  = 1/(1-betta*0 )*lambtilde_ss*y_ss;
