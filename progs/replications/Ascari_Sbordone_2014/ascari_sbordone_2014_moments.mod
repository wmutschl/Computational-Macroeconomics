%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Replicate business cycle moments reported on page 717  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
@#define LOGUTILITY=1
@#include "ascari_sbordone_2014_common.mod"
@#include "ascari_sbordone_2014_calib_common.inc"

VARPHI = 1;
RHO_A = 0.95;
RHO_I = 0;
PHI_PI = 1.5;
PHI_Y = 0.5/4;

shocks;          
var eps_nu; stderr 0;   
var eps_a = 0.45^2;
var eps_zeta; stderr 0;
end;

set_param_value('TREND_INFLATION',0);
stoch_simul(irf=0,order=1,nograph,noprint) log_y log_pi;
output_var_low_target = oo_.var(strmatch('log_y',var_list_,'exact'),strmatch('log_y',var_list_,'exact'));
inflation_var_low_target = oo_.var(strmatch('log_pi',var_list_,'exact'),strmatch('log_pi',var_list_,'exact'));

set_param_value('TREND_INFLATION',4);
stoch_simul(irf=0,order=1,nograph,noprint) log_y log_pi; 
output_var_high_target=oo_.var(strmatch('log_y',var_list_,'exact'),strmatch('log_y',var_list_,'exact'));
inflation_var_high_target=oo_.var(strmatch('log_pi',var_list_,'exact'),strmatch('log_pi',var_list_,'exact'));

fprintf('Output Standard Deviation: \t %4.3f \t %4.3f\n',sqrt(output_var_low_target),sqrt(output_var_high_target));
fprintf('Inflation Standard Deviation: \t %4.3f \t %4.3f\n',sqrt(inflation_var_low_target),sqrt(inflation_var_high_target))
