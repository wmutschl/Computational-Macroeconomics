%% PLOTS
options_.irf = 30;
PLOTVARS = ["nu" "ahat" "zhat" "yhat" "what" "nhat" "piehat_an" "Rhat_an" "rhat_an" "mchat"];
hh = dyn_figure(options_.nodisplay,'name',['Shock to ' tit]);
x = 0:options_.irf;
plt_nbr = 1;
for j = 1:length(PLOTVARS)
    subplot(4,3,plt_nbr);
    hold on;
    y = oo_.endo_simul(ismember(M_.endo_names,PLOTVARS(j)),3:(options_.irf+3));
    plot(x,y,'linewidth',2);
    title(PLOTVARS(j));
    grid on;
    hold off;
    plt_nbr = plt_nbr+1;
end
dyn_saveas(hh,[M_.dname, '/graphs/' M_.fname '_IRF_' tit],options_.nodisplay,options_.graph_format);

