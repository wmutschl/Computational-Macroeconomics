function PERT1 = perturbation_solver_order1(MODEL,ENDO_STST,EXO_STST)

%% Get dynamic Jacobians
SIGMA{1} = zeros(MODEL.exo_nbr,1); % first centered product moment: E[u]

y_     = transpose(MODEL.nstatic+(1:MODEL.nspred));          % index for state variables in DR order
yp     = transpose(MODEL.nstatic+MODEL.npred+(1:MODEL.nsfwrd)); % index for jumper variables in DR order
y_lag  = MODEL.lead_lag_incidence(1,MODEL.order_var);    % index for variables that appear at t-1, in DR order
y_curr = MODEL.lead_lag_incidence(2,MODEL.order_var);    % index for variables that appear at t, in DR order
y_lead = MODEL.lead_lag_incidence(3,MODEL.order_var);    % index for variables that appear at t+1, in DR order
z_nbr = nnz(MODEL.lead_lag_incidence) + MODEL.exo_nbr;       % number of dynamic variables in Jacobian (including exogenous)
[I,~] = find(MODEL.lead_lag_incidence');                  % index for dynamic variables that actually appear
% ENDO_STST(I) are the dynamic model variables [y^*_{t-1}, y_t, y^{**}_{t+1}] (without exogenous) evaluated at steady-state
fz1 = feval("preprocessed_" + MODEL.model_name + "_dynamic_g1",ENDO_STST(I),EXO_STST,MODEL.params,ENDO_STST);

% put Dynamic Jacobians into DR order
fy__back = fz1(:,nonzeros(y_lag));  % f_{y_{-}^{*}}
fy0_curr = fz1(:,nonzeros(y_curr)); % f_{y_{0}}
fyp_fwrd = fz1(:,nonzeros(y_lead)); % f_{y_{+}^{**}}
fu = fz1(:,(z_nbr-MODEL.exo_nbr+1):end);
%z1 = [nonzeros(MODEL.lead_lag_incidence(:,MODEL.order_var)'); nnz(MODEL.lead_lag_incidence)+(1:MODEL.exo_nbr)']; % index for columns in first dynamic derivative matrix g1
%fz1 = fz1(:,z1); % first partial derivative matrix in DR order


%% First-order approximation
% See Villemot (2011) for details on the algorithm

%%%%%%%%%%%%%%
% Recover gx %
%%%%%%%%%%%%%%
% Get rid of static variables
pred0_nbr = nnz(ismember(transpose(MODEL.lead_lag_incidence(:,MODEL.order_var)>0), [1 1 0],'rows'));
fystatic_curr = fy0_curr(:,1:MODEL.nstatic); %submatrix with columns for static variables only
fypred_curr = fy0_curr(:,MODEL.nstatic+(1:pred0_nbr));
fyp_curr = fy0_curr(:,(MODEL.nstatic+pred0_nbr+1):end);
[QQ,~] = qr(fystatic_curr);
%norm(QQ*QQ'-eye(size(QQ,1)),'inf') % QQ is orthogonal
%norm(QQ'-inv(QQ),'inf') % QQ is orthogonal
%fQy0_curr = QQ'*fy0_curr;
%norm(fQy0_curr((M_.nstatic+1):end,1:M_.nstatic),'inf') % columns of static variables are zero in lower part by construction
% multiply with QQ' and focus on lower part
fQy__back    = QQ'*fy__back;     fQy__back    = fQy__back(MODEL.nstatic+1:end,:);
fQypred_curr = QQ'*fypred_curr;  fQypred_curr = fQypred_curr(MODEL.nstatic+1:end,:);
fQyp_curr    = QQ'*fyp_curr;     fQyp_curr    = fQyp_curr(MODEL.nstatic+1:end,:);
fQyp_fwrd    = QQ'*fyp_fwrd;     fQyp_fwrd    = fQyp_fwrd(MODEL.nstatic+1:end,:);

% Set up D and E matrices
[Drow1_nbr,Dcol1_nbr] = size(fQypred_curr);
Dcol3_nbr = size(fQyp_fwrd,2);
D = [fQypred_curr              zeros(Drow1_nbr,MODEL.nboth) fQyp_fwrd;
     zeros(MODEL.nboth,Dcol1_nbr) eye(MODEL.nboth)             zeros(MODEL.nboth,Dcol3_nbr);
     ];
Ecol1_nbr = size(fQy__back,2);
%Ecol2_nbr = size(fQyp_curr,2);
E = [-fQy__back                              -fQyp_curr;
     zeros(MODEL.nboth,Ecol1_nbr) eye(MODEL.nboth)             zeros(MODEL.nboth,MODEL.nfwrd);
     ];
%eig(D,E)
[T,S,Q,Z] = qz(D,E);
[T,S,Q,Z] = ordqz(T,S,Q,Z,'udo');
idx_stable_root    = 1:(size(Z,1) - MODEL.nsfwrd); % index of stable roots
idx_explosive_root = (MODEL.nspred+1:size(Z,1)); % index of explosive roots
Z = Z';
Z11 = Z(idx_stable_root,    idx_stable_root);
Z21 = Z(idx_explosive_root, idx_stable_root);
Z22 = Z(idx_explosive_root, idx_explosive_root);
S11 = S(idx_stable_root,    idx_stable_root);
T11 = T(idx_stable_root,    idx_stable_root);

% recover gxp
gxp = -Z22\Z21;
gxp = real(gxp); % because we did generalized complex Schur

% recover gx_
gx_ = (Z11')*inv(T11)*(S11)*inv(Z11');    
gx_ = real(gx_); % because we did generalized complex Schur    

% recover gxnonstatic
gxnonstatic = [gx_;gxp(MODEL.nboth+(1:MODEL.nfwrd),:)];

% recover gxstatic
% multiply with QQ' and focus on upper part
fcheckQy__back = QQ'*fy__back;  fcheckQy__back = fcheckQy__back(1:MODEL.nstatic,:);
fcheckQyp_fwrd = QQ'*fyp_fwrd;  fcheckQyp_fwrd = fcheckQyp_fwrd(1:MODEL.nstatic,:);
fcheckQy0_curr = QQ'*fy0_curr;  fcheckQy0_curr = fcheckQy0_curr(1:MODEL.nstatic,:);
fcheckQystatic_curr = fcheckQy0_curr(:,1:MODEL.nstatic);
fcheckQynonstatic_curr = fcheckQy0_curr(:,(MODEL.nstatic+1):end);
gxstatic = -fcheckQystatic_curr\(fcheckQy__back+fcheckQynonstatic_curr*gxnonstatic+fcheckQyp_fwrd*gxp*gx_);

% Combine to get gx
gx  = [gxstatic;gxnonstatic];    
    
%%%%%%%%%%%%%%%%%%%%%%%%%
% Perturbation Matrices %
%%%%%%%%%%%%%%%%%%%%%%%%%
A = zeros(MODEL.endo_nbr,MODEL.endo_nbr);
A(:,y_curr~=0) = fy0_curr;
A(:,y_) = A(:,y_) + fyp_fwrd*gxp;
B = zeros(MODEL.endo_nbr,MODEL.endo_nbr);
B(:,MODEL.nstatic+MODEL.npred+1:end) = fyp_fwrd;


%%%%%%%%%%%%%%
% Recover gu %
%%%%%%%%%%%%%%
gu  = -A\fu;
    
%%%%%%%%%%%%%%
% Recover gs %
%%%%%%%%%%%%%%
D001 = fyp_fwrd*gu(yp,:)*SIGMA{1};
gs = -((A+B)\D001);    

%% Store results
PERT1.gx = gx;
PERT1.gu = gu;
PERT1.gs = gs;
PERT1.A  = A;
PERT1.B  = B;