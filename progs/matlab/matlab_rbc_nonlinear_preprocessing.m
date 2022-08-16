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
for j = 1:length(endo_names)
    syms(sym(strcat(endo_names(j), '_back')))
    syms(sym(strcat(endo_names(j), '_curr')))
    syms(sym(strcat(endo_names(j), '_fwrd')))
    syms(sym(strcat(endo_names(j), '_stst')))
end

% declare exogenous variables as symbolic
for j = 1:length(exo_names)
    syms(sym(strcat(exo_names(j))))
end

% declare parameters as symbolic
for j = 1:length(param_names)
    syms(sym(strcat(param_names(j))))
end

%% Model Equations
% intertemporal optimality (Euler)
dynamic_model_eqs(1,1) = GAMA*c_curr^(-1) - BETTA*GAMA*c_fwrd^(-1)*(1-DELT+r_fwrd);
% labor supply
dynamic_model_eqs(2,1) = w_curr + (-PSSI*(1-l_curr)^(-1)) / (GAMA*c_curr^(-1));
% capital accumulation
dynamic_model_eqs(3,1) = k_curr - (1-DELT)*k_back - iv_curr;
% market clearing
dynamic_model_eqs(4,1) = y_curr - c_curr - iv_curr;
% production function
dynamic_model_eqs(5,1) = y_curr - a_curr*k_back^ALPH*l_curr^(1-ALPH);
% labor demand
dynamic_model_eqs(6,1) = w_curr - (1-ALPH)*y_curr/l_curr;
% capital demand
dynamic_model_eqs(7,1) = r_curr - ALPH*y_curr/k_back;
% total factor productivity
dynamic_model_eqs(8,1) = log(a_curr) - RHOA*log(a_back) - eps_a;

if size(dynamic_model_eqs,1) ~= endo_nbr
    error('You need to have as many endogenous variables as model equations.')
end

%% Get dynamic variables, i.e. which variables do we actually use at t-1, t, and t+1

% create lead_lag_incidence matrix for dynamic variables
lead_lag_incidence = zeros(endo_nbr,3);
used_vars = symvar(dynamic_model_eqs);
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
% this might help to understand lead_lag_incidence:
%disp(array2table(lead_lag_incidence','VariableNames',endo_names,'RowNames',{'t-1','t','t+1'}));

% static variables: appear only at curr, but not at back and not at fwrd
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
dynamic_names_no_suffix = [endo_names(lead_lag_incidence(:,1)==1);...
                           endo_names(lead_lag_incidence(:,2)==1);...
                           endo_names(lead_lag_incidence(:,3)==1);...
                          ];
dynamic_vars = sym(dynamic_names);
dynamic_vars_no_suffix = sym(dynamic_names_no_suffix);
exo_vars = sym(exo_names);

% replace ones in lead_lag_incidence by number in dynamic_vars
lead_lag_incidence(lead_lag_incidence==1) = 1:nnz(lead_lag_incidence);
lead_lag_incidence = transpose(lead_lag_incidence); % transpose to make according to Dynare's M_.lead_lag_incidence

% this might help to understand lead_lag_incidence:
%disp(array2table(lead_lag_incidence,'VariableNames',endo_names,'RowNames',{'t-1','t','t+1'}));
%disp(transpose(dynamic_vars))

%% Compute static model equations
static_model_eqs = subs(dynamic_model_eqs,dynamic_vars,dynamic_vars_no_suffix);

%% Compute static Jacobians
static_g1 = jacobian(static_model_eqs,sym(endo_names));

%% Compute dynamic Jacobians
dynamic_g1 = jacobian(dynamic_model_eqs,[dynamic_vars;exo_vars]);


%% Write out to script files
write_out(static_model_eqs, 'rbc_static_resid', 'residual', true, dynamic_names, endo_names, exo_names, param_names);
write_out(static_g1, 'rbc_static_g1', 'g1', true, dynamic_names, endo_names, exo_names, param_names);

write_out(dynamic_model_eqs, 'rbc_dynamic_resid', 'residual', false, dynamic_names, endo_names, exo_names, param_names);
write_out(dynamic_g1, 'rbc_dynamic_g1', 'g1', false, dynamic_names, endo_names, exo_names, param_names);

%% Store to structure
MODEL.endo_names = endo_names;
MODEL.endo_nbr = endo_nbr;
MODEL.exo_names = exo_names;
MODEL.exo_nbr = exo_nbr;
MODEL.lead_lag_incidence = lead_lag_incidence;
MODEL.param_names = param_names;
MODEL.param_nbr = param_nbr;