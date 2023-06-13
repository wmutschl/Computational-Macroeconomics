% =========================================================================
% Computes the steady-state of a New Keynesian model with Calvo price
% rigidities, capital, investment adjustment costs, nonzero inflation target
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: May 5, 2023
% =========================================================================

%-------------------------------------------------------------------------%
% settings for macro preprocessor
%-------------------------------------------------------------------------%
@#define USE_INITVAL=0 // set to 1 to use initval block
                       // otherwise steady_state_model block will be used
                       // to compute the steady-state

%-------------------------------------------------------------------------%
% declare variables and parameters
%-------------------------------------------------------------------------%
var
y       // real output
c       // real consumption
iv      // real investment
k       // capital stock
q       // Lagrange multiplier capital accumulation constraint (Tobins marginal q)
lam     // Lagrange multiplier budget constraint (marginal consumption utility)
rnom    // nominal interest rate
rreal   // real interest rate
rk      // real rental rate of capital
w       // real wage
h       // labor
div     // real dividends of firms
mc      // real marginal costs
pstar   // price efficiency distortion
ptilde  // optimal reset price
s1      // auxiliary variable 1 for recursive price setting
s2      // auxiliary variable 2 for recursive price setting
pie     // gross inflation rate
a       // total factor productivity
nu      // monetary policy shock
zeta    // discount factor shifter

// reporting variables in percentage deviation from steady-state
hat_y hat_c hat_w hat_h hat_k hat_iv hat_pi_ann hat_rnom_ann hat_rreal_ann hat_rk_ann hat_mc hat_a hat_zeta
;

varexo
eps_a     // innovation to total factor productivity
eps_nu    // innovation to monetary policy shock
eps_zeta  // innovation to discount factor shifter (enters with a negative sign)
;

parameters
BETA     // discount factor
SIGMA_C  // inverse intertemporal elasticity of substitution (risk aversion)
SIGMA_H  // inverse Frisch elasticity of labor
CHIH     // weight of labor in utility function
EPSILON  // elasticity of substitution between differentiated goods
DELTA    // capital depreciation rate
PHIIV    // quadratic investment adjustment cost
ALPHA    // capital productivity in production
THETA    // Calvo probability
PISTAR   // inflation target
PSI_PI   // monetary policy feedback parameter to deviations of inflation from its target
PSI_Y    // monetary policy feedback parameter to deviations of output from its steady-state
RHOA     // persistence total factor productivity process
RHONU    // persistence monetary policy shock process
RHOZETA  // persistence discount factor shifter process
;

%-------------------------------------------------------------------------%
% model equations
%-------------------------------------------------------------------------%
model;

////////////////////////////////
// definitions and identities //
////////////////////////////////
[name='definition real interest rate']
rnom = rreal*pie(+1);

////////////////
// households //
////////////////
[name='capital accumulation']
k = (1-DELTA)*k(-1) + ( 1- PHIIV/2*(iv/iv(-1)-1)^2 ) * iv;
[name='marginal utility']
lam = zeta*c^(-SIGMA_C);
[name='labor supply']
w = CHIH*h^(SIGMA_H)*c^(SIGMA_C);
[name='optimal bond holding, Euler equation for bonds']
lam = BETA*lam(+1)*rreal;
[name='optimal investment decision, Euler equation for investment']
1 = q * ( 1 - PHIIV/2 * (iv/iv(-1)-1)^2 - PHIIV * (iv/iv(-1)-1)*(iv/iv(-1)) )
  + BETA * lam(+1)/lam * q(+1) * PHIIV * (iv(+1)/iv-1) * (iv(+1)/iv)^2;
[name='optimal capital decision, Euler equation for capital']
q = BETA*lam(+1)/lam*(rk(+1)+q(+1)*(1-DELTA));

///////////
// firms //
///////////
[name='optimal factor input, capital to labor ratio']
k(-1)/h = w/(1-ALPHA) * (ALPHA/rk);
[name='marginal costs']
mc = 1/a * (w/(1-ALPHA))^(1-ALPHA) * (rk/ALPHA)^ALPHA;
[name='recursive price setting']
ptilde * s1 = EPSILON/(EPSILON-1)*s2;
[name='recursive price setting auxiliary sum 1']
s1 = y + BETA*THETA*lam(+1)/lam*pie(+1)^(EPSILON-1)*s1(+1);
[name='recursive price setting auxiliary sum 2']
s2 = mc*y + BETA*THETA*lam(+1)/lam*pie(+1)^EPSILON*s2(+1);
[name='dividends intermediate firms (wholesale sector)']
div = y - w*h - rk*k(-1);
[name='optimal reset price law of motion']
1 = THETA*pie^(EPSILON-1) + (1-THETA)*ptilde^(1-EPSILON);

/////////////////////////////////////
// aggregation and market clearing //
/////////////////////////////////////
[name='aggregate demand']
y = c + iv;
[name='aggregate supply']
pstar*y = a*k(-1)^ALPHA*h^(1-ALPHA);
[name='price efficiency distortion law of motion']
pstar = (1-THETA)*ptilde^(-EPSILON) + THETA*pie^EPSILON*pstar(-1);
[name='monetary policy rule']
rnom = steady_state(rnom) * (pie/PISTAR)^PSI_PI * (y/steady_state(y))^PSI_Y * exp(nu);

/////////////////////////
// exogenous processes //
/////////////////////////
[name='total factor productivity process']
log(a) = RHOA*log(a(-1)) + eps_a;
[name='monetary policy shock process']
nu = RHONU*nu(-1) + eps_nu;
[name='discount factor shifter process']
log(zeta) = RHOZETA*log(zeta(-1)) - eps_zeta; // note the minus sign

