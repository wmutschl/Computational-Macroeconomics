% =========================================================================
% Annicchiarico and Di Dio (2015) - Environmental policy and macroeconomic
% dynamics in a new Keynesian model
% common declarations and equations
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: May 5, 2023
% =========================================================================

%-------------------------------------------------------------------------%
% declare variables and parameters
%-------------------------------------------------------------------------%
var
a        // total factor productivity
c        // consumption
ca_y     // abatement cost ratio
dp       // price efficiency distortion
g        // public consumption
iv       // investment
k        // capital
l        // labor
m        // pollution stock
mc       // overall marginal costs
pstar    // reset price
pz       // unit cost of emissions (in real terms)
rnom     // nominal interest rate
rk       // real rental rate of capital
t        // lump-sum taxes
u        // abatement effort
w        // real wage
x        // recursive price setting auxiliary sum 1
y        // output
z        // emissions
eta      // monetary policy shock
Gamma_m  // damage function
Theta    // recursive price setting auxiliary sum 2
pie      // inflation
Psi      // marginal cost component related to capital and labor
Omega    // recursive price setting auxiliary sum 3
q        // tobin''s q
welf     // recursive welfare
;

predetermined_variables k; // paper uses beginning-of-period timing for capital

varexo
eps_a    // innovation to total factor productivity
eps_g    // innovation to public spending rule
eps_eta  // innovation to monetary policy shock
;

parameters
ALPHA          // bias towards capital in production
BETA           // discount factor
DELTA_K        // depreciation rate of capital
GAMMA_I        // capital adjustment cost
PHI            // inverse Frisch elasticity
THETA          // Dixit-Stiglitz price elasticity
XI             // Calvo probability
A              // target for steady-state technology
MU_L           // utility weight for labor
IOTA_PI        // interest rate inflation sensitivity
DELTA_M        // pollution decay
VARPHI         // emissions per unit of output
PHI_1          // abatement cost function coefficient 1
PHI_2          // abatement cost function coefficient 2
GAMMA_0        // damage function intercept coefficient
GAMMA_1        // damage function linear coefficient
GAMMA_2        // damage function quadratic coefficient
RHO_A          // persistence total factor productivity process
RHO_G          // persistence government consumption rule
RHO_ETA        // persistence monetary policy shock

TARGET_PIE     // target for inflation
TARGET_GSHARE  // target for government consumption to output ratio
TARGET_M       // target for steady-state pollution stock
TARGET_ZSHARE  // target for steady-state emissions
ZSTAR          // target for steady-state emissions rest of the world
TARGET_INTENSITY  // steady-state emissions to output ratio
CARBON_TAX     // steady-state carbon tax
;