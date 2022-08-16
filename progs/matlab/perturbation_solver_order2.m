function PERT2 = perturbation_solver_order2(MODEL,ENDO_STST,EXO_STST,PERT1)

% get moment structure of shocks
SIGMA{1} = zeros(MODEL.exo_nbr,1); % first centered product moment: E[u]
SIGMA{2} = MODEL.Sigma_e(:); % second centered product moments: E[kron(u,u)]

%% Get dynamic Jacobians
y_     = transpose(MODEL.nstatic+(1:MODEL.nspred));          % index for state variables in DR order
yp     = transpose(MODEL.nstatic+MODEL.npred+(1:MODEL.nsfwrd)); % index for jumper variables in DR order
y_lag  = MODEL.lead_lag_incidence(1,MODEL.order_var);    % index for variables that appear at t-1, in DR order
y_curr = MODEL.lead_lag_incidence(2,MODEL.order_var);    % index for variables that appear at t, in DR order
y_lead = MODEL.lead_lag_incidence(3,MODEL.order_var);    % index for variables that appear at t+1, in DR order
z_nbr = nnz(MODEL.lead_lag_incidence) + MODEL.exo_nbr;       % number of dynamic variables in Jacobian (including exogenous)
[I,~] = find(MODEL.lead_lag_incidence');                  % index for dynamic variables that actually appear
% ENDO_STST(I) are the dynamic model variables [y^*_{t-1}, y_t, y^{**}_{t+1}] (without exogenous) evaluated at steady-state
fz1 = feval("preprocessed_" + MODEL.model_name + "_dynamic_g1",ENDO_STST(I),EXO_STST,MODEL.params,ENDO_STST);
fz2 = feval("preprocessed_" + MODEL.model_name + "_dynamic_g2",ENDO_STST(I),EXO_STST,MODEL.params,ENDO_STST);

% put Dynamic Jacobians into DR order
fy__back = fz1(:,nonzeros(y_lag));  % f_{y_{-}^{*}}
fy0_curr = fz1(:,nonzeros(y_curr)); % f_{y_{0}}
fyp_fwrd = fz1(:,nonzeros(y_lead)); % f_{y_{+}^{**}}
fu       = fz1(:,(z_nbr-MODEL.exo_nbr+1):end);
z1  = [nonzeros(MODEL.lead_lag_incidence(:,MODEL.order_var)'); nnz(MODEL.lead_lag_incidence)+(1:MODEL.exo_nbr)']; % index for columns in first dynamic derivative matrix g1
z2  = permute(reshape(1:z_nbr^2,z_nbr,z_nbr),[2 1]); % index for columns in second dynamic derivative matrix g2
fz1 = fz1(:,z1); % first partial derivative matrix in DR order
fz2 = fz2(:,z2(z1,z1)); % second partial derivative matrix in DR order

%% Second-order approximation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% organize stuff from lower order %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A  = PERT1.A;
B  = PERT1.B;
gx = PERT1.gx;
gu = PERT1.gu;
gs = PERT1.gs;

Gx  = gx(yp,:)*gx(y_,:);
Gu  = gx(yp,:)*gu(y_,:);
Gup = gu(yp,:);
Gs  = gx(yp,:)*gs(y_,:) + gs(yp,:);
zx  = [eye(MODEL.nspred);
       gx;
       Gx;
       zeros(MODEL.exo_nbr,MODEL.nspred)];
zu  = [zeros(MODEL.nspred,MODEL.exo_nbr);
       gu;
       Gu;
       eye(MODEL.exo_nbr)];
zup = [zeros(MODEL.nspred,MODEL.exo_nbr);
       zeros(MODEL.endo_nbr,MODEL.exo_nbr);
       Gup;
       zeros(MODEL.exo_nbr,MODEL.exo_nbr)];
zs  = [zeros(MODEL.nspred,1);
       gs;
       Gs;
       zeros(MODEL.exo_nbr,1)];

%%%%%%%%%%%%%%%
% Recover gxx %
%%%%%%%%%%%%%%%
Gcond_xx = zeros(MODEL.nsfwrd,MODEL.nspred*MODEL.nspred);
Fcond_xx = fyp_fwrd*Gcond_xx + fz2*kron(zx,zx);
gxx = dynare_gensylv(2,A,B,gx(y_,:),-Fcond_xx);

%%%%%%%%%%%%%%%
% Recover guu %
%%%%%%%%%%%%%%%
Gcond_uu = gxx(yp,:)*kron(gu(y_,:),gu(y_,:));
Fcond_uu = fyp_fwrd*Gcond_uu + fz2*kron(zu,zu);
guu = -(A\Fcond_uu);

%%%%%%%%%%%%%%%
% Recover gxu %
%%%%%%%%%%%%%%%
Gcond_xu = gxx(yp,:)*kron(gx(y_,:),gu(y_,:));
Fcond_xu = fyp_fwrd*Gcond_xu + fz2*kron(zx,zu);
gxu = -(A\Fcond_xu);

%%%%%%%%%%%%%%%
% Recover gxs %
%%%%%%%%%%%%%%%
Gxup = gxu(yp,:)*kron(gx(y_,:),eye(MODEL.exo_nbr));
Gcond_xs = gxx(yp,:)*kron(gx(y_,:),gs(y_,:));
Fxup = fyp_fwrd*Gxup + fz2*kron(zx,zup);
Fcond_xs = fyp_fwrd*Gcond_xs + fz2*kron(zx,zs);
D101 = Fxup*kron(eye(MODEL.nspred),SIGMA{1});
gxs = dynare_gensylv(1,A,B,gx(y_,:),-Fcond_xs-D101);

%%%%%%%%%%%%%%%
% Recover gus %
%%%%%%%%%%%%%%%
Guup = gxu(yp,:)*kron(gu(y_,:),eye(MODEL.exo_nbr));
Gcond_us = gxx(yp,:)*kron(gu(y_,:),gs(y_,:)) + gxs(yp,:)*gu(y_,:);
Fuup = fyp_fwrd*Guup + fz2*kron(zu,zup);
Fcond_us = fyp_fwrd*Gcond_us + fz2*kron(zu,zs);
D011 = Fuup*kron(eye(MODEL.exo_nbr),SIGMA{1});
gus = -(A\(Fcond_us+D011));

%%%%%%%%%%%%%%%
% Recover gss %
%%%%%%%%%%%%%%%
Gupup = guu(yp,:);
Gups  = gxu(yp,:)*kron(gs(y_,:),eye(MODEL.exo_nbr)) + gus(yp,:);
Fupup = fyp_fwrd*Gupup + fz2*kron(zup,zup);
Fups  = fyp_fwrd*Gups  + fz2*kron(zup,zs);
D002 = Fupup*SIGMA{2};
E002 = 2*Fups*SIGMA{1};
Gcond_ss = gxx(yp,:)*kron(gs(y_,:),gs(y_,:)) + 2*gxs(yp,:)*gs(y_,:);
Fcond_ss = fyp_fwrd*Gcond_ss + fz2*kron(zs,zs); % Fcond_ss
gss = -((A+B)\(Fcond_ss+D002+E002));

%% Store results
PERT2.gxx = gxx;
PERT2.gxu = gxu;
PERT2.gxs = gxs;
PERT2.guu = guu;
PERT2.gus = gus;
PERT2.gss = gss;