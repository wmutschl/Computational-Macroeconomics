% This file simulates an ARMA(1,1) model with Dynare and showcases
% identification issue whenever coefficients are equal to each other
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: Apri 25, 2024
% =========================================================================

% declare variables and parameters
var x;
varexo e;
parameters THETA PHI;

% declare model equations
model;
x - THETA*x(-1) = e - PHI*e(-1);
end;

% steady-state values for endogenous variables
steady_state_model;
x = 0;
end;

% calibration (note that if THETA=PHI we always get x=e)
THETA = 0.4;
PHI   = 0.4;

% variance of normally distributed shock
shocks;
var e = 1^2;
end;

% computations
steady;
stoch_simul(order=1,periods=200,irf=0);

% plots
options_.smpl = [51 150]; % select a subsample to plot
options_.rplottype = 2;   % possible values are 0, 1, 2
rplot x e;                % quick way to plot simulations in Dynare
if THETA == PHI
    sgtitle('SERIES ARE THE SAME BECAUSE (THETA = PHI)')
end