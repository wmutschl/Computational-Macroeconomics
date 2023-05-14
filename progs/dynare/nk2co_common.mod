% =========================================================================
% Two-country New-Keynesian DSGE model with Zero-Lower-Bound on interest
% rates and endogenous discount factor
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: May 10, 2023
% =========================================================================

%--------------------------------------------------------------------------
% declaration of endogenous variables
%--------------------------------------------------------------------------
var
yHH        ${y^H_H}$          (long_name='HOME: production')
yFF        ${y^F_F}$          (long_name='FOREIGN: production')
cH         ${c^H}$            (long_name='HOME: consumption')
cF         ${c^F}$            (long_name='FOREIGN: consumption')
labH       ${l^H}$            (long_name='HOME: labor')
labF       ${l^F}$            (long_name='FOREIGN: labor')
lambdaH    ${\lambda^H}$      (long_name='HOME: Lagrange multiplier with respect to budget restriction (marginal consumption utility)')
lambdaF    ${\lambda^F}$      (long_name='FOREIGN: Lagrange multiplier with respect to budget restriction (marginal consumption utility)')
wH         ${w^H}$            (long_name='HOME: wage')
wF         ${w^F}$            (long_name='FOREIGN: wage')
rnomH      ${R^H}$            (long_name='HOME: nominal interest rate')
rnomF      ${R^F}$            (long_name='FOREIGN: nominal interset rate')
rnom_annH  ${R^{ann,H}}$      (long_name='HOME: Annualized nominal interest rate')
rnom_annF  ${R^{ann,H}}$      (long_name='HOME: Annualized nominal interest rate')
ivH        ${i^H}$            (long_name='HOME: investment')
ivF        ${i^F}$            (long_name='FOREIGN: investment')
kH         ${k^{H}}$          (long_name='HOME: capital used in production')
kF         ${k^{F}}$          (long_name='FOREIGN: capital used in production')
rkH        ${r_k^H}$          (long_name='HOME: rental rate of capital')
rkF        ${r_k^F}$          (long_name='FOREIGN: rental rate of capital')
qkH        ${q_k^H}$          (long_name='HOME: Lagrange multiplier with respect to capital accumulation (Tobins Q)')
qkF        ${q_k^F}$          (long_name='FOREIGN: Lagrange multiplier with respect to capital accumulation (Tobins Q)')
mcH        ${{mc}^H}$         (long_name='HOME: marginal costs')
mcF        ${{mc}^F}$         (long_name='FOREIGN: marginal costs')
pHH        ${p^H_H}$          (long_name='HOME: price of HOME goods relative to HOME CPI')
pFH        ${p^F_H}$          (long_name='FOREIGN: price of HOME goods relative to FOREIGN CPI')
pHF        ${p^H_F}$          (long_name='HOME: price of FOREIGN goods relative to HOME CPI')
pFF        ${p^F_F}$          (long_name='FOREIGN: price of FOREIGN goods relative to FOREIGN CPI')
piH        ${\Pi^H}$          (long_name='HOME: CPI inflation')
piF        ${\Pi^F}$          (long_name='FOREIGN: CPI inflation')
pi_annH    ${\Pi^{ann,H}}$    (long_name='HOME: Annualized CPI inflation')
pi_annF    ${\Pi^{ann,F}}$    (long_name='HOME: Annualized CPI inflation')
piHH       ${\Pi^H_H}$        (long_name='HOME: PPI inflation')
piFF       ${\Pi^F_F}$        (long_name='FOREIGN: PPI inflation')
ptildeH    ${\tilde{p^H}}$    (long_name='HOME: optimal reset price')
ptildeF    ${\tilde{p^F}}$    (long_name='FOREIGN: optimal reset price')
xptilde1H  ${{x_{p_1}}^H}$    (long_name='HOME: auxiliary sum 1 recursive price setting')
xptilde1F  ${{x_{p_1}}^F}$    (long_name='FOREIGN: auxiliary sum 1 recursive price setting')
xptilde2H  ${{x_{p_2}}^H}$    (long_name='HOME: auxiliary sum 2 recursive price setting')
xptilde2F  ${{x_{p_2}}^F}$    (long_name='FOREIGN: auxiliary sum 2 recursive price setting')
pstarH     ${p^{*H}}$         (long_name='HOME: price dispersion')
pstarF     ${p^{*F}}$         (long_name='FOREIN: price dispersion')
rerH       ${s^H}$            (long_name='HOME: real exchange rate')
rerF       ${s^F}$            (long_name='FOREIGN: real exchange rate')
dnerH      ${{\Delta e^H}}$   (long_name='HOME: change in nominal exchange rate')
dnerF      ${{\Delta e^F}}$   (long_name='FOREIGN: change in nominal exchange rate')
gH         ${g^H}$            (long_name='HOME: government spending')
gF         ${g^F}$            (long_name='FOREIGN: government spending')
tauH       ${\tau^H}$         (long_name='HOME: income tax rate')
tauF       ${\tau^F}$         (long_name='FOREIGN: income tax rate')
trH        ${tr^H}$           (long_name='HOME: lump-sum transfers')
trF        ${tr^F}$           (long_name='FOREIGN: lump-sum transfers')
aH         ${a^H}$            (long_name='HOME: total factor productivity')
aF         ${a^F}$            (long_name='FOREIGN: total factor productivity')
zetaH      ${\zeta^H}$        (long_name='HOME: investment-specific technology')
zetaF      ${\zeta^F}$        (long_name='FOREIGN: investment-specific technology')
dbetaH     ${\beta^H}$        (long_name='HOME: change in endogenous discount factor from t to t+1')
dbetaF     ${\beta^F}$        (long_name='FOREIGN: change in endogenous discount factor from t to t+1')
bHH        ${b^H_H}$          (long_name='HOME: holding of HOME bonds relative to HOME CPI')
bFF        ${b^F_F}$          (long_name='FOREIGN: holding of FOREIGN bonds relative to FOREIGN CPI')
bHF        ${b^H_F}$          (long_name='HOME: holding of FOREIGN bonds relative to FOREIGN CPI')
dH         ${d^H}$            (long_name='HOME: government bonds')
dF         ${d^F}$            (long_name='FOREIGN: government bonds')
importsH   ${imp^H}$          (long_name='HOME: imports')
importsF   ${imp^F}$          (long_name='FOREIGN: imports')
test_walras                   (long_name='Check Walras Law on FOREIGN budget constraint')
;


