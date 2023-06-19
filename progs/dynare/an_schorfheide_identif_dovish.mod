% This file computes impulse responses and theoretical moments of the
% stationary nonlinear model equations of An and Schorfheide (2007, 
% Econometric Reviews) for a dovish monetary policy rule to showcase
% identification problems when comparing these to a hawkish monetary policy
% rule (see an_schorfheide_identif_hawkish.mod)
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: June 13, 2023
% =========================================================================

@#include "an_schorfheide_identif_bk.mod"

% common calibration
TAU   = 2;
KAPPA = 0.33;
NU    = 0.1;
RHOG  = 0.95;
RHOZ  = 0.90;
RA    = 1;
PA    = 3.2;
GAMQ  = 0.5;
GBAR  = 1/0.85;
SIG2Z = 0.9;
SIG2G = 0.36;

% dovish Taylor rule (values are taken from Qu and Tkachenko (2012, Table 1, panel (b) \theta_{-9})
PSI1  = 1.043195;
PSI2  = 0.918417;
RHOR  = 0.792647;
SIG2R = 0.446783;

shocks;
var epsr = SIG2R;
var epsz = SIG2Z;
var epsg = SIG2G;
end;

stoch_simul(order=1);