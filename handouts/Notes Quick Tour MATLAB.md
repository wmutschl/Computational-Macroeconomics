# Quick Tour of MATLAB

1) Overview of layout
When opening Matlab in the default specification (everything can be changed according to your taste), you have the command window, the workspace, the current directory, and the command history in one big window. Figure 1 shows the default setup.

• Command Window: Here you can type commands ’on the spot’, i.e. they get ex-
ecuted, but not saved in a file. Furthermore, possible output from programs gets displayed here.
Up arrow scrolls through history

• Workspace: An overview over all variables in the memory. Double clicking on a variable inside the workspace opens the variable editor (which looks similar to Excel) where you can see (and sometimes change) the variable’s value.
• Command History: A list of recently used commands in the command window. You can double-click on them to execute them again.
• Current Directory: The directory where you currently are. Note that you need to be in the directory of a certain file in order to execute it (if it is not in a directory listed under the ’Set Path’ option under ’Home’).

2) Go through preferences
3) What is MATLAB?
MATLAB is an interactive computing environment, you type in something and it will compute results and store them in the workspace:
1+sqrt(5)/2
x = [1 2 3];
disp(x)

Now for replicability, it is better to create a script, That is, a text file that includes sequences of instructions that we want the computer to do.
MATLAB is real
1+sqrt(5)/2
x = [1 2 3];
disp(x)
x
mean(x)
A = [1 2 3; 8 2 1; 2 2 2];
disp(A);
mean(A)
mean(A,1)
mean(A,2)
A*x
A*A'
A*transpose(A)
A^2
A.^2

We can solve systems of linear equations:
% A*x = b
A = [3 5 -1;
     9 2 4;
     4 -2 -9];
b = (1:3)';
x = mldivide(A,b)
x = A\b
[lambda,V] = eig(A)
inv(A)
det(A)
rank(A)
diag(A)
str = 'hello world';
STR = 'GOODBYE WORLD';
disp(str);
disp(STR);

Note that a semicolon supresses output.If you do not want to execute your whole code, but only parts, you can select the code
you want to run and press F9.



window and press Ctrl+C to stop the execution of the current listing.
MATLAB provides both basic and very sophisticated functions for all sorts of numerical computations, but it can also do sophisticated data analysis, plots and even create apps that you can share with people.

In this course we will of course make use of many built-in function to solve our problems such as
- solving systems of linear equations
- solving non-linear equations in several unknowns
- approximating functions
- computing derivatives and integrals
All this is basically included in MATLAB's core functionality. It is designed to shine for numerical problems. MATLAB also provides additional toolboxes that even extend the core functionality, say you need to do something with Machine Learning or for risk management tasks, there are toolboxes for this.

TOOLBOXES:
- Optimization Toolbox and Global Optimization Toolbox to solve complex optimization problems
- Statistics and Machine Learning Toolbox and Econometrics toolbox that provide functionality for many statistical tasks, draw random numbers etc
- Symbolic Math toolbox to derive derivatives of our model equations analytically and save them into files for further evaluation
- Parallel Computing Toolbox is also useful because our machines are quite powerful nowadays and several tasks can be run in parallel

HELP:
if you want to know how a function works go into the help and have a look at the examples
Now MATLAB is a matrix-oriented environment and programming language. It works best with objects you know from linear algebra, that is scalars, vectors, matrices and more general multidimensional arrays. you create such objects with squared brackets or built-in functions. Let's have a look at the help for zeros, ones and nan:
X = zeros(3,2);
Y = ones(3,2,4);
Z = nan(3,2,4,5);
This creates an array.
these functions will be useful to initialize variables and the fill them with more computations.
 If we want to set a certain value, we access this with round brackets:
X(2,3,1) = 5;
Y(2,1) = 2;
disp(Y)
Y(4) = 3;
disp(Y)
Y(:,2)
Y(end-1,:)

Note the use of the column to select all rows, but only the second column.

[] is the empty vector,
a = [];
disp(a);

it can be also used to remove objects:
X(:,:,1) = [];
disp(X)


How do we find functions? We could use "lookfor"
lookfor svd

But honestly: in most cases you will simply search for stuff online:
The forums are really great and people also share additional helper functions that are quite useful.

Functions.
Let's create a basic function

function [a,b,c] = myfun(x,y)
a = exp(2*x).*sin(y);
b = exp(2*y).*sin(x);
c = a + b;

myfun([1:3],[2:2:4])

Plotting a function of a single variable is easy:

x = 0:0.01:2*pi;
plot(x,sin(x));
axis([0 2*pi -1 1])
plot(0:20,rand(1,21),'o')
hold on
plot(0:20,rand(1,21),'o-')
hold off


Programming: 
mynumber = input('Enter an integer:');
if mod(mynumber,2)==0
disp('Even');
elseif mod(mynumber,2)==1
disp('Odd');
else
error('Number is no integer');
end

control structures common in many programming languages: if, for , while

Loops
Z = nan(100,1);
for i = 1:size(Z,1)
  % compute something
  Z(i,1) = mean(randn(100,1));
end
histogram(Z)

n = 1;
nFactorial = 1;
while nFactorial < 1e10
n = n + 1;
nFactorial = nFactorial * n;
end

while x == 2; x=2; end
CTRL+CSometimes, you may want to terminate the execution of code, e.g. when you did a pro-
gramming error and Matlab entered an infinite loop. In this case, click into the command


## Video

### Title
Introduction to MATLAB

### Description
Course on Computational Macroeconomics (Master and PhD level)
Week 1: Introduction to MATLAB
Taught at University of Tübingen, Summer 2022

GitHub Repo: https://github.com/wmutschl/Computational-Macroeconomics

References:
- Brandimarte (2006, Appendix A) - Numerical Methods in Finance & Economics A MATLAB based Introduction - Paolo Brandimarte.pdf
- Miranda, Fackler (2002, Appendix B) - Applied Computational Economics and Finance

**Timestamps**
00:10 - Default layout of MATLAB
00:41 - Interacting with the command window
00:58 - Interacting with the workspace window
01:31 - Command history
01:55 - Preferences
03:12 - Creating scripts
03:56 - Basic computations
05:28 - Calling built-in functions
07:29 - MATLAB is a matrix language, i.e. check your dimensions!
08:16 - Elementwise computations
08:43 - Comments
09:10 - Matrix left divide to solve systems of linear equations
10:07 - Looking at the help of a function
11:14 - Functions can have both several inputs as well as several outputs
11:50 - Difference between mldivide and inv
12:47 - MATLAB is case sensitive
13:10 - Different types of variables
13:54 - Additional toolboxes
15:18 - Toolboxes we will use
16:27 - How to look for and get help
17:20 - Initialize arrays of any dimension
20:00 - Change values in arrays
21:43 - Empty vector can delete stuff in arrays
22:20 - Writing user functions
25:10 - Very basic plot
26:21 - If statements
28:48 - Difference between error and warning
29:07 - For loop
33:12 - Terminate busy computations
34:08 - Outro

### playlists
- Computational Macroeconomics (University Tübingen, Summer 2022)

### tags
Computational Macroeconomics, Macroeconometrics, MATLAB, Quick Tour, Introduction, Numerical Methods
