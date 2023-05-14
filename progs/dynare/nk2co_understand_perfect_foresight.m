% =========================================================================
% illustrates Dynare's deterministic simulation method, i.e.
% perfect_foresight_setup and perfect_foresight_solver;
% also re-implements the Newton-type algorithm, based on the sparse Jacobian
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: May 10, 2023
% =========================================================================

%% houskeeping
clear all;

%% run mod file in dynare and store some objects from mod file
dynare nk2co_perm_tax_announced.mod;
% note that in the mod file the following variables are created:
% - taxval:            value of increase in exogenous tax shock
% - ys0:               initial steady-state
% - ys1:               terminal steady-state
% - endo_simul_init:   initial value for Newton including information of initval and endval blocks
% - exo_simul_init:    initial value for Newton including information of shocks block
ny = M_.endo_nbr;
nu = M_.exo_nbr;
T = options_.periods;

%% manually create initial matrices endo_simul and exo_simul and compare to Dynare
% since we have an endval block in the mod file, Dynare initializes endo_simul at terminal steady-state, so let's do the same
% if you are using a different mod file, this section needs to be adjusted

endo_simul = repmat(ys1, 1, 1+T+1);
% first period in endo_simul, however, is initialized at initial steady-state (initval block)
endo_simul(:,1)= ys0;

% initialize exo_simul with zero matrix
exo_simul = zeros(1+T+1, nu);
% after period 5 change tax shock to new value
exo_simul(1+5+1:end, ismember(M_.exo_names,'eps_tauH')) = taxval;

% check whether initial values are equal to the one's created by Dynare
if ~isequal(endo_simul,endo_simul_init); error('Manually created initial value matrix for endogenous variables is not equal to the initial values created by Dynare.'); end
if ~isequal(exo_simul,exo_simul_init);   error('Manually created initial value matrix for exogenous variables is not equal to the initial values created by Dynare.'); end

%% Perfect Foresight Algorithm
% this is generic, no adjustment needed if different mod file is used
y_init = endo_simul(:, 1);
y_end  = endo_simul(:, 1+T+1);
Y = reshape(endo_simul(:, 1+(1:T)), ny*T, 1); % Y has only values for t=1,...,T (no init and end value)
for iter = 1:options_.simul.maxit
    F = zeros(ny*T,1);     % F is the stacked vector of model residuals with (periods x equations) along the rows
    dF = zeros(ny*T,ny*T); % dF is the stacked Jacobian with (periods x equations) along the rows and (periods x variables) along the columns (variables in declaration order)
    for t=1:T
        % get values for shocks and variables to evaluate dynamic model residuals and Jacobian
        u_curr = exo_simul(t+1,:); % u_{t}
        if t==1
            y_back = y_init;           % y_{0}
            y_curr = Y(1:ny,1);        % y_{1}
            y_fwrd = Y(ny + (1:ny),1); % y_{2}
        elseif t==T
            y_back = y_curr; % y_{T-1}
            y_curr = y_fwrd; % y_{T}
            y_fwrd = y_end;  % y_{T+1}
        else
            y_back = y_curr;             % y_{t-1}
            y_curr = y_fwrd;             % y_{t}
            y_fwrd = Y(ny*t + (1:ny),1); % y_{t+1}
        end
        % Note that the dynamic Jacobian (g1) in the dynamic script file
        % does not contain derivatives for all y_{t-1}, y_{t}, and y_{t+1},
        % but only for those variables that actually appear at a certain
        % time period, i.e. for
        %   - previous state variables (predetermined and mixed) y^*_{t-1}
        %   - variables that actually appear at t: y_{t}
        %   - forward jumper variables (mixed and forward): y^{**}_{t+1}
        %   - exogenous variables at t: u_{t≠
        % the information on the columns is encoded in in the lead_lag_incidence matrix
        % disp(array2table(M_.lead_lag_incidence,'VariableNames',M_.endo_names,'RowNames',{'t-1','t','t+1'}));
        
        % create vector of dynamic variables [y^*_{t-1}', y_t', y^{**}_{t+1}']' to evaluate the dynamic script files
        yyy = [y_back(M_.lead_lag_incidence(1,:)~=0);
               y_curr(M_.lead_lag_incidence(2,:)~=0);
               y_fwrd(M_.lead_lag_incidence(3,:)~=0);
              ];
        [res, g1] = feval([M_.fname,'.dynamic'], yyy, u_curr, M_.params, oo_.steady_state, 1);
        
        % Newton algorithm, however, requires the Jacobian for all [y_{t-1}', y_{t}', y_{t+1}']',
        % so we initialize the A, B, C submatrices with zeros and fill them
        % according to the lead_lag_incidence matrix
        At = zeros(ny,ny);  At(:,M_.lead_lag_incidence(1,:)~=0) = g1(:,nonzeros(M_.lead_lag_incidence(1,:)));
        Bt = zeros(ny,ny);  Bt(:,M_.lead_lag_incidence(2,:)~=0) = g1(:,nonzeros(M_.lead_lag_incidence(2,:)));
        Ct = zeros(ny,ny);  Ct(:,M_.lead_lag_incidence(3,:)~=0) = g1(:,nonzeros(M_.lead_lag_incidence(3,:)));
        
        % create stacked Jacobian, first and last period are special
        if t==1
            dF(1:ny,1:ny*2) = [Bt Ct];
        elseif t==T            
            dF((t-1)*ny+(1:ny),(t-2)*ny*1+(1:ny*2)) = [At Bt];
        else
            dF((t-1)*ny+(1:ny),(t-2)*ny*1+(1:ny*3)) = [At Bt Ct];
        end
        
        % store residuals into stacked vector
        F((t-1)*ny+(1:ny),1) = res;
    end
    % make matrices sparse
    F = sparse(F);
    dF = sparse(dF);
    % for comparison: this is Dynare's function which is written in C++ (and included into MATLAB as a compiled MEX)
    [dyn_F, dyn_dF] = perfect_foresight_problem(Y, y_init, y_end, exo_simul, M_.params, oo_.steady_state, T, M_, options_);
    if ~isequal(dF,dyn_dF) || ~isequal(F,dyn_F)
        error('not equal to Dynare')
    end
    
    % termination criteria on function value
    if max(abs(F)) < options_.dynatol.f
        break % stop Newton iterations as we found a solution
    end
    
    % compute Newton step and update guess value for next iteration of Newton algorithm
    DY = -(dF\F);
    %DY(~isfinite(DY)) = 0; % a bit more robust
    Y = Y + DY;
    
    % termination criteria on function argument
    if max(abs(DY)) < options_.dynatol.x
        break % stop Newton iterations as we found a solution
    end
end

% back out endo_simul from Y
endo_simul(:, 1+(1:T)) = reshape(Y, ny, T);

% check whether solution is the same as the one computed by Dynare
if isequal(oo_.endo_simul,endo_simul)
    fprintf('Solution is the same!\n')
else
    error('Solution is not the same!')
end