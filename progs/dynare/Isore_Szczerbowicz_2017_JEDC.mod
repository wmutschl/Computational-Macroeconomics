% Disaster risk and preference shifts in a New Keynesian model
% by Marlène Isoré and Urszula Szczerbowicz
% Journal of Economic Dynamics and Control, June 2017
% (c) copyright Marlene Isore and Urszula Szczerbowicz. 
% Please, cite as: Isoré, M. and U. Szczerbowicz, "Disaster risk and preference shifts in a New Keynesian model", Journal of Economic Dynamics and Control, Volume 79, Pages 97–125, June 2017, https://doi.org/10.1016/j.jedc.2017.04.001 



%------------------------------------------------------------------------------------------%
%                 ENDOGENOUS VARIABLES                                                     % 
%------------------------------------------------------------------------------------------%

var 
theta       %probability of disaster
betatheta   %endogenous discount factor 
y           %output
c           %consumption
i           %investment
L           %labor
k           %capital
u           %capital utilization
ktilde      %effective capital
w           %wage
Pkr         %real rental rate of capital
Q           %stochastic discount factor 
pi          %inflation
pireset     %reset inflation
X1          %auxiliary variable 1 (reset inflation)
X2          %auxiliary variable 2 (reset inflation)
Omega       %price dispersion
mc          %marginal costs
v           %EZW value function
r           %nominal interest rate on bonds (disaster-riskfree bond main scenario)
rr          %real interest rate on bonds (disaster-riskfree bond main scenario)
rk          %return on capital
rp          %nominal risk premium
;

%------------------------------------------------------------------------------------------%
%                  EXOGENOUS VARIABLES                                                     % 
%------------------------------------------------------------------------------------------%

varexo 
etheta        %disaster probability shock 
er            %monetary policy shock
;

%------------------------------------------------------------------------------------------%
%                      PARAMETERS                                                          % 
%------------------------------------------------------------------------------------------%
parameters muz, beta0, delta0, zeta, upsilon, gamma, psi, psitilde, chi, alpha, varpi, tau, 
rhor, rhotheta, phipi, phiy, sigr, sigtheta, eta, yss, rss, iss, kss, piss, thetass, uss, betathetass, Delta;  

delta0 = 0.02;                  % depreciation rate of capital
upsilon = 6;                    % elasticity of substitution across monopolistic goods
alpha = 0.33;                   % labor share of production 
muz = 0.005;                    % trend growth of TFP

phipi = 1.6;                    % taylor rule inflation response
phiy = 0.4;                     % taylor rule output response
sigr = 1;                       % standard deviation of monetary policy shock
rhor =0.85;                     % interest rate smoothing parameter

psitilde = 2;                   % inverse of Elasticity of intertemporal substitution (EIS)
zeta = 0.6;                     % Calvo probability
gamma = 3.8;                    % risk-aversion
tau = 2;           			    % capital adjustment costs
varpi = 2.33;                   % leisure preference (Gourio, AER 2012)

Delta = 0.22;                   % fraction of capital destroyed in case of disaster realization
rhotheta = 0.9;                 % disaster probability smoothing parameter 
sigtheta = 0.6;                 % standard deviation of disaster risk shock


%------------------------------------------------------------------------------------------%
%                                 STEADY STATE                                             % 
%------------------------------------------------------------------------------------------%

piss = 1.005;                    % steady state inflation (inflation target)
thetass = 0.009;                 % steady state probability of disaster
uss = 1;                         % steady state utilization rate of capital
beta0 = 0.99;

psi=1-((1-psitilde)/(1+varpi));  % parameter transformation (Gourio, AER 2014) 
chi = 1- (1-gamma)/(1-psi);      % parameter transformation

betathetass = beta0 * ((1 - thetass + thetass * exp((1-gamma)*log(1-Delta)))^(1/(1-chi)));
Qss=betathetass*exp((1-psi)*muz)/((1-thetass*Delta)*exp(muz));
rss=(piss)/Qss;
eta=(1/(Qss*(1-thetass*Delta))-1)*1/delta0 +1;
pkrss=delta0*eta; %FOC wrt u
piresetss=(((piss)^(1-upsilon)-zeta)/(1-zeta))^(1/(1-upsilon));
mcss=((upsilon-1)/upsilon)*(1/(piss))*((1-(zeta*Qss*(1-thetass*Delta)*exp(muz)*(piss)^upsilon))/(1-(zeta*Qss*(1-thetass*Delta)*exp(muz)*(piss)^(upsilon-1))))*(piresetss);
klss=(mcss*alpha/pkrss)^(1/(1-alpha));
wss=mcss*(1-alpha)*(klss)^alpha;
omegass=((1-zeta)*(piresetss)^(-upsilon)*(piss)^upsilon)/(1-zeta*(piss)^upsilon);
clss=(1/omegass)*(klss)^alpha - klss*(exp(muz)-1+delta0);
lss=1/(1+(varpi/wss)*clss);
kss=klss*lss;
ktildess=kss;
css=clss*lss;
ylss=clss+klss*(exp(muz)-1+delta0);
yss=ylss*lss;
iss=yss-css;
X1ss=yss*mcss/(1-zeta*Qss*(1-thetass*Delta)*exp(muz)*(piss)^upsilon);
X2ss=yss/(1-zeta*Qss*(1-thetass*Delta)*exp(muz)*(piss)^(upsilon-1));
vss=(css*(1-lss)^varpi)^(1-psi) /(1-betathetass*exp(muz*(1-psi)));
rrss = rss/piss;
rkss = (1-Delta*thetass)*(pkrss + (1-delta0));
rpss = rkss*piss / rss;



