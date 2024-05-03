% computes the steady-state of the RBC model with log utility
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: April 26, 2024
% -------------------------------------------------------------------------
var y c k n a r w iv;
varexo eps_a;
parameters BETTA DELT GAMA PSSI ALPH RHOA A;

model;
GAMA*c^(-1) = BETTA*GAMA*c(+1)^(-1)*(1-DELT+r(+1));
w = - (-PSSI*(1-n)^(-1)) / (GAMA*c^(-1));
k = (1-DELT)*k(-1) + iv;
y = c + iv;
y = a*k(-1)^ALPH*n^(1-ALPH);
w = (1-ALPH)*y/n;
r = ALPH*y/k(-1);
log(a) = (1-RHOA)*log(steady_state(a)) + RHOA*log(a(-1)) + eps_a;
end;

BETTA=0.99; DELT=0.025; GAMA=1; PSSI=1.6; ALPH=0.35; RHOA=0.9; A=10; 

steady_state_model;
a = A;
r = 1/BETTA+DELT-1;
k_n = ((ALPH*a)/r)^(1/(1-ALPH));
w = (1-ALPH)*a*k_n^ALPH;
iv_n = DELT*k_n;
y_n = a*k_n^ALPH;
c_n = y_n - iv_n;
n = GAMA/PSSI*c_n^(-1)*w/(1+GAMA/PSSI*c_n^(-1)*w);
c = c_n*n; iv = iv_n*n; k = k_n*n; y = y_n*n;
end;
steady;

% this might help with understanding the M_.lead_lag_incidence matrix
disp(array2table(M_.lead_lag_incidence,...
                 'VariableNames',M_.endo_names,'RowNames',{'t-1','t','t+1'}));

% create steady-state vectors
[I,~] = find(M_.lead_lag_incidence');
y_ss   = oo_.steady_state;                % steady-state of endogenous variables
zzz_ss = oo_.steady_state(I);             % steady-state of dynamic variables
ex_ss  = transpose(oo_.exo_steady_state); % steady-state of exogenous variables

% evaluate dynamic model residuals and Jacobian at steady-state
[dynare_resid, dynare_g1] = feval([M_.fname,'.dynamic'], zzz_ss, ex_ss, M_.params, y_ss, 1);
% evaluate static model residuals and Jacobian at steady-state
[dynare_resid_static, dynare_g1_static] = feval([M_.fname,'.static'], y_ss, ex_ss, M_.params);	
