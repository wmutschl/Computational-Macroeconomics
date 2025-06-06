% =========================================================================
% Stripped down sticky-price version of New Keynesian Model of Eichenbaum,
% Rebelo, and Trabandt (2022, JEDC): "Epidemics in the New Keynesian model"
% based on the original Dynare replication files kindly provided by the
% authors (downloaded from Mathias Trabandt's homepage)
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: May 18, 2023
% =========================================================================

%-------------------------------------------------------------------------%
% DECLARE ENDOGENOUS VARIABLES FOR THE STICKY-PRICE ECONOMY
%-------------------------------------------------------------------------%
var
y           ${y}$                  (long_name='output')
k           ${k}$                  (long_name='aggregate capital')
n           ${n}$                  (long_name='aggregate labor')
w           ${w}$                  (long_name='real wage')
rk          ${r^k}$                (long_name='real rental rate of capital')
x           ${x}$                  (long_name='investment')
c           ${c}$                  (long_name='aggregate consumption')
s           ${s}$                  (long_name='susceptible')
i           ${i}$                  (long_name='infected')
r           ${r}$                  (long_name='recovered')
ns          ${n^s}$                (long_name='labor supply of susceptibles')
ni          ${n^i}$                (long_name='labor supply of infected')
nr          ${n^r}$                (long_name='labor supply of recovered')
cs          ${c^s}$                (long_name='consumption of susceptibles')
ci          ${c^i}$                (long_name='consumption of infected')
cr          ${c^r}$                (long_name='consumption of recovered')
tau         ${\tau}$               (long_name='newly infected')
lambtilde   ${\tilde{\lambda}^b}$  (long_name='Lagrange multiplier on household budget')
lamtau      ${\lambda^\tau}$       (long_name='Lagrange multiplier on transmission function')
lami        ${\lambda^i}$          (long_name='Lagrange multiplier on law of motion of infected')
lams        ${\lambda^s}$          (long_name='Lagrange multiplier on law of motion of susceptible')
lamr        ${\lambda^r}$          (long_name='Lagrange multiplier on law of motion of recovered')
dd          ${d}$                  (long_name='deceased')
pop         ${pop}$                (long_name='population')
pbreve      ${\breve{p}}$          (long_name='inverse price dispersion')
mc          ${mc}$                 (long_name='real marginal costs')
rr          ${rr}$                 (long_name='real interest rate')
Rb          ${R^b}$                (long_name='nominal interest rate')
pie         ${\pi}$                (long_name='inflation')
Kf          ${K^f}$                (long_name='auxiliary variable 1 in recursive price setting')
F           ${F}$                  (long_name='auxiliary variable 2 in recursive price setting')
@#ifdef FLEX_PRICE_OUTPUT_GAP
y_flex      ${y^{flex}}$           (long_name='output (flex-price)')
@#endif
;

%-------------------------------------------------------------------------%
% DECLARE MODEL PARAMETERS
%-------------------------------------------------------------------------%
parameters
xi          ${\xi}$          (long_name='Calvo probability sticky-price economy')
rpi         ${r_\pi}$        (long_name='Taylor rule coefficient inflation')
rx          ${r_x}$          (long_name='Taylor rule coefficient output gap')
gam         ${\gamma}$       (long_name='elasticity in Dixit-Stiglitz aggregator (steady-state gross price markup)')
pi1         ${\pi_1}$        (long_name='probability of becoming infected as a result of time spent in consumption activities')
pi2         ${\pi_2}$        (long_name='probability of becoming infected as a result of time spent in working interactions')
pi3         ${\pi_3}$        (long_name='probability of becoming infected as a result of random meetings')
pir         ${\pi_r}$        (long_name='probability of recovering from infection')
pid         ${\pi_d}$        (long_name='probability of dying from infection')
betta       ${\beta}$        (long_name='discount factor')
A           ${A}$            (long_name='common productivity level')
theta       ${\theta}$       (long_name='weight of labor in utility function')
alfa        ${\alpha}$       (long_name='labor share in production')
delta       ${\delta}$       (long_name='capital depreciation rate')
g_ss        ${G}$            (long_name='government spending')
inc_target  ${\bar{Y}}$      (long_name='calibration target for income in steady-state')
n_target    ${\bar{N}}$      (long_name='calibration target for labor in steady-state')
eta         ${\eta}$         (long_name='calibration target for government consumption to GDP ratio')
varepsilon  ${\varepsilon}$  (long_name='initial seed of infection (I_0)')
;

%-------------------------------------------------------------------------%
% STICKY-PRICE MODEL EQUATIONS (ACCORDING TO APPENDIX A)
%-------------------------------------------------------------------------%
predetermined_variables k i s r dd pop;
model(differentiate_forward_vars);
[name='1) aggregate supply']
y = pbreve * A * k^(1-alfa) * n^alfa;
[name='2) marginal costs']
mc = w^alfa * rk^(1-alfa) / ( A * alfa^alfa * (1-alfa)^(1-alfa) );
[name='3) optimal factor input']
w = mc * alfa * A * n^(alfa-1) * k^(1-alfa);
[name='4) capital accumulation']
k(+1) = (1-delta) * k + x;
[name='5) aggregate demand']
y = c + x + g_ss;
[name='6) aggregate hours']
n = (s * ns) + (i * ni) + (r * nr);
[name='7) aggregate consumption']
c = (s * cs) + (i * ci) + (r * cr);
[name='8) transmission function for new infections']
tau = pi1 * (s * cs) * (i * ci) + pi2 * (s * ns) * (i * ni) + pi3 * (s * i);
[name='9) law of motion susceptible population']
s(+1) = s - tau;
[name='10) law of motion infected population']
i(+1) = i + tau - (pir + pid) * i;
[name='11) law of motion recovered population']
r(+1) = r + pir * i;
[name='12) law of motion deceased population']
dd(+1) = dd + pid * i;
[name='13) total population']
pop(+1) = pop - pid * i;
[name='14) first order condition wrt consumption susceptibles']
1 / cs = lambtilde - lamtau * pi1 * (i * ci);
[name='15) first order condition wrt consumption infected']
1 / ci = lambtilde;
[name='16) first order condition wrt consumption recovered']
1 / cr = lambtilde;
[name='17) first order condition wrt hours susceptibles']
theta * ns = lambtilde * w + lamtau * pi2 * (i * ni);
[name='18) first order condition wrt hours infected']
theta * ni = lambtilde * w;
[name='19) first order condition wrt hours recovered']
theta * nr = lambtilde * w;
[name='20) first order condition wrt capital']
lambtilde = betta * ( rk(+1) + 1 - delta ) * lambtilde(+1);
[name='21) first order condition wrt newly infected']
lami = lamtau + lams;
[name='22) first order condition wrt susceptibles']
0 = log(cs(+1)) - theta/2 * ns(+1)^2
  + lamtau(+1) * ( pi1 * cs(+1) * i(+1) * ci(+1)
                 + pi2 * ns(+1) * i(+1) * ni(+1)
                 + pi3 * i(+1)
                 )
  + lambtilde(+1) * ( w(+1) * ns(+1) - cs(+1) )
  - lams / betta + lams(+1);
[name='23) first order condition wrt infected']
0 = log(ci(+1)) - theta/2 * ni(+1)^2
  + lambtilde(+1) * ( w(+1) * ni(+1) - ci(+1) )
  - lami/betta + lami(+1) * (1 - pir - pid) + lamr(+1)*pir;
[name='24) first order condition wrt recovered']
0 = log(cr(+1)) - theta/2 * nr(+1)^2
  + lambtilde(+1) * ( w(+1) * nr(+1) - cr(+1) )
  - lamr/betta + lamr(+1);
[name='25) first order condition wrt bonds']
lambtilde = betta * rr * lambtilde(+1);
[name='26) real interest rate']
rr = Rb / pie(+1);
[name='27) recursion nonlinear price setting 1']
Kf = gam * mc * lambtilde * y + betta * xi * pie(+1)^(gam/(gam-1)) * Kf(+1);
[name='28) recursion nonlinear price setting 2']
F = lambtilde * y + betta * xi * pie(+1)^(1/(gam-1)) *F(+1);
[name='29) nonlinear price setting']
Kf = F * ( ( 1 - xi * pie^(1/(gam-1)) ) / (1 - xi) )^(-(gam-1));
[name='30) inverse price dispersion']
pbreve^(-1) = (1-xi) * ( ( 1 - xi * pie^(1/(gam-1)) ) / (1 - xi) )^gam
            + xi * pie^(gam/(gam-1)) / pbreve(-1);
[name='31) Taylor rule']
Rb - STEADY_STATE(Rb) = rpi * log( pie / STEADY_STATE(pie) )
@#ifdef FLEX_PRICE_OUTPUT_GAP
                      + rx * log( y / y_flex )
@#else
                      + rx * log( y / steady_state(y) )
@#endif
;
end;

%-------------------------------------------------------------------------%
% COMMON WEEKLY CALIBRATION (SECTION 3.1, TABLE 8)
%-------------------------------------------------------------------------%
pid        = 7*0.002/14;  % probability of dying
pir        = 7/14 - pid;  % probability of recovering
delta      = 0.06/52;     % capital depreciation rate
alfa       = 2/3;         % labor share
gam        = 1.35;        % gross price markup
xi         = 0.98;        % Calvo price stickiness
rpi        = 1.5;         % Taylor rule coefficient inflation
rx         = 0.5/52;      % Taylor rule coefficient output gap
eta        = 0.19;        % government consumption share of output
n_target   = 28;          % hours worked target
inc_target = 58000/52;    % income target
betta      = 0.98^(1/52); % discount factor
varepsilon = 0.001;       % initial seed of infection (varepsilon)
RplusD_target = 0.60;     % total share of people infected and then either
                          % recovered or dead after epidemic (Merkel scenario)

%-------------------------------------------------------------------------%
% PRE-INFECTION STEADY-STATE
%-------------------------------------------------------------------------%
pi1 = 0; pi2 = 0; pi3 = 0; % initialize to compute steady-state,
                           % these will change depending on epidemic type
pop_ss = 1; % normalize
s_ss = 1;   % no infections
i_ss = 0;   % no infections
r_ss = 0;   % no infections
dd_ss = 0;  % no infections
y_ss = inc_target; % calibration target
n_ss = n_target;   % calibration target
pie_ss = 1; % calibration target: no inflation
pbreve_ss = 1; % law of motion price dispersion with no inflation steady-state
mc_ss = 1/gam; % recursive price setting, combined with no inflation steady-state
w_ss  = mc_ss*alfa*y_ss/n_ss; % optimal labor demand
rk_ss = 1/betta-1+delta; % first-order condition wrt capital
kn_ss = (1-alfa)*w_ss/alfa/rk_ss; % optimal factor input (as a ratio to labor)
yk_ss = (y_ss/n_ss)/kn_ss; % definition output-to-capital ratio
A = (y_ss/n_ss)^alfa*yk_ss^(1-alfa); % production function
k_ss = (y_ss/A/n_ss^alfa)^(1/(1-alfa)); % production function
x_ss = delta*k_ss; % capital accumulation
g_ss = eta*y_ss; % target
c_ss = y_ss - x_ss - g_ss; % aggregate demand
ns_ss = n_ss; % aggregate labor with no infections
cs_ss = c_ss; % aggregate consumption with no infections
tau_ss = 0; % transmission function with no infections
s_ss = 1; % law of motion susceptibles with no infections
i_ss = 0; % law of motion infected with no infections
r_ss = 0; % law of motion recovered with no infections
lambtilde_ss = 1/cs_ss; % first-order condition wrt susceptibles
ci_ss = cs_ss; % first-order condition wrt infected
cr_ss = cs_ss; % first-order condition wrt recovered
theta = lambtilde_ss*w_ss/ns_ss; % first order condition wrt hours susceptibles
ni_ss = lambtilde_ss*w_ss/theta; % first order condition wrt hours infected
nr_ss = ns_ss; % first order condition wrt hours recovered
% value of life
lams_ss = (log(cs_ss)-theta/2*ns_ss^2 + lambtilde_ss*(w_ss*ns_ss-cs_ss) ) / ( 1/betta-1 );
lamr_ss = (log(cr_ss)-theta/2*nr_ss^2 + lambtilde_ss*(w_ss*nr_ss-cr_ss) ) / ( 1/betta-1 );
lami_ss = (log(ci_ss)-theta/2*ni_ss^2 + lambtilde_ss*(w_ss*ni_ss-ci_ss) + pir*lamr_ss) / ( 1/betta-1+pir+pid );
lamtau_ss = lami_ss-lams_ss; % first order condition wrt newly infected
Rb_ss = pie_ss/betta; % first order condition wrt bonds
rr_ss = Rb_ss/pie_ss; % real interest rate
% recursion nonlinear price setting (sticky-price)
Kf_ss  = 1/(1-betta*xi)*gam*mc_ss*lambtilde_ss*y_ss;
F_ss   = 1/(1-betta*xi)*lambtilde_ss*y_ss;

%-------------------------------------------------------------------------%
% display useful calibration targets, ratios and steady-state
%-------------------------------------------------------------------------%
fprintf('CALIBRATION TARGETS, RATIOS, STEADY-STATE\n');
fprintf('  - value of life = %.2f\n', 1/(1-betta)*(log(c_ss)-theta/2*n_ss^2)*c_ss);
fprintf('  - steady-state real wage = %.2f\n', w_ss);
fprintf('  - value of utility weight of labor = %.3f\n', theta);
fprintf('  - value of common productivtiy level = %.3f\n', A);
fprintf('  - annualized capital to output ratio = %.2f%%\n', k_ss/(52*y_ss));
fprintf('  - share of investment as a fraction of y = %.2f%%\n',100*x_ss/y_ss);
fprintf('  - share of consumption as a fraction of y = %.2f%%\n',100*c_ss/y_ss);
fprintf('  - share of gov. spending as a fraction of y = %.2f%%\n',100*g_ss/y_ss);
fprintf('  - prices change on average %.2f times per year\n', (1/(1-xi))/52)