%--------------------------------------------------------------------------
% declaration of exogenous variables
%--------------------------------------------------------------------------
varexo
eps_aH        ${{\varepsilon_{a}^H}}$        (long_name='HOME: innovation to total factor productivity')
eps_aF        ${{\varepsilon_{a}^F}}$        (long_name='FOREIGN: innovation to total factor productivity')
eps_gH        ${{\varepsilon_{g}^H}}$        (long_name='HOME: innovation to government spending rule')
eps_gF        ${{\varepsilon_{g}^F}}$        (long_name='FOREIGN: innovation to government spending rule')
eps_tauH      ${{\varepsilon_{\tau}^H}}$     (long_name='HOME: innovation to tax rule')
eps_tauF      ${{\varepsilon_{\tau}^F}}$     (long_name='FOREIGN: innovation tax rule')
eps_rH        ${{\varepsilon_{r}^H}}$        (long_name='HOME: innovation to interest rate rule')
eps_rF        ${{\varepsilon_{r}^F}}$        (long_name='FOREIGN: innovation to interest rate rule')
eps_zetaH     ${{\varepsilon_{\zeta}^H}}$    (long_name='HOME: innovation to investment-specific technology')
eps_zetaF     ${{\varepsilon_{\zeta}^F}}$    (long_name='FOREIGN: innovation to investment-specific technology')
;

