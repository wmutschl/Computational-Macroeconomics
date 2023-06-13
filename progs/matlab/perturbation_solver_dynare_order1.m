function [g_x, g_u, info] = perturbation_solver_dynare_order1(M_, oo_, fname_dynamic_Jacobian, keep_static, compare_to_dynare)
% function [g_x, g_u, info] = perturbation_solver_dynare_order1(M_, oo_, fname_dynamic_Jacobian, keep_static, compare_to_dynare)
% =========================================================================
% Exact illustration how Dynare computes the first-order perturbation
% solution. This basically reimplements the core functionality of
% "dyn_first_order_solver.m" in a slightly simplified, but more understandable
% manner and better notation.
% For reference, see the second part of the lecture notes "Solving rational
% expectations model at first order: what Dynare does" which is inspired by
% Villemot (2011): "Solving rational expectations model at first order: what Dynare does"
% =========================================================================
% INPUT
%   - M_    : Dynare's model structure
%   - oo_   : Dynare's result structure
%   - fname_dynamic_Jacobian: optional name of function that computes
%                             dynamic Jacobian (in case of manually
%                             preprocessing the model with MATLAB's
%                             symbolic toolbox); otherwise Dynare's script
%                             files will be used
%   - keep_static: boolean indicator whether to skip the step to get rid of
%                  static variables by doing a QR decomposition on the
%                  dynamic Jacobian
%   - compare_to_dynare: boolean indicator to compare the computed
%                        perturbation matrices with Dynare's matrices
%                        oo_.dr.ghx and oo_.dr.ghu;
%                        note that the computed matrices should be exactly
%                        equal to Dynare's matrices, so the norm will be 0
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
    keep_static = false;
end
if nargin < 5
    compare_to_dynare = false;
