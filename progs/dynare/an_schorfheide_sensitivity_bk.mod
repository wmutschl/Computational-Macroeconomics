@#include "an_schorfheide_identif_bk.mod"

TAU   = 2;
KAPPA = 0.33;
NU    = 0.1;
RHOG  = 0.95;
RHOZ  = 0.90;
RA    = 1;
PA    = 3.2;
GAMQ  = 0.5;
C_Y   = 0.85;
SIG2Z = 0.9;
SIG2G = 0.36;
PSI1  = 1.5;
PSI2  = 0.125;
RHOR  = 0.75;
SIG2R = 0.4;

shocks;
var epsr = SIG2R;
var epsz = SIG2Z;
var epsg = SIG2G;
end;

%specify parameters for which to map sensitivity
estimated_params;
PSI1, uniform_pdf,,, 0,6; %draw uniformly from 0 to 6
PSI2, uniform_pdf,,,-1,6; %draw uniformly from -1 to 6
RHOR, uniform_pdf,,,-1,1; %draw uniformly from -1 to 1
end;
varobs y p r; % for analysis of BK conditions, it does not matter which variables
dynare_sensitivity(prior_range=0,stab=1,nsam=2000);