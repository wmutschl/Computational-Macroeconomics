%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Replicate Figure 13: Impulse Response Functions to a 1 Percent Positive Total Factor Productivity Shock
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
@#define LOGUTILITY=1
@#include "ascari_sbordone_2014_common.mod"
@#include "ascari_sbordone_2014_calib_common.inc"
VARPHI = 0; % p.713
% monetary policy according to footnote 67
PHI_PI = 1.5;
PHI_Y = 0.5/4;
RHO_I = 0;
steady;

shocks;
var eps_nu;   stderr 0;
var eps_a;    stderr 1; % 1 percent TFP shock (as shock is on log_a)
var eps_zeta; stderr 0;
end;

% consider panel A with RHO_A=0 and VARPHI=0
set_param_value('RHO_A',0);  set_param_value('VARPHI',0);

set_param_value('TREND_INFLATION',0);
stoch_simul(irf=14,order=1,nograph,noprint) log_y log_pi log_s;
irf_0_trend_infl = oo_.irfs;
set_param_value('TREND_INFLATION',2);
stoch_simul(irf=14,order=1,nograph,noprint) log_y log_pi log_s;
irf_2_trend_infl = oo_.irfs;
set_param_value('TREND_INFLATION',4);
stoch_simul(irf=14,order=1,nograph,noprint) log_y log_pi log_s;
irf_4_trend_infl = oo_.irfs;

figure('Name','Figure 13: Impulse Response Functions to a 1 Percent Positive Technology Shock')
subplot(3,3,1)
    plot(0:options_.irf,[0 irf_0_trend_infl.log_y_eps_a],'k-',...
         0:options_.irf,[0 irf_2_trend_infl.log_y_eps_a],'b--',...
         0:options_.irf,[0 irf_4_trend_infl.log_y_eps_a],'r-.',...
         'LineWidth',2);
    ylim([-0.05 0.15]);
    title('Output');
subplot(3,3,2)
    plot(0:options_.irf,[0 irf_0_trend_infl.log_pi_eps_a],'k-',...
         0:options_.irf,[0 irf_2_trend_infl.log_pi_eps_a],'b--',...
         0:options_.irf,[0 irf_4_trend_infl.log_pi_eps_a],'r-.',...
         'LineWidth',2);
    ylim([-0.08 0.02]);
    title('Inflation');
subplot(3,3,3)
    plot(0:options_.irf,[0 irf_0_trend_infl.log_s_eps_a],'k-',...
         0:options_.irf,[0 irf_2_trend_infl.log_s_eps_a],'b--',...
         0:options_.irf,[0 irf_4_trend_infl.log_s_eps_a],'r-.',...
         'LineWidth',2);
    ylim([-0.02 0.005]);title('Price Dispersion')

% consider panel B with RHO_A=0.95 and VARPHI=0
set_param_value('RHO_A',0.95);  set_param_value('VARPHI',0);

set_param_value('TREND_INFLATION',0)
stoch_simul(irf=14,order=1,nograph,noprint) log_y log_pi log_s;
irf_0_trend_infl=oo_.irfs;
set_param_value('TREND_INFLATION',2)
stoch_simul(irf=14,order=1,nograph,noprint) log_y log_pi log_s;
irf_2_trend_infl=oo_.irfs;
set_param_value('TREND_INFLATION',4)
stoch_simul(irf=14,order=1,nograph,noprint) log_y log_pi log_s;
irf_4_trend_infl=oo_.irfs;

subplot(3,3,4)
    plot(0:options_.irf,[0 irf_0_trend_infl.log_y_eps_a],'k-',...
         0:options_.irf,[0 irf_2_trend_infl.log_y_eps_a],'b--',...
         0:options_.irf,[0 irf_4_trend_infl.log_y_eps_a],'r-.',...
         'LineWidth',2);
    ylim([0 1.5]);
subplot(3,3,5)
    plot(0:options_.irf,[0 irf_0_trend_infl.log_pi_eps_a],'k-',...
         0:options_.irf,[0 irf_2_trend_infl.log_pi_eps_a],'b--',...
         0:options_.irf,[0 irf_4_trend_infl.log_pi_eps_a],'r-.',...
         'LineWidth',2);
    ylim([-0.4 0]);
subplot(3,3,6)
    plot(0:options_.irf,[0 irf_0_trend_infl.log_s_eps_a],'k-',...
         0:options_.irf,[0 irf_2_trend_infl.log_s_eps_a],'b--',...
         0:options_.irf,[0 irf_4_trend_infl.log_s_eps_a],'r-.',...
         'LineWidth',2);
    ylim([-0.65 0.2]);

% consider panel C with RHO_A=0.95 and VARPHI=3
set_param_value('RHO_A',0.95);  set_param_value('VARPHI',3);

set_param_value('TREND_INFLATION',0)
stoch_simul(irf=14,order=1,nograph,noprint) log_y log_pi log_s;
irf_0_trend_infl=oo_.irfs;
set_param_value('TREND_INFLATION',2)
stoch_simul(irf=14,order=1,nograph,noprint) log_y log_pi log_s;
irf_2_trend_infl=oo_.irfs;
set_param_value('TREND_INFLATION',4)
stoch_simul(irf=14,order=1,nograph,noprint) log_y log_pi log_s;
irf_4_trend_infl=oo_.irfs;

subplot(3,3,7)
    plot(0:options_.irf,[0 irf_0_trend_infl.log_y_eps_a],'k-',...
         0:options_.irf,[0 irf_2_trend_infl.log_y_eps_a],'b--',...
         0:options_.irf,[0 irf_4_trend_infl.log_y_eps_a],'r-.',...
         'LineWidth',2);
    ylim([0 1.55]);
subplot(3,3,8)
    plot(0:options_.irf,[0 irf_0_trend_infl.log_pi_eps_a],'k-',...
         0:options_.irf,[0 irf_2_trend_infl.log_pi_eps_a],'b--',...
         0:options_.irf,[0 irf_4_trend_infl.log_pi_eps_a],'r-.',...
         'LineWidth',2);
    ylim([-0.4 0]);
subplot(3,3,9)
    hh = plot(0:options_.irf,[0 irf_0_trend_infl.log_s_eps_a],'k-',...
              0:options_.irf,[0 irf_2_trend_infl.log_s_eps_a],'b--',...
              0:options_.irf,[0 irf_4_trend_infl.log_s_eps_a],'r-.',...
              'LineWidth',2);
    ylim([-1 0.5]);
    legend(hh,'pi=0%','pi=2%','pi=4%');