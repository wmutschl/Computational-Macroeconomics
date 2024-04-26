function SIGy = dlyapdoubling(A,SIGu)
% SIGy = dlyapdoubling(A,SIGu)
% -------------------------------------------------------------------------
% solves the Lyapunov equation SIGy = A*SIGy*A' + SIGu using the doubling algorithm
% -------------------------------------------------------------------------
% INPUT
%   - A     : square matrix [n x n] (usually autoregressive or state-space matrix)
%   - SIGu  : square matrix (n x n] (usually covariance matrix of shocks)
% -------------------------------------------------------------------------
% OUTPUT
%	- SIGy: square matrix (usually covariance matrix) [n x n] that solves the Lyapunov equation
% -------------------------------------------------------------------------
% Willi Mutschler, April 26, 2024
% willi@mutschler.eu
% -------------------------------------------------------------------------

max_iter   = 500;
A_old      = A;
SIGu_old   = SIGu;
SIGy_old   = eye(size(A));
difference = .1;
index1     = 1;
tol        = 1e-25;
while (difference > tol) && (index1 < max_iter)
    SIGy       = A_old*SIGy_old*transpose(A_old) + SIGu_old;
    difference = max(abs(SIGy(:)-SIGy_old(:)));
    SIGu_old   = A_old*SIGu_old*transpose(A_old) + SIGu_old;
    A_old      = A_old*A_old;
    SIGy_old   = SIGy;
    index1     = index1 + 1;
end

end %function end