%--------------------------------------------------------------------------
% declaration of parameters
%--------------------------------------------------------------------------
parameters
BETA_H            ${\bar{beta}^H}$        (long_name='HOME: discount factor')
BETA_F            ${\bar{beta}^F}$        (long_name='FOREIGN: discount factor')
SIGMAC_H          ${\sigma_c^H}$          (long_name='HOME: elasticity of utility wrt consumption (relative risk aversion)')
SIGMAC_F          ${\sigma_c^F}$          (long_name='FOREIGN: elasticity of utility wrt consumption (relative risk aversion)')
SIGMAL_H          ${\sigma_l^H}$          (long_name='HOME: elasticity of utility wrt labor (inverse of Frisch elasticity)')
SIGMAL_F          ${\sigma_l^F}$          (long_name='FOREIGN: elasticity of utility wrt labor (inverse of Frisch elasticity)')
DELTA_H           ${\delta^H}$            (long_name='HOME: capital depreciation rate')
DELTA_F           ${\delta^F}$            (long_name='FOREIGN: capital depreciation rate')
ALPHA_H           ${\alpha^H}$            (long_name='HOME: elasticity of production wrt capital')
ALPHA_F           ${\alpha^F}$            (long_name='FOREIGN: elasticity of production wrt capital')
EPSILONP_H        ${\epsilon_p^H}$        (long_name='HOME: elasticity of substitution btw differentiated intermediate production goods')
EPSILONP_F        ${\epsilon_p^F}$        (long_name='FOREIGN: elasticity of substitution btw differentiated intermediate production goods')
PIH               ${\bar{\pi}^H}$         (long_name='HOME: target inflation rate in steady-state')
PIF               ${\bar{\pi}^F}$         (long_name='FOREIGN: target inflation rate in steady-state')
PHIIV_H           ${\phi_i^H}$            (long_name='HOME: investment adjustment cost coefficient')
PHIIV_F           ${\phi_i^F}$            (long_name='FOREIGN: investment adjustment cost coefficient')
XIP_H             ${\xi_p^H}$             (long_name='HOME: Calvo probability for prices')
XIP_F             ${\xi_p^F}$             (long_name='FOREIGN: Calvo probability for prices')
RHOA_H            ${\rho_a^H}$            (long_name='HOME: persistence of total factor productivity process')
RHOA_F            ${\rho_a^F}$            (long_name='FOREIGN: persistence of total factor productivity process')
RHOG_H            ${\rho_g^H}$            (long_name='HOME: persistence of public spending process')
RHOG_F            ${\rho_g^F}$            (long_name='FOREIGN: persistence of public spending process')
RHOR_H            ${\rho_r^H}$            (long_name='HOME: persistence of interest rate rule')
RHOR_F            ${\rho_r^F}$            (long_name='FOREIGN: persistence of interest rate rule')
RHOZETA_H         ${\rho_\zeta^H}$        (long_name='HOME: persistence of investment-specific technology process')
RHOZETA_F         ${\rho_\zeta^F}$        (long_name='FOREIGN: persistence of investment-specific technology process')
SIZE_H            ${n}$                   (long_name='relative population of HOME country')
ETA_H             ${\eta^H}$              (long_name='HOME: trade elasticity of intratemporal substitution in consumption and investment bundles')
ETA_F             ${\eta^F}$              (long_name='FOREIGN: trade elasticity of intratemporal substitution in consumption and investment bundles')
OMEGA_H           ${\omega^H}$            (long_name='HOME: bias towards own goods')
OMEGA_F           ${\omega^F}$            (long_name='FOREIGN: bias towards own goods')
TAU_H             ${\tau^H}$              (long_name='HOME: target income tax rate')
TAU_F             ${\tau^F}$              (long_name='FOREIGN: target income tax rate')
GY_H              ${g^H/\y^H}$            (long_name='HOME: steady-state government spending ratio')
GY_F              ${g^F/\y^F}$            (long_name='FOREIGN: steady-state government spending ratio')
DY_H              ${d^H/\y^H}$            (long_name='HOME: steady-state government bonds ratio')
DY_F              ${d^F/\y^F}$            (long_name='FOREIGN: steady-state government bonds ratio')
PSIGY_H           ${\psi_{g,y}^H}$        (long_name='HOME: government spending rule feedback to output devations')
PSIGY_F           ${\psi_{g,y}^F}$        (long_name='FOREIGN: government spending rule feedback to output devations')
PSIGD_H           ${\psi_{g,d}^H}$        (long_name='HOME: government spending rule feedback to bonds deviations')
PSIGD_F           ${\psi_{g,d}^F}$        (long_name='FOREIGN: government spending rule feedback to bonds deviations')
PSITG_H           ${\psi_{\tau,g}^H}$     (long_name='HOME: lump-sum tax rule feedback to government spending deviations')
PSITG_F           ${\psi_{\tau,g}^F}$     (long_name='FOREIGN: lump-sum tax rule feedback to government spending deviations')
PSITD_H           ${\psi_{\tau,d}^H}$     (long_name='HOME: lump-sum tax rule feedback to bonds deviations')
PSITD_F           ${\psi_{\tau,d}^F}$     (long_name='FOREIGN: lump-sum tax rule feedback to bonds deviations') 
PSIRPI_H          ${\psi_{R,\pi}^H}$      (long_name='HOME: monetary policy rule response to inflation deviations')
PSIRPI_F          ${\psi_{R,\pi}\pi^F}$   (long_name='FOREIGN: monetary policy rule response to inflation deviations')
PSIRY_H           ${\psi_{R,y}^H}$        (long_name='HOME: monetary policy rule response to output deviations')
PSIRY_F           ${\psi_{R,y}^F}$        (long_name='FOREIGN: monetary policy rule response to output deviations')
PSIRE_H           ${\psi_{R,e}^H}$        (long_name='HOME: monetary policy rule response to nominal exchange rate deviations')
PSIRE_F           ${\psi_{R,e}^F}$        (long_name='FOREIGN: monetary policy rule response to nominal exchange rate deviations')
LABH              ${l^H}$                 (long_name='HOME: steady-state labor')
LABF              ${l^F}$                 (long_name='FOREIGN: steady-state labor')
GDPH              ${gdp^H}$               (long_name='HOME: steady-state GDP')
RERHGDPF_TO_GDPH  ${s^H gdp^F/gdp^H}$     (long_name='real GDP Ratio')
;


