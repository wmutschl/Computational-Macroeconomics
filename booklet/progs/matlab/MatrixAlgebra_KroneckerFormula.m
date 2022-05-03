% =======================================================================
% MatrixAlgebra_KroneckerFormula.m
% =========================================================================
% Show that vec(D*E*F) = kron(F',D)*vec(E) using MATLAB's symbolic toolbox
% =========================================================================
% Willi Mutschler, November 16, 2021
% willi@mutschler.eu
% =========================================================================
clearvars; clc; close all;

%% Some basics on the symbolic toolbox
syms x % create symbolic variable
% note that matlab does not simplify or expand by default! example:
f1 = (x - 2)^2;
f2 = x^2 - 4*x + 4;
expand(f1)
simplify(f2)
isequal(f1,f2)
isequal(expand(f1),f2)
isequal(f1,simplify(f2)) % note that simplify usually takes longer than expand

%% Show that vec(D*E*F) = kron(F',D)*vec(E)
dim = randi([1 10],1,4); % generate 4 random integers between 1 and 10 as dimensions
% create symbolic matrices
D = sym('d',[dim(1) dim(2)]);
E = sym('e',[dim(2) dim(3)]);
F = sym('f',[dim(3) dim(4)]);
DEF = D*E*F; % check whether matrix product is defined
vecDEF = DEF(:); %vectorization

% correct: compare expanded symbolic expressions
if isequal(expand(vecDEF),expand(kron(transpose(F),D)*E(:))) 
    fprintf('Expanded expressions are identical\n');
else
    error('Expanded expressions are not identical');
end