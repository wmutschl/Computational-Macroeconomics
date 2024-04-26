function ert_model_plot_by_type_results(epidemic_type,M_,oo_)
% function ert_model_plot_by_type_results(epidemic_type,M_,oo_)
% -------------------------------------------------------------------------
% create plots of consumption and hours by population type from the New Keynesian Model of
% Eichenbaum, Rebelo, Trabandt (2022, JEDC): "Epidemics in the New Keynesian model"
% based on plot_by_type_results.m from the original Dynare replication files
% kindly provided by the authors (downloaded from Mathias Trabandt's homepage)
% -------------------------------------------------------------------------
% INPUTS
% - epidemic_type  [string]     type of epidemic, possible values:
%                               "demand", "supply", "both"
% - M_             [structure]  Dynare's model structure
% - oo_            [structure]  Dynare's results structure
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: May 18, 2023
% =========================================================================

% common settings for plots
fsize = 12;
horz  = 100;
time  = 0:1:horz-1;

% title for figure
if epidemic_type == "demand"
    strtitle = "Response of consumption and hours when epidemic is a shock to demand";
elseif epidemic_type == "supply"
    strtitle = "Response of consumption and hours when epidemic is a shock to supply";
elseif epidemic_type == "both"
    strtitle = "Response of consumption and hours when epidemic is a shock to both demand and supply";
end
figure('name',strtitle,'units','normalized','outerposition',[0 0 0.75 0.75]);

% Consumption by Type
c_ss = oo_.steady_state(M_.endo_names=="c");
cs = oo_.endo_simul(M_.endo_names=="cs",:);
ci = oo_.endo_simul(M_.endo_names=="ci",:);
cr = oo_.endo_simul(M_.endo_names=="cr",:);
subplot(1,2,1);
hold on;
plot(time(1:end-1),100*(cs(2:horz)-c_ss)/c_ss,'r--','LineWidth',2);
plot(time(1:end-1),100*(ci(2:horz)-c_ss)/c_ss,'k-.','LineWidth',2);
plot(time(1:end-1),100*(cr(2:horz)-c_ss)/c_ss,'m:','LineWidth',2);
plot(time(1:end-1),0*time(1:end-1),'b-','LineWidth',1);
hold off
box off;
title('Consumption by Type','FontSize',fsize);
ylabel('% Dev. from initial steady-state','FontSize',fsize);
xlabel('Weeks','FontSize',fsize);
set(gca,'FontSize',fsize);
legend('Susceptibles','Infected','Recovered','Location','SouthEast');
legend boxoff

% Hours by Type
n_ss = oo_.steady_state(M_.endo_names=="n");
ns = oo_.endo_simul(M_.endo_names=="ns",:);
ni = oo_.endo_simul(M_.endo_names=="ni",:);
nr = oo_.endo_simul(M_.endo_names=="nr",:);
subplot(1,2,2);
hold on;
plot(time(1:end-1),100*(ns(2:horz)-n_ss)/n_ss,'r--','LineWidth',2);
plot(time(1:end-1),100*(ni(2:horz)-n_ss)/n_ss,'k-.','LineWidth',2);
plot(time(1:end-1),100*(nr(2:horz)-n_ss)/n_ss,'m:','LineWidth',2);
plot(time(1:end-1),0*time(1:end-1),'b-','LineWidth',1);
hold off
box off;
title('Hours by Type','FontSize',fsize);
ylabel('% Dev. from initial steady-state','FontSize',fsize);
xlabel('Weeks','FontSize',fsize);
set(gca,'FontSize',fsize);
legend('Susceptibles','Infected','Recovered','Location','best');
legend boxoff
 
if epidemic_type == "demand"
    suptitle("Figure 6: " + strtitle);
elseif epidemic_type == "supply"
    suptitle("Figure 8: " + strtitle);
elseif epidemic_type == "both"
    suptitle("Figure 10: " + strtitle);
end