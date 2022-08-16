% =========================================================================
% MatrixAlgebra_Cholesky.m
% =========================================================================
% Decompose a covariance matrix using the Cholesky decomposition, i.e.
% SIGu = W*SIGe*W'
% =========================================================================
% Willi Mutschler, November 16, 2021
% willi@mutschler.eu
% =========================================================================
clearvars; clc; close all;

SIGu = [2.25 0 0; 0 1 0.5; 0 0.5 0.74];
P = chol(SIGu,'lower');
% Note that P = W*SIGe^(1/2)
SIGe_sqrt = diag(P);
SIGe = diag(SIGe_sqrt.^2); 
% Find W which is solution to equation W*SIGe^(1/2) = P
% - A\B (mldivide) solves A*x = B
% - A/B (mrdivide) solves x*B = A <-- we want this to get W
W = P/diag(SIGe_sqrt); 
isequal(W*SIGe*W',SIGu)