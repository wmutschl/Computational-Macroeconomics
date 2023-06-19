% This file provides the calibration of parameters and shock variances
% of the model in An and Schorfheide (2007, Econometric Reviews) according
% to Table (3, DGP D_1(Q))
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: June 13, 2023
% =========================================================================

TAU   = 2.00;
KAPPA = 0.33;
PSI1  = 1.50;
PSI2  = 0.125;
RHOR  = 0.75;
RHOG  = 0.95;
RHOZ  = 0.90;
RA    = 1.00;
PA    = 3.20;
GAMQ  = 0.55;
NU    = 0.10;
GBAR  = 1/0.85;

shocks;
var epsr; stderr 0.20/100;
var epsg; stderr 0.60/100;
var epsz; stderr 0.30/100;
end;