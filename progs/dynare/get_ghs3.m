function gsss = get_ghs3(M_,oo_,SIGMA3)
% get dynamic Jacobians from script files evaluated at non-stochastic steady-state
yp     = transpose(M_.nstatic+M_.npred+(1:M_.nsfwrd)); % index for jumper variables in DR order
z_nbr = nnz(M_.lead_lag_incidence) + M_.exo_nbr;       % number of dynamic variables in Jacobian (including exogenous)
[I,~] = find(M_.lead_lag_incidence');                  % index for dynamic variables that actually appear
[~, fz1, fz2, fz3] = feval([M_.fname,'.dynamic'], oo_.steady_state(I), oo_.exo_steady_state', M_.params, oo_.steady_state, 1); % in declaration order
fz3 = identification.unfold_g3(fz3,z_nbr);
z2 = permute(reshape(1:z_nbr^2,z_nbr,z_nbr),[2 1]); % index for columns in second dynamic derivative matrix g2
z3 = permute(reshape(1:z_nbr^3,z_nbr,z_nbr,z_nbr),[3 2 1]); % index for columns in third dynamic derivative matrix g3
fy0_curr = fz1(:,nonzeros(M_.lead_lag_incidence(2,oo_.dr.order_var))); % f_{y_{0}}
fyp_fwrd = fz1(:,nonzeros(M_.lead_lag_incidence(3,oo_.dr.order_var))); % f_{y_{+}^{**}}
fyp_fwrd2 = fz2(:,z2(nonzeros(M_.lead_lag_incidence(3,oo_.dr.order_var)),nonzeros(M_.lead_lag_incidence(3,oo_.dr.order_var)))); % f_{y_{+}^{**} y_{+}^{**}}
fyp_fwrd3 = fz3(:,z3(nonzeros(M_.lead_lag_incidence(3,oo_.dr.order_var)),nonzeros(M_.lead_lag_incidence(3,oo_.dr.order_var)),nonzeros(M_.lead_lag_incidence(3,oo_.dr.order_var)))); % f_{y_{+}^{**} y_{+}^{**} y_{+}^{**}}

% permutation matrix
iduuu = reshape(1:M_.exo_nbr^3,1,M_.exo_nbr,M_.exo_nbr,M_.exo_nbr);
Iuuu  = eye(M_.exo_nbr^3);
Puuu  = Iuuu(:,ipermute(iduuu,[1, 3,4, 2])) + Iuuu(:,ipermute(iduuu,[1, 2,4, 3])) + Iuuu(:,ipermute(iduuu,[1, 2,3, 4]));

A = zeros(M_.endo_nbr,M_.endo_nbr);
A(:,M_.lead_lag_incidence(2,oo_.dr.order_var)~=0) = fy0_curr;
A(:,M_.nstatic+(1:M_.nspred)) = A(:,M_.nstatic+(1:M_.nspred)) + fyp_fwrd*oo_.dr.ghx(yp,:);
B = zeros(M_.endo_nbr,M_.endo_nbr);
B(:,M_.nstatic+M_.npred+1:end) = fyp_fwrd;

rhs = (fyp_fwrd*oo_.dr.ghuuu(yp,:) + fyp_fwrd2*kron(oo_.dr.ghu(yp,:),oo_.dr.ghuu(yp,:))*Puuu + fyp_fwrd3*kron(oo_.dr.ghu(yp,:),kron(oo_.dr.ghu(yp,:),oo_.dr.ghu(yp,:))))*SIGMA3(:);
gsss = -((A+B)\rhs);

end % main function end
