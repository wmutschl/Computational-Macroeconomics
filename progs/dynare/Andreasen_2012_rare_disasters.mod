% DSGE model based on replication files of
% Andreasen (2012), On the effects of rare disasters and uncertainty shocks
% for risk premia in non-linear DSGE modesl, Review of Economic Dynamics, 15, pp. 295-316
% Original code by Martin M. Andreasen, Aug 2011
% This adaption focuses on the model to study rare disasters
% Adapted for Dynare by Willi Mutschler (@wmutschl, willi@mutschler.eu), July 20222
% =========================================================================
% Copyright © 2022 Willi Mutschler (@wmutschl, willi@mutschler.eu)
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
% see <https://www.gnu.org/licenses/>.
% =========================================================================

%--------------------------------------------------------------------------
% Declarations
%--------------------------------------------------------------------------
var
  Gr_C       ${\Delta c}$    (long_name='Δc_t: growth rate in consumption: annualized and in pct')
  Infl       ${\pi}$         (long_name='π_t: inflation rate: annualized and in pct')
  R1         ${r}$           (long_name='r_t: short-term interest rate: annualized and in pct')
  R40        ${r_{40}}$      (long_name='r40_t: long-term interest rate: annualized and in pct')
  Slope      ${r_{40}-r}$    (long_name='r40_t-r_t: Slope of yield curve')
  TP         ${P_{40}}$      (long_name='P40_t: term premia: annualized basis points')
  xhr40      ${xhr_{40}}$    (long_name='xhr40_t: 10 year excess holding period return')
  ln_a       ${a_t}$         (long_name='log of technology level')
  
  ln_r       (long_name='log of short-term nominal interest rate')
  ln_g       (long_name='log of government spending')
  ln_p       (long_name='log of short-term bond price')
  ln_y       (long_name='log of output')
  ln_c       (long_name='log of consumption')
  ln_n       (long_name='log of labor supply')
  ln_evf     (long_name='log of expected value of the value function')
  ln_pai     (long_name='log of gross inflation')
  varsdf     (long_name='variance of the nominal stochastic discount factor')
  @#for i in 2:40
  ln_p@{i}   (long_name='log of bond price for maturity @{i} under Rotemberg pricing kernel')
  @#endfor
  @#for i in 2:40
  ln_q@{i}   (long_name='log of bond price for maturity @{i} under neutral pricing kernel')
  @#endfor  
  @#for i in 2:40
  ln_tp@{i}  (long_name='log of term premium for maturity @{i}')
  @#endfor  
;

varobs Gr_C Infl R1 R40 Slope TP xhr40 ln_a;

varexo 
  epsA       ${\epsilon_a}$    (long_name='productivity shock (might be non-Gaussian)')
  epsG       ${\epsilon_g}$    (long_name='government spending shock (Gaussian)')
  epsR       ${\epsilon_r}$    (long_name='monetary polilcy shock (Gaussian)')
;

parameters 
  GAMA       ${\gamma}$           (long_name='first parameter that determines size of intertemporal elasticity of substitution')
  NU         ${\nu}$              (long_name='second parameter that determines size of intertemporal elasticity of substitution')
  BETTA      ${\beta}$            (long_name='discount factor')
  ALFA       ${\alpha}$           (long_name='degree of relative risk-aversion')
  THETA      ${\theta}$           (long_name='capital elasticity in Cobb-Douglas production function')
  ETA        ${\eta}$             (long_name='love of variety parameter in Dixit-Stiglitz aggregator')
  XI         ${\xi}$              (long_name='Rotemberg quadratic price adjustment cost coefficient')
  DELTA      ${\delta}$           (long_name='depreciation rate of capital')
  PHI_pai    ${\phi_\pi}$         (long_name='inflation feedback Taylor Rule')
  PHI_y      ${\phi_y}$           (long_name='output gap feedback Taylor Rule')
  RHOA       ${\rho_a}$           (long_name='persistence parameter productivity process')
  RHOG       ${\rho_g}$           (long_name='persistence parameter government spending process')
  RHOR       ${\rho_r}$           (long_name='persistence parameter Taylor rule')
  N          ${n_{ss}}$           (long_name='steady-state labor supply')
  G_O_Y      ${g_{ss}/y_{ss}}$    (long_name='steady-state ratio of government spending to output')
  PAI        ${\pi_{ss}}$         (long_name='inflation target')
  MUZ        ${\mu_{z,ss}}$       (long_name='deterministic trend')
  Kss        ${\bar{k}}$          (long_name='steady-state capital stock')
  AA                              (long_name='normalization constant equal to minus the steady-state of expected value function')
  Ass                             (long_name='steady-state level of technology')
