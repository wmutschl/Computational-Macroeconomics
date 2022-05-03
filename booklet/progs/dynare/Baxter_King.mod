%----------------------------------%
% declare variables and parameters %
%----------------------------------%
var 
  y   % output
  c   % consumption
  iv  % private investment
  gb  % government spending
  ivb % government investment
  lam % marginal utility of consumption
  k   % private capital stock
  kb  % public capital stock
  r   % real interest rate
  w   % real wage
  tau % net tax rate
  tr  % fiscal transfers
  z   % productivity process
  n   % labor
;

varexo
  e_z   % productivity shock
  e_gb  % government spending shock
  e_ivb % government investment shock
  e_tau % tax rate shock
;

parameters 
  BETA    % discount factor
  ETA     % public capital productivity
  ALPHA   % private capital productivity
  THETA_L % utility weight for labor
  DELTA   % capital depreciation rate
  RHO_Z   % persistence parameter technology process
  RHO_GB  % persistence parameter government spending process
  RHO_IVB % persistence parameter government investment process
  RHO_TAU % persistence parameter tax process
  SIG_Z   % standard deviation technology shock
  SIG_GB  % standard devation government spending shock
  SIG_IVB % standard deviation government investment shock
  SIG_TAU % standard deviation tax rate shock
  Z_BAR   % target value of technology level
  GB_BAR  % target value of government spending
  IVB_BAR % target value of government investment
  TAU_BAR % target value of net tax rate
;

%----------------------%
% calibrate parameters %
%----------------------%
%% parameter calibration using targeted steady-state values
Y_BAR   = 1;
GB_BAR  = 0.2*Y_BAR;
IVB_BAR = 0.02*Y_BAR;
TR_BAR  = 0;
W_BAR   = 2;
N_BAR   = 1/3;
Z_BAR   = 1; %normalize

% public capital productivity ETA should be lower than capital share in production ALPHA
ALPHA = 1-W_BAR*N_BAR/Y_BAR; % from labor demand in steady-state
ETA = 0.3*ALPHA; % ETA is lower

% exogenous processes
RHO_Z   = 0.75;
RHO_GB  = 0.75;
RHO_IVB = 0.75;
RHO_TAU = 0.75;
SIG_Z   = 0.01;
SIG_GB  = 0.01;
SIG_IVB = 0.01;
SIG_TAU = 0.01;

% Set some reasonable values for DELTA and BETA (see RBC model!)
DELTA = 0.025;
KB_BAR = IVB_BAR/DELTA; % from public capital law of motion in steady-state
K_BAR = (Y_BAR/(Z_BAR*KB_BAR^ETA*N_BAR^(1-ALPHA)))^(1/ALPHA);% from production function
IV_BAR = K_BAR*DELTA;
R_BAR = ALPHA*Y_BAR/K_BAR; % from capital demand

TAU_BAR = (GB_BAR + IVB_BAR + TR_BAR)/(W_BAR*N_BAR+R_BAR*K_BAR); % fiscal budget ins steady-state
BETA = 1/(1-DELTA+(1-TAU_BAR)*R_BAR); % from savings decision in steady-state
C_BAR = Y_BAR - IV_BAR - GB_BAR - IVB_BAR; % from ressource constraint in steady-state

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
kb = (1-DELTA)*kb(-1) + ivb;
[name='production function']
y = z*kb(-1)^ETA*k(-1)^ALPHA*n^(1-ALPHA);
[name='labor demand']
w*n = (1-ALPHA)*y;
[name='private capital demand']
r*k(-1) = ALPHA*y;
[name='productivity process']
log(z/Z_BAR) = RHO_Z*log(z(-1)/Z_BAR) + e_z;
[name='government budget constraint']
gb + ivb + tr = tau*(w*n + r*k(-1));
[name='fiscal rule: government spending']
gb - GB_BAR = RHO_GB*(gb(-1)-GB_BAR) + e_gb;
[name='fiscal rule: government investment']
ivb - IVB_BAR = RHO_IVB*(ivb(-1)-IVB_BAR) + e_ivb;
[name='fiscal rule: tax rate']
log(tau/TAU_BAR) = RHO_TAU*log(tau(-1)/TAU_BAR) + e_tau;
[name='market clearing']
y = c + iv + gb + ivb;
end;


%--------------%
% computations %
%--------------%
initval;
y   = Y_BAR;
c   = C_BAR;
iv  = IV_BAR;
gb  = GB_BAR;
ivb = IVB_BAR;
lam = 1/C_BAR; 
k   = K_BAR;
kb  = KB_BAR;
r   = R_BAR;
w   = W_BAR;
tau = TAU_BAR;
tr  = TR_BAR;
z   = Z_BAR;
n   = N_BAR;
end;
steady; % compute steady-state

