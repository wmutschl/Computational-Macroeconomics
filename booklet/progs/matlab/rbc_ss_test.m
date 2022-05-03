% this computes the steady-state of the rbc model

% calibration
params.alph = 0.35;
params.betta = 0.9901;
params.delt = 0.025;
params.gam = 1;
params.pssi = 1.7333;
params.rhoA = 0.9;
params.etaC = 2;
params.etaL = 1.5;

% compute steady-state
[SS,error_indicator] = rbc_ss(params);
if ~error_indicator
    disp(SS);
else
    error('steady-state could not be computed')
end

% double check
params.etaC = 1;
params.etaL = 1;

SS1 = rbc_ss(params,0);
SS2 = rbc_logutil_ss(params);

if ~isequal(SS1,SS2)
    error('steady-state is not computed correctly for etaC=etaL=1')
end


