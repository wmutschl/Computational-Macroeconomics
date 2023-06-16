% =========================================================================
% plotting routines for impulse response functions computed by deterministic
% simulations with perfect_foresight_solver in the baseline New Keynesian
% model with monopolistic competition, Calvo price frictions, and
% investment adjustment costs.
% =========================================================================
options_.irf = 30;
PLOTVARS = ["hat_y" "hat_c" "hat_iv" "hat_h" "hat_k" "hat_rnom_ann"...
            "hat_w" "hat_rk_ann" "hat_pi_ann" "hat_rreal_ann"...
            "hat_mc" "nu" "hat_a" "hat_zeta"];
hh = dyn_figure(options_.nodisplay,'name',['Shock to ' tit]);
x = 0:options_.irf;
plt_nbr = 1;
for j = 1:length(PLOTVARS)
    y = oo_.endo_simul(ismember(M_.endo_names,PLOTVARS(j)),3:(options_.irf+3));
    if ~iszero(y)
        subplot(4,3,plt_nbr);
        hold on;    
        plot(x,y,'linewidth',2);
        title(PLOTVARS(j),'Interpreter','none');
        grid on;
        hold off;
        plt_nbr = plt_nbr+1;
    end
end