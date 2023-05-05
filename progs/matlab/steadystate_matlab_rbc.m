% =========================================================================
% comparison of computing steady-state in Dynare or in MATLAB of basic RBC model
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: May 5, 2023
% =========================================================================

clear all;

%% analytical steady-state and residuals from Dynare
oldfolder = cd('../dynare'); % go to folder of rbc.mod
dynare rbc
stst_dynare = oo_.steady_state; % store steady-state computed with Dynare
params = M_.params; % store parameters
param_names = M_.param_names; % store names of parameters
[resid_dynare] = feval([M_.fname,'.static'], stst_dynare, 0, M_.params); % evaluate residuals of static model
ssq_dynare = sum(resid_dynare.^2); % compute sum of squared residuals of static model
cd(oldfolder)
clearvars -except stst_dynare resid_dynare ssq_dynare params param_names

%% preprocess model in MATLAB
MODEL = preprocessing_matlab_rbc;

%% calibration (use same as in Dynare)
% create params field in MODEL structure with numerical vales, make sure to have same ordering as in MODEL.param_names
for j=1:MODEL.param_nbr
    MODEL.params(j,1) = params(param_names==MODEL.param_names(j));
end
fprintf('Calibration:\n')
disp(array2table(MODEL.params','VariableNames',MODEL.param_names));

%% compute steady-state completely numerically in MATLAB using different optimizers
exo_stst = zeros(MODEL.exo_nbr,1); % shocks are always zero
% create function handle
obj     = @(xparam)     rbc_static_resid(xparam,exo_stst,MODEL.params)    ; % for vector-valued optimizers we minimize each static model equation
obj_ssq = @(xparam) sum(rbc_static_resid(xparam,exo_stst,MODEL.params).^2); % for scalar optimizers we minimize sum of squared residuals of static model equations

% provide initial values in a vector, ordering as in MODEL.param_names
xparam0 = zeros(MODEL.endo_nbr,1);
xparam0(MODEL.endo_names=="y",1)  = 1.2;
xparam0(MODEL.endo_names=="c",1)  = 0.9;
xparam0(MODEL.endo_names=="k",1)  = 12;
xparam0(MODEL.endo_names=="n",1)  = 1/3;
xparam0(MODEL.endo_names=="a",1)  = 1;
xparam0(MODEL.endo_names=="r",1)  = 0.03;
xparam0(MODEL.endo_names=="w",1)  = 2.25;
xparam0(MODEL.endo_names=="iv",1) = 0.35;
LB = zeros(MODEL.endo_nbr,1);     % lower bound
UB = repmat(20,MODEL.endo_nbr,1); % upper bound

randomize_initial_values = 1; % set to 1 to randomize initial values
if randomize_initial_values
    no_good = 1;
    while no_good
        xparam0 = LB + (UB-LB).*rand(length(xparam0),1);    
        if all(~isnan(obj(xparam0)))
            no_good = 0;
        end
    end
end

% find steady-state with fsolve
[stst_fsolve,resid_fsolve] = fsolve(obj, xparam0, optimset('Display','iter','TolX',1e-7,'TolFun',1e-7));
ssq_fsolve = sum(resid_fsolve.^2);
% find steady-state with lsqnonlin
[stst_lsqnonlin,ssq_lsqnonlin,resid_lsqnonlin] = lsqnonlin(obj,xparam0,LB,UB,optimset('Display','iter','TolX',1e-7,'TolFun',1e-7));
% find steady-state with fminunc
[stst_fminunc,ssq_fminunc] = fminunc(obj_ssq, xparam0, optimset('Display','iter','TolX',1e-7,'TolFun',1e-7));
resid_fminunc = rbc_static_resid(stst_fminunc,exo_stst,MODEL.params);
% find steady-state with fminsearch
[stst_fminsearch,ssq_fminsearch] = fminsearch(obj_ssq, xparam0, optimset('Display','iter','TolX',1e-7,'TolFun',1e-7,'MaxFunEvals',10000));
resid_fminsearch = rbc_static_resid(stst_fminsearch,exo_stst,MODEL.params);
% find steady-state with fmincon
[stst_fmincon,ssq_fmincon] = fmincon(obj_ssq, xparam0, [],[],[],[],LB,UB,[],optimset('Display','iter','TolX',1e-7,'TolFun',1e-7,'MaxFunEvals',10000));
resid_fmincon = rbc_static_resid(stst_fmincon,exo_stst,MODEL.params);
% find steady-state with simulannealbnd
[stst_simulannealbnd,ssq_simulannealbnd] = simulannealbnd(obj_ssq, xparam0, LB,UB,optimset('Display','iter','TolX',1e-7,'TolFun',1e-7));
resid_simulannealbnd = rbc_static_resid(stst_simulannealbnd,exo_stst,MODEL.params);
% find steady-state with patternsearch
[stst_patternsearch,ssq_patternsearch] = patternsearch(obj_ssq, xparam0, [],[],[],[],LB,UB,[],optimset('Display','iter','TolX',1e-7,'TolFun',1e-7,'MaxIter',200000,'MaxFunEvals',300000));
resid_patternsearch = rbc_static_resid(stst_patternsearch,exo_stst,MODEL.params);

%% Comparison
fprintf('Compare steady-states:\n')
disp(array2table([stst_dynare stst_fsolve stst_lsqnonlin stst_fminunc stst_fminsearch stst_fmincon stst_simulannealbnd stst_patternsearch],...
                 'VariableNames',{'Dynare analytical','fsolve','lsqnonlin','fminunc','fminsearch','fmincon','simulannealbnd','patternsearch'},...
                 'RowNames',MODEL.endo_names));

fprintf('Compare residuals:\n')
disp(array2table([[resid_dynare resid_fsolve resid_lsqnonlin resid_fminunc resid_fminsearch resid_fmincon resid_simulannealbnd resid_patternsearch]; ...
                  [ssq_dynare   ssq_fsolve   ssq_lsqnonlin   ssq_fminunc   ssq_fminsearch   ssq_fmincon   ssq_simulannealbnd   ssq_patternsearch]],...
                 'VariableNames',{'Dynare analytical','fsolve','lsqnonlin','fminunc','fminsearch','fmincon','simulannealbnd','patternsearch'},...
                 'RowNames',[strcat('eq_',num2str(transpose(1:MODEL.endo_nbr)));"Sum Of Squared Residuals"]));