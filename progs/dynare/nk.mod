% Computes the steady-state of a New Keynesian model with Calvo price rigidities,
% capital, investment adjustment costs, nonzero inflation target, and fiscal policy
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: May 1, 2024
% -------------------------------------------------------------------------

%-------------------------------------------------------------------------%
% settings for macro preprocessor
%-------------------------------------------------------------------------%
@#define USE_INITVAL = false // set to true to use initval block
                             // otherwise steady_state_model block will be used

%-------------------------------------------------------------------------%
% declare variables and parameters
%-------------------------------------------------------------------------%
var
y       // real output
c       // real consumption
iv      // real investment
k       // capital stock
qk      // Lagrange multiplier capital accumulation constraint (Tobins marginal qk)
lam     // Lagrange multiplier budget constraint (marginal consumption utility)
rnom    // nominal interest rate
rk      // real rental rate of capital
w       // real wage
lab     // labor
divm    // real dividends of monopolists
mc      // real marginal costs
pstar   // price efficiency distortion
ptilde  // optimal reset price
s1p     // auxiliary numerator for recursive price setting
s2p     // auxiliary denominator for recursive price setting
pie     // gross inflation rate
g       // government spending
tau     // lump-sum taxes
a       // total factor productivity
mu      // discount factor shifter

// reporting variables in percentage deviation from steady-state
rreal   // real interest rate
hat_y hat_c hat_w hat_lab hat_k hat_iv hat_pi_an hat_rnom_an hat_rreal_an hat_rk_an hat_mc hat_a hat_mu hat_g
walras_test
;

varexo
eps_mu    // innovation to discount factor shifter (enters with a negative sign)
eps_a     // innovation to total factor productivity
eps_r     // innovation to monetary policy rule
eps_g     // innovation to government spending rule
;

parameters
BETA       // discount factor
SIGMAC     // inverse intertemporal elasticity of substitution (risk aversion)
SIGMAL     // inverse Frisch elasticity of labor
CHIL       // weight of labor in utility function
DELTAK     // capital depreciation rate
PHII       // quadratic investment adjustment cost
ALPHAK     // capital productivity in production
EPSILONP   // elasticity of substitution between differentiated goods
THETAP     // Calvo price probability
PSIRPI     // monetary policy feedback parameter to deviations of inflation from its target
PSIRY      // monetary policy feedback parameter to deviations of output from its steady-state
RHOMU      // persistence in discount factor shifter process
RHOA       // persistence in total factor productivity process
RHOR       // persistence in monetary policy rule
RHOG       // persistence in fiscal spending rule
TARGET_A   // baseline level of technology
TARGET_PI  // gross inflation target
TARGET_G_Y // government spending to output ratio target
;

%-------------------------------------------------------------------------%
% model equations
%-------------------------------------------------------------------------%
model;

%%%%%%%%%%%%%%
% households %
%%%%%%%%%%%%%%
[name='discount factor shifter process']
log(mu) = RHOMU * log(mu(-1)) - eps_mu; // note the minus sign!
[name='optimal bond holding, Euler equation for bonds']
1/rnom = BETA * (lam(+1)/lam) / pie(+1);
[name='marginal utility']
lam = mu * c^(-SIGMAC);
[name='labor supply']
w = CHIL * lab^(SIGMAL) * c^(SIGMAC);
[name='optimal capital decision, Euler equation for capital']
qk = BETA * lam(+1) / lam * ( rk(+1) + qk(+1) * (1-DELTAK) );
[name='optimal investment decision, Euler equation for investment']
1 = qk * ( 1 - PHII/2 * (iv/iv(-1)-1)^2 - PHII * (iv/iv(-1)-1) * (iv/iv(-1)) )
  + BETA * lam(+1) / lam * qk(+1) * PHII * (iv(+1)/iv-1) * (iv(+1)/iv)^2;
[name='capital accumulation']
k = (1-DELTAK) * k(-1) + ( 1 - PHII/2 * (iv/iv(-1)-1)^2 ) * iv;