;

%--------------------------------------------------------------------------
% Calibration
%--------------------------------------------------------------------------
Ass = 1;
GAMA = 2.5;
NU = 0.35;
BETTA = 0.9995;
ALFA = -110;
THETA = 0.36;
ETA = 6;
ALFAp = 0.75;
DELTA = 0.025;
PHI_pai = 1.5;
PHI_y = 0.30;
RHOA = 0.98;
RHOG = 0.90;
RHOR = 0.85;
N = 0.38;
G_O_Y = 0.17;
PAI = 1.008;
MUZ = 1.005;
XI = (1-THETA+ETA*THETA)*(ETA-1)*ALFAp/((1-ALFAp)*(1-THETA)*(1-ALFAp*BETTA*MUZ^(NU*(1-GAMA))));
IES = 1/(1-NU*(1-GAMA));
RRA = (GAMA+ALFA*(1-GAMA));
fprintf('Chosen calibration implies Inverse Elasticity of Substitution (IES) of: %f\n',IES);
fprintf('Chosen calibration implies Risk Aversion (RRA) of: %f\n',RRA);

%--------------------------------------------------------------------------
% Model equations
%--------------------------------------------------------------------------
model;
    % do exp transform such that model equations contain actual variables and not logged variables
    #r_ba1 = exp(ln_r(-1));
    #a_ba1 = exp(ln_a(-1));
    #g_ba1 = exp(ln_g(-1));
    
    #a_cu = exp(ln_a);
    #g_cu = exp(ln_g);
    #p_cu = exp(ln_p);
    #r_cu = exp(ln_r);
    #y_cu = exp(ln_y);
    #c_cu = exp(ln_c);
    #n_cu = exp(ln_n);
    #evf_cu = exp(ln_evf);
    #pai_cu = exp(ln_pai);
    
    #a_cup = exp(ln_a(+1));
    #g_cup = exp(ln_g(+1));
    #p_cup = exp(ln_p(+1));
    #r_cup = exp(ln_r(+1));
    #y_cup = exp(ln_y(+1));
    #c_cup = exp(ln_c(+1));
    #n_cup = exp(ln_n(+1));
    #evf_cup = exp(ln_evf(+1));
    #pai_cup = exp(ln_pai(+1));
    
    #varsdf_cu = varsdf;
    #varsdf_cup = varsdf(+1);
    
    % auxiliary expressions and parameters
    #MUZss = MUZ;
    #muz_cu  = MUZss;
    #muz_cup = MUZss;
    #PAIss = exp(steady_state(ln_pai));
    #Rss = exp(steady_state(ln_r));
    #Yss = exp(steady_state(ln_y));
    #Gss = G_O_Y*Yss;
    
    % FOC for household with respect to labour
    #w_cu = (1-NU)*c_cu/(NU*(1-n_cu));
    % FOC for firms with respect to labour
    #mc_cu  = w_cu/((1-THETA)*a_cu*Kss^THETA*n_cu^(-THETA));
    % The expression for minus the value function
    % Here we use the fact that the trend is deterministic
    #mvf_cup = -(c_cup^(NU*(1-GAMA))*(1-n_cu)^((1-NU)*(1-GAMA))/(1-GAMA)-BETTA*muz_cup^(NU*(1-GAMA))*AA*evf_cup^(1/(1-ALFA)));
    % The ratio of lambda_cup/lambda_cu
    #mu_la_cup = (AA*evf_cu^(1/(1-ALFA))/mvf_cup)^ALFA*muz_cup^(NU*(1-GAMA)-1)*(c_cup/c_cu)^(NU*(1-GAMA)-1)*((1-n_cup)/(1-n_cu))^((1-NU)*(1-GAMA));
    
    % Actual model equations
    [name='Expected value of the value function']
    0 = -evf_cu + (mvf_cup/AA)^(1-ALFA);
    [name='The one period bond price']
    0 = - p_cu + BETTA*mu_la_cup*1/pai_cup;
    [name='The one period interest rate']
    0 = - 1 + BETTA*mu_la_cup*r_cu/pai_cup;
    [name='The FOC firms with respect to prices']
    0 = - mc_cu + (ETA-1)/ETA
                 - BETTA*(AA*evf_cu^(1/(1-ALFA))/mvf_cup)^ALFA*muz_cup^(NU*(1-GAMA))
                   *(c_cup/c_cu)^(NU*(1-GAMA)-1)*((1-n_cup)/(1-n_cu))^((1-NU)*(1-GAMA))
                   *XI/ETA*(pai_cup/PAIss-1)*pai_cup*y_cup/(PAIss*y_cu)
                 + XI/ETA*(pai_cu/PAIss-1)*pai_cu/PAIss;
    [name='The Taylor rule']
    0 = -log(r_cu/Rss) + RHOR*log(r_ba1/Rss)+ PHI_pai*log(pai_cu/PAIss) + PHI_y*log(y_cu/Yss) + epsR;
    [name='The output level']
    0 = -y_cu + a_cu*Kss^THETA*n_cu^(1-THETA);
    [name='The budget resource constraint']
    0 = -y_cu + c_cu + g_cu + DELTA*Kss;
    [name='Technology shocks']
    0 = -log(a_cu/Ass) + RHOA*log(a_ba1/Ass) + epsA;
    [name='Shocks to government spendings']
    0 = -log(g_cu/Gss) + RHOG*log(g_ba1/Gss) + epsG;
    [name='The variance of the nominal stochastic discount factor']
    0 = -varsdf_cu + (BETTA*mu_la_cup*1/pai_cup)^2-(1/r_cu)^2;
    
    #p1_cu = p_cu;
    #p1_cup = p_cup;
    #q1_cu = p_cu;
    #q1_cup = p_cup;
    @#for i in 2:40
    #p@{i}_cu   = exp(ln_p@{i});
    #p@{i}_cup  = exp(ln_p@{i}(+1));
    #q@{i}_cu   = exp(ln_q@{i});
    #q@{i}_cup  = exp(ln_q@{i}(+1));
    @#endfor
    
    %pricing kernels for models given risk neutral pricing (Q) and Rotemberg prices(P)
    #M_Q = 1/r_cu;
    #M_P = BETTA*mu_la_cup/pai_cup;
    
    % compute bond prices up to a given maturity using the log-transformation
    @#for i in 2:40
    [name='The yield curve: p@{i}']
    0 = -p@{i}_cu + M_P*p@{i-1}_cup;
    [name='The yield curve: q@{i}']
    0 = -q@{i}_cu + M_Q*q@{i-1}_cup;
    [name='The term premium: ln_tp@{i}']
    ln_tp@{i} = -1/@{i}*(ln_p@{i}-ln_q@{i});
    @#endfor
    
    % reporting
    [name='Δc_t: growth rate in consumption: annualized and in pct']
    Gr_C = 400*(log(MUZ) + ln_c - ln_c(-1));
    [name='π_t: inflation rate: annualized and in pct']
    Infl = 400*ln_pai;
    [name='r_t: short-term interest rate: annualized and in pct']
    R1 = 400*ln_r;
    [name='r40_t: long-term interest rate: annualized and in pct']
    R40 = 400*(-1/40*ln_p40);
    [name='r40_t-r_t: Slope of yield curve']
    Slope = R40 - R1;
    [name='P40_t: term premia: annualized basis points']
    TP = 400*ln_tp40;
    [name='xhr40_t: 10 year excess holding period return']
    xhr40 = (ln_p39 - ln_p40(-1) - ln_r(-1))*400;
