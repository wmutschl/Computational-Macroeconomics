var
  y     ${Y}$        (long_name='output')
  c     ${C}$        (long_name='consumption')
  k     ${K}$        (long_name='capital')
  l     ${L}$        (long_name='labor')
  a     ${A}$        (long_name='productivity')
  r     ${R}$        (long_name='interest Rate')
  w     ${W}$        (long_name='wage')
  iv    ${I}$        (long_name='investment')
;

varexo
  ea  ${\varepsilon^A}$   (long_name='Productivity Shock')
;

parameters
  BETTA  ${\beta}$  (long_name='Discount Factor')
  DELT ${\delta}$ (long_name='Depreciation Rate')
  GAMA ${\gamma}$ (long_name='Consumption Utility Weight')
  PSSI   ${\psi}$   (long_name='Labor Disutility Weight')
  ALPH ${\alpha}$ (long_name='Output Elasticity of Capital')
  RHOA  ${\rho^A}$ (long_name='Persistence technology')
;

% Parameter calibration
ALPH = 0.35;
BETTA  = 0.99;
DELT = 0.025;
GAMA = 1;
PSSI   = 1.6;
RHOA  = 0.9;

model;
[name='intertemporal optimality (Euler)']
GAMA*c^(-1) = BETTA*GAMA*c(+1)^(-1)*(1-DELT+r(+1));
[name='labor supply']
w = - (-PSSI*(1-l)^(-1)) / (GAMA*c^(-1));
[name='capital accumulation']
k = (1-DELT)*k(-1) + iv;
[name='market clearing']
y = c + iv;
[name='production function']
y = a*k(-1)^ALPH*l^(1-ALPH);
[name='labor demand']
w = (1-ALPH)*y/l;
[name='capital demand']
r = ALPH*y/k(-1);
[name='total factor productivity']
log(a) = RHOA*log(a(-1)) + ea;
end;

initval;
 a = 1;
 r = 0.03;
 l = 1/3;
 y = 1.2;
 c = 0.9;
 iv = 0.35;
 k = 12;
 w = 2.25;
end;



steady;

%----------------------------------------------------------------
% optionally: compile latex
%----------------------------------------------------------------
write_latex_definitions;
write_latex_parameter_table;
write_latex_original_model;
collect_latex_files;

path_to_pdflatex = '';
%path_to_pdflatex = '/usr/local/bin/'; % sometimes you need to adjust the path where pdflatex is, depending on your operating system
if system([ path_to_pdflatex 'pdflatex -halt-on-error -interaction=batchmode ' M_.fname '_TeX_binder.tex'])
    warning('TeX-File did not compile; you need to compile it manually')
end