@#include "new_keynesian_common_with_minus_eps_z.inc"

%----------------------------------------------------------------
%  Calibration
%---------------------------------------------------------------
BETA    = 0.99;
RHO_A   = 0.9;
RHO_Z   = 0.5;
RHO_NU  = 0.4;
SIGMA   = 1;
VARPHI  = 5;
THETA   = 0.75;
EPSILON = 9;
PHI_PIE = 1.5;
PHI_Y   = 0.125;
PIESTAR = 1;

%----------------------------------------------------------------
%  unit shock to technology
%---------------------------------------------------------------
steady;% start at steady-state
shocks;
var eps_a; periods 1; values 1;
var eps_z; periods 1; values 0;
var eps_nu; periods 1; values 0;
end;
perfect_foresight_setup(periods=50);
perfect_foresight_solver(maxit=100,tolf=1e-5,tolx=1e-5,stack_solve_algo=0);
tit = 'eps_a';
new_keynesian_irfs_do_plots;
sgtitle('unit shock to technology');

%----------------------------------------------------------------
%  initial preference shifter shock is set to -0.5 percentage points
%---------------------------------------------------------------
steady;% start at steady-state
shocks;
var eps_a; periods 1; values 0;
var eps_z; periods 1; values 0.5; % important to change the sign of eps z to a minus
var eps_nu; periods 1; values 0;
end;
perfect_foresight_setup(periods=50);
perfect_foresight_solver(maxit=100,tolf=1e-5,tolx=1e-5,stack_solve_algo=0);
tit = 'eps_z';
new_keynesian_irfs_do_plots;
sgtitle('initial preference shifter shock is set to -0.5 percentage points');

%----------------------------------------------------------------
%  contractionary monetary policy shock of 25 basis points
%---------------------------------------------------------------
steady;% start at steady-state
shocks;
var eps_a; periods 1; values 0;
var eps_z; periods 1; values 0;
var eps_nu; periods 1; values 0.25;
end;
perfect_foresight_setup(periods=50);
perfect_foresight_solver(maxit=100,tolf=1e-5,tolx=1e-5,stack_solve_algo=0);
tit = 'eps_nu';
new_keynesian_irfs_do_plots;
sgtitle('contractionary monetary policy shock of 25 basis points')