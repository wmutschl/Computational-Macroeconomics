%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Generate Figure 11: The Determinacy Region and Trend Inflation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
@#define LOGUTILITY=1
@#include "ascari_sbordone_2014_common.mod"
@#include "ascari_sbordone_2014_calib_common.inc"
VARPHI = 1;
% monetary policy according to footnote 67
PHI_PI = 2;
PHI_Y = 0.5/4;
RHO_I = 0;

% phi_pi_vec = linspace(0,5,200);
% phi_y_vec = linspace(-1,5,200);
% [phi_pi_mat,phi_y_mat] = ndgrid(phi_pi_vec,phi_y_vec);
% trend_inflation_vector = [0,2,4,6,8];
% Z_plot_total = zeros(size(phi_pi_mat));
% for trend_inflation_iter=1:length(trend_inflation_vector)
%     set_param_value('TREND_INFLATION',trend_inflation_vector(trend_inflation_iter));
%     info_mat=NaN(size(phi_pi_mat));
%     for phi_pi_iter=1:length(phi_pi_vec)
%         for phi_y_iter=1:length(phi_y_vec)
%             set_param_value('PHI_PI',phi_pi_mat(phi_pi_iter,phi_y_iter));
%             set_param_value('PHI_Y',phi_y_mat(phi_pi_iter,phi_y_iter));
%             [dr,info] = resol(0,M_,options_,oo_);
%             info_mat(phi_pi_iter,phi_y_iter) = info(1);
%         end
%     end
%     Z_plot = zeros(size(info_mat));
%     Z_plot(info_mat==0) = 1;
%     figure
%     contourf(phi_pi_mat,phi_y_mat,Z_plot,1)
%     Z_plot_total(info_mat==0) = trend_inflation_iter;
%     xlabel('\phi_\pi')
%     ylabel('\phi_y')
%     title([num2str(trend_inflation_vector(trend_inflation_iter)) '%'])
% end    
% 
% figure('Name','Figure 11: The Determinacy Region and Trend Inflation')
% contourf(phi_pi_mat,phi_y_mat,Z_plot_total,5);
% colormap(hot);
                
estimated_params;
PHI_PI,uniform_pdf,(0+6)/2,sqrt(12)^(-1)*(6-0);
PHI_Y,uniform_pdf,((-1)+6)/2,sqrt(12)^(-1)*(6-(-1));      
end;
 
varobs log_y log_pi; //some observables must be specified for sensitivity command, inessential for results
options_.nograph=0; %enable graphs again
 
trend_inflation_vector = [0,2,4,6,8];
for trend_inflation_iter=1:length(trend_inflation_vector)
    set_param_value('TREND_INFLATION',trend_inflation_vector(trend_inflation_iter));
    dynare_sensitivity(prior_range=0,stab=1,nsam=5000);
end