%% Compute steady-state numerically
clear all;

%% from dynare
oldfolder = cd('../dynare'); % go to folder of rbc_nonlinear.mod
dynare rbc_nonlinear
stst_dyn = oo_.steady_state;
[resid_dyn] = feval([M_.fname,'.static'], stst_dyn, 0, M_.params);
ssq_dyn = sum(resid_dyn.^2);
cd(oldfolder)

%% preprocess model
MODEL = matlab_rbc_nonlinear_preprocessing;

%% calibration
ALPH  = 0.35;
BETTA = 0.99;
DELT  = 0.025;
GAMA  = 1;
PSSI  = 1.6;
RHOA  = 0.9;

% create numerical params, make sure to have same ordering as in param_names
for j=1:MODEL.param_nbr
    MODEL.params(j,1) = eval(MODEL.param_names(j));
end

%% Option : Compute the steady-state completely numerically
exo_vars(1,1) = 0; % shocks are always zero
% create function handles
fun = @(xparam) rbc_static_resid(xparam,exo_vars,MODEL.params);
fun_ssq = @(xparam) sum(rbc_static_resid(xparam,exo_vars,MODEL.params).^2);


% provide initial values in a vector, ordering as in MODEL.param_names
xparam0(1,1) = 1.2;  LB(1,1) = 0; UB(1,1) = 10;% y
xparam0(2,1) = 0.9;  LB(2,1) = 0; UB(2,1) = 10;% c
xparam0(3,1) = 12;   LB(3,1) = 0; UB(3,1) = 20;% k
xparam0(4,1) = 1/3;  LB(4,1) = 0; UB(4,1) = 10;% l
xparam0(5,1) = 1;    LB(5,1) = 0; UB(5,1) = 10;% a
xparam0(6,1) = 0.03; LB(6,1) = 0; UB(6,1) = 10;% r
xparam0(7,1) = 2.25; LB(7,1) = 0; UB(7,1) = 10;% w
xparam0(8,1) = 0.35; LB(8,1) = 0; UB(8,1) = 10;%iv
randomize_initial_values = 1;
if randomize_initial_values
    no_good = 1;
    while no_good
        xparam0 = LB + (UB-LB).*rand(length(xparam0),1);    
        if all(isnan(rbc_static_resid(xparam0,exo_vars,MODEL.params))==0)
            no_good = 0;
        end
    end
end
[stst_n1,resid_n1] = fsolve(fun, xparam0, optimset('Display','iter','TolX',1e-7,'TolFun',1e-7));
ssq_n1 = sum(resid_n1.^2);

[stst_n2,ssq_n2,resid_n2] = lsqnonlin(fun,xparam0,LB,UB,optimset('Display','iter','TolX',1e-7,'TolFun',1e-7));

[stst_n3,ssq_n3] = fminunc(fun_ssq, xparam0, optimset('Display','iter','TolX',1e-7,'TolFun',1e-7));
resid_n3 = rbc_static_resid(stst_n3,exo_vars,MODEL.params);

[stst_n4,ssq_n4] = fminsearch(fun_ssq, xparam0, optimset('Display','iter','TolX',1e-7,'TolFun',1e-7,'MaxFunEvals',10000));
resid_n4 = rbc_static_resid(stst_n4,exo_vars,MODEL.params);

[stst_n5,ssq_n5] = fmincon(fun_ssq, xparam0, [],[],[],[],LB,UB,[],optimset('Display','iter','TolX',1e-7,'TolFun',1e-7,'MaxFunEvals',10000));
resid_n5 = rbc_static_resid(stst_n5,exo_vars,MODEL.params);

[stst_n6,ssq_n6] = simulannealbnd(fun_ssq, xparam0, LB,UB,optimset('Display','iter','TolX',1e-7,'TolFun',1e-7));
resid_n6 = rbc_static_resid(stst_n6,exo_vars,MODEL.params);

[stst_n7,ssq_n7] = patternsearch(fun_ssq, xparam0, [],[],[],[],LB,UB,[],optimset('Display','iter','TolX',1e-7,'TolFun',1e-7,'MaxIter',200000,'MaxFunEvals',300000));
resid_n7 = rbc_static_resid(stst_n7,exo_vars,MODEL.params);


%% Option 2: Compute the steady-state in closed-form (as much as possible)
ea = 0;
a = 1;
MC = 1;
r = 1/BETTA + DELT -1;
K_L = (MC*ALPH*a/r)^(1/(1-ALPH));
w = MC*(1-ALPH)*a*K_L^ALPH;
IV_L = DELT*K_L;
Y_L = a*(K_L)^ALPH;
C_L = Y_L - IV_L;
l = GAMA/PSSI*C_L^(-1)*w/(1+GAMA/PSSI*C_L^(-1)*w);
c  = C_L*l;
y  = Y_L*l;
iv = IV_L*l;
k  = K_L*l;

% store into array, keep same ordering as endo_names
for j=1:MODEL.endo_nbr
    stst_a(j,1) = eval(MODEL.endo_names(j));
end
resid_a = rbc_static_resid(stst_a,exo_vars,MODEL.params);
ssq_a = sum(resid_a.^2);



%% Comparison
format long

fprintf('Compare steady-states:\n')
disp(array2table([stst_a stst_dyn stst_n1 stst_n2 stst_n3 stst_n4 stst_n5 stst_n6 stst_n7],...
                 'VariableNames',{'Analytical','Dynare initval','fsolve','lsqnonlin','fminunc','fminsearch','fmincon','simulannealbnd','patternsearch'},...
                 'RowNames',MODEL.endo_names));

fprintf('Compare residuals:\n')
disp(array2table([[resid_a resid_dyn resid_n1 resid_n2 resid_n3 resid_n4 resid_n5 resid_n6 resid_n7]; ...
                  [ssq_a   ssq_dyn   ssq_n1   ssq_n2   ssq_n3   ssq_n4   ssq_n5   ssq_n6   ssq_n7]],...
            'VariableNames',{'Analytical','Dynare initval','fsolve','lsqnonlin','fminunc','fminsearch','fmincon','simulannealbnd','patternsearch'},...
            'RowNames',[strcat('eq_',num2str(transpose(1:MODEL.endo_nbr)));"Sum Of Squared Residuals"]));
format short


