%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Generate Figure 11: The Determinacy Region and Trend Inflation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
@#define LOGUTILITY=1
@#include "ascari_sbordone_2014_common.mod"
@#include "ascari_sbordone_2014_calib_common.inc"
VARPHI = 1;
% monetary policy according to footnote 67
PHI_PI = 2;
PHI_Y = 0.5/4;
RHO_I = 0;


%% using sensitivity toolbox
estimated_params;
PHI_PI,uniform_pdf,(0+6)/2,sqrt(12)^(-1)*(6-0);
PHI_Y,uniform_pdf,((-1)+6)/2,sqrt(12)^(-1)*(6-(-1));      
end;
 
varobs log_y log_pi; //some observables must be specified for sensitivity command, inessential for results
options_.nograph=0; %enable graphs again
 
trend_inflation_vector = [0,2,4,6,8];
for trend_inflation_iter=1:length(trend_inflation_vector)
    set_param_value('TREND_INFLATION',trend_inflation_vector(trend_inflation_iter));
    dynare_sensitivity(prior_range=0,stab=1,nsam=5000);
end