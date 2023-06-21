% =========================================================================
% Annicchiarico and Di Dio (2015) - Environmental policy and macroeconomic
% dynamics in a new Keynesian model
% common declarations and equations
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: May 5, 2023
% =========================================================================
model;
@#include "ann_dio_2015_environmental_regime.inc"
%-------------------------------------------------------------------------%
% common model equations
%-------------------------------------------------------------------------%
[name='A(17) bond holding']
rnom^(-1) = BETA / pie(+1) * c / c(+1);
[name='A(18) labor supply']
MU_L * l^PHI = 1/c * w;
[name='A(19) investment decision']
BETA * ( rk(+1) + GAMMA_I * ( iv(+1)/k(+1) - DELTA_K ) * (iv(+1)/k(+1))^2 ) - q * c(+1) / c + BETA * (1-DELTA_K)*q(+1) = 0;
[name='A(20) capital decision']
q - 1 - GAMMA_I * ( iv/k - DELTA_K) * (iv/k) - GAMMA_I/2 * ( iv/k - DELTA_K )^2 = 0;
[name='A(21) aggregate demand']
y = c + iv + g + ca_y*y + GAMMA_I/2* ( ( iv/k - DELTA_K )^2 ) * iv;
[name='A(22) capital accumulation']
k(+1) = (1-DELTA_K)*k + iv;
[name='A(23) damage function']
Gamma_m = GAMMA_0 + GAMMA_1*m + GAMMA_2*m^2;
[name='A(23) aggregate supply with damage function']
y = (1 - Gamma_m) * a * k^ALPHA * l^(1-ALPHA) * dp^(-1);
[name='A(24) labor demand']
(1-ALPHA) * y/l * Psi = w;
[name='A(25) capital demand']
ALPHA * y/k * Psi = rk;
[name='A(27) recursive price setting']
pstar = THETA/(THETA-1) * (x + Omega) / Theta;
[name='A(28) recursive price setting auxiliary sum 1']
x = c^(-1)*Psi*y + XI*BETA*pie(+1)^THETA*x(+1);
[name='A(29) recursive price setting auxiliary sum 2']
Theta = c^(-1)*y + XI*BETA*pie(+1)^(THETA-1)*Theta(+1);
[name='A(30) recursive price setting auxiliary sum 3']
Omega = c^(-1)*( PHI_1*u^PHI_2 + pz*(1-u)*VARPHI )*y + XI*BETA*pie(+1)^THETA*Omega(+1);
[name='A(31) optimal reset price law of motion']
1 = XI*pie^(THETA-1) + (1-XI)*pstar^(1-THETA);
[name='A(32) price efficiency distortion law of motion']
dp = (1-XI)*pstar^(-THETA) + XI*pie^THETA*dp(-1);
[name='A(33) overall marginal costs']
mc = Psi + PHI_1*u^PHI_2 + pz*(1-u)*VARPHI;
[name='A(34) emissions']
z = (1-u) * VARPHI * y * dp;
[name='A(35) pollution stock']
m = (1-DELTA_M)*m(-1) + z + ZSTAR;
[name='A(36) abatement cost ratio']
ca_y = PHI_1 * u^PHI_2 * dp;
[name='A(37) government budget constraint']
t + pz*z = g;
[name='A(38) monetary rule']
rnom = steady_state(rnom) * (pie/TARGET_PIE)^IOTA_PI * eta;
[name='A(38) total factor productivity']
log(a) = (1-RHO_A)*log(A) + RHO_A*log(a(-1)) + eps_a;
[name='A(39) public spending rule']
log(g) = (1-RHO_G)*log(TARGET_GSHARE*steady_state(y)) + RHO_G*log(g(-1)) + eps_g;
[name='A(40) monetary policy shock']
log(eta) = RHO_ETA*log(eta(-1)) + eps_eta;
[name='(14) recursive welfare (lifetime utility)']
welf = ( log(c) - MU_L*l^(1+PHI)/(1+PHI) ) + BETA*welf(+1);
end;