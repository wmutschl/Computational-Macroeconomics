% this computes the steady-state of the rbc model

% calibration
params.alph = 0.35;
params.betta = 0.9901;
params.delt = 0.025;
params.gam = 1;
params.pssi = 1.7333;
params.rhoA = 0.9;

% compute steady-state
[SS,error_indicator] = rbc_logutil_ss(params);
if ~error_indicator
    disp(SS);
else
    error('steady-state could not be computed')
end


