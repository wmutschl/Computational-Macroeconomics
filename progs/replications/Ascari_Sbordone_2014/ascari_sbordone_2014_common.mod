var
log_y        ${\log(Y)}$           (long_name='log of output')
log_i        ${\log(i)}$           (long_name='log of nominal interest rate')
log_pi       ${\log(\pi)}$         (long_name='log of inflation')
log_n        ${\log(N)}$           (long_name='log of hours worked')
log_w        ${\log(w)}$           (long_name='log of real wage')
log_pstar    ${\log(p^*)}$         (long_name='log of reset price')
log_psi      ${\log(\psi)}$        (long_name='log of recursive auxiliary variable 1 price setting')
log_phi      ${\log(\phi)}$        (long_name='log of recursive auxiliary variable 2 price setting')
log_mc       ${\log(MC^r)}$ 	   (long_name='log of real marginal costs')
log_r        ${\log(r)}$           (long_name='log of real interest rate')
log_s        ${\log(s)}$           (long_name='log of price dispersion')
log_a        ${\log(A)}$           (long_name='log of total factor productivity')
zeta         ${\zeta}$             (long_name='preference shifter (no need to log)')
nu           ${\nu}$               (long_name='monetary policy shock (no need to log)')
log_atilde   ${\log(\tilde{A})}$   (long_name='effective aggregate productivity')
utility      ${U}$                 (long_name='lifetime utility, recursively defined, no log as it can be negative')
log_average_markup
log_marginal_markup
log_price_adjustment_gap
;

varexo
eps_nu     ${\epsilon_\nu}$     (long_name='monetary policy shock')
eps_a      ${\epsilon_A}$       (long_name='innovation to total factor productivity')
eps_zeta   ${\epsilon_\zeta}$   (long_name='innovation to preference shock')
;

parameters
BETA         $\beta$          (long_name='discount factor')
ALPHA        $\alpha$ 	      (long_name='capital share')
VARPHI       $\varphi$        (long_name='inverse Frisch elasticity')
THETA        $\theta$         (long_name='Calvo parameter')
SIGMA        $\sigma$         (long_name='risk aversion')
VAREPSILON   $\varepsilon$    (long_name='Elasticity of substitution')
PIBAR        ${\bar{\pi}}$    (long_name='gross quarterly steady state inflation')
RHO_NU       ${\rho_\nu}$     (long_name='autocorrelation of monetary shock')
RHO_A        ${\rho_A}$       (long_name='autocorrelation of technology shock')
RHO_ZETA     ${\rho_\zeta}$   (long_name='autocorrelation of preference shock')
PHI_PI       ${\phi_\pi}$     (long_name='Taylor rule feedback inflation')
PHI_Y        ${\phi_Y}$       (long_name='Taylor rule output')
YBAR         ${\bar{Y}}$      (long_name='steady state output, set in steady state model block')
VARRHO       ${\varrho}$      (long_name='degree of indexing')
IBAR         ${\bar{i}}$      (long_name='steady state interest rate, set in steady state model block')
D_N          ${d_n}$          (long_name='labor disutility parameter')
RHO_I        ${\rho_i}$       (long_name='interest rate smoothing parameter')
TREND_INFLATION
;

model;
//note that we do exp transform on variables
[name='Euler equation (equation 1 in section 1.6 in appendix)']
1/(exp(log_y)^(SIGMA)) = BETA*(1+exp(log_i)) / (exp(log_pi(+1)) * (exp(log_y(+1))^SIGMA) );
[name='labor supply (equation 2 section 1.6 in appendix)']
exp(log_w) = D_N*exp(zeta)*(exp(log_n)^VARPHI)*(exp(log_y)^SIGMA);
[name='optimal reset price (equation 3 section 1.6 in appendix)']
exp(log_pstar) = ( ( 1-THETA*(exp(log_pi(-1))^((1-VAREPSILON)*VARRHO)) * (exp(log_pi)^(VAREPSILON-1)) ) / (1-THETA) )^(1/(1-VAREPSILON));
[name='recursive price setting (equation 4 section 1.6 in appendix)']
(exp(log_pstar))^(1+((VAREPSILON*ALPHA)/(1-ALPHA))) = (VAREPSILON/((VAREPSILON-1)*(1-ALPHA)))*exp(log_psi)/exp(log_phi);
[name='recursive price setting auxiliary sum 1 (equation 5 section 1.6 in appendix)']
exp(log_psi) = exp(log_w)*((exp(log_a))^(-1/(1-ALPHA)))*(exp(log_y)^((1/(1-ALPHA))-SIGMA))
             + THETA*BETA*(exp(log_pi))^((-VARRHO*VAREPSILON)/(1-ALPHA))*exp(log_pi(+1))^(VAREPSILON/(1-ALPHA))*exp(log_psi(+1));
[name='recursive price setting auxiliary sum 2 (equation 6 section 1.6 in appendix)']
exp(log_phi) = exp(log_y)^(1-SIGMA)+THETA*BETA*exp(log_pi)^(VARRHO*(1-VAREPSILON))*exp(log_pi(+1))^(VAREPSILON-1)*exp(log_phi(+1));
[name='aggregate supply (equation 7 section 1.6 in appendix)']
exp(log_n) = exp(log_s)*(exp(log_y)/exp(log_a))^(1/(1-ALPHA));
[name='law of motion price dispersion (equation 8 section 1.6 in appendix)']
exp(log_s) = (1-THETA)*exp(log_pstar)^(-VAREPSILON/(1-ALPHA))
           + THETA*exp(log_pi(-1))^((-VAREPSILON*VARRHO)/(1-ALPHA))*exp(log_pi)^(VAREPSILON/(1-ALPHA))*exp(log_s(-1));
