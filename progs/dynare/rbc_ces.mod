% =========================================================================
% computes the steady-state of the RBC model with CRRA utility
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: April 17, 2023
% =========================================================================

%% Declare Variables and Parameters
var y c k n a rk w iv uc un fn fk;
varexo eps_a;
parameters ALPHA BETA DELTA GAMMA PSI RHOA ETAC ETAL;

%% Calibration of parameters (simple)
ALPHA = 0.35;
BETA  = 0.9901;
DELTA = 0.025;
GAMMA = 1;
PSI   = 1.7333;
RHOA  = 0.9;
ETAC  = 2;
ETAL  = 1.5;


%% Model Equations
model;
uc = GAMMA*c^(-ETAC);
un = -PSI*(1-n)^(-ETAL);
fn = (1-ALPHA)*a*(k(-1)/n)^ALPHA;
fk = ALPHA*a*(k(-1)/n)^(ALPHA-1);

uc = BETA*uc(+1)*(1-DELTA+rk(+1));
w = - un/uc;
w = fn;
rk = fk;
y = a*k(-1)^ALPHA*n^(1-ALPHA);
k = (1-DELTA)*k(-1) + iv;
y = c + iv;
log(a) = RHOA*log(a(-1)) + eps_a;
end;

%% Steady State
steady_state_model;
a = 1;
rk = 1/BETA+DELTA-1;
k_n = ((ALPHA*a)/rk)^(1/(1-ALPHA));
w = (1-ALPHA)*a*k_n^ALPHA;
iv_n = DELTA*k_n;
y_n = a*k_n^ALPHA;
c_n = y_n - iv_n;
n0 = 1/3; % initial guess
n = rbc_ces_helper_function(n0,PSI,ETAL,ETAC,GAMMA,c_n,w);
c = c_n*n;
iv = iv_n*n;
k = k_n*n;
y = y_n*n;
uc = GAMMA*c^(-ETAC);
un = -PSI*(1-n)^(-ETAL);
fn = (1-ALPHA)*a*(k_n)^ALPHA;
fk = ALPHA*a*(k_n)^(ALPHA-1);
end;

steady;
