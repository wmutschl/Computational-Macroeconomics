function MODEL = nk_preprocessing
model_name = "nk";

%% Declarations
endo_names = ["c"; "w"; "pie"; "n"; "R"; "r"; "y"; "div"; "Q"; "mc"; "pstar"; "ptilde"; "s1"; "s2"; "a"; "z"; "nu"; "ahat"; "zhat"; "yhat"; "what"; "nhat"; "piehat_an"; "Rhat_an"; "rhat_an"; "mchat"];
exo_names = ["eps_a"; "eps_z"; "eps_nu"];
param_names = ["BETTA"; "RHO_A"; "RHO_NU"; "RHO_Z"; "SIG"; "VARPHI"; "PHI_PIE"; "PHI_Y"; "EPSI"; "THET"; "PIESTAR"];
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
%marginal utilities
Un_curr = -z_curr*n_curr^VARPHI;
Uc_curr = z_curr*c_curr^(-SIG);
Uc_fwrd = z_fwrd*c_fwrd^(-SIG);
  
%labor supply
dynamic_model_eqs(1,1) = -w_curr - Un_curr/Uc_curr;
%Euler equation
dynamic_model_eqs(2,1) = -Uc_curr + BETTA*Uc_fwrd*r_curr;  
%optimal price setting
dynamic_model_eqs(3,1) = -ptilde_curr*s1_curr + EPSI/(EPSI-1)*s2_curr;  
%optimal price setting auxiliary recursion 1
dynamic_model_eqs(4,1) = -s1_curr + y_curr*Uc_curr + BETTA*THET*pie_fwrd^(EPSI-1)*s1_fwrd;
%optimal price setting auxiliary recursion 2
dynamic_model_eqs(5,1) = -s2_curr + mc_curr*y_curr*Uc_curr + BETTA*THET*pie_fwrd^EPSI*s2_fwrd;    
%law of motion for optimal reset price
dynamic_model_eqs(6,1) = -1 + THET*pie_curr^(EPSI-1)+(1-THET)*ptilde_curr^(1-EPSI);  
%marginal costs / labor demand
dynamic_model_eqs(7,1) = -mc_curr  + w_curr/a_curr;
%real profits
dynamic_model_eqs(8,1) = -div_curr + y_curr -w_curr*n_curr;  
%aggregate demand
dynamic_model_eqs(9,1) = -c_curr + y_curr;
%aggregate supply
dynamic_model_eqs(10,1) = -pstar_curr*y_curr + a_curr*n_curr;
%law of motion for price inefficiency distortion
dynamic_model_eqs(11,1) = -pstar_curr + (1-THET)*ptilde_curr^(-EPSI) + THET*pie_curr^EPSI*pstar_back;
%price of a zero-coupon bond
dynamic_model_eqs(12,1) = -Q_curr + 1/R_curr;
%Fisher equation
dynamic_model_eqs(13,1) = -R_curr + r_curr*pie_fwrd;  
%monetary policy rule
dynamic_model_eqs(14,1) = -R_curr + R_stst*(pie_curr/PIESTAR)^PHI_PIE*(y_curr/y_stst)^PHI_Y*exp(nu_curr);
%preference shifter
dynamic_model_eqs(15,1) = -log(z_curr) + RHO_Z*log(z_back) + eps_z;
%technology process
dynamic_model_eqs(16,1) = -log(a_curr) + RHO_A*log(a_back) + eps_a;
%monetary policy shock process
dynamic_model_eqs(17,1) = -nu_curr + RHO_NU*nu_back + eps_nu;
%definition log output (dev. from ss)
dynamic_model_eqs(18,1) = -yhat_curr + log(y_curr) - log(y_stst);  
%definition log real wage (dev. from ss)
dynamic_model_eqs(19,1) = -what_curr + log(w_curr) - log(w_stst);  
%definition log hours worked (dev. from ss)
dynamic_model_eqs(20,1) = -nhat_curr + log(n_curr) - log(n_stst);    
%definition log annualized inflation (dev. from ss)
dynamic_model_eqs(21,1) = -piehat_an_curr + 4*(log(pie_curr)-log(pie_stst));    
%definition log annualized nominal interest rate (dev. from ss)
dynamic_model_eqs(22,1) = -Rhat_an_curr + 4*(log(R_curr)-log(R_stst));  
%definition log annualized real interest rate (dev. from ss)
dynamic_model_eqs(23,1) = -rhat_an_curr + 4*(log(r_curr)-log(r_stst));  
%definition log technology (dev. from ss)
dynamic_model_eqs(24,1) = -ahat_curr + log(a_curr) - log(a_stst);  
%definition log discount factor shifter (dev. from ss)
dynamic_model_eqs(25,1) = -zhat_curr + log(z_curr) - log(z_stst);
%definition log real marginal costs (dev. from ss)
dynamic_model_eqs(26,1) = -mchat_curr + log(mc_curr) - log(mc_stst);

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

