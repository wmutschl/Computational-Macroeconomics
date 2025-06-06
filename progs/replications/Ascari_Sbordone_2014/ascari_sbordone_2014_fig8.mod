%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Generate Figure 8: Trend Inflation and Steady-State Variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
@#define LOGUTILITY=1
@#include "ascari_sbordone_2014_common.mod"
@#include "ascari_sbordone_2014_calib_common.inc"
VARPHI = 1;
% monetary policy according to footnote 67
PHI_PI = 2;
PHI_Y = 0.5/4;
RHO_I = 0.8;

verbatim;

figure('Name','Trend Inflation and Steady-State Variables');
trend_inflation_vector = 0:0.5:8;
utility = NaN(length(trend_inflation_vector),1);
output = NaN(length(trend_inflation_vector),1);
marg_markup = NaN(length(trend_inflation_vector),1);
ave_markup = NaN(length(trend_inflation_vector),1);
price_adjust_gap = NaN(length(trend_inflation_vector),1);
for iter=1:length(trend_inflation_vector)
    set_param_value('TREND_INFLATION',trend_inflation_vector(iter));
    steady;
    utility(iter,1) = oo_.steady_state(strmatch('utility',M_.endo_names,'exact'));
    output(iter,1) = oo_.steady_state(strmatch('log_y',M_.endo_names,'exact'));
    marg_markup(iter,1) = oo_.steady_state(strmatch('log_marginal_markup',M_.endo_names,'exact'));
    ave_markup(iter,1) = oo_.steady_state(strmatch('log_average_markup',M_.endo_names,'exact'));
    price_adjust_gap(iter,1) = oo_.steady_state(strmatch('log_price_adjustment_gap',M_.endo_names,'exact'));
end

subplot(1,3,1)
    plot(trend_inflation_vector,(output-output(1,1))*100);
    xlabel('Annualized Trend Inflation');
    ylabel('Steady-state output');
subplot(1,3,2)
    plot(trend_inflation_vector,(ave_markup-ave_markup(1,1))*100,'-',...
         trend_inflation_vector,(marg_markup-marg_markup(1,1))*100,'--',...
         trend_inflation_vector,(price_adjust_gap-price_adjust_gap(1,1))*100,'.');
    xlabel('Annualized Trend Inflation');
    ylabel('SS price adj. gap, marg. and ave. markup');
subplot(1,3,3)
    plot(trend_inflation_vector,(utility-utility(1,1))./abs(utility(1,1))*100);
    xlabel('Annualized Trend Inflation');
    ylabel('Steady-state welfare');

end;