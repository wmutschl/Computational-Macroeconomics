% =========================================================================
% Annicchiarico and Di Dio (2015) - Environmental policy and macroeconomic
% dynamics in a new Keynesian model
% steady-state of environmental policy model variant
% replicates table 2 right column
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: May 5, 2023
% =========================================================================
@#define CAP_AND_TRADE = 1 // pick any policy

@#include "ann_dio_2015_symdecls.inc"
% switch types to access old g in steady_state_model block
change_type(parameters) g            ;
change_type(var)        TARGET_GSHARE;

@#include "ann_dio_2015_modeleqs.inc"

%-------------------------------------------------------------------------%
% calibration via new steady-state
%-------------------------------------------------------------------------%
load_params_and_steady_state('ann_dio_2015_calib_no_policy.inc'); % start from no policy calibration

steady_state_model;
z_old = TARGET_ZSHARE*DELTA_M*TARGET_M; % get old emissions from parameters
z = (1-0.2)*z_old; % new emissions target as outlined in the calibration section
TARGET_M = (z + ZSTAR)/DELTA_M; % update parameter
TARGET_ZSHARE = z/(DELTA_M*TARGET_M); % update parameter
m = TARGET_M; % new pollution stock
Gamma_m = GAMMA_0 + GAMMA_1*m + GAMMA_2*m^2; % damage function in steady-state
a = A; % tfp in steady-state
eta = 1; % monetary policy shock in steady-state
pie = TARGET_PIE; % monetary policy rule in steady-state
q = 1; % investment Euler equation in steady-state
rk = 1/BETA -q*(1-DELTA_K); % capital Euler equation in steady-state
rnom = pie/BETA; % bond Euler equation in steady-state
pstar = ( (1-XI*pie^(THETA-1)) / (1-XI) )^(1/(1-THETA)); % law of motion optimal reset price in steady-state
dp = (1-XI)*pstar^(-THETA) / (1-XI*pie^THETA); % law of motion price dispersion in steady-state
x_plus_Omega_over_Theta = (THETA-1)/THETA*pstar; % recursive price setting in steady-state
mc = (1-XI*BETA*pie^THETA)/(1-XI*BETA*pie^(THETA-1)) * x_plus_Omega_over_Theta; % recursive price setting in steady-state combined with overall marginal costs
[u,pz,Psi,ca_y,y,c,l,k,iv,w] = ann_dio_2015_steadystate_helper(z,Gamma_m,rk,mc,dp,g, DELTA_K,ALPHA,PHI,MU_L,A,VARPHI,PHI_1,PHI_2);
x = c^(-1)*Psi*y/(1-XI*BETA*pie^THETA); % recursive price setting auxiliary sum 1 in steady-state
Theta = c^(-1)*y/(1-XI*BETA*pie^(THETA-1));  % recursive price setting auxiliary sum 2 in steady-state
Omega = c^(-1)*(PHI_1*u^PHI_2+pz*(1-u)*VARPHI)*y/(1-XI*BETA*pie^THETA); % recursive price setting auxiliary sum 3 in steady-state
t = g - pz*z; % fiscal budget in steady-state
welf = ( log(c) - MU_L*l^(1+PHI)/(1+PHI) ) / (1-BETA); % recursive welfare in steady-state
TARGET_GSHARE = g/y; % update parameter
TARGET_INTENSITY = z/y;
CARBON_TAX = pz;
end;
steady;
save_params_and_steady_state('ann_dio_2015_calib_environmental_policy.inc');

%-------------------------------------------------------------------------%
% check calibration: replicate table 2 for environmental policy case
%-------------------------------------------------------------------------%
fprintf('\n\nCHECK CALIBRATION\n');
varlist_tbl2 = varlist_indices({'y','c','iv','l','mc','z','m','u','pz','ca_y','Gamma_m','welf'},M_.endo_names);
tbl2 = array2table(oo_.steady_state(varlist_tbl2),...
                   'RowNames', M_.endo_names(varlist_tbl2),...
                   'VariableNames',{'Table 2'});
format long; disp(tbl2); format short;
fprintf('    steady-state public consumption to GDP ratio: %f\n', oo_.steady_state(M_.endo_names=="TARGET_GSHARE"));
fprintf('    steady-state private consumption to GDP ratio: %f\n', oo_.steady_state(M_.endo_names=="c")/oo_.steady_state(M_.endo_names=="y"));
fprintf('\n\n');