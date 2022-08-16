%----------------------------------%
% declare variables and parameters %
%----------------------------------%
var 
  y   % output
  c   % consumption
  iv  % private investment
  g   % government spending
  ivg % government investment
  lam % marginal utility of consumption
  k   % private capital stock
  kg  % public capital stock
  r   % real interest rate
  w   % real wage
  tau % net tax rate
  tr  % fiscal transfers
  z   % productivity process
  n   % labor
  y_obs    (long_name='output')
  c_obs    (long_name='consumption')
  iv_obs   (long_name='investment')
  n_obs    (long_name='labor')
  w_obs    (long_name='wages')
  r_obs    (long_name='interest')
  tr_obs   (long_name='transfers')
  g_obs    (long_name='gov.spending')
  ivg_obs  (long_name='gov.investment')
;

varexo
  e_z   % productivity shock
  e_g   % government spending shock
  e_ivg % government investment shock
  e_tau % tax rate shock
;

parameters 
  BETA    % discount factor
  ETA     % public capital productivity
  ALPHA   % private capital productivity
  THETA_L % utility weight for labor
  DELTA   % capital depreciation rate
  RHO_Z   % persistence parameter technology process
  RHO_G   % persistence parameter government spending process
  RHO_IVG % persistence parameter government investment process
  RHO_TAU % persistence parameter tax process
  Z_BAR   % target value of technology level
  G_BAR   % target value of government spending
  IVG_BAR % target value of government investment
  TAU_BAR % target value of net tax rate
;

%----------------------%
% calibrate parameters %
%----------------------%
%% parameter calibration using targeted steady-state values
Y_BAR   = 1;
G_BAR   = 0.2*Y_BAR;
IVG_BAR = 0.02*Y_BAR;
TR_BAR  = 0;
W_BAR   = 2;
N_BAR   = 1/3;
Z_BAR   = 1; %normalize
% public capital productivity ETA should be lower than capital share in production ALPHA
ALPHA = 1-W_BAR*N_BAR/Y_BAR; % from labor demand in steady-state
ETA = 0.3*ALPHA; % ETA is lower
% exogenous processes
RHO_Z   = 0.75;
RHO_G   = 0.75;
RHO_IVG = 0.75;
RHO_TAU = 0.75;
% Set some reasonable values for DELTA and BETA (see e.g. RBC model)
DELTA = 0.025;
KG_BAR = IVG_BAR/DELTA; % from public capital law of motion in steady-state
K_BAR = (Y_BAR/(Z_BAR*KG_BAR^ETA*N_BAR^(1-ALPHA)))^(1/ALPHA);% from production function
IV_BAR = K_BAR*DELTA;
R_BAR = ALPHA*Y_BAR/K_BAR; % from capital demand
TAU_BAR = (G_BAR + IVG_BAR + TR_BAR)/(W_BAR*N_BAR+R_BAR*K_BAR); % fiscal budget ins steady-state
BETA = 1/(1-DELTA+(1-TAU_BAR)*R_BAR); % from savings decision in steady-state
C_BAR = Y_BAR - IV_BAR - G_BAR - IVG_BAR; % from ressource constraint in steady-state
% labor utility weight from labor supply decision
THETA_L = (1-TAU_BAR)*W_BAR*(1-N_BAR)/C_BAR;

%-----------------%
% model equations %
%-----------------%
model;
[name='labor-leisure decision']
(1-tau)*w = THETA_L*c/(1-n);
[name='savings decision']
lam = BETA*lam(+1)*(1-DELTA + (1-tau(+1))*r(+1));
[name='marginal utility of consumption']
lam = 1/c;
[name='law of motion private capital stock']
k  = (1-DELTA)*k(-1)  + iv;
[name='law of motion public capital stock']
kg = (1-DELTA)*kg(-1) + ivg;
[name='production function']
y = z*kg(-1)^ETA*k(-1)^ALPHA*n^(1-ALPHA);
[name='labor demand']
w*n = (1-ALPHA)*y;
[name='private capital demand']
r*k(-1) = ALPHA*y;
[name='productivity process']
log(z/Z_BAR) = RHO_Z*log(z(-1)/Z_BAR) + e_z;
[name='government budget constraint']
g + ivg + tr = tau*(w*n + r*k(-1));
[name='fiscal rule: government spending']
g - G_BAR = RHO_G*(g(-1)-G_BAR) + e_g;
[name='fiscal rule: government investment']
ivg - IVG_BAR = RHO_IVG*(ivg(-1)-IVG_BAR) + e_ivg;
[name='fiscal rule: tax rate']
log(tau/TAU_BAR) = RHO_TAU*log(tau(-1)/TAU_BAR) + e_tau;
[name='market clearing']
y = c + iv + g + ivg;
y_obs = 100*(y-steady_state(y))/steady_state(y);
c_obs = 100*(c-steady_state(c))/steady_state(c);
iv_obs = 100*(iv-steady_state(iv))/steady_state(y);
n_obs = 100*(n-steady_state(n))/steady_state(n); 
w_obs = 100*(w-steady_state(w))/steady_state(w);
r_obs = 100*(r-steady_state(r))/steady_state(r);
tr_obs = 100*(tr-steady_state(tr));
g_obs = 100*(g-steady_state(g)/steady_state(g));
ivg_obs = 100*(ivg-steady_state(ivg)/steady_state(ivg));
end;

%--------------%
% computations %
%--------------%
initval;
y   = Y_BAR; 
c   = C_BAR;
iv  = IV_BAR;
g   = G_BAR;
ivg = IVG_BAR;
lam = 1/C_BAR; 
k   = K_BAR;
kg  = KG_BAR;
r   = R_BAR;
w   = W_BAR;
tau = TAU_BAR;
tr  = TR_BAR;
z   = Z_BAR;
n   = N_BAR;
end;
steady; % compute steady-state