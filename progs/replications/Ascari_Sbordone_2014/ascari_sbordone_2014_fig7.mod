%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Figure 7: The Cost of Price Dispersion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
@#define LOGUTILITY=1
@#include "ascari_sbordone_2014_common.mod"
@#include "ascari_sbordone_2014_calib_common.inc"
VARPHI = 1;
% monetary policy according to footnote 67
PHI_PI = 2;
PHI_Y = 0.5/4;
RHO_I = 0.8;
figure('Name','The Cost of Price Dispersion')

trend_inflation_vector = [2,4];
theta_vector = linspace(0.5,0.87,50);
output_loss = NaN(length(theta_vector),2);
for trend_inflation_iter=1:2
    set_param_value('TREND_INFLATION',trend_inflation_vector(trend_inflation_iter));
    for iter=1:length(theta_vector)
        set_param_value('THETA',theta_vector(iter));
        steady;
        output_loss(iter,trend_inflation_iter) = oo_.steady_state(strmatch('log_atilde',M_.endo_names,'exact'))*100;
    end
end
subplot(1,3,1)
    plot(theta_vector,output_loss(:,1)-output_loss(1,1),'-',...
         theta_vector,output_loss(:,2)-output_loss(1,2),'--'); % normalize relative to first value
    xlabel('\theta');
    ylim([-10 0]);
    xlim([0.5 0.9]);

set_param_value('THETA',0.75);
trend_inflation_vector = [2,4];
varepsilon_vector = linspace(1.01,14,50);
output_loss = NaN(length(varepsilon_vector),2);
for trend_inflation_iter=1:2
    set_param_value('TREND_INFLATION',trend_inflation_vector(trend_inflation_iter));
    for iter=1:length(varepsilon_vector)
        set_param_value('VAREPSILON',varepsilon_vector(iter));
        steady;
        output_loss(iter,trend_inflation_iter) = oo_.steady_state(strmatch('log_atilde',M_.endo_names,'exact'))*100;
    end
end
subplot(1,3,2)
    plot(varepsilon_vector,output_loss(:,1)-output_loss(1,1),'-',...
         varepsilon_vector,output_loss(:,2)-output_loss(1,2),'--'); %normalize relative to first value
    xlabel('\epsilon');
    ylim([-2 0]);
    xlim([0 15]);

set_param_value('THETA',0.75);    % reset to baseline
set_param_value('VAREPSILON',10); % reset to baseline
trend_inflation_vector = 0:0.5:8;
output_loss = NaN(length(trend_inflation_vector),1);
for iter=1:length(trend_inflation_vector)
    set_param_value('TREND_INFLATION',trend_inflation_vector(iter));
    steady;
    output_loss(iter,1) = oo_.steady_state(strmatch('log_atilde',M_.endo_names,'exact'))*100;
end
subplot(1,3,3)
    plot(trend_inflation_vector,output_loss)
    xlabel('Trend Inflation');
    ylim([-8 0]);
    xlim([0 10]);