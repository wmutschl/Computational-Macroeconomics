% =========================================================================
% simulate an ARMA(1,1) model and compare with simulation done in Dynare
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: April 14, 2023
% =========================================================================

% housekeeping
clear global; clearvars; close all; clc;

% let's first run the mod file with dynare so we can compare the simulations
oldfolder = cd('../dynare')
dynare arma_1_1
cd(oldfolder)

% store stuff from Dynare
dyn_x = transpose(oo_.endo_simul(1,:));
dyn_e = oo_.exo_simul(:,1);
sample_size = options_.periods;
std_dev = sqrt(M_.Sigma_e); % this is the standard error declared in the shocks block
THETA = M_.params(ismember(M_.param_names,'THETA'));
PHI = M_.params(ismember(M_.param_names,'PHI'));

% get same shock series that was used in Dynare by using the same seed
set_dynare_seed('default');
e = std_dev*randn(sample_size,1); % randn draws standard normally distributed variables
if isequal(e,dyn_e)
    disp('shock series are equal')
else
    fprintf('shock series are not equal\n') % fprintf is more flexible than disp, the \n prints a new line
end

% simulate
x = zeros(sample_size,1); % pre-allocate storage
x(1) = THETA*0 + e(1) - PHI*0; % first period t=1
for t = 2:sample_size
    x(t) = THETA*x(t-1) + e(t) - PHI*e(t-1);
end

if isequal(x,dyn_x)
    fprintf('simulated series are the same\n')
else
    fprintf('simulated series are not the same, the maximum absolute deviation is %e:\n',norm(x-dyn_x))    
end

% exploding paths
THETA = 1.5;
PHI = 0.4;
x = zeros(sample_size,1); % pre-allocate storage
x(1) = THETA*0 + e(1) - PHI*0; % first period t=1
for t = 2:sample_size
    x(t) = THETA*x(t-1) + e(t) - PHI*e(t-1);
end

figure;
subplot(2,1,1)
plot([1:50],x(1:50));
subplot(2,1,2)
plot([51:100],x(51:100));
sgtitle('exploding $x_t$','Interpreter','latex');