%--------------------------------------------------------------------------
% model equations
%--------------------------------------------------------------------------
model;

//AUXILIARY PARAMETERS
#SIZE_F = 1-SIZE_H ; // relative size of country F
#BETAELAST_H = (1/BETA_H-1)* 1/steady_state(cH) ; // elasticity of discount factor to consumption
#BETAELAST_F = (1/BETA_F-1)* 1/steady_state(cF) ; // elasticity of discount factor to consumption
#CHIL_H = steady_state(lambdaH)*steady_state(wH)*(1-steady_state(tauH))/(steady_state(labH)^SIGMAL_H); // labor utility weight
#CHIL_F = steady_state(lambdaF)*steady_state(wF)*(1-steady_state(tauF))/(steady_state(labF)^SIGMAL_F); // labor utility weight

//AUXILIARY VARIABLES
#yH = cH + ivH; // demand for HOME goods
#yF = cF + ivF; // demand for FOREIGN goods
#bFH     = 0;   // assuming zero net supply of HOME-currency bonds
#bFH_bak = 0;   // assuming zero net supply of HOME-currency bonds

//ACTUAL MODEL EQUATIONS

[name='HOME: law of one price and real exchange rate']
pHH = pFH * rerH;
[name='FOREIGN: law of one price and real exchange rate']
pFF = pHF * rerF;

[name='HOME: dynamic law of one price']
pHF/pHF(-1) = dnerH * piF/piH * pFF/pFF(-1);
[name='FOREIGN: dynamic law of one price']
pFH/pFH(-1) = dnerF * piH/piF * pHH/pHH(-1);

[name='HOME: PPI inflation definition']
pHH = (piHH/piH) * pHH(-1);
[name='FOREIGN: PPI inflation definition']
pFF = (piFF/piF) * pFF(-1);

[name='HOME: CPI index']
1 = (1-SIZE_F*OMEGA_H)*pHH^(1-ETA_H) + SIZE_F*OMEGA_H*pHF^(1-ETA_H);
[name='FOREIGN: CPI index']
1 = (1-SIZE_H*OMEGA_F)*pFF^(1-ETA_F) + SIZE_H*OMEGA_F*pFH^(1-ETA_F);

[name='HOME: aggregate demand']
yHH = pHH^(-ETA_H)*(1-SIZE_F*OMEGA_H)*yH + gH + (pHH/rerH)^(-ETA_F)*SIZE_F*OMEGA_F*yF;
[name='FOREIGN: aggregate demand']
yFF = pFF^(-ETA_F)*(1-SIZE_H*OMEGA_F)*yF + gF + (pFF/rerF)^(-ETA_H)*SIZE_H*OMEGA_H*yH;

[name='HOME: total factor productivity']
log(aH) = (1-RHOA_H) * log(steady_state(aH)) + RHOA_H * log(aH(-1)) + eps_aH;
[name='FOREIGN: total factor productivity']
log(aF) = (1-RHOA_F) * log(steady_state(aF)) + RHOA_F * log(aF(-1)) + eps_aF;

[name='HOME: optimal factor input']
ALPHA_H*wH*labH = (1-ALPHA_H)*rkH*kH(-1);
[name='FOREIGN: optimal factor input']
ALPHA_F*wF*labF = (1-ALPHA_F)*rkF*kF(-1);

[name='HOME: marginal costs']
mcH = ( rkH^ALPHA_H * wH^(1-ALPHA_H) ) / ( ALPHA_H^ALPHA_H * (1-ALPHA_H)^(1-ALPHA_H) * aH );
[name='FOREIGN: marginal costs']
mcF = ( rkF^ALPHA_F * wF^(1-ALPHA_F) ) / ( ALPHA_F^ALPHA_F * (1-ALPHA_F)^(1-ALPHA_F) * aF );

