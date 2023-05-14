function do_plots(fig_title,irfhorizon,oo_,M_)
% function do_plots(fig_title,irfhorizon,oo_,M_)
% =========================================================================
% creates plots for deterministic simulations of a two-country New Keynesian DSGE model
% -------------------------------------------------------------------------
% INPUTS
% - fig_title    [string]      title of figure
% - irfhorizon   [integer]     number of periods to plot
% - oo_          [structure]   Dynare's output structure containing the results of the simulation
% - M_           [structure]   Dynare's model structure containing information on the model
% -------------------------------------------------------------------------
% Willi Mutschler (willi@mutschler.eu)
% Version: May 10, 2023
% =========================================================================

%% common settings for plots
col_H = "#7E2F8E";
col_F = "#0072BD";
width_lines = 2;
size_fonts = 16;

%% variable transformations
% variables in percentage deviation from steady-state
hat_yHH = 100*(oo_.endo_simul(M_.endo_names=="yHH",2:(irfhorizon+1))./oo_.endo_simul(M_.endo_names=="yHH",1) - 1);
hat_yFF = 100*(oo_.endo_simul(M_.endo_names=="yFF",2:(irfhorizon+1))./oo_.endo_simul(M_.endo_names=="yFF",1) - 1);
hat_cH = 100*(oo_.endo_simul(M_.endo_names=="cH",2:(irfhorizon+1))./oo_.endo_simul(M_.endo_names=="cH",1) - 1);
hat_cF = 100*(oo_.endo_simul(M_.endo_names=="cF",2:(irfhorizon+1))./oo_.endo_simul(M_.endo_names=="cF",1) - 1);

% variables in deviation from steady-state in basis points
hat_pi_annH = 100*100*(oo_.endo_simul(M_.endo_names=="pi_annH",2:(irfhorizon+1)) - oo_.endo_simul(M_.endo_names=="pi_annH",1));
hat_pi_annF = 100*100*(oo_.endo_simul(M_.endo_names=="pi_annF",2:(irfhorizon+1)) - oo_.endo_simul(M_.endo_names=="pi_annF",1));
hat_rnom_annH = 100*100*(oo_.endo_simul(M_.endo_names=="rnom_annH",2:(irfhorizon+1)) - 1);
hat_rnom_annF = 100*100*(oo_.endo_simul(M_.endo_names=="rnom_annF",2:(irfhorizon+1)) - oo_.endo_simul(M_.endo_names=="rnom_annF",1));
hat_tauH = 100*100*(oo_.endo_simul(M_.endo_names=="tauH",2:(irfhorizon+1)) - oo_.endo_simul(M_.endo_names=="tauH",1));
hat_tauF = 100*100*(oo_.endo_simul(M_.endo_names=="tauF",2:(irfhorizon+1)) - oo_.endo_simul(M_.endo_names=="tauF",1));

% variables in basis points
hat_eps_rH = 100*100*oo_.exo_simul(2:(irfhorizon+1),M_.exo_names=="eps_rH");
hat_eps_rF = 100*100*oo_.exo_simul(2:(irfhorizon+1),M_.exo_names=="eps_rF");


%% create figure
figure(name=fig_title);
sgtitle(fig_title,'FontSize',size_fonts+2);

subplot(2,3,1)
    title('Output')
    hold on;
    plot_hat_yHH = plot(0:(irfhorizon-1), hat_yHH, '-', 'LineWidth',width_lines,'Color',col_H);
    plot_hat_yFF = plot(0:(irfhorizon-1), hat_yFF, '-', 'LineWidth',width_lines,'Color',col_F);
    yline(0,'LineWidth',width_lines);
    set(gca,'FontSize',size_fonts);
    legend([plot_hat_yHH,plot_hat_yFF],{'HOME','FOREIGN'},'Location','NorthEast','Box', 'off');
    xlabel('Quarters'); ylabel(sprintf('%% dev. from initial SS\n(in Percent)'));
    xticks(0:2:(irfhorizon-1));
    grid on;
    hold off;