end;


%--------------------------------------------------------------------------
% Steady State Computations
%--------------------------------------------------------------------------
steady_state_model;
    PSS = BETTA*MUZ^(NU*(1-GAMA)-1)/PAI;
    RSS = 1/PSS;
    MCSS = (ETA-1)/ETA;
    C_O_Y = ((1-NU)*N/(NU*(1-N)*MCSS*(1-THETA)))^-1;
    K_O_Y = (1-C_O_Y-G_O_Y)/DELTA;
    N_O_Y = (1/Ass*K_O_Y^(-THETA))^(1/(1-THETA));
    WSS = MCSS*(1-THETA)*(N_O_Y)^-1;
    CSS = WSS*NU*(1-N)/(1-NU);
    YSS = C_O_Y^-1*CSS;
    Kss = K_O_Y*YSS; % endogenous parameter
    MVFSS = CSS^(NU*(1-GAMA))*(1-N)^((1-NU)*(1-GAMA))/((1-GAMA)*(BETTA*MUZ^(NU*(1-GAMA))-1));
    AA  = MVFSS; % endogenous parameter
    EVFSS= (MVFSS/AA)^(1-ALFA);
    GSS = G_O_Y*YSS;
    MQ = 1/RSS;
    MP = BETTA*(AA*EVFSS^(1/(1-ALFA))/MVFSS)^ALFA*MUZ^(NU*(1-GAMA)-1)*(CSS/CSS)^(NU*(1-GAMA)-1)*((1-N)/(1-N))^((1-NU)*(1-GAMA))/PAI;
    ln_p       = log(PSS);
    ln_r       = log(RSS);
    ln_y       = log(YSS);
    ln_c       = log(CSS);
    ln_n       = log(N);
    ln_evf     = log(EVFSS);
    ln_pai     = log(PAI);
    varsdf     = 0;
    ln_a     = log(Ass); 
    ln_g     = log(GSS);
    ln_r_ba1 = ln_r;
    ln_a_ba1 = ln_a;
    ln_g_ba1 = ln_g;
    ln_p1  = ln_p*1;   ln_q1  = ln_p*1;   ln_tp1  = -1/1*(ln_p1-ln_q1);
    ln_p2  = ln_p*2;   ln_q2  = ln_p*2;   ln_tp2  = -1/2*(ln_p2-ln_q2);
    ln_p3  = ln_p*3;   ln_q3  = ln_p*3;   ln_tp3  = -1/3*(ln_p3-ln_q3);
    ln_p4  = ln_p*4;   ln_q4  = ln_p*4;   ln_tp4  = -1/4*(ln_p4-ln_q4);
    ln_p5  = ln_p*5;   ln_q5  = ln_p*5;   ln_tp5  = -1/5*(ln_p5-ln_q5);
    ln_p6  = ln_p*6;   ln_q6  = ln_p*6;   ln_tp6  = -1/6*(ln_p6-ln_q6);
    ln_p7  = ln_p*7;   ln_q7  = ln_p*7;   ln_tp7  = -1/7*(ln_p7-ln_q7);
    ln_p8  = ln_p*8;   ln_q8  = ln_p*8;   ln_tp8  = -1/8*(ln_p8-ln_q8);
    ln_p9  = ln_p*9;   ln_q9  = ln_p*9;   ln_tp9  = -1/9*(ln_p9-ln_q9);
    ln_p10 = ln_p*10;  ln_q10 = ln_p*10;  ln_tp10 = -1/10*(ln_p10-ln_q10);
    ln_p11 = ln_p*11;  ln_q11 = ln_p*11;  ln_tp11 = -1/11*(ln_p11-ln_q11);
    ln_p12 = ln_p*12;  ln_q12 = ln_p*12;  ln_tp12 = -1/12*(ln_p12-ln_q12);
    ln_p13 = ln_p*13;  ln_q13 = ln_p*13;  ln_tp13 = -1/13*(ln_p13-ln_q13);
    ln_p14 = ln_p*14;  ln_q14 = ln_p*14;  ln_tp14 = -1/14*(ln_p14-ln_q14);
    ln_p15 = ln_p*15;  ln_q15 = ln_p*15;  ln_tp15 = -1/15*(ln_p15-ln_q15);
    ln_p16 = ln_p*16;  ln_q16 = ln_p*16;  ln_tp16 = -1/16*(ln_p16-ln_q16);
    ln_p17 = ln_p*17;  ln_q17 = ln_p*17;  ln_tp17 = -1/17*(ln_p17-ln_q17);
    ln_p18 = ln_p*18;  ln_q18 = ln_p*18;  ln_tp18 = -1/18*(ln_p18-ln_q18);
    ln_p19 = ln_p*19;  ln_q19 = ln_p*19;  ln_tp19 = -1/19*(ln_p19-ln_q19);
    ln_p20 = ln_p*20;  ln_q20 = ln_p*20;  ln_tp20 = -1/20*(ln_p20-ln_q20);
    ln_p21 = ln_p*21;  ln_q21 = ln_p*21;  ln_tp21 = -1/21*(ln_p21-ln_q21);
    ln_p22 = ln_p*22;  ln_q22 = ln_p*22;  ln_tp22 = -1/22*(ln_p22-ln_q22);
    ln_p23 = ln_p*23;  ln_q23 = ln_p*23;  ln_tp23 = -1/23*(ln_p23-ln_q23);
    ln_p24 = ln_p*24;  ln_q24 = ln_p*24;  ln_tp24 = -1/24*(ln_p24-ln_q24);
    ln_p25 = ln_p*25;  ln_q25 = ln_p*25;  ln_tp25 = -1/25*(ln_p25-ln_q25);
    ln_p26 = ln_p*26;  ln_q26 = ln_p*26;  ln_tp26 = -1/26*(ln_p26-ln_q26);
    ln_p27 = ln_p*27;  ln_q27 = ln_p*27;  ln_tp27 = -1/27*(ln_p27-ln_q27);
    ln_p28 = ln_p*28;  ln_q28 = ln_p*28;  ln_tp28 = -1/28*(ln_p28-ln_q28);
    ln_p29 = ln_p*29;  ln_q29 = ln_p*29;  ln_tp29 = -1/29*(ln_p29-ln_q29);
    ln_p30 = ln_p*30;  ln_q30 = ln_p*30;  ln_tp30 = -1/30*(ln_p30-ln_q30);
    ln_p31 = ln_p*31;  ln_q31 = ln_p*31;  ln_tp31 = -1/31*(ln_p31-ln_q31);
    ln_p32 = ln_p*32;  ln_q32 = ln_p*32;  ln_tp32 = -1/32*(ln_p32-ln_q32);
    ln_p33 = ln_p*33;  ln_q33 = ln_p*33;  ln_tp33 = -1/33*(ln_p33-ln_q33);
    ln_p34 = ln_p*34;  ln_q34 = ln_p*34;  ln_tp34 = -1/34*(ln_p34-ln_q34);
    ln_p35 = ln_p*35;  ln_q35 = ln_p*35;  ln_tp35 = -1/35*(ln_p35-ln_q35);
    ln_p36 = ln_p*36;  ln_q36 = ln_p*36;  ln_tp36 = -1/36*(ln_p36-ln_q36);
    ln_p37 = ln_p*37;  ln_q37 = ln_p*37;  ln_tp37 = -1/37*(ln_p37-ln_q37);
    ln_p38 = ln_p*38;  ln_q38 = ln_p*38;  ln_tp38 = -1/38*(ln_p38-ln_q38);
    ln_p39 = ln_p*39;  ln_q39 = ln_p*39;  ln_tp39 = -1/39*(ln_p39-ln_q39);
    ln_p40 = ln_p*40;  ln_q40 = ln_p*40;  ln_tp40 = -1/40*(ln_p40-ln_q40);
    
    Gr_C = 400*log(MUZ);
    Infl = 400*log(PAI);
    R1 = 400*ln_r;
    R40 = 400*(-1/40*ln_p40);
    Slope = R40 - R1;
    TP = 400*ln_tp40;
    xhr40 = (ln_p39 - ln_p40 - ln_r)*400;
