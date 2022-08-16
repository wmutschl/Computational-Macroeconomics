% Jermann(1998) - Asset pricing in production economies, Journal of Monetary Economics 41, pages 257-275
% This is the Ramsey model with adjustment costs
% Based on codes by Olaf Weeken and Michel Juillard
% Willi Mutschler (willi@mutschler.eu)
% 2022-06-22

%--------------------------------------------------------------------------
% variable declaration
%--------------------------------------------------------------------------
var
  c
  d
  erp1
  i
  k
  r1
  rf1
  w
  y
  z
  mu
; 

varexo ez;

//---------------------------------------------------------------------
// 2. Parameter declaration and calibration
//---------------------------------------------------------------------

parameters
  alf
  chihab
  xi
  delt
  tau
  g
  rho
  a1
  a2
  betstar
  bet
;

alf        = 0.36;    // capital share in production function
chihab     = 0.819;   // habit formation parameter
xi         = 1/4.3;   // capital adjustment cost parameter
delt       = 0.025;   // quarterly deprecition rate
g          = 1.005;   //quarterly growth rate (note zero growth =>g=1)
tau        = 5;       // curvature parameter with respect to c
rho        = 0.95;    // AR(1) parameter for technology shock

a1         = (g-1+delt)^(1/xi);             
a2         = (g-1+delt)-(((g-1+delt)^(1/xi))/(1-(1/xi)))*((g-1+delt)^(1-(1/xi))); 
betstar    = g/1.011138;
bet        = betstar/(g^(1-tau));             

//---------------------------------------------------------------------
// 3. Model declaration
//---------------------------------------------------------------------

model;  
g*k  = (1-delt)*k(-1) + ((a1/(1-1/xi))*(g*i/k(-1))^(1-1/xi)+a2)*k(-1);
d    = y - w - i; 
w    = (1-alf)*y;
y    = z*g^(-alf)*k(-1)^alf;
c    = w + d; 
mu   = (c-chihab*c(-1)/g)^(-tau)-chihab*bet*(c(+1)*g-chihab*c)^(-tau);
mu   = (betstar/g)*mu(+1)*(a1*(g*i/k(-1))^(-1/xi))*(alf*z(+1)*g^(1-alf)*
       (k^(alf-1))+((1-delt+(a1/(1-1/xi))*(g*i(+1)/k)^(1-1/xi)+a2))/
       (a1*(g*i(+1)/k)^(-1/xi))-g*i(+1)/k);
log(z) = rho*log(z(-1)) + ez;

rf1  = 1/((betstar/g)*mu(+1)/mu);
r1   = (a1*(g*i/k(-1))^(-1/xi))*(alf*z(+1)*g^(1-alf)*(k^(alf-1))+
       (1-delt+(a1/(1-1/xi))*(g*i(+1)/k)^(1-1/xi)+a2)/
       (a1*(g*i(+1)/k)^(-1/xi))-g*i(+1)/k);
erp1 = r1 - rf1;

end;

//---------------------------------------------------------------------
// 4. Initial values and steady state
//---------------------------------------------------------------------

steady_state_model;
rf1    = g/betstar;
r1     = g/betstar;
erp1   = r1-rf1;

z      = 1;
k      = (((g/betstar)-(1-delt))/(alf*g^(1-alf)))^(1/(alf-1));
y      = (g^(-alf))*k^alf;
w      = (1-alf)*y;
i      = (1-(1/g)*(1-delt))*k;
d      = y - w - i;
c      = w + d;

mu     = ((c-(chihab*c/g))^(-tau))-chihab*bet*((c*g-chihab*c)^(-tau));

end;

steady;                      

//---------------------------------------------------------------------
// 5. Shock declaration  
//                       
//---------------------------------------------------------------------

shocks;
var ez; stderr 0.01;  
end;

//stoch_simul(order=1) erp1, rf1, r1;
//stoch_simul(order=2) erp1, rf1, r1, y, z, c, d, mu, k;
stoch_simul(order=3, periods=50000, pruning) erp1, rf1, r1, y, z, c, d, mu, k;

