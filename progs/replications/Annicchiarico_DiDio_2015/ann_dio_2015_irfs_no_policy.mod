% =========================================================================
% Annicchiarico and Di Dio (2015) - Environmental policy and macroeconomic
% dynamics in a new Keynesian model
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: May 5, 2023
% =========================================================================
@#define NO_POLICY = 1
@#include "ann_dio_2015_symdecls.inc"
@#include "ann_dio_2015_modeleqs.inc"

%-------------------------------------------------------------------------%
% calibration
%-------------------------------------------------------------------------%
load_params_and_steady_state('ann_dio_2015_calib_no_policy.inc');
steady;

%-------------------------------------------------------------------------%
% computation: impulse response function
%-------------------------------------------------------------------------%
SIGMA_A   = 1;%0.0045;
SIGMA_G   = 1;%0.0053;
SIGMA_ETA = 0;%0.0024;
shocks;
var eps_a   = SIGMA_A^2;
var eps_g   = SIGMA_G^2;
var eps_eta = SIGMA_ETA^2;
end;
stoch_simul(order=1,irf=21,nograph) y c iv l mc z u pz;
%stoch_simul(order=2,pruning,irf=21,nograph) y c iv l mc z u pz;