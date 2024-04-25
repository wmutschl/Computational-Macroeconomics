function x = arma11Simulate(THETA, PHI, e, x0)
% x = arma11Simulate(THETA, PHI, e, x0)
% -------------------------------------------------------------------------
% simulate univariate ARMA(1,1) model
% x(t) - THETA * x(t-1) = e(t) - PHI * e(t-1) where e(t) ~ N(0,1)
% -------------------------------------------------------------------------
% INPUTS
%   THETA   [scalar]     AR coefficient
%   PHI     [scalar]     MA coefficient
%   e       [nobs by 1]  number of observations
%   x0      [scalar]     initial value for simulation
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: April 25, 2024
% -------------------------------------------------------------------------
nobs = length(e);
x = zeros(nobs, 1); % pre-allocate storage
for t = 1:nobs
    if t == 1
        x(t) = THETA * x0 + e(t) - PHI * 0;
    else
        x(t) = THETA * x(t-1) + e(t) - PHI * e(t-1);
    end
end