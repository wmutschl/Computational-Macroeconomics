% fix labor to 1/3 to compute labor disutility parameter under benchmark of
% zero trend inflation steady-state with Frisch elasticity of 1
N_SS = 1/3;
BETA_SS = 0.99;
ALPHA_SS = 0;
THETA_SS = 0.75;
VAREPSILON_SS = 10;
SIGMA_SS = 1;
VARPHI_SS = 1;
VARRHO_SS = 0;
TREND_INFLATION_SS = 0;
PIBAR = (1+0/100)^(1/4); % set to reflect quarterly inflation
PSTAR_SS = ((1-THETA_SS*PIBAR^((VAREPSILON_SS-1)*(1-VARRHO_SS)))/(1-THETA_SS))^(1/(1-VAREPSILON_SS));
S_SS = (1-THETA_SS)/(1-THETA_SS*PIBAR^((VAREPSILON_SS*(1-VARRHO_SS))/(1-ALPHA_SS)))*PSTAR_SS^(-VAREPSILON_SS/(1^-ALPHA_SS));
Y_SS = (N_SS/S_SS)^(1-ALPHA_SS);
A_SS = 1;
PHI_SS = Y_SS^(1-SIGMA_SS)/(1-THETA_SS*BETA_SS*PIBAR^((VAREPSILON_SS-1)*(1-VARRHO_SS)));
PSI_SS = PSTAR_SS^(1+VAREPSILON_SS*ALPHA_SS/(1-ALPHA_SS))*PHI_SS/(VAREPSILON_SS/((VAREPSILON_SS-1)*(1-ALPHA_SS)));
W_SS = PSI_SS*(1-THETA_SS*BETA_SS*PIBAR^((VAREPSILON_SS*(1-VARRHO_SS))/(1-ALPHA_SS)))/(A_SS^(-1/(1-ALPHA_SS))*Y_SS^(1/(1-ALPHA_SS)-SIGMA_SS));
D_N = W_SS/(N_SS^VARPHI_SS*Y_SS^SIGMA_SS);

% actual calibration set according to footnote 36
BETA = 0.99;
ALPHA = 0;
THETA = 0.75;
VAREPSILON = 10;
@#ifdef LOGUTILITY
  SIGMA = 1;
@#else
  SIGMA = 2; 
@#endif
RHO_NU   = 0;
RHO_A    = 0;
RHO_ZETA = 0;

VARRHO = 0;
TREND_INFLATION = 0; % initialize