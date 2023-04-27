% =======================================================================
% Illustration how to compute Eigenvalues of a matrix
% =======================================================================
% Willi Mutschler, April 24, 2023
% willi@mutschler.eu
% =======================================================================
clearvars; clc; close all; % housekeeping
A = [0.5,   0,   0;
     0.1, 0.1, 0.3;
     0,   0.2, 0.3];
EV_A = eig(A);
if all(abs(EV_A)<1)
    fprintf('All Eigenvalues are inside the unit circle\n')
end