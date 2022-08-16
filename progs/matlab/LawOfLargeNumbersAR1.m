% =======================================================================
% LawOfLargeNumbersAR1.m
% =======================================================================
% Illustration of the weak law of large numbers for the AR(1) process based
% on different error term distributions. Distributions considered:
% normal,uniform,geometric,student's t (finite and infinite variance),gamma.
% =======================================================================
% Willi Mutschler, October 27, 2021
% willi@mutschler.eu
% =======================================================================
%% Housekeeping
clearvars; clc;close all;

%% Initializations
T = 100000;                   % maximum horizon of periods
sig_z = 2; mu_z = 10;         % parameters for normal distribution
a = 2; b = 4; mu_u = (a+b)/2; % parameters for uniform distribution
p = 0.2; mu_ge = (1-p)/p;     % parameters for geometric distribution
k=2; thet=2; mu_ga=k*thet;    % parameters for gamma distribution
nu1 = 5; mu_st1 = 0;          % parameters for student t with finite variance
nu2 = 2; mu_st2 = 0;          % parameters for student t with infinite variance
phi=0.8; mu_y = 0;            % parameters for stable AR(1) process

Y = nan(T,6);                 % initialize output vector: sample size in rows, distributions in columns
%% Draw random variables
ZZ = mu_z + sig_z.*randn(1,T); % normal distribution
UU = a + (b-a).*rand(1,T);     % uniform distribution
GeGe = geornd(p,1,T);          % geometric distribution
GaGa = gamrnd(k,thet,1,T);     % gamma distribution
ST1 = trnd(nu1,1,T);           % student t with finite variance
ST2 = trnd(nu2,1,T);           % student t with infinite variance

%% Compute and store mean for growing sample sizes
wait = waitbar(0,'Please wait...'); % open waitbar
for t = 1:T    
    Yt = nan(t,6);  % initialize matrix for simulated data of sample size t in the rows
                    % different processes due to the 6 different error term distributions are in the columns
    Yt(1,:) = mu_y; % initialize the first observation with the unconditional mean
    
    if t>1
        for tt=2:t
            % Note that we demean the errors
            Yt(tt,1) = phi*Yt(tt-1,1) + (ZZ(tt)-mu_z);    % normal distribution with mean zero
            Yt(tt,2) = phi*Yt(tt-1,2) + (UU(tt)-mu_u);    % uniform
            Yt(tt,3) = phi*Yt(tt-1,3) + (GeGe(tt)-mu_ge); % geometric
            Yt(tt,4) = phi*Yt(tt-1,4) + (GaGa(tt)-mu_ga); % gamma 
            Yt(tt,5) = phi*Yt(tt-1,5) + (ST1(tt)-mu_st1); % finite variance student t
            Yt(tt,6) = phi*Yt(tt-1,6) + (ST2(tt)-mu_st2); % infinite variance student t
        end
    end
    % Compute and store averages
    Y(t,:) = mean(Yt,1);
    waitbar(t/T); % update waitbar
end
close(wait); % close waitbar

%% Create plot for AR(1) with different distributions
figure('name','Law of Large Numbers for stable AR(1)');
subplot(2,3,1); 
    plot(Y(:,1)); 
    line(0:T,repmat(mu_y,1,T+1),'linestyle','--','color','black'); 
    title('Normal errors');
subplot(2,3,2); 
    plot(Y(:,2)); 
    line(0:T,repmat(mu_y,1,T+1),'linestyle','--','color','black');
    title('Uniform errors');
subplot(2,3,3); 
    plot(Y(:,3)); 
    line(0:T,repmat(mu_y,1,T+1),'linestyle','--','color','black'); 
    title('Geometric errors');
subplot(2,3,4); 
    plot(Y(:,4));  
    line(0:T,repmat(mu_y,1,T+1),'linestyle','--','color','black'); 
    title('Gamma errors');
subplot(2,3,5); 
    plot(Y(:,5));  
    line(0:T,repmat(mu_y,1,T+1),'linestyle','--','color','black'); 
    title('Student''s t finite variance errors');
subplot(2,3,6); 
    plot(Y(:,6));
    line(0:T,repmat(mu_y,1,T+1),'linestyle','--','color','black'); 
    title('Student''s t infinite variance errors');        