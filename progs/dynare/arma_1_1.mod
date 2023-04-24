var x;
varexo e;
parameters THETA PHI;

THETA = 0.4;
PHI   = 0.4;

model;
x - THETA*x(-1) = e - PHI*e(-1);
end;

steady_state_model;
x = 0;
end;

shocks;
var e = 1;
end;

steady;
check;

stoch_simul(order=1,periods=200,irf=0);
% stoch_simul stores simulated values for x in two places:
%   - a variable x in the workspace
%   - a variable endo_simul in the structure oo_
% the underlying shocks (that were drawn from the normal distribution) are in
%   - a variable exo_simul in the structure oo_

figure;
subplot(2,1,1);
plot(x(51:end));% get rid of the initial 50 periods
title('$x_t$','Interpreter','latex');
subplot(2,1,2);
plot(oo_.exo_simul(51:end));
title('$\varepsilon_t$','Interpreter','latex');

% Note that both x and exo_simul are equal whenever PHI=THETA
if PHI == THETA
    disp(isequal(x,oo_.exo_simul))
end