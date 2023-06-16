% =========================================================================
% computes the first-order perturbation solution, impulse-response function
% and simulated data in the Brock and Mirman (1972) model
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: June 13, 2023
% =========================================================================
var c a k;
varexo eps_a;
parameters ALPHA BETA RHO;

ALPHA = 0.3;
BETA  = 0.96;
RHO   = 0.5;
SIG   = 0.2;

model;
c^(-1) = ALPHA*BETA*c(+1)^(-1)*a(+1)*k^(ALPHA-1);
k = a*k(-1)^ALPHA - c;
log(a) = RHO*log(a(-1)) + eps_a;
end;

steady_state_model;
a = 1;
k = (ALPHA*BETA*a)^(1/(1-ALPHA));
c = a*k^ALPHA-k;
end;
steady;

shocks;
var eps_a = SIG^2;
end;
stoch_simul(order=1,irf=30,periods=200);