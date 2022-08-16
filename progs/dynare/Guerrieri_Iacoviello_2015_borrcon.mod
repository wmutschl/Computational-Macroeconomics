/*
Note that the reference regime is one where the borrowing 
constraint is binding, i.e. the relax condition specifies the condition where we return to
the reference regime with a binding constraint.
*/

var
  b        ${b}$          (long_name='borrowing')
  c        ${c}$          (long_name='consumption')
  lam      ${\lambda}$    (long_name='Lagrange multiplier')
  y        ${y}$          (long_name='Output')
  c_hat    ${\hat c}$     (long_name='consumption (perc. dev. steady-state)')
  b_hat    ${\hat b}$     (long_name='borrowing (perc. dev. steady-state)')
  y_hat    ${\hat y}$     (long_name='output (perc. dev. steady-state)')
  m_hat    ${\hat m}$     (long_name='ratio borrowing/income')
;
varexo
  e        ${e}$          (long_name='output shock')
;

parameters
  BETA     ${\beta}$      (long_name='discount factor')
  RHO      ${\rho}$       (long_name='persistence output process')
  M        ${m}$          (long_name='borrowing limit')
  R        ${R}$          (long_name='nominal interest rate')
  GAMMA    ${\gamma}$     (long_name='risk aversion')
;

BETA  = 0.945;
R     = 1.05;
RHO   = 0.9;
GAMMA = 1;
M     = 1;

model;
[name='budget constraint']
c + R*b(-1) = y + b;
[name='output law of motion']
log(y) = RHO*log(y(-1)) + e;
[name='consumption Euler']
c^(-GAMMA) = BETA*R*c(+1)^(-GAMMA) + lam;

[name = 'borrowing', relax='borrcon']
b = M*y;
[name = 'borrowing', bind='borrcon']
lam = 0;

% reporting
[name = 'reporting: consumption (in percentage deviation from steady-state']
c_hat = 100*(c/steady_state(c)-1);
[name = 'reporting: borrowing (in percentage deviation from steady-state']
b_hat = 100*(b/steady_state(b)-1);
[name = 'reporting: ratio of borrowing to income']
m_hat = b/y;
[name = 'reporting: output (in percentage deviation from steady-state']
y_hat = 100*(y/steady_state(y)-1);
end;

occbin_constraints;
name 'borrcon'; bind lam<=0; relax b>M*y;
end;

steady_state_model;
y   = 1;
b   = M*y;
c   = y + b - R*b;
lam = (1-BETA*R)*c^(-GAMMA);
c_hat = 0;
b_hat = 0;
y_hat = 0;
m_hat = b/y;
end;
steady;

@#define SHOCKSIZE = 2*0.0131

shocks(surprise,overwrite);
var e; periods 2 21; values @{SHOCKSIZE} -@{SHOCKSIZE};
end;

occbin_setup(simul_periods=40);
occbin_solver;
occbin_graph c_hat b_hat m_hat y_hat;