[name='HOME: optimal price setting']
(EPSILONP_H-1) * ptildeH * xptilde1H = EPSILONP_H * xptilde2H;
[name='FOREIGN: optimal price setting']
(EPSILONP_F-1) * ptildeF * xptilde1F = EPSILONP_F * xptilde2F;

[name='HOME: optimal price setting auxiliary recursion 1']
xptilde1H = (ptildeH/pHH)^(-EPSILONP_H)*yHH + XIP_H * dbetaH*lambdaH(+1)/lambdaH * (ptildeH/ptildeH(+1))^(-EPSILONP_H) * piH(+1)^(EPSILONP_H-1) * xptilde1H(+1);
[name='FOREIGN: optimal price setting auxiliary recursion 1']
xptilde1F = (ptildeF/pFF)^(-EPSILONP_F)*yFF + XIP_F * dbetaF*lambdaF(+1)/lambdaF * (ptildeF/ptildeF(+1))^(-EPSILONP_F) * piF(+1)^(EPSILONP_F-1) * xptilde1F(+1);

[name='HOME: optimal price setting auxiliary recursion 2']
xptilde2H = (ptildeH/pHH)^(-EPSILONP_H)*yHH*mcH + XIP_H * dbetaH*lambdaH(+1)/lambdaH * (ptildeH/ptildeH(+1))^(-EPSILONP_H) * piH(+1)^(EPSILONP_H) * xptilde2H(+1);
[name='FOREIGN: optimal price setting auxiliary recursion 2']
xptilde2F = (ptildeF/pFF)^(-EPSILONP_F)*yFF*mcF + XIP_F * dbetaF*lambdaF(+1)/lambdaF * (ptildeF/ptildeF(+1))^(-EPSILONP_F) * piF(+1)^(EPSILONP_F) * xptilde2F(+1);

[name='HOME: law of motion for optimal reset price']
pHH^(1-EPSILONP_H) = (1-XIP_H)*ptildeH^(1-EPSILONP_H) + XIP_H*(pHH(-1)/piH)^(1-EPSILONP_H);
[name='FOREIGN: law of motion for optimal reset price']
pFF^(1-EPSILONP_F) = (1-XIP_F)*ptildeF^(1-EPSILONP_F) + XIP_F*(pFF(-1)/piF)^(1-EPSILONP_F);

[name='HOME: law of motion for price dispersion']
pstarH = (1-XIP_H)*(ptildeH/pHH)^(-EPSILONP_H) + XIP_H*(pHH(-1)/(pHH*piH))^(-EPSILONP_H)*pstarH(-1);
[name='FOREIGN: law of motion for price dispersion']
pstarF = (1-XIP_F)*(ptildeF/pFF)^(-EPSILONP_F) + XIP_F*(pFF(-1)/(pFF*piF))^(-EPSILONP_F)*pstarF(-1);

[name='HOME: aggregate production function']
yHH * pstarH = aH * kH(-1)^ALPHA_H * labH^(1-ALPHA_H);
[name='FOREIGN: aggregate production function']
yFF * pstarF = aF * kF(-1)^ALPHA_F * labF^(1-ALPHA_F);

[name='HOME: law of motion capital']
kH = (1-DELTA_H)*kH(-1) + zetaH*(1-PHIIV_H/2*(ivH/ivH(-1)-1)^2)*ivH;
[name='FOREIGN: law of motion capital']
kF = (1-DELTA_F)*kF(-1) + zetaF*(1-PHIIV_F/2*(ivF/ivF(-1)-1)^2)*ivF;

[name='HOME: law of motion for investment-specific technology']
log(zetaH) = (1-RHOZETA_H)*log(steady_state(zetaH)) + RHOZETA_H*log(zetaH(-1)) + eps_zetaH;
[name='FOREIGN: law of motion for investment-specific technology']
log(zetaF) = (1-RHOZETA_F)*log(steady_state(zetaF)) + RHOZETA_F*log(zetaF(-1)) + eps_zetaF;

[name='HOME: endogenous discount factor']
dbetaH = (1 + BETAELAST_H * cH)^(-1);
[name='FOREIGN: endogenous discount factor']
dbetaF = (1 + BETAELAST_F * cF)^(-1);

