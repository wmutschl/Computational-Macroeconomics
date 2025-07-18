% very simple program to solve the standard growth model with projection methods using:
% - a simple grid
% - regular polynomial
%
% based on codes by Wouter den Haan

clear all
clc

% parameter values
params.BETA = 0.99;
params.ALPHA = 0.33;
params.DELTA = 0.025;
params.TAU = 4;
params.RHO   = 0.95;
params.SIGMA = 0.1;


% define grid
k_ss = (params.BETA*params.ALPHA/(1-params.BETA*(1-params.DELTA)))^(1/(1-params.ALPHA)); % steady-state capital
k_low    =  0.5*k_ss;
k_high   =  1.5*k_ss;
z_low    = -3*sqrt(params.SIGMA^2/(1-params.RHO^2));
z_high   =  3*sqrt(params.SIGMA^2/(1-params.RHO^2));
k_number =  10;
z_number =  10;
k_step   =  (k_high-k_low)/(k_number-1);
z_step   =  (z_high-z_low)/(z_number-1);

grid.k = (k_low:k_step:k_high)';
grid.z = (z_low:z_step:z_high)';
grid.z = exp(grid.z);

% generate nodes and weights for numerical integration
GH.number = 5;
[GH.nodes, GH.weights] = GaussHermite(GH.number);

% policy function
ln_c = @(k,z,coef) coef(1) + coef(2)*log(k) + coef(3)*log(z) + coef(4)*(log(k)).^2 + coef(5)*(log(z)).^2 + coef(6)*log(k).*log(z);

% initial value
coef_init = [0; 0; 0; 0; 0; 0];
% find solution by minimizing the errors on the grid
coef_opt = fminsearch(@projection_rbc_residual,coef_init,...
                      optimset('MaxFunEvals',1e5,'MaxIter',1e6,'TolFun',1e-7,'TolX',1e-7,'Display','Iter'),...
                      grid,GH,params,ln_c);

%% Plots

% plot for whole grid
figure;
fsurf(@(k,z) exp(ln_c(k,z,coef_opt)), [k_low k_high z_low z_high],'ShowContours','on')
title('Policy Function for consumption')
xlabel('k')
ylabel('z')
zlabel('c')

% plot the consumption choice as a function of the grid on k and for 3 values of z
figure;
k_grid_fine = (k_low:(k_high-k_low)/1000:k_high)';
plot(k_grid_fine,exp(ln_c(k_grid_fine,0.9,coef_opt)),...
     k_grid_fine,exp(ln_c(k_grid_fine,1.0,coef_opt)),...
     k_grid_fine,exp(ln_c(k_grid_fine,1.1,coef_opt)));
hold on;
plot(k_ss,exp(ln_c(k_ss,1,coef_opt)),'x')
legend({'z_t=0.9','z_t=1.0','z_t=1.1','steady-state'})
xlabel('k')
ylabel('c')
hold off;