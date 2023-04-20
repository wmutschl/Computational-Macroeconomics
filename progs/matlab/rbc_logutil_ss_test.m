% =========================================================================
% computes the steady-state of the RBC model with log utility
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: April 17, 2023
% =========================================================================

% calibration
PARAMS.ALPHA = 0.35;
PARAMS.BETA = 0.9901;
PARAMS.DELTA = 0.025;
PARAMS.GAMMA = 1;
PARAMS.PSI = 1.7333;
PARAMS.RHOA = 0.9;
SS = []; % no need for initial values

% compute steady-state
[SS,PARAMS,error_indicator] = rbc_logutil_ss(SS,PARAMS);
if ~error_indicator
    disp(SS);
else
    error('steady-state could not be computed')
end