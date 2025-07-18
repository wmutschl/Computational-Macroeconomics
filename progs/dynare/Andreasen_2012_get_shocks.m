function [EXO,SIGMA3] = Andreasen_2012_get_shocks(Sigma_e,exo_names,nSim)
exo_nbr = length(exo_names);

%% Benchmark: shocks are Gaussian
SIGMA3.Benchmark = zeros(exo_nbr,exo_nbr,exo_nbr);
randn('seed',1) % this is the seed used in Andreasen (2012)
EXO.Benchmark = transpose(chol(Sigma_e)*randn(exo_nbr,nSim)); % draw from standard normal and multiply with standard deviations

%% Non-Symmetric: shocks are drawn from a mixed-normal
PHI = -38.6667; % this is the value used in Table 2 Non-Symmetric Case I
randn('seed',10); rand('seed',11); % this is the seed used in Andreasen (2012)
% draw from a mixed normal
tmpu = rand(nSim,1);
tmp1 = randn(nSim,1);
tmp2 = repmat(PHI,nSim,1) + randn(nSim,1)*0.00001;
epsA_skew = zeros(nSim,1);
for i=1:nSim
   if tmpu(i,1) < 0.9958
       epsA_skew(i,1) = tmp1(i,1);
   else
       epsA_skew(i,1) = tmp2(i,1);
   end
end
epsA_skew = (epsA_skew - repmat(mean(epsA_skew,1),nSim,1))./repmat(std(epsA_skew,1),nSim,1); %standardize
Moments_epsA_skew = zeros(4,1);
Moments_epsA_skew(1,1) = 0; % as we standardized
Moments_epsA_skew(2,1) = 1; % as we standardized
Moments_epsA_skew(3,1) = skewness(epsA_skew); % compute empirical skewness coefficient, this is the value of E[e_{a,t}^3] reported in Table 2
Moments_epsA_skew(4,1) = kurtosis(epsA_skew); % compute empirical kurtosis coefficient
% use same shocks as in Gaussian case, but switch out epsA
EXO.CaseI = EXO.Benchmark;
SIGMA3.CaseI = SIGMA3.Benchmark;
idepsA = ismember(exo_names,'epsA');
EXO.CaseI(:,idepsA) = sqrt(Sigma_e(idepsA,idepsA))*epsA_skew; % need to scale by the standard deviation
SIGMA3.CaseI(idepsA,idepsA,idepsA) = sqrt(Sigma_e(idepsA,idepsA))^3*Moments_epsA_skew(3,1); % use the third-order product moment and scale it by the standard deviation raised to the 3rd power to get SIGMA3
end