%%%%%%%%%
% firms %
%%%%%%%%%
[name='total factor productivity process']
log(a) = (1-RHOA) * log(TARGET_A) + RHOA * log(a(-1)) + eps_a;
[name='optimal factor input, capital to labor ratio']
k(-1)/lab = (w/(1-ALPHAK)) * (ALPHAK/rk);
[name='marginal costs']
mc = 1/a * (w/(1-ALPHAK))^(1-ALPHAK) * (rk/ALPHAK)^ALPHAK;
[name='recursive price setting']
ptilde = EPSILONP/(EPSILONP-1) * s1p / s2p;
[name='recursive price setting: auxiliary numerator']
s1p = mc * y + THETAP * BETA * lam(+1) / lam * pie(+1)^EPSILONP * s1p(+1);
[name='recursive price setting: auxiliary denominator']
s2p = y + THETAP * BETA * lam(+1) / lam*pie(+1)^(EPSILONP-1) * s2p(+1);
[name='optimal reset price law of motion']
1 = (1-THETAP) * ptilde^(1-EPSILONP) + THETAP * pie^(EPSILONP-1);

%%%%%%%%%%%%%%
% government %
%%%%%%%%%%%%%%
[name='monetary policy rule']
rnom/steady_state(rnom) = (rnom/steady_state(rnom))^(RHOR) * ( (pie/TARGET_PI)^PSIRPI * (y/steady_state(y))^PSIRY )^(1-RHOR) * exp(eps_r);
[name='government spending rule']
g/steady_state(y) = (1-RHOG) * TARGET_G_Y + RHOG * g(-1)/steady_state(y) + eps_g;
[name='fiscal budget constraint']
tau = g;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% aggregation and market clearing %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[name='resource constraint']
y = c + iv + g;
[name='dividends intermediate firms (monopolists)']
divm = y - w * lab - rk * k(-1);
[name='aggregate supply']
pstar * y = a * k(-1)^ALPHAK * lab^(1-ALPHAK);
[name='price efficiency distortion law of motion']
pstar = (1-THETAP) * ptilde^(-EPSILONP) + THETAP * pie^EPSILONP * pstar(-1);
[name='aggregate budget constraint (optional for Walras)']
y = c + iv + g + walras_test;

%%%%%%%%%%%%%
% reporting %
%%%%%%%%%%%%%
[name='definition real interest rate']
rnom = rreal * pie(+1);
[name='output in percentage deviation from steady-state']
hat_y = log(y) - log(steady_state(y));
[name='consumption in percentage deviation from steady-state']
hat_c = log(c) - log(steady_state(c));
[name='wage in percentage deviation from steady-state']
hat_w = log(w) - log(steady_state(w));
[name='labor in percentage deviation from steady-state']
hat_lab = log(lab) - log(steady_state(lab));
[name='capital in percentage deviation from steady-state']
hat_k = log(k) - log(steady_state(k));
[name='investment in percentage deviation from steady-state']
hat_iv = log(iv) - log(steady_state(iv));
[name='annualized inflation in percentage deviation from steady-state']
hat_pi_an = 4*(log(pie) - log(steady_state(pie)));
[name='annualized nominal interest rate in percentage deviation from steady-state']
hat_rnom_an = 4*(log(rnom) - log(steady_state(rnom)));
[name='annualized real interest rate in percentage deviation from steady-state']
hat_rreal_an = 4*(log(rreal) - log(steady_state(rreal)));
[name='annualized real return on capital in percentage deviation from steady-state']
hat_rk_an = 4*(log(rk) - log(steady_state(rk)));
[name='marginal costs in percentage deviation from steady-state']
hat_mc = log(mc) - log(steady_state(mc));
[name='total factor productivity in percentage deviation from steady-state']
hat_a = log(a) - log(steady_state(a));
[name='discount factor shifter in percentage deviation from steady-state']
hat_mu = log(mu) - log(steady_state(mu));
[name='government spending ratio in percentage point deviation from steady-state']
hat_g = g/steady_state(y) - TARGET_G_Y;

end;

%-------------------------------------------------------------------------%
% calibration
%-------------------------------------------------------------------------%
BETA       = 0.99;
SIGMAC     = 2;
SIGMAL     = 2;
CHIL       = 5;
DELTAK     = 0.025;
PHII       = 4.25;
ALPHAK     = 0.33;
EPSILONP   = 6;
THETAP     = 0.75;
PSIRPI     = 1.5;
PSIRY      = 0.5/4;
RHOMU      = 0.5;
RHOA       = 0.9;
RHOR       = 0.5;
RHOG       = 0.5;
TARGET_A   = 1;
TARGET_PI  = 1.005;
TARGET_G_Y = 0.2;

