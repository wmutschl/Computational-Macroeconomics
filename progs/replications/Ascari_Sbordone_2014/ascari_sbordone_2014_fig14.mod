%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Replicate Figure 14: Impulse Response Functions to a 1 Percent Positive Monetary Policy Shock
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
@#define LOGUTILITY=1
@#include "ascari_sbordone_2014_common.mod"
@#include "ascari_sbordone_2014_calib_common.inc"
VARPHI = 1;
% monetary policy according to footnote 67
PHI_PI = 2;
PHI_Y = 0.5/4;
RHO_I = 0.8;
steady;

shocks;
var eps_nu; stderr 1; % 1 percent monetary policy shock as interest rate is in logs
var eps_a; stderr 0;
var eps_zeta; stderr 0;
end;

set_param_value('TREND_INFLATION',0)
stoch_simul(irf=7,order=1,irf_plot_threshold=0,nograph,noprint) log_y log_pi log_r log_s log_i nu;
irf_0_trend_infl=oo_.irfs;
set_param_value('TREND_INFLATION',2)
stoch_simul(irf=7,order=1,irf_plot_threshold=0,nograph,noprint) log_y log_pi log_r log_s log_i nu;
irf_2_trend_infl=oo_.irfs;
set_param_value('TREND_INFLATION',4)
stoch_simul(irf=7,order=1,irf_plot_threshold=0,nograph,noprint) log_y log_pi log_r log_s log_i nu;
irf_4_trend_infl=oo_.irfs;
set_param_value('TREND_INFLATION',6)
stoch_simul(irf=7,order=1,irf_plot_threshold=0,nograph,noprint) log_y log_pi log_r log_s log_i nu;
irf_6_trend_infl=oo_.irfs;

figure('Name','Figure 14: Impulse Response Functions to a 1 Percent Positive Monetary Policy Shock ')
subplot(2,2,1)
    plot(0:options_.irf,[0 irf_0_trend_infl.log_y_eps_nu],'k-',...
         0:options_.irf,[0 irf_2_trend_infl.log_y_eps_nu],'b--',...
         0:options_.irf,[0 irf_4_trend_infl.log_y_eps_nu],'r-.',...
         0:options_.irf,[0 irf_6_trend_infl.log_y_eps_nu],'*-',...
         'LineWidth',2);
    ylim([-2.5 0.5]);
    title('Output');
subplot(2,2,2)
    plot(0:options_.irf,[0 irf_0_trend_infl.log_pi_eps_nu],'k-',...
         0:options_.irf,[0 irf_2_trend_infl.log_pi_eps_nu],'b--',...
         0:options_.irf,[0 irf_4_trend_infl.log_pi_eps_nu],'r-.',...
         0:options_.irf,[0 irf_6_trend_infl.log_pi_eps_nu],'*-',...
         'LineWidth',2);
    ylim([-0.80 0]);
    title('Inflation');
subplot(2,2,3)
    plot(0:options_.irf,[0 irf_0_trend_infl.log_r_eps_nu],'k-',...
         0:options_.irf,[0 irf_2_trend_infl.log_r_eps_nu],'b--',...
         0:options_.irf,[0 irf_4_trend_infl.log_r_eps_nu],'r-.',...
         0:options_.irf,[0 irf_6_trend_infl.log_r_eps_nu],'*-',...
         'LineWidth',2);
    ylim([0 1.4]);
    title('Real Interest Rate');
subplot(2,2,4)
    hh = plot(0:options_.irf,[0 irf_0_trend_infl.log_s_eps_nu],'k-',...
              0:options_.irf,[0 irf_2_trend_infl.log_s_eps_nu],'b--',...
              0:options_.irf,[0 irf_4_trend_infl.log_s_eps_nu],'r-.',...
              0:options_.irf,[0 irf_6_trend_infl.log_s_eps_nu],'*-',...
              'LineWidth',2);
    ylim([-0.8 0]);
    title('Price Dispersion');
    legend(hh,'\pi=0%','\pi=2%','\pi=4%','\pi=6%');