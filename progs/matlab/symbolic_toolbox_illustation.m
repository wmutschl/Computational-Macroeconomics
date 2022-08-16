%% 1
sym(1/3)
1/3
% The symbolic number is represented in exact rational form, while the floating-point number is a decimal approximation.
% Note that the symbolic result is not indented, while the standard MATLAB result is indented.
    
%% 2
sin(sym(pi))
sin(pi)
% The symbolic result is exact, while the numeric result is an approximation.


%% 3
syms x
z=sym('y')
syms x y z

%% 4
A = sym('a', [1 20]);
disp(A)
% A is a symbolic variable with size 1x20

%% 5
clearvars
A = sym('a', [1 10])
% The MATLAB workspace contains 1 variable A which is symbolic and has 10 entries
clearvars
syms(sym('a', [1 10]))
% The MATLAB workspace contains 10 MATLAB variables whie are symbolic and each has 1 entry

%% 6
syms a b c;
A = [ a b c;
      c a b;
      b c a];
isequal(sum(A(1,:)), sum(A(:,2)))

%% 7
clearvars
A = sym('a', [2 4])
B = sym('b_%d_%d', [2 4])

%% 8
clearvars
syms a b c x;
f = a*x^2 + b*x + c
g(x) = a*x^2 + b*x + c
g(4)
solve(g)% solves the equation a*x^2 + b*x + c = 0 for the variable x, i.e. this is the famous abc formula for quadratic equations
solve(f==2,a) % solves the equation a*x^2 + b*x + c=2 for the variable a. Note that if you don't specify a variable, then MATLAB takes the variable which name is closest to x

%% 9
diff(f,x)
diff(f,a)
diff(f,b)
diff(f,c)
diff(f,x,a)
jacobian(f,[a;b;c;x])


%% 10
subs(int(f,x),x,-2)
int(f,x,-2,1)

%% 11
phi = (1 + sqrt(sym(5)))/2;
golden_ratio = phi^2 - phi - 1
simplify(golden_ratio)

%% 12
clearvars
syms x
f = (x^2-1)*(x^4+x^3+x^2+x+1)*(x^4-x^3+x^2-x+1);
disp(f)
expand(f)

%% 13
syms x
g = x^3 + 6*x^2 + 11*x + 6;
disp(g)
factor(g)

%% 14
clearvars
syms x
h = x^5 + x^4 + x^3 + x^2 + x;
disp(h)
horner(h)

%% 15
clearvars
syms x y
f = x^2*log(y) + 5*x*sqrt(y);
disp(f)
subs(f, x, 3)
subs(f, x, y)

syms a b c
alpha = sym('alpha');
beta = sym('beta');
A = [a b c; c a b; b c a];
disp(A);
A(2,1) = beta;
subs(A,b,alpha);
B = subs(A,b,alpha);
disp(A);
disp(B)
%The subs function does not change the original expression f:

%% 16
doc fprintf

%% 17
clearvars
var_names = ["x";"y"];
param_names = ["ALPHA";"BETA"];
syms(sym(var_names));
syms(sym(param_names));
f(1,1) = x^ALPHA*log(y) + BETA*x*sqrt(y);
f(2,1) = x^2-y + BETA/ALPHA*sqrt(x^3)*(y/2);
f(3,1) = x^ALPHA + BETA*x;
f(4,1) = log(y) + BETA*sqrt(y);
df = jacobian(f,[x;y]);

NameOfFunction = 'num_df';
NameOfFile = strcat(NameOfFunction,'.m');
NameOfOutput = 'df';
if exist(NameOfFile,'file') > 0
    delete(NameOfFile); % Delete old version of file (if it exists)
end
fileID = fopen(NameOfFile,'w');
fprintf(fileID,'function %s = %s(%s)\n',NameOfOutput,NameOfFunction,strjoin([var_names;param_names],','));

fprintf(fileID,'\n%% Evaluate the jacobian of f=x^ALPHA*log(y) + BETA*x*sqrt(y)\n');
fprintf(fileID,'\n%% Initialize %s\n',NameOfOutput);
fprintf(fileID,'%s = zeros(%d, %d);\n',NameOfOutput,size(df,1),size(df,2));
[nonzero_row,nonzero_col,nonzero_vals] = find(df);
for j = 1:size(nonzero_vals,1)
    fprintf(fileID,'%s(%d,%d) = %s;\n',NameOfOutput,nonzero_row(j),nonzero_col(j),char(nonzero_vals(j)));
end
fprintf(fileID,'\nend %% function end \n');
fclose(fileID);

%% 18
% Compare time to evaluate either script files or symbolic expressions
rng(123); % get same random numbers by setting seed
tic;
for j=1:100
    num_df(randn(),randn(),rand(),rand());
end
toc

rng(123); % get same random numbers by setting seed
tic;
for j=1:100
    double(subs(df,[x y ALPHA BETA],[randn(),randn(),rand(),rand()]));
end
toc