[name='HOME: marginal utility']
cH^(-SIGMAC_H) = lambdaH;
[name='FOREIGN: marginal utility']
cF^(-SIGMAC_F) = lambdaF;

[name='HOME: labor supply']
CHIL_H*labH^SIGMAL_H = lambdaH*wH*(1-tauH);
[name='FOREIGN: labor supply']
CHIL_F*labF^SIGMAL_F = lambdaF*wF*(1-tauF);

[name='HOME: FOC investment']
lambdaH = lambdaH*qkH*zetaH*( 1 - PHIIV_H/2*(ivH/ivH(-1)-1)^2 - PHIIV_H*(ivH/ivH(-1)-1)*ivH/ivH(-1) ) + dbetaH*lambdaH(+1)*qkH(+1)*zetaH(+1)*PHIIV_H*(ivH(+1)/ivH-1)*(ivH(+1)/ivH)^2;
[name='FOREIGN: FOC investment']
lambdaF = lambdaF*qkF*zetaF*( 1 - PHIIV_F/2*(ivF/ivF(-1)-1)^2 - PHIIV_F*(ivF/ivF(-1)-1)*ivF/ivF(-1) ) + dbetaF*lambdaF(+1)*qkF(+1)*zetaF(+1)*PHIIV_F*(ivF(+1)/ivF-1)*(ivF(+1)/ivF)^2;

[name='HOME: capital Euler']
lambdaH * qkH = dbetaH * lambdaH(+1) * ( qkH(+1) * (1 - DELTA_H) + (1 - tauH)*rkH(+1) );
[name='FOREIGN: capital Euler']
lambdaF * qkF = dbetaF * lambdaF(+1) * ( qkF(+1) * (1 - DELTA_F) + (1 - tauF)*rkF(+1) );

[name='HOME: Bond Euler']
1 = dbetaH * (lambdaH(+1) / lambdaH * rnomH / piH(+1));
[name='FOREIGN: Bond Euler']
1 = dbetaF * (lambdaF(+1) / lambdaF * rnomF / piF(+1));

[name='uncovered interest rate parity']
rnomH = rnomF * dnerH(+1);
[name='real exchange rate identity']
rerH * rerF = 1;

[name='HOME: interest rate rule']
(rnomH-1) = max(0,RHOR_H*(rnomH(-1)-1) + (1-RHOR_H)*( (steady_state(rnomH)-1) + PSIRPI_H*(piH-steady_state(piH))) + PSIRY_H*(yHH/yHH(-1)-1) + eps_rH);
[name='FOREIGN: interest rate rule']
(rnomF-1) = max(0,RHOR_F*(rnomF(-1)-1) + (1-RHOR_F)*( (steady_state(rnomF)-1) + PSIRPI_F*(piF-steady_state(piF))) + PSIRY_F*(yFF/yFF(-1)-1) + eps_rF);

[name='HOME: government spending rule']
gH = (1-RHOG_H) * steady_state(gH) + RHOG_H * gH(-1) + PSIGY_H * (yHH(-1) - steady_state(yHH)) + PSIGD_H * (dH(-1) - steady_state(dH)) + eps_gH;
[name='FOREIGN: government spending']
gF = (1-RHOG_F) * steady_state(gF) + RHOG_F * gF(-1) + PSIGY_F * (yFF(-1) - steady_state(yFF)) + PSIGD_F * (dF(-1) - steady_state(dF)) + eps_gF;

[name='HOME: income tax rule']
tauH = TAU_H + eps_tauH;
[name='FOREIGN: income tax rule']
tauF = TAU_F + eps_tauF;

[name='HOME: transfers rule']
trH = steady_state(trH) + PSITG_H*pHH*(gH-steady_state(gH)) - PSITD_H*(bHH(-1)-steady_state(bHH));
[name='FOREIGN: transfers rule']
trF = steady_state(trF) + PSITG_F*pFF*(gF-steady_state(gF)) - PSITD_F*(bFF(-1)-steady_state(bFF));

[name='HOME: government budget constraint']
trH + pHH*gH + dH(-1)*rnomH(-1)/piH = tauH*pHH*yHH + dH;
[name='FOREIGN: government budget constraint']
trF + pFF*gF + dF(-1)*rnomF(-1)/piF = tauF*pFF*yFF + dF;

[name='HOME: bonds market clearing ']
SIZE_H*bHH + (1-SIZE_H)*bFH = SIZE_H*dH;
[name='FOREIGN: bonds market clearing']
SIZE_H*bHF + (1-SIZE_H)*bFF = (1-SIZE_H)*dF;

