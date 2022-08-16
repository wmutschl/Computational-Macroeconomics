\section[RBC model: steady-state in MATLAB]{RBC model: steady-state in MATLAB\label{ex:RBCModelSteadyMATLAB}}
Consider the basic Real Business Cycle (RBC) model with leisure and log utility function.
The dynamic model equations are given Table \ref{tbl:RBC.Model},
  the variable description in Table \ref{tbl:RBC.Variables},
  and the description and calibration of parameters in Table \ref{tbl:RBC.Parameters}.

\begin{enumerate}
\item Create a Dynare mod file for this model and use an \texttt{initval} block to compute the steady-state.
  Store the computed steady-state into a variable \texttt{stst\_dyn}.
  Evaluate the static file at the steady-state and store your result into a variable \texttt{resid\_dyn}.
  Compute the sum of squared residuals of \texttt{resid\_dyn} and store your result into a variable \texttt{ssq\_dyn}.
\item Preprocess the model using the function \texttt{matlab\_rbc\_nonlinear\_preprocessing.m} created in the previous exercise.
\item Put the values for the parameters given in Table \ref{tbl:RBC.Parameters} into a vector \texttt{MODEL.params}.
\item Create two functions handles:
\begin{lstlisting}
exo_vars = 0;
fun = @(xparam) rbc_static_resid(xparam,exo_vars,MODEL.params);
fun_ssq = @(xparam) sum(rbc_static_resid(xparam,exo_vars,MODEL.params).^2);
\end{lstlisting} 
\item Provide initial guess values for the steady-state of all endogenous variables in a vector called \texttt{xparam0}.
Also create two vectors \texttt{LB} and \texttt{UB} with a lower and upper bound for the variables.
\item Minimize either \texttt{fun} or \texttt{fun\_ssq} with a numerical optimization algorithm.
  You might want to have a look into \texttt{fsolve}, \texttt{lsqnonlin}, \texttt{fminunc}, \texttt{fminsearch}, \texttt{fmincon}, \texttt{simulannealbnd} and \texttt{patternsearch}.
\item Compare the computed steady-state values, the residuals of the static model equations and the sum of squared residuals.
\item Compare your results with the one obtained from Dynare.
\item Compute the steady-state in closed-form (analytically) and compare with the previous exercises.
\item Redo the exercise, but now randomize your starting values by drawing them with uniformly given the lower and upper bounds (use \texttt{rand}).
\end{enumerate}

\begin{solution}\textbf{Solution to \nameref{ex:RBCModelPreprocessMATLAB}}
\ifDisplaySolutions
\lstinputlisting{../progs/matlab/matlab_rbc_nonlinear_steadystate.m}
\fi
\newpage
\end{solution}