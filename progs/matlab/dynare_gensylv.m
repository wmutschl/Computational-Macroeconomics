function E = dynare_gensylv(kron_prod,A,B,C0,D)
%function E = gensylv(kron_prod,A,B,C,D)
% Solves a Sylvester equation.
%
% INPUTS
%   kron_prod
%   A
%   B
%   C
%   D
%
% OUTPUTS
%   err      [double] scalar: 1 indicates failure, 0 indicates success
%   E
%
% ALGORITHM
%   none.
%
% SPECIAL REQUIREMENTS
%   none.

% Copyright © 1996-2020 Dynare Team
%
% This file is part of Dynare.
%
% Dynare is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Dynare is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Dynare.  If not, see <https://www.gnu.org/licenses/>.
C = C0;
for i=1:(kron_prod-1)
    C  = kron(C0,C);
end

x0 = sylvester3(A,B,C,D);
E  = sylvester3a(x0,A,B,C,D);


function x=sylvester3(a,b,c,d)
    % solves a*x+b*x*c=d where d is [n x m x p]
    
    % Copyright (C) 2005-2017 Dynare Team
    %
    % This file is part of Dynare.
    %
    % Dynare is free software: you can redistribute it and/or modify
    % it under the terms of the GNU General Public License as published by
    % the Free Software Foundation, either version 3 of the License, or
    % (at your option) any later version.
    %
    % Dynare is distributed in the hope that it will be useful,
    % but WITHOUT ANY WARRANTY; without even the implied warranty of
    % MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    % GNU General Public License for more details.
    %
    % You should have received a copy of the GNU General Public License
    % along with Dynare.  If not, see <https://www.gnu.org/licenses/>.
    
    n = size(a,1);
    m = size(c,1);
    p = size(d,3);
    x=zeros(n,m,p);
    if n == 1
        for j=1:p
            x(:,:,j)=d(:,:,j)./(a*ones(1,m)+b*c);
        end
        return
    end
    if m == 1
        for j=1:p
            x(:,:,j) = (a+c*b)\d(:,:,j);
        end
        return
    end
    [u,t]=schur(c);
    if isoctave
        [aa,bb,qq,zz]=qz(full(a),full(b));
        for j=1:p
            d(:,:,j)=qq*d(:,:,j)*u;
        end
    else
        [aa,bb,qq,zz]=qz(full(a),full(b),'real'); % available in Matlab version 6.0
        for j=1:p
            d(:,:,j)=qq*d(:,:,j)*u;
        end
    end
    i = 1;
    c = zeros(n,1,p);
    c1 = zeros(n,1,p);
    while i < m
        if t(i+1,i) == 0
            if i == 1
                c = zeros(n,1,p);
            else
                for j=1:p
                    c(:,:,j) = bb*(x(:,1:i-1,j)*t(1:i-1,i));
                end
            end
            x(:,i,:)=(aa+bb*t(i,i))\squeeze(d(:,i,:)-c);
            i = i+1;
        else
            if i == n
                c = zeros(n,1,p);
                c1 = zeros(n,1,p);
            else
                for j=1:p
                    c(:,:,j) = bb*(x(:,1:i-1,j)*t(1:i-1,i));
                    c1(:,:,j) = bb*(x(:,1:i-1,j)*t(1:i-1,i+1));
                end
            end
            bigmat = ([aa+bb*t(i,i) bb*t(i+1,i); bb*t(i,i+1) aa+bb*t(i+1,i+1)]);
            z = bigmat\squeeze([d(:,i,:)-c;d(:,i+1,:)-c1]);
            x(:,i,:) = z(1:n,:);
            x(:,i+1,:) = z(n+1:end,:);
            i = i + 2;
        end
    end
    if i == m
        for j=1:p
            c(:,:,j) = bb*(x(:,1:m-1,j)*t(1:m-1,m));
        end
        aabbt = (aa+bb*t(m,m));
        x(:,m,:)=aabbt\squeeze(d(:,m,:)-c);
    end
    for j=1:p
        x(:,:,j)=zz*x(:,:,j)*u';
    end
    
    % 01/25/03 MJ corrected bug for i==m (sign of c in x determination)
    % 01/31/03 MJ added 'real' to qz call
end


function [x0, flag]=sylvester3a(x0,a,b,c,dd)
    % solves iteratively ax+bxc=d
    
    % Copyright (C) 2005-2017,2020 Dynare Team
    %
    % This file is part of Dynare.
    %
    % Dynare is free software: you can redistribute it and/or modify
    % it under the terms of the GNU General Public License as published by
    % the Free Software Foundation, either version 3 of the License, or
    % (at your option) any later version.
    %
    % Dynare is distributed in the hope that it will be useful,
    % but WITHOUT ANY WARRANTY; without even the implied warranty of
    % MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    % GNU General Public License for more details.
    %
    % You should have received a copy of the GNU General Public License
    % along with Dynare.  If not, see <https://www.gnu.org/licenses/>.
    
    a_1 = inv(a);
    b = a_1*b;
    flag=0;
    for j=1:size(dd,3)
        d = a_1*dd(:,:,j);
        e = 1;
        iter = 1;
        while all(e > 1e-8) && iter < 500 %use all() to get a logical in case e is empty
            x = d-b*x0(:,:,j)*c;
            e = max(max(abs(x-x0(:,:,j))));
            x0(:,:,j) = x;
            iter = iter + 1;
        end
        if iter == 500
            sprintf('sylvester3a : Only accuracy of %10.8f is achieved after 500 iterations',e);
            flag=1;
        end
    end

end

function A = isoctave()

    % Copyright © 2013-2016 Dynare Team
    %
    % This file is part of Dynare.
    %
    % Dynare is free software: you can redistribute it and/or modify
    % it under the terms of the GNU General Public License as published by
    % the Free Software Foundation, either version 3 of the License, or
    % (at your option) any later version.
    %
    % Dynare is distributed in the hope that it will be useful,
    % but WITHOUT ANY WARRANTY; without even the implied warranty of
    % MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    % GNU General Public License for more details.
    %
    % You should have received a copy of the GNU General Public License
    % along with Dynare.  If not, see <https://www.gnu.org/licenses/>.
    
    A = exist('OCTAVE_VERSION');
end


end % main function end