end;
steady; %important to compute steady-state first as this updates endogenous parameters


%--------------------------------------------------------------------------
% shock specification, note that we also allow for non-Gaussian epsA and compute oo_.dr.ghs3
%--------------------------------------------------------------------------
shocks;
    var epsA = 0.0075^2;
    var epsG = 0.004^2;
    var epsR = 0.003^2;
end;
stoch_simul(order=3,irf=0,nocorr,periods=0); % this computes all nonzero perturbation matrices in oo_.dr
% Get shock series and moments that are used in Andreasen (2012)
nSim = 2000000; % feel free to decrease this number if your computer struggles or takes too long!
[EXO,SIGMA3] = Andreasen_2012_get_shocks(M_.Sigma_e,M_.exo_names,nSim);

%--------------------------------------------------------------------------
% Simulations
%--------------------------------------------------------------------------
% choose which shocks to use Benchmark or CaseI
model_variant = "Benchmark";
% model_variant = "CaseI";

exo = EXO.(model_variant); 
sigma3 = SIGMA3.(model_variant); % choose third-product moments 
oo_.dr.ghs3 = get_ghs3(M_,oo_,sigma3); % with sigma3 we can compute ghs3, it will be zero for symmetric and nonzero for non-symmetric shocks

%% THE FOLLOWING PART SIMULATES THE MODEL USING FIRST-ORDER PERTURBATION
%% YOU ONLY NEED TO ADJUST THE FOLLOWING PART TO DO THIRD-ORDER SIMULATIONS

