% =======================================================================
% MatrixAlgebra_Rotation.m
% =======================================================================
% Show orthogonality of 2-dimensional rotation matrix using MATLAB's
% symbolic toolbox
% =======================================================================
% Willi Mutschler, November 16, 2021
% willi@mutschler.eu
% =======================================================================
clearvars; clc; close all;

theta = sym('theta');
R = [cos(theta), -sin(theta);
     sin(theta), cos(theta)];

simplify(transpose(R)*R)
simplify(R*transpose(R))
Rinv = R\eye(size(R,1));
simplify(transpose(R) - Rinv)
