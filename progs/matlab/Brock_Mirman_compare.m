% =========================================================================
% comparison of first-order perturbation solution and true policy function
% in the Brock and Mirman (1972) model.
% Showcases how the policy function is used to compute impulse response
% functions and simulated time series.
% Impulse response functions and simulated data are computed using both
% Dynare routines as well as manual MATLAB code.
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: June 12, 2023
% =========================================================================

%% housekeeping
clearvars;

%% Dynare
% mod file BrockMirman.mod computes first-order perturbation solution,
% impulse response functions and simulated data
% we'll store this for comparision with out manual codes below

oldfolder = cd('../dynare'); % go to folder of BrockMirman.mod
dynare Brock_Mirman
cd(oldfolder);

%% PREPROCESS AND SOLVE MANUALLY IN MATLAB

% manually preprocess model
MODEL = Brock_Mirman_preprocessing;
RESULTS.dr.order_var = oo_.dr.order_var; % create additional field
idx_states = MODEL.nstatic+(1:MODEL.nspred);

% use same calibration as in Dynare
MODEL.params(MODEL.param_names=="ALPHA",1) = ALPHA;
MODEL.params(MODEL.param_names=="BETA",1)  = BETA;
MODEL.params(MODEL.param_names=="RHO",1)   = RHO;

% compute steady-state and store similar to Dynare's oo_ structure (we need this
% for the manual perturbation solver functions)
[RESULTS.steady_state,MODEL.params,error_indicator] = Brock_Mirman_ss([],MODEL.params,MODEL);
RESULTS.exo_steady_state = zeros(1,MODEL.exo_nbr);
y_bar = RESULTS.steady_state(RESULTS.dr.order_var); % steady-state of all endogenous in DR order
x_bar = y_bar(idx_states); % steady-state of state variables

% compute first-order perturbation solution
[RESULTS.dr.ghx, RESULTS.dr.ghu, RESULTS.info] = perturbation_solver_LRE(MODEL, RESULTS, "BrockMirman_dynamic_g1");
  % optional: this is what Dynare does
  addpath('../dynare'); % temporarily add folder of BrockMirman.mod
  [dyn_ghx, dyn_ghu, dyn_info] = perturbation_solver_dynare_order1(M_, oo_);
  rmpath('../dynare'); % temporarily add folder of BrockMirman.mod
% compare with Dynare
norm(RESULTS.dr.ghx-oo_.dr.ghx)
norm(RESULTS.dr.ghu-oo_.dr.ghu)
isequal(dyn_ghx,oo_.dr.ghx)
isequal(dyn_ghu,oo_.dr.ghu)

%% impulse Response Function with (i) true and (ii) approximated policy function (both Dynare and manual)
T = options_.irf;
% initialize shocks
u = zeros(T,MODEL.exo_nbr);
% Dynare uses the Cholesky decomposition on the covariance matrix to set
% the one standard deviation shock; however, if a shock has 0 variance,
% the matrix isn't definite positive and chol() can't be computed.
% So we add a small positive amount on the diagonal to ensure that the
% matrix is nevertheless positive definite in this case.
u(1,MODEL.exo_names=="eps_a") = chol(M_.Sigma_e+1e-14*eye(MODEL.exo_nbr)); % single shock of one std-dev in first period
% initialize simulation vectors for true policy function
a_true_irf = zeros(1,T+1); k_true_irf = zeros(1,T+1); c_true_irf = zeros(1,T+1);
a_true_irf(1) = y_bar(2); k_true_irf(1) = y_bar(1); c_true_irf(1) = y_bar(3);
% initialize simulation vector for manually approximated policy function
y_approx_irf_m = zeros(MODEL.endo_nbr,T+1);
y_approx_irf_m(:,1) = y_bar;
% initialize simulation vector for replicating exactly Dynare's computations
yhat_approx_irf_d = zeros(MODEL.endo_nbr,T+1); % in deviation from steady-state
ghu_u_d = oo_.dr.ghu * transpose(u);
% do simulation
for t = 2:(T+1)
    % using true policy functions
    a_true_irf(t) = a_true_irf(t-1)^RHO * exp(u(t-1,1));
    k_true_irf(t) = ALPHA*BETA*a_true_irf(t-1)^RHO*k_true_irf(t-1)^ALPHA*exp(u(t-1,1));
    c_true_irf(t) = (1-ALPHA*BETA)*a_true_irf(t-1)^RHO*k_true_irf(t-1)^ALPHA*exp(u(t-1,1));
    % using manually approximated policy function
    y_approx_irf_m(:,t) = y_bar + RESULTS.dr.ghx * (y_approx_irf_m(idx_states,t-1)-x_bar) + RESULTS.dr.ghu * u(t-1,1);
    % using Dynare's policy function, as in simult_.m
    yhat_approx_irf_d(:,t) = oo_.dr.ghx * yhat_approx_irf_d(idx_states,t-1) + ghu_u_d(:,t-1);
end
y_approx_irf_d = bsxfun(@plus,yhat_approx_irf_d,y_bar); % to be equivalent to Dynare's simult_.m and irf.m
% eliminate first period and put in deviation from steady-state
a_true_irf = a_true_irf(2:end)-y_bar(2); k_true_irf = k_true_irf(2:end)-y_bar(1); c_true_irf = c_true_irf(2:end)-y_bar(3);
yhat_approx_irf_m = y_approx_irf_m(:,2:end)-y_bar;
yhat_approx_irf_d = y_approx_irf_d(:,2:end)-y_bar;

