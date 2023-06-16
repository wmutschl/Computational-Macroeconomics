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
C_Y   = 0.85;
SIG2Z = 0.9;
SIG2G = 0.36;

% hawkish Taylor rule
PSI1  = 1.5;
PSI2  = 0.125;
RHOR  = 0.75;
SIG2R = 0.4;

shocks;
var epsr = SIG2R;
var epsz = SIG2Z;
var epsg = SIG2G;
end;

stoch_simul(order=1);