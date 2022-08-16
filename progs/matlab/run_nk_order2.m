%% preprocessing
MODEL = nk_preprocessing;

%% calibration
BETTA   = 0.99;
RHO_A   = 0.9;
RHO_Z   = 0.5;
RHO_NU  = 0.4;
SIG     = 1;
VARPHI  = 5;
THET    = 0.75;
EPSI    = 9;
PHI_PIE = 1.5;
PHI_Y   = 0.125;
PIESTAR = 1;

% create numerical params, make sure to have same ordering as in param_names
for j=1:MODEL.param_nbr
    MODEL.params(j,1) = eval(MODEL.param_names(j));
end
MODEL.Sigma_e = [1^2 0 0; 0 0.5^2 0; 0 0 0.25^2];

%% Compute the steady-state in closed-form
z   = 1;
a   = 1;
nu  = 0;
pie = PIESTAR;
ptilde = ( (1-THET*pie^(EPSI-1))/(1-THET) )^(1/(1-EPSI));
mc = (EPSI-1)/EPSI * ptilde * (1-BETTA*THET*pie^EPSI) / (1-BETTA*THET*pie^(EPSI-1)) ;
pstar = (1-THET)/(1-THET*pie^EPSI) * ptilde^(-EPSI);
Q = BETTA/pie;
R = 1/Q;
r = R/pie;
w = mc*a;
n = (w/(a/pstar)^SIG)^(1/(VARPHI+SIG));
y = a*n/pstar;
c = y;
div = y-w*n;
s1 = c^(-SIG)*y/(1-BETTA*THET*pie^(EPSI-1));
s2 = c^(-SIG)*y*mc/(1-BETTA*THET*pie^EPSI);

yhat=0;what=0;nhat=0;piehat_an=0;Rhat_an=0;rhat_an=0;ahat=0;zhat=0;mchat=0;

% store into array, keep same ordering as endo_names
for j=1:MODEL.endo_nbr
    ENDO_STST(j,1) = eval(MODEL.endo_names(j));
end
EXO_STST = zeros(MODEL.exo_nbr,1);
resid = feval("preprocessed_" + MODEL.model_name + "_static_resid",ENDO_STST,EXO_STST,MODEL.params);
if any(resid>1e-8)
    error('steady-state is wrong')
end

clearvars(MODEL.param_names{:},MODEL.endo_names{:},'resid','j'); % remove variables from workspace

%% Compute first-order perturbation approximation
PERT1 = perturbation_solver_order1(MODEL,ENDO_STST,EXO_STST);

%% Compute second-order perturbation approximation
PERT2 = perturbation_solver_order2(MODEL,ENDO_STST,EXO_STST,PERT1);

%% Compare with dynare

load nk_order2_from_dynare

max(max(abs(oo_.dr.ghx - PERT1.gx)))
max(max(abs(oo_.dr.ghu - PERT1.gu)))

max(max(abs(oo_.dr.ghxx - PERT2.gxx)))
max(max(abs(oo_.dr.ghxu - PERT2.gxu)))
max(max(abs(oo_.dr.ghuu - PERT2.guu)))
max(max(abs(oo_.dr.ghs2 - PERT2.gss)))