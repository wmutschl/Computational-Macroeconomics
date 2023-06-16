% This file implements the stationary nonlinear model equations of
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

var c z pie R Rstar y ystar g 
    chat zhat piehat Rhat yhat ghat
    YGR INFL INT;
varexo epsr epsg epsz;
parameters TAU KAPPA PSI1 PSI2 RHOR RHOG RHOZ RA PIEA GAMQ NU GSTAR;

% Parametrization follows table (3)
TAU=2; KAPPA=0.33; PSI1=1.5; PSI2=0.125; RHOR=0.75; RHOG=0.95; RHOZ=0.90;
RA=1; PIEA=3.2; GAMQ= 0.5; NU=0.1; GSTAR=1/0.85;

model;
#GAMMA = 1+GAMQ/100;
#BETA = 1/(1+RA/400);
#PIESTAR = 1+PIEA/400; %note that in steady state pie=PIESTAR
#PHI = TAU*(1-NU)/(NU*PIESTAR^2*KAPPA);

1 = BETA * (c(+1)/c)^(-TAU) * 1/(GAMMA*z(+1)) * R/pie(+1);
1 =  PHI*(pie-steady_state(pie))*( (1-1/(2*NU))*pie + steady_state(pie)/(2*NU) )
    -PHI*BETA*( (c(+1)/c)^(-TAU)*y(+1)/y*(pie(+1)-steady_state(pie))*pie(+1) )
    +1/NU*(1-c^TAU);
y = c + (g-1)/g*y + PHI/2*(pie-steady_state(pie))^2*y;
R = Rstar^(1-RHOR)*R(-1)^RHOR*exp(epsr);
Rstar = steady_state(R) * (pie/PIESTAR)^PSI1 * (y/ystar)^PSI2;
log(z) = RHOZ*log(z(-1)) + epsz;
log(g) = (1-RHOG)*log(GSTAR) + RHOG*log(g(-1)) + epsg;
ystar = (1-NU)^(1/TAU)*g;
chat = log(c) - log(steady_state(c));
zhat = log(z) - log(steady_state(z));
piehat = log(pie) - log(steady_state(pie));
Rhat = log(R) - log(steady_state(R));
yhat = log(y) - log(steady_state(y));
ghat = log(g) - log(steady_state(g));
YGR = GAMQ + 100*( yhat - yhat(-1) + zhat );
INFL = PIEA + 400*piehat;
INT = PIEA + RA + 4*GAMQ + 400*Rhat;
end;

steady_state_model;
z=1; pie=1+PIEA/400; g=GSTAR;
R=(1+GAMQ/100)/(1/(1+RA/400))*pie; Rstar=R;
c=(1-NU)^(1/TAU); y=g*c; ystar=y;
chat=0; zhat=0; piehat=0; Rhat=0; yhat=0; ghat=0;
YGR=GAMQ; INFL=PIEA; INT=PIEA+RA+4*GAMQ;
end;

shocks;
var epsr; stderr 0.2/100;
var epsz; stderr 0.3/100;
var epsg; stderr 0.6/100;
end;

steady;
stoch_simul(order=1);