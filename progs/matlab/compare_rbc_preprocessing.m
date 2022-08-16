clearvars;
%% Dynare preprocessing
oldfolder = cd('../dynare'); % go to folder of rbc_nonlinear.mod
dynare rbc_nonlinear

[I,~]     = find(M_.lead_lag_incidence');
ys        = oo_.steady_state;    % steady state of endogenous variables
yy0       = oo_.steady_state(I); % steady state of dynamic model variables [y^*(-1), y, y^**(+1)]
ex0       = oo_.exo_steady_state'; % steady state of exogenous variables u

% get dynamic model derivatives from dynare files
[dynare_resid, dynare_g1] = feval([M_.fname,'.dynamic'], yy0, ex0, M_.params, ys, 1);
[dynare_resid_static, dynare_g1_static] = feval([M_.fname,'.static'], ys, ex0, M_.params);

cd(oldfolder);

%% Our preprocessing
matlab_rbc_nonlinear_preprocessing;
our_resid        = rbc_dynamic_resid(yy0,ex0,M_.params,ys);
our_resid_static = rbc_static_resid(ys,ex0,M_.params);
our_g1           = rbc_dynamic_g1(yy0,ex0,M_.params,ys);
our_g1_static    = rbc_static_g1(ys,ex0,M_.params);

%% Compare
our_resid - dynare_resid
our_resid_static - dynare_resid_static
our_g1 - dynare_g1
our_g1_static - dynare_g1_static
