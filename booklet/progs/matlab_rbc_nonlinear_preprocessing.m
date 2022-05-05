%% Basic Real Business Cycle Model
function MODEL = matlab_rbc_nonlinear_preprocessing

%% Declarations
endo_names = ["y"; "c"; "k"; "l"; "a"; "r"; "w"; "iv"];
exo_names = ["eps_a"];
param_names = ["BETTA"; "DELT"; "GAMA"; "PSSI"; "ALPH"; "RHOA"];
endo_nbr = length(endo_names);
exo_nbr = length(exo_names);
param_nbr = length(param_names);

% declare endogenous variables as symbolic
syms y_stst   y_back  y_curr  y_fwrd   'real'; % output
syms c_stst   c_back  c_curr  c_fwrd   'real'; % consumption
syms k_stst   k_back  k_curr  k_fwrd   'real'; % capital
syms l_stst   l_back  l_curr  l_fwrd   'real'; % labor
syms a_stst   a_back  a_curr  a_fwrd   'real'; % productivity
syms r_stst   r_back  r_curr  r_fwrd   'real'; % interest Rate
syms w_stst   w_back  w_curr  w_fwrd   'real'; % wage
syms iv_stst iv_back iv_curr iv_fwrd   'real'; % investment

% declare exogenous variables as symbolic
syms eps_a   'real'; % productivity innovation

% declare parameters as symbolic
syms BETTA   'real'; % discount factor
syms DELT    'real'; % depreciation rate
syms GAMA    'real'; % consumption utility weight
syms PSSI    'real'; % labor disutility weight')
syms ALPH    'real'; % output elasticity of capital
syms RHOA    'real'; % persistence technology process

%% Model Equations

%auxiliary: marginal utilities
uc_curr = GAMA*c_curr^(-1);
uc_fwrd = GAMA*c_fwrd^(-1);
ul_curr = -PSSI*(1-l_curr)^(-1);

%auxiliary: marginal products of production
fk_curr = ALPH*y_curr/k_back;
fl_curr = (1-ALPH)*y_curr/l_curr;

%auxiliary:marginal costs
MC=1;

% intertemporal optimality (Euler)
model_eqs(1,1) = uc_curr - BETTA*uc_fwrd*(1-DELT+r_fwrd);
% labor supply
model_eqs(2,1) = w_curr + ul_curr/uc_curr;
% capital accumulation
model_eqs(3,1) = k_curr - (1-DELT)*k_back - iv_curr;
% market clearing
model_eqs(4,1) = y_curr - c_curr - iv_curr;
% production function
model_eqs(5,1) = y_curr - a_curr*k_back^ALPH*l_curr^(1-ALPH);
% labor demand
model_eqs(6,1) = w_curr - MC*fl_curr;
% capital demand
model_eqs(7,1) = r_curr - MC*fk_curr;
% total factor productivity
model_eqs(8,1) = log(a_curr) - RHOA*log(a_back) - eps_a;

if size(model_eqs,1) ~= endo_nbr
    error('You need to have as many endogenous variables as model equations.')
end

%% Get dynamic variables, i.e. which variables do we actually use at t-1, t, and t+1

% create lead_lag_incidence matrix for dynamic variables
lead_lag_incidence = zeros(endo_nbr,3);
used_vars = symvar(model_eqs);
for j=1:endo_nbr
    if any(has(used_vars, sym(strcat(endo_names(j),'_back'))))
        lead_lag_incidence(j,1) = 1;
    end
    if any(has(used_vars, sym(strcat(endo_names(j),'_curr'))))
        lead_lag_incidence(j,2) = 1;
    end
    if any(has(used_vars, sym(strcat(endo_names(j),'_fwrd'))))
        lead_lag_incidence(j,3) = 1;
    end