@#if USE_INITVAL==true
%-------------------------------------------------------------------------%
% computations: steady-state with initval block
%-------------------------------------------------------------------------%
% note that you can compute simple expressions in the initval block and also
% re-use computed variables in subsequent initial values of other variables,
initval;
a = 1;
mu = 1;
qk = 1;
pie = TARGET_PI; 
rnom = pie/BETA;
rreal = 1/BETA;
rk = 1/BETA -qk*(1-DELTAK);
mc = (EPSILONP-1)/EPSILONP;
w = 1.5;
k = 8;
lab = 0.33;
y = a*k^ALPHAK*lab^(1-ALPHAK);
iv = DELTAK*k;
c = y-iv;
lam = mu*c^(-SIGMAC);
pstar = 1;
ptilde = 1;
s1p = y/(1-BETA*THETAP*pie^(EPSILONP-1));
s2p = mc*y/(1-BETA*THETAP*pie^EPSILONP);
g = TARGET_G_Y*y;
tau = g;
% by default a zero is assigned for any non-specified variables in this block
% so we can skip specifying the reporting variables as they have a steady-state of 0
end;
steady;

@#else
%-------------------------------------------------------------------------%
% computations: compute steady-state with steady_state_model block
%-------------------------------------------------------------------------%
steady_state_model;
mu = 1; % discount factor shifter process in steady-state
a = TARGET_A; % total factor productivity process in steady-state
pie = TARGET_PI; % monetary policy rule in steady-state
rnom = pie/BETA; % Bond Euler equation in steady-state
qk = 1; % investment Euler equation in steady-state
rk = qk/BETA - qk*(1-DELTAK); % capital Euler equation in steady-state
ptilde = ( (1-THETAP*pie^(EPSILONP-1)) / (1-THETAP) )^(1/(1-EPSILONP)); % law of motion optimal reset price in steady-state
pstar = (1-THETAP) / (1-THETAP*pie^EPSILONP) * ptilde^(-EPSILONP); % law of motion price dispersion in steady-state
s1p_over_s2p = (EPSILONP-1)/EPSILONP*ptilde; % recursive price setting in steady-state
mc = (1-THETAP*BETA*pie^EPSILONP)/(1-THETAP*BETA*pie^(EPSILONP-1)) * s1p_over_s2p;
w = (1-ALPHAK) * (mc*a*(ALPHAK/rk)^ALPHAK)^(1/(1-ALPHAK)); % marginal costs in steady-state
k_lab = w/(1-ALPHAK) * (ALPHAK/rk); % capital to labor ratio in steady-state
iv_lab = DELTAK*k_lab; % capital accumulation in steady-state
y_lab = pstar^(-1)*a*k_lab^ALPHAK; % aggregate supply in steady-state
g_lab = TARGET_G_Y * y_lab;
c_lab = y_lab - iv_lab - g_lab; % aggregate demand in steady-state
lab = ( (w/CHIL) * c_lab^(-SIGMAC) )^(1/(SIGMAL+SIGMAC)); % labor supply in steady-state
k = k_lab*lab; iv = iv_lab*lab; c = c_lab*lab; y = y_lab*lab; g = g_lab*lab;% identities
divm = y - w*lab - rk*k; % dividends in steady-state
lam = mu*c^(-SIGMAC); % marginal utility in steady-state
s2p =    y / (1 - THETAP*BETA*pie^(EPSILONP-1)); % recursive price setting denominator in steady-state
s1p = mc*y / (1 - THETAP*BETA*pie^(EPSILONP  )); % recursive price setting numerator in steady-state
tau = g; % fiscal budget
rreal = 1/BETA; % definition real interest rate
% by default a zero is assigned for any non-specified variables in this block
% so we can skip specifying the reporting variables as they have a steady-state of 0
% the preprocessor will issue a WARNING which we can correctly ignore
end;
steady;
@#endif

%-------------------------------------------------------------------------%
% checks
%-------------------------------------------------------------------------%
model_diagnostics; % finds obvious errors in your code