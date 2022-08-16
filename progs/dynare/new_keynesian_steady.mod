@#include "new_keynesian_common.inc"

%--------------------------------------------------------------------------
% Parametrization for quarterly models (follows mostly Gali (2015) Chapter 3)
%--------------------------------------------------------------------------
ALPHA    = 1/4;  % implies steady state labor income share of 0.75
BETA     = 0.99; % implies quarterly gross interest rate of 1.0101 (under price stability)
RHO_A    = 0.9;  % high persistent TFP process
RHO_Z    = 0.5;  % mild persistent preference shifter process
RHO_NU   = 0.5;  % mild persistent monetary policy shock
SIGMA    = 1;    % log utility, i.e. substitution effect equals income effect
VARPHI   = 5;    % inverse Frisch elasticity
PHI_PIE  = 1.5;  % original value used by Taylor, needs to be above 1
PHI_Y    = 0.5/4;% original value used by Taylor
THETA    = 3/4;  % Calvo probability, implies average duration of 1/(1-THETA)=4 quarters
EPSILON  = 9;    % implies (under price stability target) gross markup of EPSILON/(EPSILON-1)=1.125
PIESTAR  = 1+0.02/4; % central bank targets 2% annualy

%----------------------------------------------------------------
% compute steady state
%----------------------------------------------------------------
model_diagnostics;
steady;

%----------------------------------------------------------------
% optionally: compile latex
%----------------------------------------------------------------
write_latex_definitions;
write_latex_parameter_table;
write_latex_original_model;
write_latex_steady_state_model;
collect_latex_files;

path_to_pdflatex = '';
%path_to_pdflatex = '/usr/local/bin/'; % sometimes you need to adjust the path where pdflatex is, depending on your operating system
if system([ path_to_pdflatex 'pdflatex -halt-on-error -interaction=batchmode ' M_.fname '_TeX_binder.tex'])
    warning('TeX-File did not compile; you need to compile it manually')
end