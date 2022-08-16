A = [0.5,   0,   0;
     0.1, 0.1, 0.3;
     0,   0.2, 0.3];
SIGu = [2.25 0 0; 0 1 0.5; 0 0.5 0.74];

theta = sym('theta');
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];

EV_A = eig(A);
disp(abs(EV_A)<1);

D = sym('d',[2 3]);
E = sym('e',[3 4]);
F = sym('f',[4 5]);
DEF = D*E*F;
vecDEF = DEF(:);
simplify(vecDEF - kron(transpose(F),D)*E(:))

simplify(transpose(R)*R)
simplify(R*transpose(R))
Rinv = R\eye(size(R,1));
simplify(transpose(R) - Rinv)

P = chol(SIGu,'lower');
sigeps = diag(P);
SIGeps = diag(sigeps.^2); 
W = P/diag(sigeps);       
W*SIGeps*W' - SIGu

tic
vecSIGy = (eye(size(A,1)^2)-kron(A,A))\SIGu(:);
SIGy_kron    = reshape(vecSIGy,size(A));
toc
tic
SIGy_dlyap1 = dlyapdoubling(A,SIGu);
toc
tic
SIGy_dlyap2 = dlyap(A,SIGu);
toc

norm(SIGy_kron-SIGy_dlyap1,'inf')
norm(SIGy_kron-SIGy_dlyap2,'inf')
