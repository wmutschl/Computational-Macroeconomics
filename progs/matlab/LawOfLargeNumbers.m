% =======================================================================
% LawOfLargeNumbers.m
% =======================================================================
% Illustration of the weak law of large numbers for several distributions:
% normal,uniform,geometric,student's t (finite and infinite variance),gamma.
% =======================================================================
% Willi Mutschler, October 27, 2021
% willi@mutschler.eu
% =======================================================================
%% Housekeeping
clearvars; clc;close all;

%% Initializations
T = 10000;                                  % maximum horizon of periods
z = nan(1,T); sig_z = 2; mu_z = 10;         % normal distribution
u = nan(1,T); a = 2; b = 4; mu_u = (a+b)/2; % uniform distribution
ge = nan(1,T); p = 0.2; mu_ge = (1-p)/p;    % geometric distribution
ga = nan(1,T); k=2; thet=2; mu_ga=k*thet;   % gamma distribution
st1 = nan(1,T); nu1 = 3; mu_st1 = 0;        % student t with finite variance
st2 = nan(1,T); nu2 = 2; mu_st2 = 0;        % student t with infinite variance

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
    % get random numbers with growing sample size
    Zt = ZZ(1:t);               % normal distribution
    Ut = UU(1:t);               % uniform distribution
    Get = GeGe(1:t);            % geometric distribution
    Gat = GaGa(1:t);            % gamma distribution
    ST1t = ST1(1:t);            % student t with finite variance
    ST2t = ST2(1:t);            % student t with infinite variance
    
    % Compute and store averages
    z(t) = mean(Zt);
    u(t) = mean(Ut);
    ge(t) = mean(Get);
    ga(t) = mean(Gat);
    st1(t) = mean(ST1t);
    st2(t) = mean(ST2t);
    
    waitbar(t/T); % update waitbar
end
close(wait); % close waitbar

%% Create plot for different distributions
figure('name','Law of Large Numbers for different distributions');
subplot(2,3,1); 
    plot(z); 
    line(0:T,repmat(mu_z,1,T+1),'linestyle','--','color','black'); 
    title('Normal');
subplot(2,3,2); 
    plot(u); 
    line(0:T,repmat(mu_u,1,T+1),'linestyle','--','color','black');
    title('Uniform');
subplot(2,3,3); 
    plot(ge); 
    line(0:T,repmat(mu_ge,1,T+1),'linestyle','--','color','black'); 
    title('Geometric');
subplot(2,3,4); 
    plot(ga); 
    line(0:T,repmat(mu_ga,1,T+1),'linestyle','--','color','black'); 
    title('Gamma');
subplot(2,3,5); 
    plot(st1); 
    line(0:T,repmat(mu_st1,1,T+1),'linestyle','--','color','black'); 
    title('Student''s t finite variance');
subplot(2,3,6); 
    plot(st2); 
    line(0:T,repmat(mu_st2,1,T+1),'linestyle','--','color','black'); 
    title('Student''s t infinite variance');      