subplot(2,3,2)
    title('Consumption')
    hold on;
    plot_hat_cH = plot(0:(irfhorizon-1), hat_cH, '-', 'LineWidth',width_lines,'Color',col_H);
    plot_hat_cF = plot(0:(irfhorizon-1), hat_cF, '-', 'LineWidth',width_lines,'Color',col_F);
    yline(0,'LineWidth',width_lines);
    set(gca,'FontSize',size_fonts);
    legend([plot_hat_cH,plot_hat_cF],{'HOME','FOREIGN'},'Location','NorthEast','Box', 'off');
    xlabel('Quarters'); ylabel(sprintf('%% dev. from initial SS\n (in Percent)'));
    xticks(0:2:(irfhorizon-1));
    grid on;
    hold off;

subplot(2,3,3)
    title('Income Tax Rate');
    hold on;
    plot_hat_tauH = plot(0:(irfhorizon-1), hat_tauH, '-', 'LineWidth',width_lines,'Color',col_H);
    plot_hat_tauF = plot(0:(irfhorizon-1), hat_tauF, '-', 'LineWidth',width_lines,'Color',col_F);
    yline(0,'LineWidth',width_lines);
    set(gca,'FontSize',size_fonts);
    legend([plot_hat_tauH,plot_hat_tauF],{'HOME','FOREIGN'},'Location','NorthEast','Box', 'off');
    xlabel('Quarters'); ylabel(sprintf('Dev. from initial SS\n(in Basis Points)'));
    xticks(0:2:(irfhorizon-1));
    grid on;
    hold off;

subplot(2,3,4)
    title('Annualized Inflation');
    hold on;
    plot_hat_piH = plot(0:(irfhorizon-1), hat_pi_annH, '-', 'LineWidth',width_lines,'Color',col_H);
    plot_hat_piF = plot(0:(irfhorizon-1), hat_pi_annF, '-', 'LineWidth',width_lines,'Color',col_F);
    yline(0,'LineWidth',width_lines);
    set(gca,'FontSize',size_fonts);
    legend([plot_hat_piH,plot_hat_piF],{'HOME','FOREIGN'},'Location','NorthEast','Box', 'off');
    xlabel('Quarters'); ylabel(sprintf('Dev. from initial SS\n(in Basis Points)'));
    xticks(0:2:(irfhorizon-1));
    grid on;
    hold off;

subplot(2,3,5)
    title('Annualized Nominal Interest Rate');
    hold on;
    plot_hat_rnomH = plot(0:(irfhorizon-1), hat_rnom_annH, '-', 'LineWidth',width_lines,'Color',col_H);
    plot_hat_rnomF = plot(0:(irfhorizon-1), hat_rnom_annF, '-', 'LineWidth',width_lines,'Color',col_F);
    yline(0,'LineWidth',width_lines);
    set(gca,'FontSize',size_fonts);
    legend([plot_hat_rnomH,plot_hat_rnomF],{'HOME','FOREIGN'},'Location','NorthEast','Box', 'off');
    xlabel('Quarters'); ylabel(sprintf('Basis Points'));
    xticks(0:2:(irfhorizon-1));
    grid on;
    hold off;

subplot(2,3,6)
    title('Monetary Policy shock');
    hold on;
    plot_hat_eps_rH = plot(0:(irfhorizon-1), hat_eps_rH, '-', 'LineWidth',width_lines,'Color',col_H);
    plot_hat_eps_rF = plot(0:(irfhorizon-1), hat_eps_rF, '-', 'LineWidth',width_lines,'Color',col_F);
    yline(0,'LineWidth',width_lines);
    set(gca,'FontSize',size_fonts);
    legend([plot_hat_eps_rH,plot_hat_eps_rF],{'HOME','FOREIGN'},'Location','NorthEast','Box', 'off');
    xlabel('Quarters'); ylabel(sprintf('Basis Points'));
    xticks(0:2:(irfhorizon-1));
    grid on;
    hold off;
