% =========================================================================
% illustration of first-order perturbation, compares Dynare's solution
% with manually computing it using:
% - perturbation_solver_LRE:
%   based on full Jacobian without distinguishing variables types,
%   illustrative use of linear algebra functions
% - perturbation_solver_dynare_order1:
%   illustrates exactly what Dynare does: distinguishing variable types,
%   getting rid of static variables, using efficient linear algebra functions
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: June 13, 2023
% =========================================================================

@#include "nk.mod"
shocks;
var eps_a    = 0.003^2;
var eps_nu   = 0.010^2;
var eps_zeta = 0.005^2;
end;

stoch_simul(order=1,irf=30,periods=200);

addpath('../matlab'); % add path that contains perturbation solver functions

fprintf('%s\n',strjoin(repmat("*",1,100),''))
fprintf('\n    Illustration Perturbation Solver: Linear Rational Expectations Model\n\n')
[ghx_LRE, ghu_LRE, info_LRE] = perturbation_solver_LRE(M_, oo_, [], true);
fprintf('\n%s\n\n',strjoin(repmat("*",1,100),''))

fprintf('%s\n',strjoin(repmat("*",1,100),''))
fprintf('\n    Illustration Perturbation Solver: What Dynare Does (keeping static variables)\n\n')
[ghx_dyn0, ghu_dyn0, info_dyn0] = perturbation_solver_dynare_order1(M_, oo_, [], true, true);
fprintf('\n%s\n\n',strjoin(repmat("*",1,100),''))

fprintf('%s\n',strjoin(repmat("*",1,100),''))
fprintf('\n    Illustration Perturbation Solver: What Dynare Does (getting rid of static variables)\n\n')
[ghx_dyn, ghu_dyn, info_dyn] = perturbation_solver_dynare_order1(M_, oo_, [], false, true);
fprintf('\n%s\n\n',strjoin(repmat("*",1,100),''))

rmpath('../matlab');