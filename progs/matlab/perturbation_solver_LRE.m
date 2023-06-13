function [g_x, g_u, info] = perturbation_solver_LRE(M_, oo_, fname_dynamic_Jacobian, compare_to_dynare)
% function [g_x, g_u, info] = perturbation_solver_LRE(M_, oo_, fname_dynamic_Jacobian, compare_to_dynare)
% =========================================================================
% Illustration of first-order perturbation approximation using the
% Linear Rational Expectations model framework, i.e. focusing on full
% dynamic Jacobian (not distinguishing variable types and groups)
% and using illustrative (instead of efficient) functions for linear algebra.
% For reference, see the first part of the lecture notes "Solving rational
% expectations model at first order: what Dynare does" which is inspired by
% lecture notes of Julliard (2022): "Introduction to Dynare and local approximation"
% =========================================================================
% INPUT
%   - M_    : Dynare's model structure
%   - oo_   : Dynare's result structure
%   - fname_dynamic_Jacobian: optional name of function that computes
%                             dynamic Jacobian (in case of manually
%                             preprocessing the model with MATLAB's
%                             symbolic toolbox); otherwise Dynare's script
%                             files will be used
%   - compare_to_dynare: boolean indicator to compare the computed
%                        perturbation matrices with Dynare's matrices
%                        oo_.dr.ghx and oo_.dr.ghu;
%                        note that the computed matrices should be
%                        numerically equal to Dynare's matrices, so the
%                        norm should be extremely small
% -------------------------------------------------------------------------
% OUTPUT
%	- g_x   [endo_nbr by nspred]   derivative of policy function wrt state variables
%	- g_u   [endo_nbr by exo_nbr]  derivative of policy function wrt exogenous variables
%   - info  [integer]              indicator for Blanchard & Khan conditions:
%                                  3: no stable equilibrium (explosiveness)
%                                  4: no unique solution (indeterminacy)
%                                  5: no solution due to rank failure
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: June 13, 2023
% =========================================================================
if nargin < 4
    compare_to_dynare = false;
end
% initialize
g_x = []; g_u = []; info = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extract variables from Dynare's global structures %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fname    = M_.fname;    % name of model
params   = M_.params;   % values of parameters
endo_nbr = M_.endo_nbr; % number of endogenous variables
nstatic  = M_.nstatic;  % number of static variables (appear only at t)
nspred   = M_.nspred;   % number of state variables: predetermined and mixed
dr_order_var       = oo_.dr.order_var;      % declaration order to DR order
lead_lag_incidence = M_.lead_lag_incidence; % lead_lag_incidence matrix with information about columns in dynamic Jacobian matrix
steady_state       = oo_.steady_state;      % steady state of endogenous in declaration order
exo_steady_state   = oo_.exo_steady_state;  % steady-state of exogenous variables