[name='monetary policy rule (reflects footnote 69) (equation 9 section 1.6 in appendix)']
(1+exp(log_i))/(1+IBAR) = ((1+exp(log_i(-1)))/(1+IBAR))^RHO_I * ( (exp(log_pi)/PIBAR)^PHI_PI * (exp(log_y)/YBAR)^PHI_Y )^(1-RHO_I) * exp(nu);
[name='definition real marginal costs (eq. 22 in appendix)']
exp(log_mc) = 1/(1-ALPHA)*exp(log_w)*exp(log_a)^(1/(ALPHA-1))*exp(log_y)^(ALPHA/(1-ALPHA));
[name='definition real interest rate']
exp(log_r) = (1+exp(log_i))/(exp(log_pi(+1)));
[name='define utility recursively']
@#ifdef LOGUTILITY
utility = log_y - D_N*exp(zeta)*exp(log_n)^(1+VARPHI)/(1+VARPHI) + BETA*utility(+1);
@#else
utility = exp(log_y)^(1-SIGMA)/(1-SIGMA) - D_N*exp(zeta)*exp(log_n)^(1+VARPHI)/(1+VARPHI) + BETA*utility(+1);
@#endif
[name='law of motion monetary policy shock']
nu = RHO_NU*nu(-1) + eps_nu;
[name='law of motion technology shock']
log_a = RHO_A*log_a(-1) + eps_a;
[name='law of motion preference shock']
zeta = RHO_ZETA*zeta(-1) + eps_zeta;
[name='definition effective aggregate productivity']
exp(log_atilde)=exp(log_a)/exp(log_s);
[name='definition average markup']
exp(log_average_markup) = 1/exp(log_mc);
[name='definition marginal markup']
exp(log_marginal_markup) = exp(log_pstar)/exp(log_mc);
[name='definition price adjustment gap']
exp(log_price_adjustment_gap) = 1/exp(log_pstar);
end;

steady_state_model;
PI = (1+TREND_INFLATION/100)^(1/4); % set to reflect quarterly inflation
nu = 0;
zeta = 0;
A = 1;
I = 1/BETA*PI - 1;
PSTAR = ((1-THETA*PI^((VAREPSILON-1)*(1-VARRHO)))/(1-THETA))^(1/(1-VAREPSILON));
S = (1-THETA)/(1-THETA*PI^((VAREPSILON*(1-VARRHO))/(1-ALPHA)))*PSTAR^(-VAREPSILON/(1^-ALPHA));
Y = (PSTAR^(1+(VAREPSILON*ALPHA)/(1-ALPHA))*(VAREPSILON/((VAREPSILON-1)*(1-ALPHA))*((1-BETA*THETA*PI^((VAREPSILON-1)*(1-VARRHO)))/(1-BETA*THETA*PI^(VAREPSILON*(1-VARRHO)/(1-ALPHA))))*D_N*S^VARPHI)^(-1))^(((VARPHI+1)/(1-ALPHA)-(1-SIGMA))^(-1));
N = S*Y^(1/(1-ALPHA));
PHI = Y^(1-SIGMA)/(1-THETA*BETA*PI^((VAREPSILON-1)*(1-VARRHO)));
PSI = PSTAR^(1+VAREPSILON*ALPHA/(1-ALPHA))*PHI/(VAREPSILON/((VAREPSILON-1)*(1-ALPHA)));
W = (PSI-THETA*BETA*PI^((-VARRHO*VAREPSILON)/(1-ALPHA))*PI^(VAREPSILON/(1-ALPHA))*PSI)/(A^(-1/(1-ALPHA))*Y^((1/(1-ALPHA))-SIGMA));
MC = 1/(1-ALPHA)*W*A^(1/(ALPHA-1))*Y^(ALPHA/(1-ALPHA));
AVERAGE_MARKUP = 1/MC;
MARGINAL_MARKUP = PSTAR/MC;
R = (1+I)/PI;
PRICE_ADJUSTMENT_GAP = 1/PSTAR;
ATILDE = A/S;
log_a = log(A);
log_i = log(I);
log_pstar = log(PSTAR);
log_pi = log(PI);
log_s = log(S);
log_y = log(Y);
log_phi = log(PHI);
log_psi = log(PSI);
log_w = log(W);
log_n = log(N);
log_mc = log(MC);
log_r = log(R);
log_atilde = log(ATILDE);
log_average_markup = log(AVERAGE_MARKUP);
log_marginal_markup = log(MARGINAL_MARKUP);
log_price_adjustment_gap = log(PRICE_ADJUSTMENT_GAP);
@#ifdef LOGUTILITY
utility = (1-BETA)^(-1) * ( log(Y) - D_N*N^(1+VARPHI)/(1+VARPHI) );
@# else
utility = (1-BETA)^(-1) * ( Y^(1-SIGMA)/(1-SIGMA) - D_N*N^(1+VARPHI)/(1+VARPHI) );
@#endif
% update endogenous parameters
IBAR = I;
PIBAR = PI;
YBAR = Y;
end;