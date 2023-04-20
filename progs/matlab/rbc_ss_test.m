% =========================================================================
% rbc_ss_test.m
% =========================================================================
% computes the steady-state of the RBC model with CES utility
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: January 26, 2023
% =========================================================================

% calibration
PARAMS.ALPHA = 0.35;
PARAMS.BETA  = 0.9901;
PARAMS.DELTA = 0.025;
PARAMS.GAMMA = 1;
PARAMS.PSI   = 1.7333;
PARAMS.RHOA  = 0.9;
PARAMS.ETAC  = 2;
PARAMS.ETAL  = 1.5;
SS.l = 1/3; % initial guess for labor

% compute steady-state
[SS,PARAMS,error_indicator] = rbc_ss(SS,PARAMS);
if ~error_indicator
    disp(SS);
else
    error('steady-state could not be computed')
end