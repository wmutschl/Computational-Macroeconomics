% This file implements the exponentially transformed stationary nonlinear
% model equations of An and Schorfheide (2007, Econometric Reviews)
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: June 13, 2023
% =========================================================================

var
chat   ${\hat{c}}$     (long_name='detrended consumption (log dev. from steady-state)')
zhat   ${\hat{z}}$     (long_name='technology growth (log dev. from steady-state)')
phat   ${\hat{\pi}}$   (long_name='inflation rate (log dev. from steady-state)')
rhat   ${\hat{R}}$     (long_name='nominal interest rate (log dev. from steady-state)')
yhat   ${\hat{y}}$     (long_name='detrended output (log dev. from steady-state)')
ghat   ${\hat{g}}$     (long_name='government consumption (log dev. from steady-state)')
// observable variables
YGR    ${YGR}$         (long_name='output growth rate (quarter-on-quarter)')
INFL   ${INFL}$        (long_name='annualized inflation rate')
INT    ${INT}$         (long_name='annualized nominal interest rate')
;

varexo
epsr   ${\varepsilon^R}$   (long_name='monetary policy shock')
epsg   ${\varepsilon^g}$   (long_name='government spending shock')
epsz   ${\varepsilon^z}$   (long_name='total factor productivity growth shock')
;

parameters
TAU     ${\tau}$           (long_name='inverse of intertemporal elasticity of subsitution')
KAPPA   ${\kappa}$         (long_name='auxiliary parameter, slope of New-Keynesian Phillips curve')
PSI1    ${\psi_1}$         (long_name='Taylor rule sensitivity parameter to inflation deviations')
PSI2    ${\psi_2}$         (long_name='Taylor rule sensitivity parameter to output deviations')
RHOR    ${\rho_R}$         (long_name='Taylor rule persistence')
RHOG    ${\rho_{g}}$       (long_name='persistence government spending process')
RHOZ    ${\rho_z}$         (long_name='persistence TFP growth rate process')
RA      ${r_{A}}$          (long_name='annualized steady-state real interest rate')
PA      ${\pi^{(A)}}$      (long_name='annualized target inflation rate')
GAMQ    ${\gamma^{(Q)}}$   (long_name='quarterly steady-state growth rate of technology')
NU      ${\nu}$            (long_name='inverse of elasticity of demand in Dixit Stiglitz aggregator')
GBAR    ${\bar{g}}$        (long_name='steady state government spending process')
;

model;
#BETA  = 1/(1+RA/400); //below eq.(38)
#PBAR  = 1+PA/400;     //below eq.(38)
#PHI   = TAU*(1-NU)/(NU*PBAR^2*KAPPA); //relationship slope of New Keynesian Phillips Curve eq.(32)
// auxiliary steady-state values
#PSS = PBAR;
#GSS = GBAR;

[name='Euler equation']
1 = exp( -TAU*chat(+1) + TAU*chat + rhat - zhat(+1) - phat(+1));
[name='Phillips curve based on Rotemberg price setting and Dixit/Stiglitz aggregator']
0 = ( exp(phat)-1 ) * ( (1-1/(2*NU)) * exp(phat) + 1/(2*NU) )
  - BETA*( ( exp(phat(+1))-1 ) * exp( -TAU*chat(+1) + TAU*chat + yhat(+1) - yhat + phat(+1) ) )
  + (1-NU)/(PHI*PSS^2*NU) * ( 1-exp(TAU*chat) );
[name='market clearing']
exp(chat-yhat) = exp(-ghat) - PHI*PSS^2*GSS/2 * (exp(phat)-1)^2;
[name='monetary policy equation and feedback rule']
rhat = RHOR*rhat(-1) + (1-RHOR)*PSI1*phat + (1-RHOR)*PSI2*(yhat-ghat) + epsr;
[name='technology growth process']
zhat = RHOZ*zhat(-1) + epsz;
[name='government spending process']
ghat = RHOG*ghat(-1) + epsg;

[name='output growth (q-on-q)']
YGR = GAMQ + 100*( yhat - yhat(-1) + zhat );
[name='annualized inflation']
INFL = PA + 400*phat;
[name='annualized nominal interest rate']
INT = PA + RA + 4*GAMQ + 400*rhat;
end;

steady_state_model;
chat=0; zhat=0; phat=0; rhat=0; yhat=0; ghat=0;
YGR  = GAMQ;
INFL = PA;
INT  = PA + RA + 4*GAMQ;
end;

@#include "an_schorfheide_params_shocks.inc"
steady;
stoch_simul(order=1,nograph);