%%%%%%%%%%%%%%%%%%%%
% dynamic Jacobian %
%%%%%%%%%%%%%%%%%%%%
% evaluate dynamic Jacobian at steady-state in declaration order
% evaluate first dynamic Jacobian, i.e. derivative of dynamic model equations f
% with respect to dynamic variables that actually appear;
% note that the colums are in declaration order
[I,~] = find(lead_lag_incidence'); % index for dynamic variables that actually appear
y = steady_state;                  % steady-state of endogenous variables
yBack_y0_yFwrd = steady_state(I);  % steady-state of dynamic variables (those variables that actually appear at t-1,t,t+1)
u = exo_steady_state';             % steady-state of exogenous variables
if isempty(fname_dynamic_Jacobian)
    [~, f_z] = feval([fname,'.dynamic'], yBack_y0_yFwrd, u, params, y, 1); % Dynare's Jacobian
else
    f_z = feval(fname_dynamic_Jacobian, yBack_y0_yFwrd, u, params, y); % own preprocessed Jacobian
end

% extract submatrices with respect to certain types of varialbes
idx_yBack = nonzeros(lead_lag_incidence(1,:)); % index for variables that actually appear at t-1, in declaration order
idx_y0    = nonzeros(lead_lag_incidence(2,:)); % index for variables that actually appear at t, in declaration order
idx_yFwrd = nonzeros(lead_lag_incidence(3,:)); % index for variables that actually appear at t+1, in declaration order
% full Jacobian: f_{y_{-}} (note that Dynare's Jacobian only contains columns for previous and mixed variables in period t-1, so we fill other columns with zeros))
f_yBack = zeros(endo_nbr,endo_nbr);
f_yBack(:,lead_lag_incidence(1,:)~=0) = f_z(:,idx_yBack);
% full Jacobian: f_{y_{0}} (note that Dynare's Jacobian contains columns for all endogenous variables in period t)
f_y0 = zeros(endo_nbr,endo_nbr);
f_y0(:,lead_lag_incidence(2,:)~=0) = f_z(:,idx_y0);
% full Jacobian: f_{y_{+}} (note that Dynare's Jacobian only contains columns for mixed and forward variables in period t+1, so we fill other columns with zeros)
f_yFwrd = zeros(endo_nbr,endo_nbr);
f_yFwrd(:,lead_lag_incidence(3,:)~=0) = f_z(:,idx_yFwrd);
% f_{u}
f_u = f_z(:,(nnz(lead_lag_incidence)+1):end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set up D and E matrices %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
D = [zeros(endo_nbr,endo_nbr) f_yFwrd;
     eye(endo_nbr)            zeros(endo_nbr,endo_nbr);
    ];
E = [-f_yBack                  -f_y0;
     zeros(endo_nbr,endo_nbr)  eye(endo_nbr);
    ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generalized Schur decomposition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[S,T,Q,Z] = qz(E,D);
% some info:
%   norm(D-Q'*T*Z')
%   norm(E-Q'*S*Z')
%   Generalized Eigenvalues lambdai:
%     eig(E,D) returns lambdai that solves the following equation:
%         E*vi = lambdai*D*vi where vi is the eigenvector
%     these are computed by the ratio of the diagonal elements of S and T
%     disp(sort([eig(E,D) diag(S)./diag(T)])); % are equal up to a reordering

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% reorder Schur decomposition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% stable (smaller than one) generalized Eigenvalues are in the upper left corner of S and T
[S,T,Q,Z] = ordqz(S,T,Q,Z,'udi');
EigenValues = abs(diag(S))./abs(diag(T));
% disp(EigenValues) % check that stable Eigenvalues come first
idx_stable_root    = find(EigenValues<1)'; % index of stable roots
idx_explosive_root = idx_stable_root(end)+1:length(EigenValues);   % index of explosive roots
%Z11 = Z(idx_stable_root,    idx_stable_root);
Z12 = Z(idx_stable_root,    idx_explosive_root);
%Z21 = Z(idx_explosive_root, idx_stable_root);
Z22 = Z(idx_explosive_root, idx_explosive_root);
%S11 = S(idx_stable_root,    idx_stable_root);
%T11 = T(idx_stable_root,    idx_stable_root);
%S22 = S(idx_explosive_root, idx_explosive_root);
%T22 = T(idx_explosive_root, idx_explosive_root);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Blanchard & Khan (1980) conditions %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if length(idx_explosive_root)>endo_nbr
    info = 3;
    warning('Blanchard & Khan (1980) order condition not fullfilled: no stable equilibrium (explosiveness)');
    return    
end
if length(idx_explosive_root)<endo_nbr
    info = 4;
    warning('Blanchard & Khan (1980) order condition not fullfilled: no unique solution (indeterminacy)');
    return
end
if rank(Z22)~=endo_nbr
    info = 5;
    warning('Blanchard & Khan (1980) rank condition not fullfilled: no solution due to rank failure');
    return    
end

%%%%%%%%%%%%%%%%%
% recover g_{y} %
%%%%%%%%%%%%%%%%%
g_y = -inv(transpose(Z22))*transpose(Z12);
g_y = real(g_y); % because we did generalized complex Schur, get rid of spurious imaginary parts
g_x = g_y(dr_order_var,dr_order_var); % put rows and columns into DR order
g_x = g_x(:,nstatic+(1:nspred)); % focus only on state variables
    
%%%%%%%%%%%%%%%%%
% recover g_{u} %
%%%%%%%%%%%%%%%%%
g_u = -inv(f_y0+f_yFwrd*g_y)*f_u;
g_u = g_u(dr_order_var,:); % put rows into DR order
    
%%%%%%%%%%%%%%%%%%%%%%%
% compare with Dynare %
%%%%%%%%%%%%%%%%%%%%%%%
if compare_to_dynare    
    fprintf('\ng_x(:) and oo_.dr.ghx(:):\n')
    disp(array2table([g_x(:) oo_.dr.ghx(:)],'VariableNames',["g_x","ghx"]));
    fprintf('\n\ng_u(:) and oo_.dr.ghu(:):\n')
    disp(array2table([g_u(:) oo_.dr.ghu(:)],'VariableNames',["g_u","ghu"]));
    fprintf('\n norm of g_x and oo_.dr.ghx: %e\n',norm(g_x-oo_.dr.ghx));
    fprintf('\n norm of g_u and oo_.dr.ghu: %e\n',norm(g_u-oo_.dr.ghu));
end
