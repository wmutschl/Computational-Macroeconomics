function [pi1,pi2,pi3] = ert_model_go_calibrate_pi(HH,varepsilon,pir,pid,pi1_shr_target,pi2_shr_target,RplusD_target,c_ss,n_ss)
% function [pi1,pi2,pi3] = ert_model_go_calibrate_pi(HH,varepsilon,pir,pid,pi1_shr_target,pi2_shr_target,RplusD_target,c_ss,n_ss)
% -------------------------------------------------------------------------
% calibrates probabilities to get infected in the SIR model in
% Eichenbaum, Rebelo, Trabandt (2022, JEDC): "Epidemics in the New Keynesian model"
% based on go_calibrate_pi.m and calibrate_pi.m from the original Dynare replication files
% kindly provided by the authors (downloaded from Mathias Trabandt's homepage)
% -------------------------------------------------------------------------
% INPUTS
% - HH              [integer]  horizon of simulation
% - varepsilon      [double]   initial seed of infection
% - pir             [double]   probability of recovering from infection
% - pid             [double]   probability of dying from infection
% - pi1_shr_target  [double]   share of T_0 jump due to consumption-based infections
% - pi2_shr_target  [double]   share of T_0 jump due to work-based infections
% - RplusD_target   [double]   total share of people infected and then either recovered or dead after epidemic
% - c_ss            [double]   pre-infection steady-state of consumption
% - n_ss            [double]   pre-infection steady-state of hours worked
% -------------------------------------------------------------------------
% OUTPUTS
% - pi1             [double]   probability of becoming infected as a result of time spent in consumption activities
% - pi2             [double]   probability of becoming infected as a result of time spent in working interactions
% - pi3             [double]   probability of becoming infected as a result of random meetings
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: May 18, 2023
% =========================================================================

% pi1, pi2, and pi3 have different scales, so we re-scale pi1 and pi2
% such that they have the same scale as pi3 (e.g. pi3=0.4997)
% we then optimize over [pi1*scale1; pi2*scale2; pi3]
scale1 = 1e6; % scale of pi1 for numerical solver as we expect very tiny pi1,
              % e.g. pi1=2.5648*1e-7 and pi1*scale1=0.2565
scale2 = 1e3; % scale of pi2 for numerical solver as we expect very small pi2,
              % e.g. pi2=1.5936*1e-4 and then pi2*scale2=0.1594

opts_fsolve = optimoptions('fsolve','Display','iter','TolFun',1e-7,'MaxFunctionEvaluations',1e5,'MaxIterations',4e3);

[sol,~,exitflag] = fsolve(@calibrate_pi, [0.2;0.2;0.2], opts_fsolve,...
                          HH,varepsilon,pir,pid,pi1_shr_target,pi2_shr_target,RplusD_target,c_ss,n_ss,scale1,scale2);
if exitflag~=1
    error('fsolve could not calibrate the SIR model');
else
    [err,pi1,pi2,pi3,RnotSIR] = calibrate_pi(sol,HH,varepsilon,pir,pid,pi1_shr_target,pi2_shr_target,RplusD_target,c_ss,n_ss,scale1,scale2);
    
    disp(['Max. abs. error in calibration targets:',num2str(max(abs(err)))]);
    disp([' ']);
    pi1=sol(1)/scale1
    pi2=sol(2)/scale2
    pi3=sol(3)
    RnotSIR
end

% helper function
function [err,pi1,pi2,pi3,RnotSIR,I,S,D,R,T] = calibrate_pi(pi_guess,HH,varepsilon,pir,pid,pi1_shr_target,pi2_shr_target,RplusD_target,C_ss,N_ss,scale1,scale2)
%back out initial guesses
pi1=pi_guess(1)/scale1; pi2=pi_guess(2)/scale2; pi3=pi_guess(3);
%pre-allocate
I=NaN*ones(HH+1,1); S=NaN*ones(HH+1,1); D=NaN*ones(HH+1,1); R=NaN*ones(HH+1,1); T=NaN*ones(HH,1);
%initial conditions
I(1)=varepsilon; S(1)=1-I(1); D(1)=0; R(1)=0;
%iterate on SIR model equations
for j=1:1:HH
    T(j,1)=pi1*S(j)*C_ss^2*I(j)+pi2*S(j)*N_ss^2*I(j)+pi3*S(j)*I(j);
    S(j+1,1)=S(j)-T(j);
    I(j+1,1)=I(j)+T(j)-(pir+pid)*I(j);
    R(j+1,1)=R(j)+pir*I(j);
    D(j+1,1)=D(j)+pid*I(j);
end
%calculate equation residuals for target equations (16) and (17) in paper
err(1) = pi1_shr_target-(pi1*C_ss^2)/(pi1*C_ss^2+pi2*N_ss^2+pi3);
err(2) = pi2_shr_target-(pi2*N_ss^2)/(pi1*C_ss^2+pi2*N_ss^2+pi3);
err(3) = RplusD_target-(R(end)+D(end));
RnotSIR=T(1)/I(1)/(pir+pid);
end % calibrate_pi end
 
end % Eichenbaum_Rebelo_Trabandt_2022_go_calibrate_pi end