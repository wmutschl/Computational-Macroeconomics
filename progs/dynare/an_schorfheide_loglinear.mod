% This file implements the log-linearized model equations of
% An and Schorfheide (2007, Econometric Reviews)
% 
% THIS MOD-FILE REQUIRES DYNARE 4.6 OR HIGHER
%==========================================================================
% Copyright (C) 2021 Willi Mutschler
%
% This is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% It is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% For a copy of the GNU General Public License,
% see <http://www.gnu.org/licenses/>.
%==========================================================================

var chat zhat piehat Rhat yhat ghat
    YGR INFL INT;
varexo epsr epsg epsz;
parameters TAU KAPPA PSI1 PSI2 RHOR RHOG RHOZ RA PIEA GAMQ NU GSTAR;

% Parametrization follows table (3)
TAU=2; KAPPA=0.33; PSI1=1.5; PSI2=0.125; RHOR=0.75; RHOG=0.95; RHOZ=0.90;
RA=1; PIEA=3.2; GAMQ= 0.5; NU=0.1; GSTAR=1/0.85;

model(linear);
#BETA = 1/(1+RA/400);

yhat = yhat(+1) + ghat - ghat(+1) - 1/TAU*(Rhat -piehat(+1) - zhat(+1));
piehat = BETA*piehat(+1) + KAPPA*(yhat-ghat);
chat = yhat - ghat;
Rhat = RHOR*Rhat(-1) + (1-RHOR)*PSI1*piehat + (1-RHOR)*PSI2*(yhat-ghat) + epsr;
zhat = RHOZ*zhat(-1) + epsz;
ghat = RHOG*ghat(-1) + epsg;
YGR = GAMQ + 100*( yhat - yhat(-1) + zhat );
INFL = PIEA + 400*piehat;
INT = PIEA + RA + 4*GAMQ + 400*Rhat;
end;

steady_state_model;
chat=0; zhat=0; piehat=0; Rhat=0; yhat=0; ghat=0; YGR=0; INFL=0; INT=0;
YGR = GAMQ;
INFL = PIEA;
INT = PIEA + RA + 4*GAMQ;
end;

shocks;
var epsr; stderr 0.2/100;
var epsz; stderr 0.3/100;
var epsg; stderr 0.6/100;
end;

steady;
stoch_simul(order=1);