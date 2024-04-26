function MODEL = Brock_Mirman_preprocessing
% function MODEL = Brock_Mirman_preprocessing
% =========================================================================
% preprocessing of Brock and Mirman (1972) model, i.e. a basic RBC model
% with log-utility (no labor) and full capital depreciation
% using MATLAB's symbolic toolbox
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: June 12, 2023
% =========================================================================

%% symbolic declarations
fname = "BrockMirman";
endo_names = ["c"; "a"; "k"];
exo_names = ["eps_a"];
param_names = ["ALPHA"; "BETA"; "RHO"];
endo_nbr = length(endo_names);
exo_nbr = length(exo_names);
param_nbr = length(param_names);

% declare endogenous variables as symbolic (check in the workspace)
syms(endo_names + "_back")
syms(endo_names + "_curr")
syms(endo_names + "_fwrd")
syms(endo_names + "_stst")

% declare exogenous variables as symbolic (check in the workspace)
syms(exo_names);

% declare parameters as symbolic (check in the workspace)
try
    syms(param_names); % depending if name of parameter is builtin MATLAB command this won't work in a function
catch
    for jp=1:length(param_names)
        eval(sprintf('%s = sym(''%s'');',param_names(jp),param_names(jp)));
    end
end

%% symbolic model equations
% intertemporal optimality (Euler)
dynamic_eqs(1,1) = -c_curr^(-1) + ALPHA*BETA*c_fwrd^(-1)*a_fwrd*k_curr^(ALPHA-1);
% capital accumulation
dynamic_eqs(2,1) = -k_curr + a_curr*k_back^ALPHA - c_curr;
% total factor productivity
dynamic_eqs(3,1) = -log(a_curr) + RHO*log(a_back) + eps_a;

if size(dynamic_eqs,1) ~= endo_nbr
    error('You need to have as many endogenous variables as model equations.')
end

%% create lead_lag_incidence matrix for dynamic variables
lead_lag_incidence = zeros(3,endo_nbr);
used_vars = symvar(dynamic_eqs); % get names of used variables
idx = 1;
for j=1:endo_nbr % check which t-1 variables appear in model equations
    if any(has(used_vars, endo_names(j) + "_back"))
        lead_lag_incidence(1,j) = idx; idx = idx+1;
    end
end
for j=1:endo_nbr % check which t variables appear in model equations
    if any(has(used_vars, endo_names(j) + "_curr"))
        lead_lag_incidence(2,j) = idx; idx = idx+1;
    end
end
for j=1:endo_nbr % check which t+1 variables appear in model equations
    if any(has(used_vars, endo_names(j) + "_fwrd"))
        lead_lag_incidence(3,j) = idx; idx = idx+1;
    end
end
% this might help to understand lead_lag_incidence:
%disp(array2table(lead_lag_incidence,'VariableNames',endo_names,'RowNames',{'t-1','t','t+1'}));

%% distinguish different types of variables
% static variables: appear only at curr, but not at back and not at fwrd
endo_static_names = endo_names(ismember(transpose(lead_lag_incidence~=0), [0 1 0],'rows'));
% (purely) predetermined variables: appear at back but not at fwrd, possibly at curr
endo_pred_names  = endo_names(ismember(transpose(lead_lag_incidence([1 3],:)~=0), [1 0],'rows'));
% (purely) forward looking variables: appear at fwrd but not at back, possibly at curr
endo_fwrd_names  = endo_names(ismember(transpose(lead_lag_incidence([1 3],:)~=0), [0 1],'rows'));
% mixed variables: appear at back and fwrd, and possibly at curr
endo_mixed_names = endo_names(ismember(transpose(lead_lag_incidence([1 3],:)~=0), [1 1],'rows'));

dynamic_names = [endo_names(lead_lag_incidence(1,:)~=0) + "_back";...
                 endo_names(lead_lag_incidence(2,:)~=0) + "_curr";...
                 endo_names(lead_lag_incidence(3,:)~=0) + "_fwrd";...
                ]; % note that this has the same ordering as the lead_lag_incidence matrix

%% compute dynamic Jacobians
dynamic_vars = sym(dynamic_names);
exo_vars = sym(exo_names);
dynamic_g1 = jacobian(dynamic_eqs,[dynamic_vars;exo_vars]);

%% compute static model equations
endo_vars = sym(endo_names);
dynamic_vars_no_timing = sym(erase(dynamic_names, ["_back", "_curr", "_fwrd"]));
static_eqs = subs(dynamic_eqs,dynamic_vars,dynamic_vars_no_timing); % substitute all dynamic variables
static_eqs = subs(static_eqs,sym(endo_names + "_stst"),endo_vars); % substitute all auxiliary steady-state expressions _stst

%% compute static Jacobian
static_g1 = jacobian(static_eqs,endo_vars);

%% write out to script files
writeOut(static_eqs,fname+"_static_resid",'residual',1,dynamic_names,endo_names,exo_names,param_names);
writeOut(static_g1,fname+"_static_g1",'g1',1,dynamic_names,endo_names,exo_names,param_names);
writeOut(dynamic_eqs,fname+"_dynamic_resid",'residual',0,dynamic_names,endo_names,exo_names,param_names);
writeOut(dynamic_g1,fname+"_dynamic_g1",'g1',0,dynamic_names,endo_names,exo_names,param_names);

%% store to structure
MODEL.fname = fname;
MODEL.endo_names = endo_names;
MODEL.endo_nbr = endo_nbr;
MODEL.nstatic = length(endo_static_names);
MODEL.npred = length(endo_pred_names);
MODEL.nboth = length(endo_mixed_names);
MODEL.nfwrd = length(endo_fwrd_names);
MODEL.nspred = MODEL.npred+MODEL.nboth;
MODEL.nsfwrd = MODEL.nboth+MODEL.nfwrd;
MODEL.exo_names = exo_names;
MODEL.exo_nbr = exo_nbr;
MODEL.lead_lag_incidence = lead_lag_incidence;
MODEL.param_names = param_names;
MODEL.param_nbr = param_nbr;

[~,MODEL.order_var] = ismember(endo_names,[endo_static_names; endo_pred_names; endo_mixed_names; endo_fwrd_names]);