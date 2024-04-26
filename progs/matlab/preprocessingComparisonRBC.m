% comparison of preprocessing in Dynare and MATLAB of basic RBC model
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: April 26, 2024
% -------------------------------------------------------------------------

clearvars;

%% Dynare preprocessing
oldfolder = cd('../dynare'); % go to folder of rbc.mod
dynare rbc
cd(oldfolder);

%% MATLAB preprocessing
preprocessingRBC;
matlab_resid        = rbc_dynamic_resid(zzz_ss,ex_ss,M_.params,y_ss);
matlab_resid_static = rbc_static_resid(y_ss,ex_ss,M_.params);
matlab_g1           = rbc_dynamic_g1(zzz_ss,ex_ss,M_.params,y_ss);
matlab_g1_static    = rbc_static_g1(y_ss,ex_ss,M_.params);

%% comparison
matlab_resid - dynare_resid
matlab_resid_static - dynare_resid_static
matlab_g1 - dynare_g1
matlab_g1_static - dynare_g1_static