%------------------------------------------------------------------------------------------%
%                                 MODEL                                                    % 
%------------------------------------------------------------------------------------------%

model;

// exogenous shock processes
log(theta)=(1-rhotheta)*log(thetass)+ rhotheta*log(theta(-1))+ etheta;

// Households
v = (c * (1-L)^varpi)^(1-psi) + betatheta * exp((1-psi)*muz) * (v(+1)^(1-chi))^(1/(1-chi));
betatheta = beta0 * ((1 - theta + theta * exp((1-gamma)*log(1-Delta)))^(1/(1-chi)));
pi(+1)/r * (1-theta*Delta)*exp(muz) = (c(+1)/c)^(-psi) * ((1-L(+1))/(1-L))^(varpi*(1-psi)) * betatheta * exp((1-psi)*muz) *v(+1)^(-chi)/(v(+1)^(1-chi))^(-chi/(1-chi));
(1-L)/c = varpi / w; 
Q = pi(+1)/r;
Q*Pkr(+1)*(u(+1) + 1/(delta0*eta*u(+1)^(eta-1)) * (1-delta0 * u(+1)^eta +tau*i(+1)/k * (i(+1)/k - iss/kss) - tau/2* (i(+1)/k - iss/kss)^2)) -1/(1-Delta*theta)* Pkr /(delta0*eta*u^(eta-1));
delta0*eta*u^(eta-1)/Pkr = 1-tau*(i/k(-1) - iss/kss);
k = ((1-delta0*u^eta) * k(-1) + (i/k(-1) - tau/2*((i/k(-1) - iss/kss)^2))*k(-1))/(exp(muz));

// Firms and price setting
y = ktilde^alpha * L^(1-alpha) / Omega;
w = mc * (1 - alpha) * (ktilde/L)^alpha;
Pkr = mc * alpha * (ktilde/L)^(alpha-1);
ktilde = u*k(-1);
pireset = pi*upsilon/(upsilon-1)*X1/X2;
Omega = (1-zeta)*pireset^(-upsilon)*pi^upsilon + zeta*pi^upsilon*Omega(-1);
pi^(1-upsilon) = (1-zeta)*pireset^(1-upsilon) + zeta;
X1 = y*mc + zeta*Q * (1-theta*Delta)*exp(muz)*X1(+1)*pi(+1)^upsilon;
X2 = y + zeta*Q * (1-theta*Delta)*exp(muz)*X2(+1)*pi(+1)^(upsilon-1);

// Asset pricing
rr = 1/Q;
rk = r/pi(+1);
rp = rk*pi(+1)/r;

// market clearing
y = c + i;

// Monetary policy
r= rhor*r(-1) + (1-rhor)*( phipi*(pi-piss) + phiy*(y-yss) + rss ) + sigr*er;

end;


%------------------------------------------------------------------------------------------%
%                          STEADY STATE INITIAL VALUES                                     % 
%------------------------------------------------------------------------------------------%

initval;
y = yss;
c = css;
i = iss;
L = lss;
u = uss;
k = kss;
ktilde = ktildess;
Omega = omegass;
pi = piss;
pireset = piresetss;
X1 = X1ss;
X2 = X2ss;
mc = mcss;
w = wss;
Pkr = pkrss;
theta = thetass;
r = rss;
betatheta = betathetass;
v = vss;
rr = rrss;
rp = rpss;
Q = Qss;
rk = rkss;

end;

resid(1);
check;

steady;

shocks;
var etheta; stderr sigtheta; 
var er; stderr 0;  
end;

stoch_simul(order=3, irf=0, periods=0, replic = 1, nograph); 

