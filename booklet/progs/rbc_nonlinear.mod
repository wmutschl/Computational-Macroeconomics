var
  y     ${Y}$        (long_name='output')
  c     ${C}$        (long_name='consumption')
  k     ${K}$        (long_name='capital')
  l     ${L}$        (long_name='labor')
  a     ${A}$        (long_name='productivity')
  r     ${R}$        (long_name='interest Rate')
  w     ${W}$        (long_name='wage')
  iv    ${I}$        (long_name='investment')
;

model_local_variable
  uc    ${U_t^C}$
  ucp   ${E_t U_{t+1}^C}$
  ul    ${U_t^L}$
  fk    ${f_t^K}$
  fl    ${f_t^L}$
;

varexo
  ea  ${\varepsilon^A}$   (long_name='Productivity Shock')
;

parameters
  BETA  ${\beta}$  (long_name='Discount Factor')
  DELTA ${\delta}$ (long_name='Depreciation Rate')
  GAMMA ${\gamma}$ (long_name='Consumption Utility Weight')
  PSI   ${\psi}$   (long_name='Labor Disutility Weight')
  ALPHA ${\alpha}$ (long_name='Output Elasticity of Capital')
  RHOA  ${\rho^A}$ (long_name='Persistence technology')
;

% Parameter calibration
ALPHA = 0.35;
BETA  = 0.99;
DELTA = 0.025;
GAMMA = 1;
PSI   = 1.6;
RHOA  = 0.9;

model;
%marginal utility of consumption and labor
#uc  = GAMMA*c^(-1);
#ucp  = GAMMA*c(+1)^(-1);
#ul = -PSI*(1-l)^(-1);

%marginal products of production
#fk = ALPHA*y/k(-1);
#fl = (1-ALPHA)*y/l;

%marginal costs
#MC = 1;

% intertemporal optimality (Euler)
uc = BETA*ucp*(1-DELTA+r(+1));
% labor supply
w = -ul/uc;
% capital accumulation
k = (1-DELTA)*k(-1) + iv;
% market clearing
y = c + iv;
% production function
y = a*k(-1)^ALPHA*l^(1-ALPHA);
% labor demand
w = MC*fl;
% capital demand
r = MC*fk;
% total factor productivity
log(a) = RHOA*log(a(-1)) + ea;
end;

initval;
 a = 1;
 r = 0.03;
 l = 1/3;
 y = 1.2;
 c = 0.9;
 iv = 0.35;
 k = 12;
 w = 2.25;
end;



steady;
stoch_simul(order=3,irf=0,periods=0);
