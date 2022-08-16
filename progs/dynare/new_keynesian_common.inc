%--------------------------------------------------------------------------
% Copyright Notice
%--------------------------------------------------------------------------
% This file implements the baseline New Keynesian model of
% Jordi Gali (2015): Monetary Policy, Inflation, and the Business Cycle,
% Princeton University Press, Second Edition, Chapter 3
% 
% THIS MOD-FILE REQUIRES DYNARE 4.5 OR HIGHER
%
% This implementation was written originally by Johannes Pfeifer and
% adapted by Willi Mutschler (willi@mutschler.eu).
%
% Copyright (C) 2016-2021 Johannes Pfeifer
% Copyright (C) 2021-2022 Willi Mutschler
%
% This is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% It is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% For a copy of the GNU General Public License,
% see <http://www.gnu.org/licenses/>.

%--------------------------------------------------------------------------
% Declaration of endogenous variables
%--------------------------------------------------------------------------
var 
c           ${c}$                     (long_name='consumption')
w           ${w}$                     (long_name='real wage')
pie         ${\pi}$                   (long_name='gross inflation')
n           ${n}$                     (long_name='hours worked')
R           ${R}$                     (long_name='nominal interest rate') 
r           ${r}$                     (long_name='real interest rate')
y           ${y}$                     (long_name='output')
div         ${div}$                   (long_name='real profits') 
Q           ${Q}$                     (long_name='bond price')
mc          ${mc}$                    (long_name='real marginal costs')
pstar       ${p^*}$                   (long_name='price inefficiency distortion')
ptilde      ${\widetilde{p}}$         (long_name='Optimal reset price')
s1          ${s_1}$                   (long_name='aux. sum 1 recursive price setting')
s2          ${s_2}$                   (long_name='aux. sum 2 recursive price setting')
a           ${a}$                     (long_name='technology level')
z           ${z}$                     (long_name='discount factor shifter')
nu          ${\nu}$                   (long_name='monetary policy shifter')
ahat        ${\widehat{a}}$           (long_name='technology level (log dev from ss)')
zhat        ${\widehat{z}}$           (long_name='preference shifter (log dev from ss)')
yhat        ${\widehat{y}}$           (long_name='output (log dev from ss)')
what        ${\widehat{w}}$           (long_name='real wage (log dev from ss)')
nhat        ${\widehat{n}}$           (long_name='hours worked (log dev from ss)')
piehat_an   ${\widehat{\pi}^{ann}}$   (long_name='annualized inflation rate (log dev from ss)')
Rhat_an     ${\widehat{R}^{ann}}$     (long_name='annualized nominal interest rate (log dev from ss)')
rhat_an     ${\widehat{r}^{ann}}$     (long_name='annualized real interest rate (log dev from ss)')
mchat       ${\widehat{mc}}$          (long_name='real marginal costs (log dev from ss)')
;
%--------------------------------------------------------------------------
% Declaration of exogenous variables (i.e. shocks)
%--------------------------------------------------------------------------
varexo 
eps_a    ${\varepsilon_a}$     (long_name='technology shock')
eps_z    ${\varepsilon_z}$     (long_name='preference shock')
eps_nu   ${\varepsilon_\nu}$   (long_name='monetary policy shock')
;   
%--------------------------------------------------------------------------
% Declaration of parameters
%--------------------------------------------------------------------------
parameters 
BETA      ${\beta}$        (long_name='discount factor')
RHO_A     ${\rho_a}$       (long_name='autocorrelation technology process')
RHO_NU    ${\rho_{\nu}}$   (long_name='autocorrelation monetary policy process')
RHO_Z     ${\rho_{z}}$     (long_name='autocorrelation preference shock')
SIGMA     ${\sigma}$       (long_name='inverse elasticity of intertemporal substitution')
VARPHI    ${\varphi}$      (long_name='inverse Frisch elasticity')
PHI_PIE   ${\phi_{\pi}}$   (long_name='inflation feedback Taylor Rule')
PHI_Y     ${\phi_{y}}$     (long_name='output feedback Taylor Rule')
EPSILON   ${\epsilon}$     (long_name='demand elasticity')
THETA     ${\theta}$       (long_name='Calvo parameter')
PIESTAR   ${\pi^*}$        (long_name='inflation target')
;

