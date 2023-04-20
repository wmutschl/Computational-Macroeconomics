% =========================================================================
% computes the steady-state of the RBC model with log utility
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: April 17, 2023
% =========================================================================

%% Declare Variables and Parameters
var y c k n a rk w iv uc un fn fk;
varexo eps_a;
parameters ALPHA BETA DELTA GAMMA PSI RHOA;

%% Calibration of parameters (simple)
% ALPHA = 0.35;
% BETA = 0.9901;
% DELTA = 0.025;
% GAMMA = 1;
% PSI = 1.7333;
% RHOA = 0.9;

%% Calibration of parameters (advanced) for OECD countries

% target values
K_Y  = 10;    % average capital productivity found in long-run averages of data
IV_Y = 0.25;  % average investment to ouput ratio found in long-run averages of data
WN_Y = 0.65;  % average share of labor income to total income
N    = 1/3;   % 8h/24h working time

% flip steady-state relationships to get parameters in terms of the target values
ALPHA = 1-WN_Y;     % labor demand in steady-state combined with Cobb-Douglas production function
DELTA = IV_Y / K_Y; % capital accumulation in steady-state
RK    = ALPHA/K_Y;  % capital demand in steady-state combined with Cobb-Douglas production function
BETA  = 1/(RK - DELTA + 1); % Euler equation in steady-state
GAMMA = 1; % normalize GAMMA and calibrate PSI to get targeted lss
A = 1; % tfp in steady-state
K_N = ((ALPHA*A)/RK)^(1/(1-ALPHA));
K = K_N*N;
Y = K/K_Y;
IV = DELTA*K;
W = (1-ALPHA)*A*K_N^ALPHA;
C = Y-IV;
PSI = GAMMA*(C/N)^(-1)*W*(N/(1-N))^(-1); % flipped steady-state labor equation

RHOA  = 0.9; % does not affect the steady-state

%% Model Equations
model;
uc = GAMMA*c^(-1);
un = -PSI/(1-n);
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
K_N = ((ALPHA*a)/rk)^(1/(1-ALPHA));
w = (1-ALPHA)*a*K_N^ALPHA;
IV_N = DELTA*K_N;
Y_N = a*K_N^ALPHA;
C_N = Y_N - IV_N;
n = GAMMA/PSI*C_N^(-1)*w/(1+GAMMA/PSI*C_N^(-1)*w);
c = C_N*n;
iv = IV_N*n;
k = K_N*n;
y = Y_N*n;
uc = GAMMA*c^(-1);
un = -PSI/(1-n);
fn = (1-ALPHA)*a*(k/n)^ALPHA;
fk  = ALPHA*a*(k/n)^(ALPHA-1);
end;

steady;

shocks;
var eps_a = 1;
end;

stoch_simul(order=1,irf=30,periods=400) y c k n rk w iv a;

figure('name','Simulated Data')
subplot(3,3,1); plot(oo_.endo_simul(ismember(M_.endo_names,'a'),300:end)); title('productivity');
subplot(3,3,2); plot(oo_.endo_simul(ismember(M_.endo_names,'y'),300:end)); title('output');
subplot(3,3,3); plot(oo_.endo_simul(ismember(M_.endo_names,'c'),300:end)); title('consumption');
subplot(3,3,4); plot(oo_.endo_simul(ismember(M_.endo_names,'k'),300:end)); title('capital');
subplot(3,3,5); plot(oo_.endo_simul(ismember(M_.endo_names,'iv'),300:end)); title('investment');
subplot(3,3,6); plot(oo_.endo_simul(ismember(M_.endo_names,'rk'),300:end)); title('rental rate');
subplot(3,3,7); plot(oo_.endo_simul(ismember(M_.endo_names,'l'),300:end)); title('labor');
subplot(3,3,8); plot(oo_.endo_simul(ismember(M_.endo_names,'w'),300:end)); title('wage');