[name='HOME: Budget Constraint']
(1-tauH)*pHH*yHH + trH + bHH(-1)*rnomH(-1)/piH + rerH*bHF(-1)*rnomF(-1)/piF = cH + ivH + bHH + rerH*bHF;
[name='FOREIGN: Budget Constraint']
(1-tauF)*pFF*yFF + trF + bFF(-1)*rnomF(-1)/piF + rerF*bFH_bak*rnomH(-1)/piH = cF + ivF + bFF + rerF*bFH + test_walras;

[name='HOME: imports']
importsH = (pFF/rerF)^(-ETA_H)*SIZE_H*OMEGA_H*yH;
[name='FOREIGN: imports']
importsF = (pHH/rerH)^(-ETA_F)*SIZE_F*OMEGA_F*yF;

[name='HOME: Annualized Nominal Interest Rate']
(rnom_annH-1) = 4*(rnomH-1);
//rnom_annH = 4*log(rnomH);
[name='FOREIGN: Annualized Net Nominal Interest Rate']
(rnom_annF-1) = 4*(rnomF-1);
//rnom_annF = 4*log(rnomF);

[name='HOME: Annualized Inflation Rate']
(pi_annH-1) = 4*(piH-1);
//pi_annH = 4*log(piH);
[name='FOREIGN: Annualized Inflation Rate']
(pi_annF-1) = 4*(piF-1);
//pi_annF = 4*log(piF);

end;

%--------------------------------------------------------------------------
% calibration
%--------------------------------------------------------------------------
SIGMAC_H    = 1;
SIGMAC_F    = 1;
SIGMAL_H    = 2;
SIGMAL_F    = 2;
BETA_H      = 0.99;
BETA_F      = 0.99;
ALPHA_H     = 0.36;
ALPHA_F     = 0.36;
DELTA_H     = 0.025;
DELTA_F     = 0.025;
PHIIV_H     = 4.25;
PHIIV_F     = 4.25;
EPSILONP_H  = 6;
EPSILONP_F  = 6;
XIP_H       = 0.75;
XIP_F       = 0.75;
GY_H        = 0.2;
GY_F        = 0.2;
TAU_H       = 0;
TAU_F       = 0;
PIH         = 1;
PIF         = 1;
PSIRPI_H    = 1.5;
PSIRPI_F    = 1.5;
PSIRY_H     = 0.5/4;
PSIRY_F     = 0.5/4;
RHOR_H      = 0.5;
RHOR_F      = 0.5;
PSIRE_H     = 0;
PSIRE_F     = 0;
PSIGY_H     = 0;
PSIGY_F     = 0;
PSIGD_H     = 0;
PSIGD_F     = 0;
PSITG_H     = 0;
PSITG_F     = 0;
PSITD_H     = 0.02;
PSITD_F     = 0.02;
RHOA_H      = 0.8;
RHOA_F      = 0.8;
RHOG_H      = 0.85;
RHOG_F      = 0.85;
RHOZETA_H   = 0.4;
RHOZETA_F   = 0.4;
DY_H        = 0;
DY_F        = 0;
LABH        = 1/3;
LABF        = 1/3;
GDPH        = 1;
RERHGDPF_TO_GDPH = 1;
SIZE_H      = 0.5;
ETA_H       = 0.66;
ETA_F       = 0.66;
OMEGA_H     = 0.5;
OMEGA_F     = 0.5;

