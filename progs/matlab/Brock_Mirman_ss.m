function [SS,PARAMS,error_indicator] = Brock_Mirman_ss(SS,PARAMS,MODEL)
% [SS,PARAMS,error_indicator] = Brock_Mirman_ss(SS,PARAMS,MODEL)
% =========================================================================
% computes the steady-state of the Brock and Mirman (1972) model analytically
% =========================================================================
% INPUTS
%   - SS     : vector with initial steady state values in declaration order
%              (usually empty, but might be useful for initial values
%               or to update endogenous parameters)
%	- params : vector with values for the parameters in declaration order
% ----------------------------------------------------------------------
% OUTPUTS
%   - SS     : vector with computed steady state values in declaration order
%	- params : vector with updated values for the parameters in declaration order
%   - error_indicator: 0 if no error when computing the steady-state
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: June 12, 2023
% =========================================================================
error_indicator = 0; % initialize no error

% read-out parameters
ALPHA = MODEL.params(MODEL.param_names=="ALPHA");
BETA = MODEL.params(MODEL.param_names=="BETA");

% compute steady-state analytically
a = 1;
k = (ALPHA*BETA*a)^(1/(1-ALPHA));
c = a*k^ALPHA-k;

% write to output structure
SS(MODEL.endo_names=="a",1) = a;
SS(MODEL.endo_names=="k",1) = k;
SS(MODEL.endo_names=="c",1) = c;

end