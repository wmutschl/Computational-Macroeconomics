%--------------------------------------------------------------------------
% Declaration of endogenous variables
%--------------------------------------------------------------------------
var
a     ${a}$     (long_name='technology level')
c     ${c}$     (long_name='consumption')
pie   ${\pi}$   (long_name='gross inflation')
w     ${w}$     (long_name='real wage')
R     ${R}$     (long_name='nominal interest rate')
n     ${n}$     (long_name='labor input')
y     ${y}$     (long_name='output')
mc    ${mc}$    (long_name='real marginal costs')
;

%--------------------------------------------------------------------------
% Declaration of exogenous variables
%--------------------------------------------------------------------------
varexo
eps_a   ${\varepsilon_a}$   (long_name='TFP shock')
;

%--------------------------------------------------------------------------
% Declaration of parameters
%--------------------------------------------------------------------------
parameters
PIEA          ${\bar{\pi}^{A}}$   (long_name='annual inflation target')
BETA          ${\beta}$           (long_name='discount factor')
SIGMA         ${\sigma}$          (long_name='inverse elasticity of intertemporal substitution')
PHI           ${\phi}$            (long_name='inverse Frisch elasticity')
EPSILON       ${\epsilon}$        (long_name='demand elasticity')
RHOA          ${\rho_a}$          (long_name='autocorrelation technology process')
GAMMA         ${\gamma}$          (long_name='weight on labor in utility')
ALPHAPIE      ${\alpha_{\pi}}$    (long_name='inflation feedback Taylor Rule')
ALPHAY        ${\alpha_{y}}$      (long_name='output-gap feedback Taylor Rule')
VARPHI        ${\varphi}$         (long_name='Rotemberg parameter')
;

%--------------------------------------------------------------------------
% Model equations
%--------------------------------------------------------------------------
model;
[name='Euler equation']
c^(-SIGMA) = BETA*R/pie(+1)*c(+1)^(-SIGMA);

[name='labor supply']
w = GAMMA*n^PHI*c^SIGMA;

[name='technology process']
log(a) = RHOA*log(a(-1)) + eps_a;

[name='marginal costs']
mc = w/a;

[name='optimal price setting']
1 - VARPHI*(pie-1)*pie + VARPHI*BETA*(c(+1)/c)^(-SIGMA)*(pie(+1)-1)*pie(+1)*y(+1)/y = (1-mc)*EPSILON;

[name='aggregate supply']
y = a*n;

[name='resource constraint']
y = c + VARPHI/2*(pie-1)^2*y;

[name='monetary policy rule']
ln(R/steady_state(R)) = ALPHAPIE*(ln(pie) - ln((1+PIEA/100)^(1/4))) + ALPHAY*ln(y/steady_state(y));
end;

steady_state_model; 
a = 1;
pie = (1 + PIEA/100)^(1/4);
R = pie/BETA;
mc = 1 - 1/EPSILON*(1-VARPHI*(pie-1)*pie+VARPHI*BETA*(pie-1)*pie);
w = mc * a;
n = (w/GAMMA * ((1-VARPHI/2*(pie-1)^2)*a)^(-SIGMA))^(1/(PHI+SIGMA));
y = a*n;
c = (1-VARPHI/2*(pie-1)^2)*y;
end;

% Calibration
BETA       = 0.99;
SIGMA      = 1;
PHI        = 1;
EPSILON    = 10;
RHOA       = 0.9;
SIGMAA     = 1;
ALPHAPIE   = 1.5;
ALPHAY     = 0.5/4;
THETA      = 0.75;
VARPHI     = ( (EPSILON-1)*THETA )/( (1-THETA)*(1-BETA*THETA) );
GAMMA      = 8.1;
PIEA       = 0;

shocks;
var eps_a = 0.01;
end;