%--------------------------------------------------------------------------
% Model Equations
%--------------------------------------------------------------------------
%model(block,bytecode); % you can also use this
model;
%marginal utilities
#Un = -z*n^VARPHI;
#Uc = z*c^(-SIGMA);
#Ucp = z(+1)*c(+1)^(-SIGMA);
  
[name='labor supply']
w = -Un/Uc;  

[name='Euler equation']
Uc = BETA*Ucp*r;
  
[name='optimal price setting']
ptilde*s1 = EPSILON/(EPSILON-1)*s2;
  
[name='optimal price setting auxiliary recursion 1']
s1 = y*Uc + BETA*THETA*pie(+1)^(EPSILON-1)*s1(+1);

[name='optimal price setting auxiliary recursion 2']
s2 = mc*y*Uc + BETA*THETA*pie(+1)^EPSILON*s2(+1);
    
[name='law of motion for optimal reset price']
1=THETA*pie^(EPSILON-1)+(1-THETA)*ptilde^(1-EPSILON);
  
[name='marginal costs / labor demand']
mc=w/a;

[name='real profits']
div=y-w*n;
  
[name='aggregate demand']
c=y;

[name='aggregate supply']
pstar*y = a*n;

[name='law of motion for price inefficiency distortion']
pstar = (1-THETA)*ptilde^(-EPSILON) + THETA*pie^EPSILON*pstar(-1);

[name='price of a zero-coupon bond']
Q=1/R;

[name='Fisher equation']
R = r*pie(+1);
  
[name='monetary policy rule']
R=steady_state(R)*(pie/PIESTAR)^PHI_PIE*(y/steady_state(y))^PHI_Y*exp(nu);

[name='preference shifter']
log(z) = RHO_Z*log(z(-1)) + eps_z;

[name='technology process']
log(a) = RHO_A*log(a(-1)) + eps_a;

[name='monetary policy shock process']
nu = RHO_NU*nu(-1) + eps_nu;

[name='definition log output (dev. from ss)']
yhat = log(y) - log(steady_state(y));
  
[name='definition log real wage (dev. from ss)']
what = log(w) - log(steady_state(w));
  
[name='definition log hours worked (dev. from ss)']
nhat = log(n) - log(steady_state(n));
    
[name='definition log annualized inflation (dev. from ss)']
piehat_an = 4*(log(pie)-log(steady_state(pie)));
    
[name='definition log annualized nominal interest rate (dev. from ss)']
Rhat_an = 4*(log(R)-log(steady_state(R)));
  
[name='definition log annualized real interest rate (dev. from ss)']
rhat_an = 4*(log(r)-log(steady_state(r)));
  
[name='definition log technology (dev. from ss)']
ahat = log(a) - log(steady_state(a));
  
[name='definition log discount factor shifter (dev. from ss)']
zhat = log(z) - log(steady_state(z));

[name='definition log real marginal costs (dev. from ss)']
mchat = log(mc) - log(steady_state(mc));
end;

%--------------------------------------------------------------------------
%  Steady state model
%--------------------------------------------------------------------------
steady_state_model;
z   = 1;
a   = 1;
nu  = 0;
pie = PIESTAR;
ptilde = ( (1-THETA*pie^(EPSILON-1))/(1-THETA) )^(1/(1-EPSILON));
mc = (EPSILON-1)/EPSILON * ptilde * (1-BETA*THETA*pie^EPSILON) / (1-BETA*THETA*pie^(EPSILON-1)) ;
pstar = (1-THETA)/(1-THETA*pie^EPSILON) * ptilde^(-EPSILON);
Q = BETA/pie;
R = 1/Q;
r = R/pie;
w = mc*a;
n = (w/(a/pstar)^SIGMA)^(1/(VARPHI+SIGMA));
y = a*n/pstar;
c = y;
div = y-w*n;
s1 = c^(-SIGMA)*y/(1-BETA*THETA*pie^(EPSILON-1));
s2 = c^(-SIGMA)*y*mc/(1-BETA*THETA*pie^EPSILON);

yhat=0;what=0;nhat=0;piehat_an=0;Rhat_an=0;rhat_an=0;ahat=0;zhat=0;mchat=0;
end;

