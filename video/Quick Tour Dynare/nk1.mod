%declare endogenous variables
var
  y        // GDP
  pie      // Inflation
  R        // Actual nominal interest rate
  R_taylor // Nominal interest rate according to Taylor rule
  eps_a    // Productivity shock (opposite of cost-push shock)
  eps_b    // Confidence shock (shock to rate of preference for the present)
;

% declare exogenous variables
varexo
  eta_r // Monetary policy error
  eta_a // Innovation to productivity shock
  eta_b // Innovation to confidence shock
;

parameters 
  sigma   // Relative risk aversion
  rho_r   // Inertia of monetary policy
  rho_pie // Reaction of monetary policy to inflation
  rho_y   // Reaction of monetary policy to output gap
  beta    // Discount factor
  rho_a   // Autocorrelation of productivity shock
  rho_b   // Autocorrelation of confidence shock
  kappa   // Weight of output gap in Phillips curve
  delta   // Weight of inflation expectations in Phillips curve
;

% calibrate parameters
sigma = 2;
rho_r = 0.96;
rho_pie = 1.68;
rho_y = 0.1;
beta = 0.99;
rho_a = 0.82;
rho_b = 0.85;
delta = 0.67;
kappa = 0.1;
rho_r = 0.66;


% model equations
model;
//Euler equation
beta*R/pie(+1)*eps_b(+1)*y(+1)^(-sigma) = eps_b*y^(-sigma);

//NK Phillips curve
log(pie/STEADY_STATE(pie)) = delta*log(pie(+1)/STEADY_STATE(pie)) + kappa*log(y/STEADY_STATE(y)) - log(eps_a);

//Cost-push shock processes
log(eps_a) = rho_a*log(eps_a(-1)) + eta_a;

//Confidence shock processes
log(eps_b) = rho_b*log(eps_b(-1)) + eta_b;

//Taylor rule (in multiplicative form)
log(R_taylor) = rho_r*log(R(-1)) + (1-rho_r)*(log(STEADY_STATE(pie)/beta) + rho_pie*log(pie/STEADY_STATE(pie)) + rho_y*log(y/STEADY_STATE(y))) + eta_r;

//Actual Nominal interest rate
R = R_taylor;
end;

initval;
y = 2.5;
pie = 2;
R = 1;
R_taylor=1;
eps_a= 1;
eps_b = 1;
end;

steady;