%% DR ordering
% static variables: appear only at t, but not at t-1 and not at t+1
idx_static = find(ismember(transpose(lead_lag_incidence>0), [0 1 0],'rows'));
% (purely) predetermined variables: appear at t-1 but not at t+1, possibly at t
idx_pred = find(ismember(transpose(lead_lag_incidence([1 3],:)>0), [1 0],'rows'));
% (purely) predetermined variables: appear at t-1 but not at t+1, possibly at t
idx_fwrd = find(ismember(transpose(lead_lag_incidence([1 3],:)>0), [0 1],'rows'));
% mixed variables: appear at t-1 and t+1, and possibly at t
idx_mixed = find(ismember(transpose(lead_lag_incidence([1 3],:)>0), [1 1],'rows'));
% get indices to quickly convert different orderings
order_var = [idx_static; idx_pred; idx_mixed; idx_fwrd]; % from declaration to DR
[~,inv_order_var] = ismember(transpose(1:endo_nbr),order_var); % from DR to declaration

%% Compute static model equations
static_model_eqs = subs(dynamic_model_eqs,dynamic_vars,dynamic_vars_no_suffix);

%% Compute static Jacobians
static_g1 = jacobian(static_model_eqs,sym(endo_names));

%% Compute dynamic Jacobians
dynamic_g1 = jacobian(dynamic_model_eqs,[dynamic_vars;exo_vars]);
dynamic_g2 = jacobian(dynamic_g1(:),[dynamic_vars;exo_vars]);
dynamic_g2 = reshape(dynamic_g2,endo_nbr,(length(dynamic_vars)+exo_nbr)^2);


%% Write out to script files
write_out(static_model_eqs, "preprocessed_" + model_name + "_static_resid", 'residual', true, dynamic_names, endo_names, exo_names, param_names);
write_out(static_g1, "preprocessed_" + model_name + "_static_g1", 'g1', true, dynamic_names, endo_names, exo_names, param_names);

write_out(dynamic_model_eqs, "preprocessed_" + model_name + "_dynamic_resid", 'residual', false, dynamic_names, endo_names, exo_names, param_names);
write_out(dynamic_g1, "preprocessed_" + model_name + "_dynamic_g1", 'g1', false, dynamic_names, endo_names, exo_names, param_names);
write_out(dynamic_g2, "preprocessed_" + model_name + "_dynamic_g2", 'g2', false, dynamic_names, endo_names, exo_names, param_names);

%% Store to structure
MODEL.model_name = model_name;
MODEL.endo_names = endo_names;
MODEL.endo_nbr = endo_nbr;
MODEL.exo_names = exo_names;
MODEL.exo_nbr = exo_nbr;
MODEL.lead_lag_incidence = lead_lag_incidence;
MODEL.param_names = param_names;
MODEL.param_nbr = param_nbr;
MODEL.order_var = order_var;
MODEL.inv_order_var = inv_order_var;
MODEL.nstatic = length(idx_static);
MODEL.npred = length(idx_pred);
MODEL.nboth = length(idx_mixed);
MODEL.nfwrd = length(idx_fwrd);
MODEL.nspred = MODEL.npred+MODEL.nboth;
MODEL.nsfwrd = MODEL.nfwrd+MODEL.nboth;