% compare to Dynare (see irf.m and simult_.m)
isequal( yhat_approx_irf_d(1,:) , oo_.irfs.k_eps_a )
isequal( yhat_approx_irf_d(2,:) , oo_.irfs.a_eps_a )
isequal( yhat_approx_irf_d(3,:) , oo_.irfs.c_eps_a )
norm( yhat_approx_irf_m(1,:) - oo_.irfs.k_eps_a)
norm( yhat_approx_irf_m(2,:) - oo_.irfs.a_eps_a)
norm( yhat_approx_irf_m(3,:) - oo_.irfs.c_eps_a)

% plot irfs
figure(name='Impulse Response Function');
% note that we plot dev from steady-state
subplot(3,1,1);
    hold on;
    plot(0:(T-1),oo_.irfs.k_eps_a);
    plot(0:(T-1),k_true_irf,'-*');
    title('Capital')
    legend(["approx","true"])
    hold off;
    set(gca,'FontSize',16);
subplot(3,1,2);
    hold on;
    plot(0:(T-1),oo_.irfs.a_eps_a);
    plot(0:(T-1),a_true_irf,'-*');
    title('Total Factor Productivity')
    legend(["approx","true"])
    hold off;
    set(gca,'FontSize',16);
subplot(3,1,3);
    hold on;
    plot(0:(T-1),oo_.irfs.c_eps_a);
    plot(0:(T-1),c_true_irf,'-*');
    title('Consumption')
    legend(["approx","true"])
    hold off;
    set(gca,'FontSize',16);

%% data simulation with (i) true and (ii) approximated policy function (both Dynare and manual)
T = options_.periods;
% use same shocks as in Dynare (those are randomly drawn from the standard
% normal distribution and multiplied with the cholesky decomposition of the
% covariance matrix)
u = oo_.exo_simul;
% initialize simulation vectors for true policy function
a_true_sim = zeros(1,T+1); k_true_sim = zeros(1,T+1); c_true_sim = zeros(1,T+1);
a_true_sim(1) = y_bar(2); k_true_sim(1) = y_bar(1); c_true_sim(1) = y_bar(3);
% initialize simulation vector for manually approximated policy function
y_approx_sim_m = zeros(MODEL.endo_nbr,T+1);
y_approx_sim_m(:,1) = y_bar;
% initialize simulation vector for replicating exactly Dynare's computations
yhat_approx_sim_d = zeros(MODEL.endo_nbr,T+1); % in deviation from steady-state
ghu_u_d = oo_.dr.ghu * transpose(u);
% do simulation
for t = 2:(T+1)
    % using true policy functions
    a_true_sim(t) = a_true_sim(t-1)^RHO * exp(u(t-1,1));
    k_true_sim(t) = ALPHA*BETA*a_true_sim(t-1)^RHO*k_true_sim(t-1)^ALPHA*exp(u(t-1,1));
    c_true_sim(t) = (1-ALPHA*BETA)*a_true_sim(t-1)^RHO*k_true_sim(t-1)^ALPHA*exp(u(t-1,1));
    % using manually approximated policy function
    y_approx_sim_m(:,t) = y_bar + RESULTS.dr.ghx * (y_approx_sim_m(idx_states,t-1)-x_bar) + RESULTS.dr.ghu * u(t-1,1);
    % using Dynare's policy function, as in simult_.m
    yhat_approx_sim_d(:,t) = oo_.dr.ghx * yhat_approx_sim_d(idx_states,t-1) + ghu_u_d(:,t-1);
end
y_approx_sim_d = bsxfun(@plus,yhat_approx_sim_d,y_bar); % to be equivalent to Dynare's simult_.m
% eliminate first period
a_true_sim = a_true_sim(2:end); k_true_sim = k_true_sim(2:end); c_true_sim = c_true_sim(2:end);
y_approx_sim_m = y_approx_sim_m(:,2:end);
y_approx_sim_d = y_approx_sim_d(:,2:end);

% compare to Dynare (see simult_.m)
isequal( y_approx_sim_d(1,:) , oo_.endo_simul(3,:) )
isequal( y_approx_sim_d(2,:) , oo_.endo_simul(2,:) )
isequal( y_approx_sim_d(3,:) , oo_.endo_simul(1,:) )
norm( y_approx_sim_m(1,:) - oo_.endo_simul(3,:))
norm( y_approx_sim_m(2,:) - oo_.endo_simul(2,:))
norm( y_approx_sim_m(3,:) - oo_.endo_simul(1,:))

% plot simulated time series
figure(name='Simulated Time Series');
% note that we plot dev from steady-state
subplot(3,1,1);
    hold on;
    plot(1:T,oo_.endo_simul(3,:));
    plot(1:T,k_true_sim,'-*');
    title('Capital')
    legend(["approx","true"])
    hold off;
    set(gca,'FontSize',16);
subplot(3,1,2);
    hold on;
    plot(1:T,oo_.endo_simul(2,:));
    plot(1:T,a_true_sim,'-*');
    title('Total Factor Productivity')
    legend(["approx","true"])
    hold off;
    set(gca,'FontSize',16);
subplot(3,1,3);
    hold on;
    plot(1:T,oo_.endo_simul(1,:));
    plot(1:T,c_true_sim,'-*');
    title('Consumption')
    legend(["approx","true"])
    hold off;
    set(gca,'FontSize',16);