@#include "Baxter_King_common.inc"

shocks;
var e_g = 0.01^2;
var e_ivg = 0.01^2;
end;

stoch_simul(order=1,irf=200) y_obs c_obs iv_obs n_obs w_obs r_obs tr_obs
                             g_obs ivg_obs;

verbatim; % verbatim tells the preprocessor to ignore the following commands but run them verbatim in MATLAB

PLOTVARS = ["y_obs" "c_obs" "iv_obs" "n_obs" "w_obs" "r_obs" "tr_obs"...
                             "g_obs" "ivg_obs"];
hh = dyn_figure(options_.nodisplay,'name','Stochastic Simulations: Gov. spending vs. investment');
sgtitle('Impulse Response Function');
x = 0:(options_.irf-1);

for j = 1:length(PLOTVARS)
    subplot(3,3,j);
    y1 = oo_.irfs.(strcat(PLOTVARS(j),'_e_g'));
    y2 = oo_.irfs.(strcat(PLOTVARS(j),'_e_ivg'));
    plot(x,[y1;y2],'linewidth',2);
    hold on;
    yline(0,'--','linewidth',2);
    title(M_.endo_names_long(ismember(M_.endo_names,PLOTVARS(j))));
    hold off;
    if j==length(PLOTVARS)
        legend({'Gov.spending','Gov.Investment'});
    end
end
dyn_saveas(hh,[M_.dname, '/graphs/' M_.fname '_IRF_comparison' ],options_.nodisplay,options_.graph_format);

end; %verbatim end