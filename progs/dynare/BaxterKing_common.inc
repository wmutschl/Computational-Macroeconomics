% =========================================================================
% declaration and model equations of the RBC model with fiscal policy
% presented in Baxter and King (1993, American Economic Review)
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: April 17, 2023
% =========================================================================

%-------------------------------------------------------------------------%
% declare variables and parameters
%-------------------------------------------------------------------------%
var
  y     ${Y}$         (long_name='output')
  c     ${C}$         (long_name='consumption')
  l     ${L}$         (long_name='leisure')
  n     ${N}$         (long_name='labor')
  iv    ${I}$         (long_name='private investment')
  k     ${K}$         (long_name='private capital stock')
  lam   ${\lambda}$   (long_name='marginal utility')
  tr    ${TR}$        (long_name='fiscal transfers')
  tau   ${\tau}$      (long_name='net tax rate')
  gb    ${G^B}$       (long_name='basic government spending')
  @#if PRODUCTIVE_INVESTMENT==1
  ivg   ${I^G}$       (long_name='government investment')
  kg    ${K^G}$       (long_name='public capital stock')
  @#endif
  w     ${w}$         (long_name='real wage')
  r     ${R}$         (long_name='real interest rate')
  @#ifdef CHECK_WALRAS
  check_walras // redundant variable that checks whether resource constraint is full-filled according to Walras law
  @#endif
;

varexo
  e_tau   ${\varepsilon_{\tau}}$   (long_name='tax rate shock')
  e_gb    ${\varepsilon_{G^B}}$    (long_name='basic government spending shock')  
  @#if PRODUCTIVE_INVESTMENT==1
  e_ivg   ${\varepsilon_{IV^G}}$   (long_name='government investment shock')
  @#endif  
;

parameters
  A         ${A}$            (long_name='common technology level')
  GAMMAX    ${\gamma_X}$     (long_name='growth rate of labor-augmenting technology') //see footnote 3
  BETA      ${\beta}$        (long_name='discount factor')
  THETA_L   ${\theta_L}$     (long_name='weight of leisure in utility function')
  DELTA_K   ${\delta_K}$     (long_name='capital depreciation rate')
  THETA_K   ${\theta_K}$     (long_name='private capital productivity in production function')
  GB_BAR    ${\bar{G}^B}$    (long_name='target value of basic government spending')
  TAU_BAR   ${\bar{\tau}}$   (long_name='target value of tax rate')
  @#if PRODUCTIVE_INVESTMENT==1
  IVG_BAR   ${\bar{I}^G}$    (long_name='target value of government investment')
  THETA_G   ${\theta_G}$     (long_name='public capital productivity in production function')
  @#endif
;

model_local_variable THETA_N ${\theta_N}$; // labor productivity in production function
model_local_variable g_curr  ${G_t}$;      // total government spending
model_local_variable q_fwrd  ${q_{t+1}}$;  // real net rate of return on capital in t+1
model_local_variable ul_curr ${\frac{\partial U_t}{\partial L_t}$;         // marginal utility wrt labor in t
model_local_variable uc_curr ${\frac{\partial U_t}{\partial C_t}$;         // marginal utility wrt consumption in t
model_local_variable uc_fwrd ${\frac{\partial U_{t+1}}{\partial C_{t+1}}$; // marginal utility wrt consumption in t+1
model_local_variable fk_curr ${\frac{\partial F_t}{\partial K_{t-1}}$; // marginal utility wrt capital in t
model_local_variable fn_curr ${\frac{\partial F_t}{\partial N_{t}}$;   // marginal utility wrt labor in t

%-------------------------------------------------------------------------%
% model equations
%-------------------------------------------------------------------------%
model;

// auxiliary parameter
#THETA_N = 1-THETA_K; // page 317 below eq. (3)

// marginal utility given momentary utility eq. (2)
#ul_curr = THETA_L*l^(-1);
#uc_curr = c^(-1);
#uc_fwrd = c(+1)^(-1);

// marginal products given production function eq. (3)
@#if PRODUCTIVE_INVESTMENT==1
#fk_curr = THETA_K*A*k(-1)^(THETA_K-1)*n^THETA_N*kg(-1)^THETA_G;
#fk_fwrd = THETA_K*A*k^(THETA_K-1)*n(+1)^THETA_N*kg^THETA_G;
#fn_curr = THETA_N*A*k(-1)^THETA_K*n^(THETA_N-1)*kg(-1)^THETA_G;
@#else
#fk_curr = THETA_K*A*k(-1)^(THETA_K-1)*n^THETA_N;
#fk_fwrd = THETA_K*A*k^(THETA_K-1)*n(+1)^THETA_N;
#fn_curr = THETA_N*A*k(-1)^THETA_K*n^(THETA_N-1);
@#endif

@#if PRODUCTIVE_INVESTMENT==1
#g_curr = gb + ivg;   // page 318 below eq. (7)
@#else
#g_curr = gb;
@#endif
#q_fwrd = (1-tau(+1))*fk_fwrd;


% actual model equations
[name='production function, eq. (3)']
y = A * k(-1)^THETA_K * n^THETA_N
@#if PRODUCTIVE_INVESTMENT==1
  * kg(-1)^THETA_G
@#endif
;

[name='law of motion private capital stock, eq. (4) combined with footnote (3)']
GAMMAX*k = (1-DELTA_K)*k(-1) + iv;

@#if PRODUCTIVE_INVESTMENT==1
[name='law of motion public capital stock, eq. (5) combined with footnote (3)']
GAMMAX*kg = (1-DELTA_K)*kg(-1) + ivg;
@#endif

[name='time endowment, eq. (6)']
l + n = 1;

[name='market clearing, eq. (8)']
y = c + iv + g_curr;

[name='government budget constraint, eq. (9)']
tau*y = g_curr + tr;

[name='marginal utility, eq. (10)']
uc_curr = lam;

[name='labor-leisure decision combined with labor demand, eq. (11)']
ul_curr = lam*(1-tau)*fn_curr;

[name='savings decision, eq. (12) combined with footnote (3)']
BETA * lam(+1) * (q_fwrd + 1 - DELTA_K) = GAMMAX*lam;

[name='fiscal rule: government spending']
gb = GB_BAR + e_gb;

[name='fiscal rule: tax rate']
tau = TAU_BAR + e_tau;

@#if PRODUCTIVE_INVESTMENT==1
[name='fiscal rule: government investment']
ivg = IVG_BAR + e_ivg;
@#endif

[name='one period real interest rate, see King, Plosser, and Rebelo (1988) page 204 above section 3']
1+r = GAMMAX*lam/(lam(+1)*BETA);

[name='real wage, see King, Plosser, and Rebelo (1988) page 204 above section 3']
w = fn_curr;

@#ifdef CHECK_WALRAS
[name='resource constraint, eq. (7) (redundant due to Walras law)']
c + iv = (1-tau)*y + tr + check_walras;
@#endif
end;