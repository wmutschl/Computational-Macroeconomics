function Auray_Eyquem_2019_plots(oo_,M_)

HORIZON = 25;
YLABEL = ["% dev.", "%", "level"];

figure(name='IRF to 5 year war shock: Macro Variables');
VARLIST_MACRO = ["y","c","inv","k","n","wr","nxy","s","pie"];
VARTITLE_MACRO = ["GDP","Consumption","Investment","Capital Stock","Hours","Real Wage","Net exports to GDP","Terms of Trade","Inflation"];
idxplot = 1;
for j=1:length(VARLIST_MACRO)
    subplot(3,3,idxplot);
    if ismember(VARLIST_MACRO(j),["nxy"])
        plot(1:HORIZON,100*( oo_.endo_simul(M_.endo_names==VARLIST_MACRO(j),1:HORIZON) )...
            ,'-k','LineWidth',2);
        ylabel(YLABEL(2));
    else
         plot(1:HORIZON,100*( oo_.endo_simul(M_.endo_names==VARLIST_MACRO(j),1:HORIZON)./oo_.endo_simul(M_.endo_names==VARLIST_MACRO(j),1) -1 )...
            ,'-k','LineWidth',2);
        ylabel(YLABEL(1));
    end
    title(VARTITLE_MACRO(j));
    idxplot=idxplot+1;
    set(gca,'FontSize',14);
end

figure(name='IRF to 5 year war shock: Policy Variables');
VARLIST_POLICY = ["br_y","mr","invg","g","taun","tauk"];
VARTITLE_POLICY = ["Debt-to-GDP","Real balances","Public invt","Public consumption","Labor tax","Capital tax"];
idxplot = 1;
for j=1:length(VARLIST_POLICY)
    subplot(3,2,idxplot);
    if ismember(VARLIST_POLICY(j),["br_y"])
        plot(1:HORIZON,100*( oo_.endo_simul(M_.endo_names==VARLIST_POLICY(j),1:HORIZON) )...
            ,'-k','LineWidth',2);
        ylabel(YLABEL(2));
    elseif ismember(VARLIST_POLICY(j),["taun","tauk"])
        plot(1:HORIZON,100*( oo_.endo_simul(M_.endo_names==VARLIST_POLICY(j),1:HORIZON) )...
            ,'-k','LineWidth',2);
        ylabel(YLABEL(3));
    else
         plot(1:HORIZON,100*( oo_.endo_simul(M_.endo_names==VARLIST_POLICY(j),1:HORIZON)./oo_.endo_simul(M_.endo_names==VARLIST_POLICY(j),1) -1 )...
            ,'-k','LineWidth',2);
        ylabel(YLABEL(1));
    end
    title(VARTITLE_POLICY(j));
    idxplot=idxplot+1;
    set(gca,'FontSize',14);
end