///////////////
// reporting //
///////////////
[name='output in percentage deviation from steady-state']
hat_y = log(y) - log(steady_state(y));
[name='consumption in percentage deviation from steady-state']
hat_c = log(c) - log(steady_state(c));
[name='wage in percentage deviation from steady-state']
hat_w = log(w) - log(steady_state(w));
[name='labor in percentage deviation from steady-state']
hat_h = log(h) - log(steady_state(h));
[name='capital in percentage deviation from steady-state']
hat_k = log(k) - log(steady_state(k));
[name='investment in percentage deviation from steady-state']
hat_iv = log(iv) - log(steady_state(iv));
[name='annualized inflation in percentage deviation from steady-state']
hat_pi_ann = 4*(log(pie) - log(steady_state(pie)));
[name='annualized nominal interest rate in percentage deviation from steady-state']
hat_rnom_ann = 4*(log(rnom) - log(steady_state(rnom)));
[name='annualized real interest rate in percentage deviation from steady-state']
hat_rreal_ann = 4*(log(rreal) - log(steady_state(rreal)));
[name='annualized real return on capital in percentage deviation from steady-state']
hat_rk_ann = 4*(log(rk) - log(steady_state(rk)));
[name='marginal costs in percentage deviation from steady-state']
hat_mc = log(mc) - log(steady_state(mc));
[name='total factor productivity in percentage deviation from steady-state']
hat_a = log(a) - log(steady_state(a));
[name='discount factor shifter in percentage deviation from steady-state']
hat_zeta = log(zeta) - log(steady_state(zeta));

end;

%-------------------------------------------------------------------------%
% calibration
%-------------------------------------------------------------------------%
DELTA = 0.025;
PHIIV = 4.25;
SIGMA_C = 2;
SIGMA_H = 2;
BETA = 0.99;
ALPHA = 0.33;
THETA = 0.75;
EPSILON = 6;
CHIH = 5;
PISTAR = 1.005;
PSI_PI = 1.5;
PSI_Y = 0.5/4;
RHOZETA = 0.5;
RHOA = 0.9;
RHONU = 0.5;

@#if USE_INITVAL==1
%-------------------------------------------------------------------------%
% computations: steady state with initval block
%-------------------------------------------------------------------------%
% note that you can compute simple expressions in the initval block and also
% re-use computed variables in subsequent initial values of other variables,
% see for example pie and rnom below.
initval;
nu = 0;
a = 1;
zeta = 1;
q = 1;
pie = PISTAR; 
rnom = pie/BETA;
rreal = 1/BETA;
rk = 1/BETA -q*(1-DELTA);
mc = (EPSILON-1)/EPSILON;
w = 1.5;
k = 8;
h = 0.33;
y = a*k^ALPHA*h^(1-ALPHA);
iv = DELTA*k;
c = y-iv;
lam = zeta*c^(-SIGMA_C);
pstar = 1;
ptilde = 1;
s1 = y/(1-BETA*THETA*pie^(EPSILON-1));
s2 = mc*y/(1-BETA*THETA*pie^EPSILON);
% by default a zero is assigned for any non-specified variables in this block
% so we can skip specifying the reporting variables as they have a steady-state of 0
end;
steady;

@#else
%-------------------------------------------------------------------------%
% computations: compute steady-state with steady_state_model block
%-------------------------------------------------------------------------%
steady_state_model;
nu = 0;       % monetary policy shock in steady-state
a = 1;        % total factor productivity process in steady-state
zeta = 1;     % discount factor shifter process in steady-state
q = 1;        % investment Euler equation in steady-state
pie = PISTAR; % monetary policy rule in steady-state
rk = 1/BETA -q*(1-DELTA); % capital Euler equation in steady-state
rreal = 1/BETA;           % Bond Euler equation in steady-state
rnom = rreal*pie;         % definition real interest rate in steady-state
ptilde = ( (1-THETA*pie^(EPSILON-1)) / (1-THETA) )^(1/(1-EPSILON)); % law of motion optimal reset price in steady-state
pstar = (1-THETA)*ptilde^(-EPSILON) / (1-THETA*pie^EPSILON); % law of motion price dispersion in steady-state
% recursive price setting in steady-state
s2_s1 = (EPSILON-1)/EPSILON*ptilde;
mc = (1-THETA*BETA*pie^EPSILON)/(1-THETA*BETA*pie^(EPSILON-1)) * s2_s1;

w = (mc*a*(ALPHA/rk)^ALPHA)^(1/(1-ALPHA)) * (1-ALPHA); % marginal costs in steady-state
k_h = w/(1-ALPHA) * (ALPHA/rk); % capital to labor ratio in steady-state
iv_h = DELTA*k_h; % capital accumulation in steady-state
y_h = pstar^(-1)*a*k_h^ALPHA; % aggregate supply in steady-state
c_h = y_h - iv_h; % aggregate demand in steady-state
h = ( w/(CHIH*c_h^SIGMA_C) )^(1/(SIGMA_H+SIGMA_C)); % labor supply in steady-state
k = k_h*h; iv = iv_h*h; c = c_h*h; y = y_h*h;       % identities
div = y - w*h - rk*k; % dividends in steady-state
lam = zeta*c^(-SIGMA_C); % marginal utility in steady-state
s1 = y/(1-THETA*BETA*pie^(EPSILON-1)); % recursive price setting auxiliary sum 1 in steady-state
s2 = mc*y/(1-THETA*BETA*pie^EPSILON);  % recursive price setting auxiliary sum 2 in steady-state

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