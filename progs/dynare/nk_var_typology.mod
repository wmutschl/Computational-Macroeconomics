% =========================================================================
% illustration of different types of variables in the baseline New Keynesian
% model with monopolistic competition, Calvo price frictions, and investment
% adjustment costs.
% illustrates Dynare's model_info command and manually extracting different
% types and groups of variables.
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: June 13, 2023
% =========================================================================

@#include "nk.mod"
model_info;

% lead_lag_incidence matrix: which variables are used at t-1, t, and t+1
fprintf('%s\n',strjoin(repmat("*",1,100),''))
fprintf('\n    M_.lead_lag_incidence matrix: which variables are used at t-1, t, and t+1\n\n')
disp(array2table(M_.lead_lag_incidence,...
    'VariableNames',M_.endo_names,...
    'RowNames',{'t-1','t','t+1'}));
fprintf('    number in M_.lead_lag_incidence corresponds to column in dynamic Jacobian g1\n');
fprintf('\n%s\n\n',strjoin(repmat("*",1,100),''))

% static variables: appear only at t, but not at t-1 and not at t+1
endo_static_names = M_.endo_names(ismember(transpose(M_.lead_lag_incidence>0), [0 1 0],'rows'));
fprintf('%s\n',strjoin(repmat("*",1,100),''))
fprintf('\n    static variables: appear only at t, but not at t-1 and not at t+1\n\n')
disp(endo_static_names')
fprintf('    M_.nstatic = %d\n',M_.nstatic)
fprintf('\n%s\n\n',strjoin(repmat("*",1,100),''))

% purely predetermined variables: appear at t-1 but not at t+1, possibly at t
endo_pred_names = M_.endo_names(ismember(transpose(M_.lead_lag_incidence([1 3],:)>0), [1 0],'rows'));
fprintf('%s\n',strjoin(repmat("*",1,100),''))
fprintf('\n    purely predetermined variables: appear at t-1 but not at t+1, possibly at t\n\n')
disp(endo_pred_names');
fprintf('    M_.npred = %d\n',M_.npred)
fprintf('\n%s\n\n',strjoin(repmat("*",1,100),''))

% purely forward looking variables: appear at t+1 but not at t-1, possibly at t
endo_fwrd_names = M_.endo_names(ismember(transpose(M_.lead_lag_incidence([1 3],:)>0), [0 1],'rows'))
fprintf('%s\n',strjoin(repmat("*",1,100),''))
fprintf('\n    purely forward looking variables: appear at t+1 but not at t-1, possibly at t\n\n')
disp(endo_pred_names');
fprintf('    M_.nfwrd = %d\n',M_.npred)
fprintf('\n%s\n\n',strjoin(repmat("*",1,100),''))

% mixed variables: appear at t-1 and t+1, and possibly at t
endo_mixed_names = M_.endo_names(ismember(transpose(M_.lead_lag_incidence([1 3],:)>0), [1 1],'rows'))
fprintf('%s\n',strjoin(repmat("*",1,100),''))
fprintf('\n    mixed variables: appear at t-1 and t+1, and possibly at t\n\n')
disp(endo_pred_names');
fprintf('    M_.nboth = %d\n',M_.npred)
fprintf('\n%s\n\n',strjoin(repmat("*",1,100),''))

% state and jumper variables
ystar     = strcat(M_.endo_names(M_.lead_lag_incidence(1,:)>0),'_{t-1}');
y0        = strcat(M_.endo_names(M_.lead_lag_incidence(2,:)>0),'_{t}');
ystarstar = strcat(M_.endo_names(M_.lead_lag_incidence(3,:)>0),'_{t+1}');
u0        = strcat(M_.exo_names,'_{t}');
fprintf('%s\n',strjoin(repmat("*",1,100),''))
fprintf('\ny_t: all endogenous variables appear at t\n\n')
disp(y0(:)')
fprintf('\ny^{*}_{t-1}: state variables are predetermined and mixed variables (i.e. endogenous variables that appear at t-1):\n\n')
disp(ystar(:)')
fprintf('\ny^{**}_{t+1}: jumper variables are mixed and forward variables (i.e. endogenous variables that appear at t+1)\n\n')
disp(ystarstar(:)')
fprintf('\nu_t: shocks only appear at t\n\n')
disp(u0(:)')
fprintf('\n%s\n\n',strjoin(repmat("*",1,100),''))

% dynamic variables
dynamic_names = [ystar;y0;ystarstar;u0];
fprintf('%s\n',strjoin(repmat("*",1,100),''))
fprintf('\ndynamic variables are endogenous variables that actually appear and exogenous variables:\n\n   z_t = [ y^{*}_{t-1}'' y_t'' y^{**}_{t+1}'' u_t'']'':\n\n')
disp(dynamic_names(:)')
fprintf('\n%s\n\n',strjoin(repmat("*",1,100),''))
