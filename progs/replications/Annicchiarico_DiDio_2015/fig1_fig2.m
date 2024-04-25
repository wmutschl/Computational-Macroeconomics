%% no policy
dynare ann_dio_2015_irfs_no_policy;
for jvar = 1:size(var_list_,1)  
    for jexo = 1:2
        no_policy.(M_.exo_names{jexo}).(var_list_{jvar}) = oo_.irfs.(sprintf('%s_%s',var_list_{jvar},M_.exo_names{jexo}))./oo_.steady_state(M_.endo_names==string(var_list_{jvar}));
    end
end
clearvars -except no_policy;

%% cap and trade
dynare ann_dio_2015_irfs_cap_and_trade;
for jvar = 1:size(var_list_,1)  
    for jexo = 1:2
        cap_and_trade.(M_.exo_names{jexo}).(var_list_{jvar}) = oo_.irfs.(sprintf('%s_%s',var_list_{jvar},M_.exo_names{jexo}))./oo_.steady_state(M_.endo_names==string(var_list_{jvar}));
    end
end
clearvars -except no_policy cap_and_trade;

%% intensity target
dynare ann_dio_2015_irfs_intensity_target;
for jvar = 1:size(var_list_,1)  
    for jexo = 1:2
        intensity_target.(M_.exo_names{jexo}).(var_list_{jvar}) = oo_.irfs.(sprintf('%s_%s',var_list_{jvar},M_.exo_names{jexo}))./oo_.steady_state(M_.endo_names==string(var_list_{jvar}));
    end
end
clearvars -except no_policy cap_and_trade intensity_target;

%% tax policy
dynare ann_dio_2015_irfs_tax_policy;
for jvar = 1:size(var_list_,1)  
    for jexo = 1:2
        tax_policy.(M_.exo_names{jexo}).(var_list_{jvar}) = oo_.irfs.(sprintf('%s_%s',var_list_{jvar},M_.exo_names{jexo}))./oo_.steady_state(M_.endo_names==string(var_list_{jvar}));
    end
end
clearvars -except no_policy cap_and_trade intensity_target tax_policy var_list_;

%% figures
TITLES = ["Output", "Consumption", "Investment", "Labor",...
         "Marginal Cost", "Emissions", "Abatement Effort", "Permit Price"];

fig_1a = figure(name='Impulse responses to a technology shock (a)');
for ip = 1:size(var_list_,1)
    subplot(2,4,ip)
    hold on;
    plot(0:1:20,     no_policy.eps_a.(var_list_{ip}),'b' ,'LineWidth',1.5);
    plot(0:1:20, cap_and_trade.eps_a.(var_list_{ip}),'b:','LineWidth',1.5);
    title(TITLES(ip))
    legend('no policy','cap-and-trade','Location','SouthWest','fontsize',8);
    set(gca,'FontSize',12)
end

fig_1b = figure(name='Impulse responses to a technology shock (b)');
for ip = 1:size(var_list_,1)
    subplot(2,4,ip)
    hold on;
    plot(0:1:20, intensity_target.eps_a.(var_list_{ip}),'b' ,'LineWidth',1.5);
    plot(0:1:20,       tax_policy.eps_a.(var_list_{ip}),'b:*','LineWidth',1.5);
    title(TITLES(ip))
    legend('intensity target','tax','Location','SouthWest','fontsize',8);
    set(gca,'FontSize',12)
end

fig_2a = figure(name='Impulse responses to a government consumption shock (a)');
for ip = 1:size(var_list_,1)
    subplot(2,4,ip)
    hold on;
    plot(0:1:20,     no_policy.eps_g.(var_list_{ip}),'b' ,'LineWidth',1.5);
    plot(0:1:20, cap_and_trade.eps_g.(var_list_{ip}),'b:','LineWidth',1.5);
    title(TITLES(ip))
    legend('no policy','cap-and-trade','Location','SouthWest','fontsize',8);
    set(gca,'FontSize',12)
end

fig_2b = figure(name='Impulse responses to a government consumption shock (b)');
for ip = 1:size(var_list_,1)
    subplot(2,4,ip)
    hold on;
    plot(0:1:20, intensity_target.eps_g.(var_list_{ip}),'b' ,'LineWidth',1.5);
    plot(0:1:20,       tax_policy.eps_g.(var_list_{ip}),'b:*','LineWidth',1.5);
    title(TITLES(ip))
    legend('intensity target','tax','Location','SouthWest','fontsize',8);
    set(gca,'FontSize',12)
end