indx = M_.nstatic + (1:M_.nspred); % state variables in DR order
indy = find(ismember(M_.endo_names(oo_.dr.order_var),options_.varobs)); % observable (i.e. reported variables) in DR order (VAROBS)
indxy = [indx(:);indy(:)]; % joint index for state and observable variables
gx = oo_.dr.ghx(indxy,:); % only for xy variables
gu = oo_.dr.ghu(indxy,:); % only for xy variables

xy_ss = oo_.dr.ys(oo_.dr.order_var); xy_ss = xy_ss(indxy); % steady-state of x and y in DR order
xhat = zeros(length(indx),1); % we start in the steady-state
y = zeros(length(indy),nSim);
for t = 1:nSim
    u = exo(t,:)';
    xy = xy_ss + gx*xhat + gu*u;
    y(:,t) = xy((length(indx)+1):end);
end

%--------------------------------------------------------------------------
% Display empirical moments
%--------------------------------------------------------------------------
MOMS = zeros(length(options_.varobs),4);
for j = 1:length(indy)
    MOMS(j,1) = mean(y(j,:)');
    MOMS(j,2) = std(y(j,:)');
    MOMS(j,3) = skewness(y(j,:)');
    MOMS(j,4) = kurtosis(y(j,:)');
end
array2table(MOMS,'RowNames',options_.varobs,'VariableNames',{'MEAN','STD','SKEWNESS','KURTOSIS'})