end
% initialize
g_x = []; g_u = []; info = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extract variables from Dynare's global structures %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fname    = M_.fname;    % name of mod file
params   = M_.params;   % values of parameters
endo_nbr = M_.endo_nbr; % number of endogenous variables
exo_nbr  = M_.exo_nbr;  % number of exogenous variables
nstatic  = M_.nstatic;  % number of static variables (appear only at t)
npred    = M_.npred;    % number of predetermined variables (appear at t-1, but not at t+1, possibly also at t)
nfwrd    = M_.nfwrd;    % number of forward variables (appear at t+1, but not at t-1, possibly also at t)
nboth    = M_.nboth;    % number of mixed variables (appear at t-1 and t+1, possibly also at t)
nspred   = M_.nspred;   % number of state variables: predetermined and mixed
nsfwrd   = M_.nsfwrd;   % number of jumper variables: mixed and forward
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
[I,~] = find(lead_lag_incidence');            % index for dynamic variables that actually appear
y = steady_state;                             % steady-state of endogenous variables
yStarBack_y0_yStarStarFwrd = steady_state(I); % steady-state of dynamic variables
u = exo_steady_state';                        % steady-state of exogenous variables
if isempty(fname_dynamic_Jacobian) % Jacobian of dynamic model in declaration order
    [~, f_z] = feval([fname,'.dynamic'], yStarBack_y0_yStarStarFwrd, u, params, y, 1); % Dynare's Jacobian
else
    f_z = feval(fname_dynamic_Jacobian, yStarBack_y0_yStarStarFwrd, u, params, y); % own preprocessed Jacobian
end
% put dynamic Jacobian into DR order and extract submatrices with respect to certain types of varialbes
f_z = f_z(:,[nonzeros(lead_lag_incidence(:,dr_order_var)'); nnz(lead_lag_incidence)+(1:exo_nbr)']); % Jacobian of dynamic model in DR order
pred0_nbr  = nnz(ismember(transpose(lead_lag_incidence(:,dr_order_var)>0), [1 1 0],'rows')); % predetermined variables that also appear in t
mixed0_nbr = nnz(ismember(transpose(lead_lag_incidence(:,dr_order_var)>0), [1 1 1],'rows')); % mixed variables that also appear in t
fwrd0_nbr  = nnz(ismember(transpose(lead_lag_incidence(:,dr_order_var)>0), [0 1 1],'rows')); % forward variables that also appear in t
f_yStatic0 = f_z(:,nspred+(1:nstatic));                                % submatrix with columns for static variables only (this is matrix S in the notes)
f_yPred0   = f_z(:,nspred+nstatic+(1:pred0_nbr));                      % submatrix with columns for predetermined variables that also appear in t
f_yMixed0  = f_z(:,nspred+nstatic+pred0_nbr+(1:mixed0_nbr));           % submatrix with columns for mixed variables that also appear in t
f_yFwrd0   = f_z(:,nspred+nstatic+pred0_nbr+mixed0_nbr+(1:fwrd0_nbr)); % submatrix with columns for forward variables that also appear in t
f_yStarBack     = f_z(:,1:nspred);                                                 % f_{y_{-}^{*}}
f_y0            = f_z(:,nspred+(1:(nstatic+pred0_nbr+mixed0_nbr+fwrd0_nbr)));      % f_{y_{0}}
f_yStarStarFwrd = f_z(:,nspred+nstatic+pred0_nbr+mixed0_nbr+fwrd0_nbr+(1:nsfwrd)); % f_{y_{+}^{**}}
f_u             = f_z(:,(nnz(lead_lag_incidence)+1):end);                          % f_{u}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set up D and E matrices %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
if keep_static
    D = [f_yStatic0           f_yPred0                zeros(endo_nbr,nboth)  f_yStarStarFwrd;
         zeros(nboth,nstatic) zeros(nboth,pred0_nbr)  eye(nboth)             zeros(nboth,nsfwrd);
        ];
    E = [zeros(endo_nbr,nstatic)  -f_yStarBack         -f_yMixed0  -f_yFwrd0;
         zeros(nboth,nstatic)     zeros(nboth,nspred)  eye(nboth)  zeros(nboth,nfwrd);
        ];
else
    % get rid of static variables (optional, but more efficient)
    [Qs,~] = qr(f_yStatic0); % Qs is orthogonal: norm(Qs*Qs'-eye(size(Qs,1)),'inf') and norm(Qs'-inv(Qs),'inf')
    % multiply with Qs'
    Qs_f_z             = Qs'*f_z;
    Qs_f_y0            = Qs_f_z(:,nspred+(1:(nstatic+pred0_nbr+mixed0_nbr+fwrd0_nbr))); % by construction columns of static variables are zero in lower part: norm(Qs_f_y0((nstatic+1):end,1:nstatic),'inf')
    Qs_f_yStarBack     = Qs_f_z(:,1:nspred);
    Qs_f_yPred0        = Qs_f_z(:,nspred+nstatic+(1:pred0_nbr));
    Qs_f_yMixed0       = Qs_f_z(:,nspred+nstatic+pred0_nbr+(1:mixed0_nbr));
    Qs_f_yFwrd0        = Qs_f_z(:,nspred+nstatic+pred0_nbr+mixed0_nbr+(1:fwrd0_nbr));
    Qs_f_yStarStarFwrd = Qs_f_z(:,nspred+nstatic+pred0_nbr+mixed0_nbr+fwrd0_nbr+(1:nsfwrd));
    % focus on lower ROWS
    fQ_yStarBack     = Qs_f_yStarBack(nstatic+1:end,:);
    fQ_yPred0        = Qs_f_yPred0(nstatic+1:end,:);
    fQ_yMixed0       = Qs_f_yMixed0(nstatic+1:end,:);
    fQ_yFwrd0        = Qs_f_yFwrd0(nstatic+1:end,:);
    fQ_yStarStarFwrd = Qs_f_yStarStarFwrd(nstatic+1:end,:);
    % set up D and E matrices without static
    D = [fQ_yPred0                       zeros(size(fQ_yPred0,1),nboth)  fQ_yStarStarFwrd;
         zeros(nboth,size(fQ_yPred0,2))  eye(nboth)                      zeros(nboth,size(fQ_yStarStarFwrd,2));
        ];
    E = [-fQ_yStarBack                      -fQ_yMixed0  -fQ_yFwrd0;
         zeros(nboth,size(fQ_yStarBack,2))  eye(nboth)   zeros(nboth,nfwrd);
        ];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generalized reordered Schur decomposition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
qz_criterium = 1.000001;  % value used to split stable from unstable eigenvalues in reordering the Generalized Schur decomposition used for solving first order problems.
qz_zero_threshold = 1e-6; % value used to test if a generalized eigenvalue is 0/0 in the generalized Schur decomposition (in which case the model does not admit a unique solution).
[S, T, Z, stable_root_nbr, EigenValues, info] = mjdgges(E, D, qz_criterium, qz_zero_threshold);
% stable (smaller than one) generalized Eigenvalues are in the upper left corner of S and T
% disp(EigenValues)% check that stable Eigenvalues come first
idx_stable_root    = 1:stable_root_nbr;                         % index of stable roots
idx_explosive_root = (stable_root_nbr+1):length(EigenValues); % index of explosive roots
Z11 = Z(idx_stable_root,    idx_stable_root);
Z12 = Z(idx_stable_root,    idx_explosive_root);
%Z21 = Z(idx_explosive_root, idx_stable_root);
Z22 = Z(idx_explosive_root, idx_explosive_root);
S11 = S(idx_stable_root,    idx_stable_root);
T11 = T(idx_stable_root,    idx_stable_root);
%S22 = S(idx_explosive_root, idx_explosive_root);
%T22 = T(idx_explosive_root, idx_explosive_root);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Blanchard & Khan (1980) order conditions %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if length(idx_explosive_root)>nsfwrd
    info = 3;
    warning('Blanchard & Khan (1980) order condition not fullfilled: no stable equilibrium (explosiveness)');
    return    
end
if length(idx_explosive_root)<nsfwrd
    info = 4;
    warning('Blanchard & Khan (1980) order condition not fullfilled: no unique solution (indeterminacy)');
    return
end

%%%%%%%%%%%%%%%%%%%%%%
% recover g_{x}^{**} %
%%%%%%%%%%%%%%%%%%%%%%
opts.TRANSA = false; % needed by Octave 4.0.0
[g_xStarStar,rc] = linsolve(transpose(Z22),transpose(Z12),opts);
if rc < 1e-9
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Blanchard & Khan (1980) rank condition %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Z22 is near singular
    info(1) = 5;
    warning('Blanchard & Khan (1980) rank condition not fullfilled: no solution due to rank failure');
    return
else
    g_xStarStar = -g_xStarStar;
end

%%%%%%%%%%%%%%%%%%%%%
% recover g_{x}^{*} %
%%%%%%%%%%%%%%%%%%%%%
opts.UT = true;
opts.TRANSA = true;
g_xStar = transpose(linsolve(T11,transpose(Z11),opts));
opts.UT = false;      % needed by Octave 4.0.0
opts.TRANSA = false;  % needed by Octave 4.0.0
g_xStar = g_xStar * transpose(linsolve(transpose(Z11),transpose(S11),opts));

if keep_static
    % only columns of state variables are nonzero, remove other columns
    g_xStar = g_xStar(:,nstatic+(1:nspred));
    g_xStarStar = g_xStarStar(:,nstatic+(1:nspred));
    g_x = [g_xStar;g_xStarStar(nboth+(1:nfwrd),:)]; % combine, note that mixed variables are both in g_xStar and g_xStarStar
else
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % recover g_{x}^{static} %
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    g_xNonstatic = [g_xStar;g_xStarStar(nboth+(1:nfwrd),:)];
    % multiply with Qs' and focus on upper rows
    finvhatQ_yStarBack     = Qs_f_yStarBack(1:nstatic,:);
    finvhatQ_yStarStarFwrd = Qs_f_yStarStarFwrd(1:nstatic,:);
    finvhatQ_yStatic0      = Qs_f_y0(1:nstatic,1:nstatic);
    finvhatQ_yNonstatic0   = Qs_f_y0(1:nstatic,(nstatic+1):end);
    RHS = - finvhatQ_yStarStarFwrd*g_xStarStar*g_xStar;
    RHS(:,1:nspred) = RHS(:,1:nspred) - finvhatQ_yStarBack;
    g_xStatic = finvhatQ_yStatic0 \ ( RHS - finvhatQ_yNonstatic0*g_xNonstatic );
    % combine to get g_x
    g_x  = [g_xStatic;g_xNonstatic];
end

%%%%%%%%%%%%%%%%%
% recover g_{u} %
%%%%%%%%%%%%%%%%%
if keep_static
    A = f_y0 + [zeros(endo_nbr,nstatic)  f_yStarStarFwrd*g_xStarStar  zeros(endo_nbr,nfwrd)];
    g_u = - A \ f_u;
else
    A_ = [Qs_f_y0(:,1:nstatic)  Qs_f_yStarStarFwrd*g_xStarStar+Qs_f_y0(:,nstatic+1:nstatic+npred+nboth)  Qs_f_y0(:,nstatic+npred+nboth+1:end)];
    g_u = - A_ \ (Qs'*f_u);
end

%%%%%%%%%%%%%%%%%%%%%%%
% compare with Dynare %
%%%%%%%%%%%%%%%%%%%%%%%
if compare_to_dynare
    fprintf('\ng_x(:) and oo_.dr.ghx(:):\n')
    disp(array2table([g_x(:) oo_.dr.ghx(:)],'VariableNames',["g_x","ghx"]));
    fprintf('\n\ng_u(:) and oo_.dr.ghu(:):\n')
    disp(array2table([g_u(:) oo_.dr.ghu(:)],'VariableNames',["g_u","ghu"]));
    if isequal(g_x,oo_.dr.ghx)
        fprintf('\n g_x and oo_.dr.ghx are equal\n');
    else
        fprintf('\n norm of g_x and oo_.dr.ghx: %e\n',norm(g_x-oo_.dr.ghx));        
    end
    if isequal(g_u,oo_.dr.ghu)
        fprintf('\n g_u and oo_.dr.ghu are equal\n');
    else
        fprintf('\n norm of g_u and oo_.dr.ghu: %e\n',norm(g_u-oo_.dr.ghu));
    end
end
