% compares two different ways (Kronecker formula and doubling algorithm)
% to compute the solution of the Lyapunov equation
% SIGy = A*SIGy*A' + SIGu
% -------------------------------------------------------------------------
% Willi Mutschler, April 26, 2024
% willi@mutschler.eu
% -------------------------------------------------------------------------
clearvars; clc; close all;

A = [0.5,   0,   0;
     0.1, 0.1, 0.3;
     0,   0.2, 0.3];
SIGu = [2.25 0 0; 0 1 0.5; 0 0.5 0.74];

vecSIGy   = (eye(size(A,1)^2)-kron(A,A)) \ SIGu(:);
SIGy_kron = reshape(vecSIGy,size(A));
SIGy_dlyap = dlyapdoubling(A,SIGu);

fprintf('The maximum absolute difference of entries is %d\n',norm(abs(SIGy_kron-SIGy_dlyap),'Inf'));