%% Understand perfect_foresight_setup (e.g.run these codes after nk_zlb_det.mod)
% initialize endo_simul at steady-state
endo_simul = repmat(oo_.steady_state, 1, M_.maximum_lag+options_.periods+M_.maximum_lead); % M_.endo_nbr x (options_.periods+M_.maximum_lag+M_.maximum_lead)
% initialize exo_simul at steady-state
exo_simul = repmat(oo_.exo_steady_state',M_.maximum_lag+options_.periods+M_.maximum_lead,1); % (options_.periods+M_.maximum_lag+M_.maximum_lead) x M_.exo_nbr
% add positive productivity shock in period 1 of one standard deviation of 0.08
exo_simul(M_.maximum_lag+1,ismember(M_.exo_names,'eta_a')) = 0.08; % e.g.for nk_zlb_det.mod

%% Understand perfect_foresight_solver
ny = M_.endo_nbr;
nu = M_.exo_nbr;
y_init = endo_simul(:, M_.maximum_lag);
y_end = endo_simul(:, M_.maximum_lag+options_.periods+1);
Y = reshape(endo_simul(:, M_.maximum_lag+(1:options_.periods)), M_.endo_nbr*options_.periods, 1); % Y has only values for t=1,...,options_.periods (no init and end value)
for iter = 1:options_.simul.maxit
    dF = zeros(ny*options_.periods,ny*options_.periods); % dF is the stacked Jacobian with period x equations alongs the rows and periods times variables (in declaration order) along the columns
    F = zeros(ny*options_.periods,1); % F is the stacked vector of model residuals with period x equations alongs the rows
    for t=1:options_.periods
        u_curr = exo_simul(t+1,:);
        if t==1
            y_back = y_init; % y_{0}
            y_curr = Y(1:ny,1); % y_{1}
            y_fwrd = Y(ny + (1:ny),1); % y_{2}
        elseif t==options_.periods
            y_back = y_curr; % y_{t-1}
            y_curr = y_fwrd; % y_{t}
            y_fwrd = y_end;  % y_{t+1}
        else
            y_back = y_curr; % y_{T-1}
            y_curr = y_fwrd; % y_{T}
            y_fwrd = Y(ny*t + (1:ny),1); % y_{T+1}
        end
        % Note that g1 in the dynamic script file does not contain derivatives
        % for all y_{t-1}, y_{t}, and y_{t+1}, but only for those variables 
        % that actually appear at a certain time period, i.e. for
        %   - previous state variables (predetermined and mixed)
        %   - variables that actually appear at t
        %   - forward jumper variables (mixed and forward)
        % This information is encoded in in the lead_lag_incidence matrix
        yyy = [y_back(M_.lead_lag_incidence(1,:)~=0);
               y_curr(M_.lead_lag_incidence(2,:)~=0);
               y_fwrd(M_.lead_lag_incidence(3,:)~=0);
              ];        
        [res, g1] = feval([M_.fname,'.dynamic'], yyy, u_curr, M_.params, oo_.steady_state, 1);
        % Newton algorithm, however, requires the Jacobian for all y_{t-1}, y_{t}, and y_{t+1},
        % so we simply initialize the A, B, C submatrices with zeros and fill them accordingly
        At = zeros(ny,ny);
        Bt = zeros(ny,ny);
        Ct = zeros(ny,ny);
        At(:,M_.lead_lag_incidence(1,:)~=0) = g1(:,nonzeros(M_.lead_lag_incidence(1,:)));
        Bt(:,M_.lead_lag_incidence(2,:)~=0) = g1(:,nonzeros(M_.lead_lag_incidence(2,:)));
        Ct(:,M_.lead_lag_incidence(3,:)~=0) = g1(:,nonzeros(M_.lead_lag_incidence(3,:)));
        % create stacked Jacobian, first and last period are special
        if t==1
            dF(1:ny,1:ny*2) = [Bt Ct];
        elseif t==options_.periods            
            dF((t-1)*ny+(1:ny),(t-2)*ny*1+(1:ny*2)) = [At Bt];
        else
            dF((t-1)*ny+(1:ny),(t-2)*ny*1+(1:ny*3)) = [At Bt Ct];
        end
        F((t-1)*ny+(1:ny),1) = res;        
    end
    % make it sparse (try running and timing it without sparse to see the difference!)
    F = sparse(F);
    dF = sparse(dF);
    % this is Dynare's function which is written in C++ (and included into MATLAB as a compiled MEX)
    [dyn_F, dyn_dF] = perfect_foresight_problem(Y, y_init, y_end, exo_simul, M_.params, oo_.steady_state, options_.periods, M_, options_);
    if ~isequal(dF,dyn_dF) || ~isequal(F,dyn_F)
        error('not equal to Dynare')
    end
    err = max(abs(F));
    if err < options_.dynatol.f
        break
    end
    DY = -(dF\F);
    DY(~isfinite(DY)) = 0; % a bit more robust
    Y = Y + DY;
end
endo_simul(:, M_.maximum_lag+(1:options_.periods)) = reshape(Y, M_.endo_nbr, options_.periods);
hold on;
plot(0:(options_.periods+1),endo_simul(ismember(M_.endo_names,'r'),:),'*');
legend({'Dynare','Manual'})