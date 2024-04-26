@#define LOGUTILITY=1
@#include "ascari_sbordone_2014_common.mod"
@#include "ascari_sbordone_2014_calib_common.inc"

VARPHI = 1;
% monetary policy according to footnote 67
PHI_PI = 2;
PHI_Y = 0.5/4;
RHO_I = 0.8;

%specify parameters for which to map sensitivity
set_param_value('TREND_INFLATION',6);
estimated_params;
PHI_PI, uniform_pdf,,, 0,6; %draw uniformly from 0 to 6
PHI_Y,  uniform_pdf,,,-1,6; %draw uniformly from -1 to 6
end;
varobs log_y log_pi log_r; % for analysis of BK conditions, it does not matter which variables are observed
dynare_sensitivity(prior_range=0,stab=1,nsam=3000);