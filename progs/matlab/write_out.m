function write_out(Output, nameOfFunction, nameOfOutput, is_static, dynamic_names, endo_names, exo_names, param_names)
% function write_out(Output, nameOfFunction, nameOfOutput, is_static, dynamic_names, endo_names, exo_names, param_names)
% =========================================================================
% helper function to create MATLAB script files for the residuals and
% Jacobian of dynamic and static model equations of DSGE models, created
% with MATLAB's symbolic toolbox
% -------------------------------------------------------------------------
% INPUTS
% - Output          [symbolic matrix]  symbolic matrix that will be
%                                      written out into a script file
%                                      either residuals or Jacobian of
%                                      dynamic or static model equations
% - nameOfFunction  [string array]     name of function that'll be created
% - nameOfOutput    [string array]     name of output variable
% - is_static       [boolean]          indicator whether Output is based on
%                                      static or dynamic model equations
% - dynamic_names   [string array]     names of dynamic variables
% - endo_names      [string array]     names of endogenous variables
% - exo_names       [string array]     names of exogenous variables
% - param_names     [string array]     names of parameters
% -------------------------------------------------------------------------
% OUTPUTS
% - creates script file that are MATLAB funcions within current folder
%   for fast evaluation of residuals or Jacobian of static or dynamic model
%   equations of a DSGE model
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: May 5, 2023
% =========================================================================
filename = strcat(nameOfFunction,'.m');
% Delete old version of file (if it exists)
if exist(filename,'file') > 0
    delete(filename);
end
fileID = fopen(filename,'w');
if is_static
    fprintf(fileID,'function %s = %s(endo_vars,exo_vars,params)\n',nameOfOutput,nameOfFunction);
    fprintf(fileID,'\n%% Evaluate numerical values for endogenous variables\n');
    for j = 1:size(endo_names,1)
        fprintf(fileID,'%s = endo_vars(%d);\n',endo_names(j),j);
    end
else
    fprintf(fileID,'function %s = %s(dynamic_vars,exo_vars,params,steady_state)\n',nameOfOutput,nameOfFunction);
    fprintf(fileID,'\n%% Evaluate numerical values for dynamic variables\n');
    for j = 1:size(dynamic_names,1)
        fprintf(fileID,'%s = dynamic_vars(%d);\n',dynamic_names(j),j);
    end
end

fprintf(fileID,'\n%% Evaluate numerical values for exogenous variables\n');
for j = 1:size(exo_names,1)
    fprintf(fileID,'%s = exo_vars(%d);\n',exo_names(j),j);
end

fprintf(fileID,'\n%% Evaluate numerical values for parameters from params\n');
for j = 1:size(param_names,1)
    fprintf(fileID,'%s = params(%d);\n',param_names(j),j);
end

if ~is_static
    fprintf(fileID,'\n%% Evaluate numerical values for steady-state variables\n');
    for j = 1:size(endo_names,1)
        fprintf(fileID,'%s_stst = steady_state(%d);\n',endo_names(j),j);
    end
end

fprintf(fileID,'\n%% Initialize %s\n',nameOfOutput);
fprintf(fileID,'%s = zeros(%d, %d);',nameOfOutput,size(Output,1),size(Output,2));

fprintf(fileID,'\n%% Evaluate non-zero entries in %s\n',nameOfOutput);
[nonzero_row,nonzero_col,nonzero_vals] = find(Output);
for j = 1:size(nonzero_vals,1)
    fprintf(fileID,'%s(%d,%d) = %s;\n',nameOfOutput,nonzero_row(j),nonzero_col(j),char(nonzero_vals(j)));
end

fprintf(fileID,'\nend %% function end \n');
fclose(fileID);