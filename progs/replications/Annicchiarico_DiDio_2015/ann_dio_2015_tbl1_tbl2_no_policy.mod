% =========================================================================
% Annicchiarico and Di Dio (2015) - Environmental policy and macroeconomic
% dynamics in a new Keynesian model
% calibration of no-policy model variant
% replicates table 1 and table 2 left column
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: May 5, 2023
% =========================================================================
@#define NO_POLICY=1

@#include "ann_dio_2015_symdecls.inc"
% we calibrate MU_L by setting a target for l
change_type(var)        MU_L;
change_type(parameters) l   ;

@#include "ann_dio_2015_modeleqs.inc"

%-------------------------------------------------------------------------%
% calibration: table 1 and section on calibration
%-------------------------------------------------------------------------%
ALPHA     = 1/3;
BETA      = 0.99;
DELTA_K   = 0.025;
GAMMA_I   = 15;
PHI       = 1;
THETA     = 6;
XI        = 3/4;
IOTA_PI   = 3;
DELTA_M   = 1-0.9979;
VARPHI    = 0.45;
PHI_1     = 0.180; % NOTE THAT THIS IS DIFFERENT TO TABLE 1
PHI_2     = 2.8;
GAMMA_0   = 1.3950e-3;
GAMMA_1   = -6.6722e-6;
GAMMA_2   = 1.4647e-8;
SIGMA_A   = 0.0045;
SIGMA_G   = 0.0053;
SIGMA_ETA = 0.0024;
RHO_A     = 0.95; 
RHO_G     = 0.97;
RHO_ETA   = 0.15;

% calibration targets
TARGET_PIE    = 1;
TARGET_GSHARE = 0.102158273389097;
TARGET_M      = 800;
TARGET_ZSHARE = 0.20840121;
l             = 0.2;

%-------------------------------------------------------------------------%
% computations: steady-state and calibration of endogenous parameters
%-------------------------------------------------------------------------%
steady_state_model;
pz = 0; % no policy regime
u = 0; % abatement effort in no policy regime
ca = 0; % abatement costs in no policy regime
Omega = 0; % auxiliary recursive variable in no policy regime
eta = 1; % monetary policy shock in steady-state
m = TARGET_M; % calibrated pollution stock in steady-state
Gamma_m = GAMMA_0 + GAMMA_1*m + GAMMA_2*m^2; % damage function in steady-state
z = TARGET_ZSHARE*DELTA_M*m; % law of motion pollution stock combined with targeted emission share
pie = TARGET_PIE; % monetary policy rule in steady-state
q = 1; % investment Euler equation in steady-state
rk = 1/BETA -q*(1-DELTA_K); % capital Euler equation in steady-state
rnom = pie/BETA; % bond Euler equation in steady-state
pstar = ( (1-XI*pie^(THETA-1)) / (1-XI) )^(1/(1-THETA)); % law of motion optimal reset price in steady-state
dp = (1-XI)*pstar^(-THETA) / (1-XI*pie^THETA); % law of motion price dispersion in steady-state
x_Theta = (THETA-1)/THETA*pstar; % recursive price setting in steady-state
Psi = (1-XI*BETA*pie^THETA)/(1-XI*BETA*pie^(THETA-1)) * x_Theta; % recursive price setting in steady-state
mc = Psi; % overall marginal costs in steady-state
y = z/(VARPHI*dp); % emissions in steady-state
w = (1-ALPHA) * y/l * Psi; % labor demand in steady-state
k = ALPHA * y/rk * Psi; % capital demand in steady-state
iv = DELTA_K*k; % capital accumulation in steady-state
a = y / ( (1-Gamma_m)*k^ALPHA*l^(1-ALPHA)*dp^(-1) ); % aggregate supply with damage function in steady-state
g = TARGET_GSHARE*y; % targeted government consumption ratio
c = y - g - iv; % aggregate demand in steady-state
x = c^(-1)*Psi*y/(1-XI*BETA*pie^THETA); % recursive price setting auxiliary sum 1 in steady-state
Theta = c^(-1)*y/(1-XI*BETA*pie^(THETA-1));  % recursive price setting auxiliary sum 2 in steady-state
t = g; % fiscal budget in steady-state
MU_L = 1/c*w*l^(-PHI); % labor supply in steady-state
welf = ( log(c) - MU_L*l^(1+PHI)/(1+PHI) ) / (1-BETA); % recursive welfare in steady-state
ca_y = ca/y;
A = a;
ZSTAR = DELTA_M*m - z; % implicit rest of the world emission share
TARGET_INTENSITY = z/y;
CARBON_TAX = pz;

log_y = log(y);
log_c = log(c);
log_iv = log(iv);
log_l = log(l);
log_mc = log(mc);
log_z = log(z);
log_u = log(u);
log_pz = log(pz);
end;
steady;
save_params_and_steady_state('ann_dio_2015_calib_no_policy.inc');

%-------------------------------------------------------------------------%
% check calibration: replicate table 1 and table 2 for no policy case
%-------------------------------------------------------------------------%
fprintf('\n\nCHECK CALIBRATION\n');
varlist_tbl1 = varlist_indices({'ALPHA','BETA','DELTA_K','GAMMA_I','PHI',...
               'THETA','XI','A','IOTA_PI','DELTA_M','VARPHI','PHI_1','PHI_2',...
               'GAMMA_0','GAMMA_1','GAMMA_2','RHO_A','RHO_G','RHO_ETA'},...
               M_.param_names);

tbl1 = array2table([M_.params(varlist_tbl1(1:8));
                    oo_.steady_state(M_.endo_names=="MU_L");
                    M_.params(varlist_tbl1(9));
                    1-M_.params(varlist_tbl1(10));
                    M_.params(varlist_tbl1(11:16));
                    SIGMA_A; SIGMA_G; SIGMA_ETA;
                    M_.params(varlist_tbl1(17:19));
                   ],'VariableNames',{'Table 1'},...
                     'RowNames',[M_.param_names(varlist_tbl1(1:8));
                                 "MU_L";
                                 M_.param_names(varlist_tbl1(9));
                                 "1-"+M_.param_names(varlist_tbl1(10));
                                 M_.param_names(varlist_tbl1(11:16));
                                 "SIGMA_A"; "SIGMA_G"; "SIGMA_ETA";
                                 M_.param_names(varlist_tbl1(17:19));
                    ]);
format long; disp(tbl1); format short;

varlist_tbl2 = varlist_indices({'y','c','iv','mc','z','m','u','pz','ca_y','Gamma_m','welf'},M_.endo_names);
tbl2 = array2table([oo_.steady_state(varlist_tbl2(1:3));
                    M_.params(M_.param_names=="l");
                    oo_.steady_state(varlist_tbl2(4:end));
                    ], 'RowNames',...
                   [M_.endo_names(varlist_tbl2(1:3));
                    "l";
                    M_.endo_names(varlist_tbl2(4:end));
                   ], 'VariableNames',{'Table 2'});
format long; disp(tbl2); format short;
fprintf('    steady-state public consumption to GDP ratio: %f\n', oo_.steady_state(M_.endo_names=="g")/oo_.steady_state(M_.endo_names=="y"));
fprintf('    steady-state private consumption to GDP ratio: %f\n', oo_.steady_state(M_.endo_names=="c")/oo_.steady_state(M_.endo_names=="y"));
fprintf('\n\n');