%% Plot Rosenbrock function
fsurf(@(x,y) ((1-x).^2)+(100*((y-(x.^2)).^2)),[-3 3 -2 5],'ShowContours','on')
title('Rosenbrock function')
xlabel('x')
ylabel('y')

%% Plot Rastrigin function
fsurf(@(x,y) 20 + x.^2 + y.^2 - 10*(cos(2*pi*x)+cos(2*pi*y)),'ShowContours','on')
title('Rastrigin function')
xlabel('x')
ylabel('y')

%% Pick function
fun = @(x) ((1-x(1)).^2)+(100*((x(2)-(x(1).^2)).^2)); % Rosenbrock
fun = @(x) 20 + x(1).^2 + x(2).^2 - 10*(cos(2*pi*x(1))+cos(2*pi*x(2))); % Rastrigin function

%% Initial values
x0 = randi([-5,5],2,1);
fun(x0)

%% Options for optimizer
optim_options = optimset('Display','iter','TolX',1e-7,'TolFun',1e-7,'MaxFunEvals',200000,'MaxIter',200000);
optim_options_swarm = optimoptions('particleswarm','Display','iter','TolFun',1e-7);

%% Run optimizers and store results
x = nan(2,7);
fval = nan(7,1);

[x(:,1),fval(1)] = fsolve(fun,x0,optim_options );
[x(:,2),fval(2)] = fminunc(fun,x0,optim_options );
[x(:,3),fval(3)] = fminsearch(fun,x0,optim_options);
[x(:,4),fval(4)] = fmincon(fun,x0,[],[],[],[],[],[],[],optim_options);
[x(:,5),fval(5)] = simulannealbnd(fun,x0,[],[],optim_options);
[x(:,6),fval(6)] = patternsearch(fun,x0,[],[],[],[],[],[],[],optim_options);
[x(:,7),fval(7)] = particleswarm(fun,2,[],[],optim_options_swarm);

%% Sort and display results
optim_names = ["fsolve","fminunc","fminsearch","fmincon","simulannealbnd","patternsearch","particleswarm"];
[~,idx_best] = sort(fval);
array2table([x(:,idx_best);fval(idx_best)'],'RowNames',{'x','y','f'},'VariableNames',optim_names(idx_best))
