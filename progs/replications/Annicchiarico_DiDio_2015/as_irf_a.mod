@#define CAP_AND_TRADE
@#include "ann_dio_2015_symdecls.inc"
@#include "ann_dio_2015_modeleqs.inc"

% calibration
%load_params_and_steady_state('ann_dio_2015_calib_no_policy.inc');
load_params_and_steady_state('ann_dio_2015_calib_environmental_policy.inc');
steady;

shocks;
var eps_a = 1;
var eps_g = 1;
var eps_eta = 1;
end;
stoch_simul(order=1,irf=21) y c iv l mc z u pz;