% =========================================================================
% illustration and comparison of different numerical optimizers
% on the Rosenbrock and Rastrigin functions
% =========================================================================
% Willi Mutschler (willi@mutschler.eu)
% Version: May 5, 2023
% =========================================================================

% plot Rosenbrock function
fsurf(@(x,y) ((1-x).^2)+(100*((y-(x.^2)).^2)),[-3 3 -2 5],'ShowContours','on')
title('Rosenbrock function')
xlabel('x')
ylabel('y')

% plot Rastrigin function
fsurf(@(x,y) 20 + x.^2 + y.^2 - 10*(cos(2*pi*x)+cos(2*pi*y)),'ShowContours','on')
title('Rastrigin function')
xlabel('x')
ylabel('y')

% common options for optimizers
optim_options = optimset('Display','iter','TolX',1e-7,'TolFun',1e-7,'MaxFunEvals',200000,'MaxIter',200000); 
optim_options_swarm = optimoptions('particleswarm','Display','iter','TolFun',1e-7); 

% define objective function
obj_rosenbrock = @(x) ((1-x(1)).^2)+(100*((x(2)-(x(1).^2)).^2));
obj_rastrigin  = @(x) 20 + x(1).^2 + x(2).^2 - 10*(cos(2*pi*x(1))+cos(2*pi*x(2)));

% initialize
x0 = randi([-5,5],2,1); % draw initial values randomly
xopt_rosenbrock = nan(2,7);  xopt_rastrigin = nan(2,7); % storage for optimal x
fval_rosenbrock = nan(7,1);  fval_rastrigin = nan(7,1); % storage for function values

% optimize with fsolve
[xopt_rosenbrock(:,1),fval_rosenbrock(1)] = fsolve(obj_rosenbrock,x0,optim_options );
[xopt_rastrigin(:,1),fval_rastrigin(1)] = fsolve(obj_rastrigin,x0,optim_options );

% optimize with fminunc
[xopt_rosenbrock(:,2),fval_rosenbrock(2)] = fminunc(obj_rosenbrock,x0,optim_options );
[xopt_rastrigin(:,2),fval_rastrigin(2)] = fminunc(obj_rastrigin,x0,optim_options );

% optimize with fminsearch
[xopt_rosenbrock(:,3),fval_rosenbrock(3)] = fminsearch(obj_rosenbrock,x0,optim_options);
[xopt_rastrigin(:,3),fval_rastrigin(3)] = fminsearch(obj_rastrigin,x0,optim_options);

% optimize with fmincon
[xopt_rosenbrock(:,4),fval_rosenbrock(4)] = fmincon(obj_rosenbrock,x0,[],[],[],[],[],[],[],optim_options);
[xopt_rastrigin(:,4),fval_rastrigin(4)] = fmincon(obj_rastrigin,x0,[],[],[],[],[],[],[],optim_options);

% optimize with simulannealbnd
[xopt_rosenbrock(:,5),fval_rosenbrock(5)] = simulannealbnd(obj_rosenbrock,x0,[],[],optim_options);
[xopt_rastrigin(:,5),fval_rastrigin(5)] = simulannealbnd(obj_rastrigin,x0,[],[],optim_options);

% optimize with patternsearch
[xopt_rosenbrock(:,6),fval_rosenbrock(6)] = patternsearch(obj_rosenbrock,x0,[],[],[],[],[],[],[],optim_options);
[xopt_rastrigin(:,6),fval_rastrigin(6)] = patternsearch(obj_rastrigin,x0,[],[],[],[],[],[],[],optim_options);

% optimize with particleswarm
[xopt_rosenbrock(:,7),fval_rosenbrock(7)] = particleswarm(obj_rosenbrock,2,[],[],optim_options_swarm);
[xopt_rastrigin(:,7),fval_rastrigin(7)] = particleswarm(obj_rastrigin,2,[],[],optim_options_swarm);

%% Sort and display results
optim_names = ["fsolve","fminunc","fminsearch","fmincon","simulannealbnd","patternsearch","particleswarm"];
[~,idx_best_rosenbrock] = sort(fval_rosenbrock);  [~,idx_best_rastrigin] = sort(fval_rastrigin);

fprintf('RESULTS ROSENBROCK\n')
disp(array2table([xopt_rosenbrock(:,idx_best_rosenbrock);fval_rosenbrock(idx_best_rosenbrock)'],...
                 'RowNames',{'x','y','f'},'VariableNames',optim_names(idx_best_rosenbrock)));

fprintf('RESULTS RASTRIGIN\n')
disp(array2table([xopt_rastrigin(:,idx_best_rastrigin);fval_rastrigin(idx_best_rastrigin)'],...
                 'RowNames',{'x','y','f'},'VariableNames',optim_names(idx_best_rastrigin)));
