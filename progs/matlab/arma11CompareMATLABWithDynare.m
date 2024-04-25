% compare simulations of ARMA(1,1) between MATLAB and Dynare
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: April 25, 2024
% -------------------------------------------------------------------------

%% housekeeping
clear global; clearvars; close all; clc;

%% Dynare simulation
% let's go into the folder with the mod file, run Dynare and return
oldfolder = cd('../dynare'); % go to folder of arma11.mod
dynare arma11
cd(oldfolder); % go back

% get values from Dynare
%   oo_.endo_simul contains simulations, it is of dimension [M_.endo_nbr by options_.periods]
%   oo_.exo_simul  contains exogenous variables drawn from normal distributions, it is of dimenstion [options_.periods by M_.exo_nbr]
x_from_Dynare = oo_.endo_simul(ismember(M_.endo_names,'x'),:); % row vector
x_from_Dynare = x_from_Dynare(:);                              % column vector
e_from_Dynare = oo_.exo_simul(:,ismember(M_.exo_names,'e'));   % column vector
std_dev = sqrt(M_.Sigma_e); % this is the standard error declared in the shocks block
THETA = M_.params(ismember(M_.param_names,'THETA'));
PHI   = M_.params(ismember(M_.param_names,'PHI'));
nobs = options_.periods;

% get same shock series that was used in Dynare by using the same seed in initialization of random number generators
set_dynare_seed('default');
e_from_MATLAB = std_dev*randn(nobs,1); % randn draws standard normally distributed variables
if isequal(e_from_MATLAB, e_from_Dynare)
    disp('shock series are equal');
else
    fprintf('shock series are not equal\n') % fprintf is more flexible than disp, the \n prints a new line
end

%% MATLAB simulation
x_from_MATLAB = arma11Simulate(THETA, PHI, e_from_MATLAB, 0);

%% comparison
if isequal(x_from_MATLAB, x_from_Dynare)
    fprintf('simulated series are the same\n');
else
    fprintf('simulated series are not the same, the maximum absolute deviation is %e:\n',norm(x_from_MATLAB - x_from_Dynare,'Inf'));
end

% CONCLUSION
% even though the difference is very small (1e-16 = 10^(-16)) and from a practical perspective irrelevant,
% it seems that Dynare is doing something different --> we need to understand the order=1 perturbation solver

%% exploding paths

% MATLAB simulation
THETA = 1.5;
PHI = 0.4;
x_exploding = arma11Simulate(THETA, PHI, e_from_MATLAB, 0);

figure('Name','Exploding paths');
subplot(2,1,1);
plot(1:50, x_exploding(1:50), 'LineWidth',2);
subplot(2,1,2);
plot(51:100, x_exploding(51:100), 'LineWidth',2);
sgtitle('exploding $x_t$','Interpreter','latex','FontSize',22);

% Dynare simulation
oldfolder = cd('../dynare'); % go to folder of arma11.mod
M_.params(ismember(M_.param_names,'THETA')) = 1.5; % change parameter inside Dynare structure
try
    % let's re-run the command Dynare uses for simulation without new preprocessing    
    [info, oo_, options_, M_] = stoch_simul(M_, options_, oo_, {});
catch ME
    disp('Error Message:');
    disp(ME.message);
end
cd(oldfolder); % go back

% CONCLUSION
% in MATLAB we can easily generate exploding paths for ARMA(1,1),
% but with Dynare we get an error: "Blanchard & Kahn conditions are not satisfied: no stable equilibrium."
% again: we need to look into the order=1 perturbation solver.