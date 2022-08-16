% =======================================================================
% MatrixAlgebra_Lyapunov.m
% =========================================================================
% Compares different ways to compute solution of Lyapunov equation
% SIGy = A*SIGy*A' + SIGu, i.e. analytically using the Kronecker formula
% and the doubling algorithm
% =========================================================================
% Willi Mutschler, November 16, 2021
% willi@mutschler.eu
% =========================================================================
clearvars; clc; close all;

A = [0.5,   0,   0;
     0.1, 0.1, 0.3;
     0,   0.2, 0.3];
SIGu = [2.25 0 0; 0 1 0.5; 0 0.5 0.74];

tic
vecSIGy = (eye(size(A,1)^2)-kron(A,A)) \ SIGu(:);
SIGy_kron    = reshape(vecSIGy,size(A));
toc

tic
SIGy_dlyap = dlyapdoubling(A,SIGu);
toc
fprintf('The maximum absolute difference of entries is %d\n',max(abs(SIGy_kron-SIGy_dlyap)))

% re-run to see that dlyapdoubling becomes faster (just-in-time compilation)