%--------------------------------------------------------------------------
% computations: steady-state
%--------------------------------------------------------------------------
steady_state_model;
tauH   = TAU_H + eps_tauH;
tauF   = TAU_F + eps_tauF;
zetaH  = 1;
zetaF  = 1;
dbetaH = BETA_H;
dbetaF = BETA_F;
piH    = PIH;
piF    = PIF;
piHH   = PIH;
piFF   = PIF;
dnerH  = piH/piF;
dnerF  = piF/piH;
rnomH  = piH/BETA_H;
rnomF  = piF/BETA_F;
qkH    = 1;
qkF    = 1;
rkH    = qkH*(1/BETA_H-1+DELTA_H)/(1-tauH);
rkF    = qkF*(1/BETA_F-1+DELTA_F)/(1-tauF);
labH   = LABH;
labF   = LABF;
pHH    = 1; % due to PIH=PIF=1
pHF  = ( ( 1 - (1-(1-SIZE_H)*OMEGA_H)*pHH^(1-ETA_H) ) / ( (1-SIZE_H)*OMEGA_H ) )^(1/(1-ETA_H));
rerF = ( (1-SIZE_H*OMEGA_F)*pHF^(1-ETA_F) + (SIZE_H*OMEGA_F)*pHH^(1-ETA_F))^(1/(ETA_F-1));
rerH = 1/rerF;
pFH  = rerF*pHH;
pFF  = rerF*pHF;
gdpH = GDPH;
gdpF = RERHGDPF_TO_GDPH*gdpH/rerH;
gH   = GY_H*gdpH;
gF   = GY_F*gdpF;
yHH  = gdpH/pHH;
yFF  = gdpF/pFF;
ptildeH   = ( (1-XIP_H*piH^(EPSILONP_H-1))/(1-XIP_H) )^(1/(1-EPSILONP_H))*pHH;
ptildeF   = ( (1-XIP_F*piF^(EPSILONP_F-1))/(1-XIP_F) )^(1/(1-EPSILONP_F))*pFF;
pstarH    = (1-XIP_H)/(1-XIP_H*piH^EPSILONP_H)*(ptildeH/pHH)^(-EPSILONP_H);
pstarF    = (1-XIP_F)/(1-XIP_F*piF^EPSILONP_F)*(ptildeF/pFF)^(-EPSILONP_F);
mcH       = (1-XIP_H*BETA_H*piH^EPSILONP_H)/(1-XIP_H*BETA_H*piH^(EPSILONP_H-1))*(EPSILONP_H-1)/EPSILONP_H*ptildeH;
mcF       = (1-XIP_F*BETA_F*piF^EPSILONP_F)/(1-XIP_F*BETA_F*piF^(EPSILONP_F-1))*(EPSILONP_F-1)/EPSILONP_F*ptildeF;
xptilde1H = (ptildeH/pHH)^(-EPSILONP_H)*yHH/(1-XIP_H*BETA_H*piH^(EPSILONP_H-1));
xptilde1F = (ptildeF/pFF)^(-EPSILONP_F)*yFF/(1-XIP_F*BETA_F*piF^(EPSILONP_F-1));
xptilde2H = (ptildeH/pHH)^(-EPSILONP_H)*yHH*mcH/(1-XIP_H*BETA_H*piH^EPSILONP_H);
xptilde2F = (ptildeF/pFF)^(-EPSILONP_F)*yFF*mcF/(1-XIP_F*BETA_F*piF^EPSILONP_F);
kH        = ALPHA_H*yHH*pstarH*mcH/rkH;
kF        = ALPHA_F*yFF*pstarF*mcF/rkF;
ivH       = DELTA_H*kH;
ivF       = DELTA_F*kF;
dH        = 0;
dF        = 0;
BFH       = 0;
bHF       = 0;
bHH       = DY_H*yHH;
bFF       = DY_F*yFF;
trH       = -pHH*gH - dH*rnomH/piH + tauH*pHH*yHH + dH;
trF       = -pFF*gF - dF*rnomF/piF + tauF*pFF*yFF + dF;
cH = (1-tauH)*pHH*yHH + trH + bHH*rnomH/piH + rerH*bHF*rnomF/piF - ivH - bHH - rerH*bHF;
cF = (1-tauF)*pFF*yFF + trF + bFF*rnomF/piF + rerF*BFH*rnomH/piH - ivF - bFF - rerF*BFH;
wH = pstarH*(1-ALPHA_H)*yHH*mcH/labH;
wF = pstarF*(1-ALPHA_F)*yFF*mcF/labF;
lambdaH = cH^(-SIGMAC_H);
lambdaF = cF^(-SIGMAC_F);
aH = pstarH*yHH/(kH^(ALPHA_H)*labH^(1-ALPHA_H));
aF = pstarF*yFF/(kF^(ALPHA_F)*labF^(1-ALPHA_F));
importsH = (pFF/rerF)^(-ETA_H)*SIZE_H*OMEGA_H*(cH+ivH);
importsF = (pHH/rerH)^(-ETA_F)*(1-SIZE_H)*OMEGA_F*(cF+ivF);
%rnom_annH = 4*log(rnomH);
%rnom_annF = 4*log(rnomF);
%pi_annH = 4*log(piH);
%pi_annF = 4*log(piF);
pi_annH = 1+4*(piH-1);
pi_annF = 1+4*(piF-1);
rnom_annH = 1+4*(rnomH-1);
rnom_annF = 1+4*(rnomF-1);
test_walras = 0;
end;

steady;