@#include "Baxter_King_common.inc"

shocks;
var e_ivg = 0.01^2;
end;

ETA = 0.1;
stoch_simul(order=1,irf=30,nograph) y_obs c_obs iv_obs n_obs w_obs r_obs tr_obs
                             g_obs ivg_obs;
irfs_high_eta = oo_.irfs;

ETA = 0.05;
stoch_simul(order=1,irf=30,nograph) y_obs c_obs iv_obs n_obs w_obs r_obs tr_obs
                             g_obs ivg_obs;
irfs_low_eta = oo_.irfs;

verbatim;

PLOTVARS = ["y_obs" "c_obs" "iv_obs" "n_obs" "w_obs" "r_obs" "tr_obs"...
                             "g_obs" "ivg_obs"];
hh = dyn_figure(options_.nodisplay,'name','Productivity effect of government investment');

sgtitle('Impulse Response Function');
x = 0:(options_.irf-1);

for j = 1:length(PLOTVARS)
    subplot(3,3,j);
    y1 = irfs_high_eta.(strcat(PLOTVARS(j),'_e_ivg'));
    y2 = irfs_low_eta.(strcat(PLOTVARS(j),'_e_ivg'));
    plot(x,[y1;y2],'linewidth',2);
    hold on;
    yline(0,'--','linewidth',2);
    title(M_.endo_names_long(ismember(M_.endo_names,PLOTVARS(j))));
    hold off;
    if j==length(PLOTVARS)
        legend({'$\eta=0.1$','$\eta=0.05$'},'interpreter','latex');
    end
end

dyn_saveas(hh,[M_.dname, '/graphs/' M_.fname '_IRF_comparison' ],options_.nodisplay,options_.graph_format);


end;