end
disp(array2table(lead_lag_incidence','VariableNames',endo_names,'RowNames',{'t-1','t','t+1'}));
% static variables: appear only at curr, but not at back and not at curr
endo_static_names = endo_names(ismember(lead_lag_incidence, [0 1 0],'rows'));
% (purely) predetermined variables: appear at back but not at fwrd, possibly at curr
endo_pred_names = endo_names(ismember(lead_lag_incidence(:,[1 3]), [1 0],'rows'));
% (purely) forward looking variables: appear at fwrd but not at back, possibly at curr
endo_fwrd_names = endo_names(ismember(lead_lag_incidence(:,[1 3]), [0 1],'rows'));
% mixed variables: appear at back and fwrd, and possibly at curr
endo_mixed_names = endo_names(ismember(lead_lag_incidence(:,[1 3]), [1 1],'rows'));

dynamic_names = [strcat(endo_names(lead_lag_incidence(:,1)==1),'_back');...
                 strcat(endo_names(lead_lag_incidence(:,2)==1),'_curr');...
                 strcat(endo_names(lead_lag_incidence(:,3)==1),'_fwrd');...
                ];
dynamic_stst_names = [strcat(endo_names(lead_lag_incidence(:,1)==1),'_stst');...
                      strcat(endo_names(lead_lag_incidence(:,2)==1),'_stst');...
                      strcat(endo_names(lead_lag_incidence(:,3)==1),'_stst');...
                     ];
dynamic_vars = sym(dynamic_names,'real');
dynamic_vars_stst = sym(dynamic_stst_names,'real');
exo_vars = sym(exo_names,'real');

% replace ones in lead_lag_incidence by number in dynamic_vars
lead_lag_incidence(lead_lag_incidence==1) = 1:nnz(lead_lag_incidence);
lead_lag_incidence = transpose(lead_lag_incidence); % transpose to make according to Dynare's M_.lead_lag_incidence
disp(array2table(lead_lag_incidence,'VariableNames',endo_names,'RowNames',{'t-1','t','t+1'}));
disp(transpose(dynamic_vars))

%% Compute static model equations
model_eqs_static = subs(model_eqs,dynamic_vars,dynamic_vars_stst);

%% Compute static Jacobians
endo_stst = sym(strcat(endo_names,'_stst'),'real');
static_g1 = jacobian(model_eqs_static,endo_stst);

%% Compute dynamic Jacobians
dyn_exo_nbr = length([dynamic_vars;exo_vars]);
dynamic_g1 = jacobian(model_eqs,[dynamic_vars;exo_vars]);
dynamic_g2 = jacobian(vec(dynamic_g1),[dynamic_vars;exo_vars]);
dynamic_g2 = reshape(dynamic_g2,endo_nbr,dyn_exo_nbr^2); % dynare ordering
for j = 1:endo_nbr
    dynamic_g3(j,:) = vec(transpose(jacobian(dynamic_g2(j,:),[dynamic_vars;exo_vars])));%dynare ordering
end


%% Write out to script files
write_out(model_eqs_static, 'rbc_static_resid', 'residual', true, dynamic_names, endo_names, exo_names, param_names);
write_out(static_g1, 'rbc_static_g1', 'g1', true, dynamic_names, endo_names, exo_names, param_names);

write_out(model_eqs, 'rbc_dynamic_resid', 'residual', false, dynamic_names, endo_names, exo_names, param_names);
write_out(dynamic_g1, 'rbc_dynamic_g1', 'g1', false, dynamic_names, endo_names, exo_names, param_names);
write_out(dynamic_g2, 'rbc_dynamic_g2', 'g2', false, dynamic_names, endo_names, exo_names, param_names);
write_out(dynamic_g3, 'rbc_dynamic_g3', 'g3', false, dynamic_names, endo_names, exo_names, param_names);

%% Store to structure
MODEL.endo_names = endo_names;
MODEL.endo_nbr = endo_nbr;
MODEL.exo_names = exo_names;
MODEL.exo_nbr = exo_nbr;
MODEL.lead_lag_incidence = lead_lag_incidence;
MODEL.param_names = param_names;
MODEL.param_nbr = param_nbr;
%% from dynare
% dynare rbc_nonlinear notmpterms
% [I,~]     = find(M_.lead_lag_incidence');
% ys        = oo_.dr.ys;    % steady state of endogenous variables in DR order
% yy0       = oo_.dr.ys(I); % steady state of dynamic model variables [y^*(-1), y, y^**(+1)]
% ex0       = oo_.exo_steady_state'; % steady state of exogenous variables u
% 
% % get dynamic model derivatives from files
% [resid, g1, g2, g3] = feval([M_.fname,'.dynamic'], yy0, ex0, M_.params, ys, 1);
% g3 = unfold_g3(g3, length(yy0)+length(ex0)); %need to unfold as g3 stores only symmetric elements
% 
% [resid_s, g1_s] = feval([M_.fname,'.static'], ys, ex0, M_.params);
% 
% gg1 = full(rbc_dynamic_g1(yy0,ex0,M_.params,ys));
% gg2 = full(rbc_dynamic_g2(yy0,ex0,M_.params,ys));
% gg3 = full(rbc_dynamic_g3(yy0,ex0,M_.params,ys));
% gg1_s = full(rbc_static_g1(ys,ex0,M_.params));
% 
% 
% norm(g1 - gg1,'Inf')
% norm(g2 - gg2,'Inf')
% norm(g3 - gg3,'Inf')
% norm(g1_s - gg1_s,'Inf')
