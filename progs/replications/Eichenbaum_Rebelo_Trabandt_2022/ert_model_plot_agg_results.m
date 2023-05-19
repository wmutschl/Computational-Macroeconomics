function ert_model_plot_agg_results(epidemic_type,M_,oo_,flex_price)
% function ert_model_plot_agg_results(epidemic_type,M_,oo_,flex_price)
% -------------------------------------------------------------------------
% create plots of aggregate variables from the New Keynesian Model of
% Eichenbaum, Rebelo, Trabandt (2022, JEDC): "Epidemics in the New Keynesian model"
% based on plot_agg_results.m from the original Dynare replication files
% kindly provided by the authors (downloaded from Mathias Trabandt's homepage)
% -------------------------------------------------------------------------
% INPUTS
% - epidemic_type  [string]     type of epidemic, possible values:
%                               "demand", "supply", "both"
% - M_             [structure]  Dynare's model structure
% - oo_            [structure]  Dynare's results structure
% - flex_price     [boolean]    indicator whether to also plot flex-price model
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
    strtitle = "Epidemic as a shock to consumption demand.";
elseif epidemic_type == "supply"
    strtitle = "Epidemic as a shock to labor supply.";
elseif epidemic_type == "both"
    strtitle = "Epidemic as a shock to both consumption demand and labor supply.";
end
figure('name',strtitle,'units','normalized','outerposition',[0 0 0.75 0.75]);

% Nominal Interest Rate
Rb_ss = oo_.steady_state(M_.endo_names=="Rb");
Rb = oo_.endo_simul(M_.endo_names=="Rb",:);
subplot(3,3,1);
hold on;
plot(time(1:end-1),0*100*((Rb(2:horz)).^52-1)+100*(Rb_ss.^52-1),'m:','LineWidth',1.5);
plot(time(1:end-1),100*((Rb(2:horz)).^52-1),'b-','LineWidth',2);
if flex_price
    Rb_flex = oo_.endo_simul(M_.endo_names=="Rb_flex",:);
    plot(time(1:end-1),100*((Rb_flex(2:horz)).^52-1),'r--','LineWidth',2);
end
hold off;
box off;
title('Nominal Interest Rate','FontSize',fsize);
xlabel('Weeks','FontSize',fsize); xticks(0:20:80);
ylabel('in %');
set(gca,'FontSize',fsize);
axis tight;

% Inflation
pie_ss = oo_.steady_state(M_.endo_names=="pie");
pie = oo_.endo_simul(M_.endo_names=="pie",:);
subplot(3,3,2);
hold on;
plot(time(1:end-1),0*100*((pie(2:horz)).^52-1)+100*(pie_ss.^52-1),'m:','LineWidth',1.5);
plot(time(1:end-1),100*((pie(2:horz)).^52-1),'b-','LineWidth',2);
if flex_price
    pie_flex = oo_.endo_simul(M_.endo_names=="pie_flex",:);
    plot(time(1:end-1),100*((pie_flex(2:horz)).^52-1),'r--','LineWidth',2);
end
hold off;
box off;
title('Inflation','FontSize',fsize);
xlabel('Weeks','FontSize',fsize); xticks(0:20:80);
ylabel('in %')
set(gca,'FontSize',fsize);
axis tight;

% GDP
y_ss = oo_.steady_state(M_.endo_names=="y");
y = oo_.endo_simul(M_.endo_names=="y",:);
subplot(3,3,3);
hold on;
plot(time(1:end-1),0*100*(y(2:horz)-y_ss)/y_ss,'m:','LineWidth',1.5);
plot(time(1:end-1),100*(y(2:horz)-y_ss)/y_ss,'b-','LineWidth',2);
if flex_price
    y_flex = oo_.endo_simul(M_.endo_names=="y_flex",:);
    plot(time(1:end-1),100*(y_flex(2:horz)-y_ss)/y_ss,'r--','LineWidth',2);
end
hold off;
box off;
title('GDP','FontSize',fsize);
xlabel('Weeks','FontSize',fsize); xticks(0:20:80);
ylabel('in % dev from init ss')
set(gca,'FontSize',fsize);
axis tight;

% Consumption
c_ss = oo_.steady_state(M_.endo_names=="c");
c = oo_.endo_simul(M_.endo_names=="c",:);
subplot(3,3,4);
hold on;
plot(time(1:end-1),0*100*(c(2:horz)-c_ss)/c_ss,'m:','LineWidth',1.5);
plot(time(1:end-1),100*(c(2:horz)-c_ss)/c_ss,'b-','LineWidth',2);
if flex_price
    c_flex = oo_.endo_simul(M_.endo_names=="c_flex",:);
    plot(time(1:end-1),100*(c_flex(2:horz)-c_ss)/c_ss,'r--','LineWidth',2);
end
hold off;
box off;
title('Consumption','FontSize',fsize);
xlabel('Weeks','FontSize',fsize); xticks(0:20:80);
ylabel('in % dev from init ss')
set(gca,'FontSize',fsize);
axis tight;

% Hours
n_ss = oo_.steady_state(M_.endo_names=="n");
n = oo_.endo_simul(M_.endo_names=="n",:);
subplot(3,3,5);
hold on;
plot(time(1:end-1),0*100*(n(2:horz)-n_ss)/n_ss,'m:','LineWidth',1.5);
plot(time(1:end-1),100*(n(2:horz)-n_ss)/n_ss,'b-','LineWidth',2);
if flex_price
    n_flex = oo_.endo_simul(M_.endo_names=="n_flex",:);
    plot(time(1:end-1),100*(n_flex(2:horz)-n_ss)/n_ss,'r--','LineWidth',2);
end
hold off;
box off;
title('Hours','FontSize',fsize);
xlabel('Weeks','FontSize',fsize); xticks(0:20:80);
ylabel('in % dev from init ss')
set(gca,'FontSize',fsize);
axis tight;

% Investment
x_ss = oo_.steady_state(M_.endo_names=="x");
x = oo_.endo_simul(M_.endo_names=="x",:);
subplot(3,3,6);
hold on;
plot(time(1:end-1),0*100*(x(2:horz)-x_ss)/x_ss,'m:','LineWidth',1.5);
plot(time(1:end-1),100*(x(2:horz)-x_ss)/x_ss,'b-','LineWidth',2);
if flex_price
    x_flex = oo_.endo_simul(M_.endo_names=="x_flex",:);
    plot(time(1:end-1),100*(x_flex(2:horz)-x_ss)/x_ss,'r--','LineWidth',2);
end
hold off;
box off;
title('Investment','FontSize',fsize);
xlabel('Weeks','FontSize',fsize); xticks(0:20:80);
ylabel('in % dev from init ss')
set(gca,'FontSize',fsize);
axis tight;


% Real Interest Rate
rr_ss = oo_.steady_state(M_.endo_names=="rr");
rr = oo_.endo_simul(M_.endo_names=="rr",:);
subplot(3,3,7);
hold on;
plot(time(1:end-1),0*100*((rr(2:horz)).^52-1)+100*(rr_ss.^52-1),'m:','LineWidth',1.5);
plot(time(1:end-1),100*((rr(2:horz)).^52-1),'b-','LineWidth',2);
if flex_price
    rr_flex = oo_.endo_simul(M_.endo_names=="rr_flex",:);
    plot(time(1:end-1),100*((rr_flex(2:horz)).^52-1),'r--','LineWidth',2);
end
hold off;
box off;
title('Real Interest Rate','FontSize',fsize);
xlabel('Weeks','FontSize',fsize); xticks(0:20:80);
ylabel('in %');
set(gca,'FontSize',fsize);
axis tight;

% Infected
i = oo_.endo_simul(M_.endo_names=="i",:);
subplot(3,3,8);
hold on;
plot(time,100*i(1:horz),'b-','LineWidth',2);
if flex_price
    i_flex = oo_.endo_simul(M_.endo_names=="i_flex",:);
    plot(time,100*i_flex(1:horz),'r--','LineWidth',2);
end
hold off;
box off;
title('Infected','FontSize',fsize);
xlabel('Weeks','FontSize',fsize); xticks(0:20:80);
ylabel('in % dev from init pop')
set(gca,'FontSize',fsize);
axis tight;

% Deaths
dd = oo_.endo_simul(M_.endo_names=="dd",:);
subplot(3,3,9);
hold on;
plot(time,100*dd(1:horz),'b-','LineWidth',2);
if flex_price
    dd_flex = oo_.endo_simul(M_.endo_names=="dd_flex",:);
    plot(time,100*dd_flex(1:horz),'r--','LineWidth',2);
end
hold off;
box off;
title('Deaths','FontSize',fsize);
xlabel('Weeks','FontSize',fsize); xticks(0:20:80);
ylabel('in % dev from init pop')
set(gca,'FontSize',fsize);
axis tight;

if flex_price
    legend('New Keynesian Model (Sticky Prices)','Model with Flexible Prices','Location','best');
    legend boxoff
end

if epidemic_type == "demand"
    suptitle("Figure 5: " + strtitle);
elseif epidemic_type == "supply"
    suptitle("Figure 7: " + strtitle);
elseif epidemic_type == "both"
    suptitle("Figure 9: " + strtitle);
end