nShocks = M_.exo_nbr; 
nIrf = 14; % length of impulse responses
korder = 3; % order of Taylor expansions, MUST be the same as order= in the stoch_simul command 
%% Calculating the ergodic mean in the absence of shocks
burnin = 10000;
ex_=zeros(burnin, nShocks); % generate the shock innovation matrix
sim_path = simult_(M_,options_,oo_.dr.ys,oo_.dr, ex_, korder); 
ergodicmean = sim_path(:,end);
% this vector contains the ergodic means of all variables in the absence of shocks
initial_condition_states = repmat(ergodicmean,1,M_.maximum_lag); 
%% Calculating impulse response of c to etheta shock
%  setting up the simulation exercise where we study the response of
%  consumption to etheta shock. Size of shock is 0.01. 
%  The impulse response is % from the steady state
ex_=zeros(nIrf, nShocks); % generate the shock innovation matrix
% choose the shock etheta and first period and input value 0.01
ex_(1,varind('etheta',false()))=0.01;
% simulate the model starting from steady-state and with shock matrix ex_
c_path = simult_(M_,options_,initial_condition_states,oo_.dr, ex_, korder); 
% calculate the impulse response as the path of c relative to steady state,
% in percent.
ytoetheta_irf = 100*(c_path(varind('y',true),:)./initial_condition_states(varind('y',true)) - 1);
ctoetheta_irf = 100*(c_path(varind('c',true),:)./initial_condition_states(varind('c',true)) - 1);
itoetheta_irf = 100*(c_path(varind('i',true),:)./initial_condition_states(varind('i',true)) - 1);
Ltoetheta_irf = 100*(c_path(varind('L',true),:)./initial_condition_states(varind('L',true)) - 1);
ktoetheta_irf = 100*(c_path(varind('k',true),:)./initial_condition_states(varind('k',true)) - 1);
ktildetoetheta_irf = 100*(c_path(varind('ktilde',true),:)./initial_condition_states(varind('ktilde',true)) - 1);
utoetheta_irf = 100*(c_path(varind('u',true),:)./initial_condition_states(varind('u',true)) - 1);
betathetatoetheta_irf = 100*(c_path(varind('betatheta',true),:)./initial_condition_states(varind('betatheta',true)) - 1);
Qtoetheta_irf = 100*(c_path(varind('Q',true),:)./initial_condition_states(varind('Q',true)) - 1);
wtoetheta_irf = 100*(c_path(varind('w',true),:)./initial_condition_states(varind('w',true)) - 1);
Pkrtoetheta_irf = 100*(c_path(varind('Pkr',true),:)./initial_condition_states(varind('Pkr',true)) - 1);
Omegatoetheta_irf = 100*(c_path(varind('Omega',true),:)./initial_condition_states(varind('Omega',true)) - 1);
pitoetheta_irf = 100*(c_path(varind('pi',true),:)./initial_condition_states(varind('pi',true)) - 1);
piresettoetheta_irf = 100*(c_path(varind('pireset',true),:)./initial_condition_states(varind('pireset',true)) - 1);
mctoetheta_irf = 100*(c_path(varind('mc',true),:)./initial_condition_states(varind('mc',true)) - 1);
rtoetheta_irf = 100*(c_path(varind('r',true),:)./initial_condition_states(varind('r',true)) - 1);
rrtoetheta_irf = 100*(c_path(varind('rr',true),:)./initial_condition_states(varind('rr',true)) - 1);
vtoetheta_irf = 100*(c_path(varind('v',true),:)./initial_condition_states(varind('v',true)) - 1);
rktoetheta_irf = 100*(c_path(varind('rk',true),:)./initial_condition_states(varind('rk',true)) - 1);
rptoetheta_irf = 100*(c_path(varind('rp',true),:)./initial_condition_states(varind('rp',true)) - 1);

save Isore-Szczerbowicz_2017_JEDC.mat

% Figure 1 - JEDC paper
figure1= figure('Position', [100, 100, 1149, 995]);
axis tight;

subplot(3,3,1)
h1 = plot(betathetatoetheta_irf, 'LineWidth',1);figure(gcf)
title('\qquad Discount Factor $\beta(\theta)$','Interpreter','Latex','Fontsize',20)
set(gca,'Fontsize',20)

subplot(3,3,2)
h2 = plot(ytoetheta_irf, 'LineWidth',1);figure(gcf)
title('Output','Interpreter','Latex','Fontsize',20)
set(gca,'Fontsize',20)

subplot(3,3,3)
h3 = plot(ctoetheta_irf, 'LineWidth',1);figure(gcf)
title('Consumption','Interpreter','Latex','Fontsize',20)
set(gca,'Fontsize',20)

subplot(3,3,4)
h4 = plot(itoetheta_irf,   'LineWidth',1);figure(gcf)
title('Investment','Interpreter','Latex','Fontsize',20)
set(gca,'Fontsize',20)

subplot(3,3,5)
h5 = plot(Ltoetheta_irf, 'LineWidth',1);figure(gcf)
title('Labor','Interpreter','Latex','Fontsize',20)
set(gca,'Fontsize',20)

subplot(3,3,6)
h6 = plot(wtoetheta_irf,   'LineWidth',1);figure(gcf)
title('Wage','Interpreter','Latex','Fontsize',20)
set(gca,'Fontsize',20)

subplot(3,3,7)
h7 = plot(pitoetheta_irf,   'LineWidth',1);figure(gcf)
title('Inflation','Interpreter','Latex','Fontsize',20)
set(gca,'Fontsize',20)

subplot(3,3,8)
h8 = plot(rtoetheta_irf, 'LineWidth',1);figure(gcf)
title('Nominal Rate','Interpreter','Latex','Fontsize',20)
set(gca,'Fontsize',20)

subplot(3,3,9)
h9 = plot(rptoetheta_irf, 'LineWidth',1);figure(gcf)
title('$\, \, ~$ Risk Premium','Interpreter','Latex','Fontsize',20)
set(gca,'Fontsize',20)