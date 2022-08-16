\section[Numerical optimization in MATLAB]{Numerical optimization in MATLAB\label{ex:MatlabNumericalOptimization}}
\begin{enumerate}
\item In a nutshell, what is the goal of numerical optimization?
\item What is an objective function, what are decision or design variables, what is a gradient, and what is a constraint?
\item What is the general idea behind gradient based optimization algorithms?
\item What is the general idea behind gradient free optimization algorithms? Name a few examples.
\item In mathematical optimization, the Rosenbrock function is a non-convex function used as a performance test problem for optimization algorithms.
    It is also known as Rosenbrock's valley or Rosenbrock's banana function.
    It is defined by:
    $$f(x,y) = 100(y-x^2)^2 + (1-x)^2$$
    The global minimum is inside a long, narrow, parabolic shaped flat valley.
    To find the valley is trivial.
    To converge to the global minimum, however, is difficult.
    \begin{enumerate}
        \item Make a 3D plot of the function to see that the global minimum is at $(x, y)=(1, 1)$ where $f(x, y)=0$.
\begin{lstlisting}        
fsurf(@(x,y) ((1-x).^2)+(100*((y-(x.^2)).^2)),[-2 2 -2 5],'ShowContours','on')
title('Rosenbrock function')
xlabel('x')
ylabel('y')
\end{lstlisting}
        \item Draw the initial values randomly (e.g. with \texttt{randi}).
        \item Try out different optimizers in order to find the global minimum of the function.    
    \end{enumerate}  
\item In mathematical optimization, the Rastrigin function is a non-convex function
    used as a performance test problem for optimization algorithms.
    It is a typical example of non-linear multi-modal function. 
    Finding the minimum of this function is a fairly difficult problem due to its large search space and its large number of local minima.
    Repeat the previous exercise for the two-dimensional Rastrigin function given by:
    $$f(x,y) = 20 + x^2 + y^2 - 10(\cos(2\pi x)+\cos(2\pi y))$$
    Note that the global minimum is at $(x, y)=(0, 0)$ where $f(x, y)=0$.
\end{enumerate}


\paragraph{Readings}
\begin{itemize}
  \item \url{https://www.youtube.com/watch?v=Q2dewZweAtU&list=PLLK3oSbvdxFdF67yVxF_1FQO9SbBY3yTL}
  \item \url{https://mathworks.com/help/gads/example-comparing-several-solvers.html}
\end{itemize}


\begin{solution}\textbf{Solution to \nameref{ex:MatlabNumericalOptimization}}
\ifDisplaySolutions
\begin{enumerate}
\item The goal of numerical optimization is to choose inputs to a function in a way that provides the best possible output.
    Typically, we want to maximize a function, e.g. utility, or minimize a function, e.g. costs, by adjusting the inputs to get the best output.
    Of course, often we are faced with limits, constraints, or boundaries on the variables.
    From high-school this corresponds to choose $x$ to get the best $y=f(x)$.
    From calculus we know that we should take the derivative and set it to 0.
    For more complicated functions, however, doing this is not feasible or even impossible,
      so we rely on numerical optimization techniques.
\item The objective function is the value you are trying to optimize, e.g. a utility or cost function.
    The goal of optimization is to improve the value of the objective function, either maximize or minimize it, or bring it to a certain value.
    Typically, the objective function is a scalar or a vector-valued function.

    The decision or design variables are the inputs to the objective function; these are the values the optimizer is allowed to change
      in order to improve the objective function. You can have either one or more decision variables.
    The more variables, the harder it is to find the best values for these variables.

    Gradients and derivatives describe the slope of a function, i.e. whether it decreases or increases in a certain direction.
    Computing gradients can be achieved with analytic, numerical or automatic differentiation techniques.

    Constraints form an area in the parameter space, where the optimizer is not allowed to go to.
    There might be equality constraints or inequality constraints.
\item Gradient based optimizers use derivatives to find the optimal value of an objective function.
    There are three steps: first the gradient defines the search direction of the next iteration,
      second a step size is chosen,
      and third the convergence is checked.
    Gradient based optimizers tend to be widely used and scale quite well.
    However, they require smooth functions and the computation of derivatives might become difficult and time-consuming.
    Gradient based optimizers typically find local optima and heavily depend on the initial value.

\item Gradient free algorithms belong to a broad class of numerical optimization methods
      that do not require the computation of derivatives or gradients to optimize objective functions.
      These are often required as many functions do not allow to compute the gradients correctly
        or it is very time-consuming.
    
    Some examples:
    \begin{itemize}
        \item Exhaustive search: try out every possible solution and pick the best answer.
        \item Genetic algorithms: don't use just one candidate draw, but generate a population of possible solutions.
            Provide a score to the candidate solutions and based on this generate a new population and repeat.
        \item Particle swarm: don't use just one candidate draw, but create a swarm of particles.
            Each particle gets a direction based on the directions of the current swarm and the overall performance.
            The swarm then moves towards the optimum.
        \item Simulated annealing: an initial guess is taken and then we randomly draw new candidates and see
              whether they improve the function value. Initially we accept many bad solutions in order to visit the parameter space.
              As time goes on, we reduce the temperature and only accept better solutions.
              This works like a ball bouncing on an uneven surface.
        \item Nelder Mead simplex: a simplex has a triangular shape and contains values.
            At each iteration the simplex flips and flops, grows and shrinks, towards its goal to focus on the optimum.
    \end{itemize}  
    Gradient free algorithms are generally much slower than gradient based ones.
    However, they are usually easy to implement as no derivatives are required.
    Gradient free algorithms often contain a stochastic part and often there is no guarantee that we actually arrive at the optimal solution.
\end{enumerate}

\item[5./6.]
\lstinputlisting{../progs/matlab/numerical_optimization_examples.m}

\fi
\newpage
\end{solution}