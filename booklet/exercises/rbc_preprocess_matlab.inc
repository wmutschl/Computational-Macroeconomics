\section[RBC model: preprocessing in MATLAB]{RBC model: preprocessing in MATLAB\label{ex:RBCModelPreprocessMATLAB}}
Consider the basic Real Business Cycle (RBC) model with leisure and log utility function.
The dynamic model equations are given Table \ref{tbl:RBC.Model},
  the variable description in Table \ref{tbl:RBC.Variables},
  and the description and calibration of parameters in Table \ref{tbl:RBC.Parameters}.

\begin{enumerate}
\item Create a Dynare mod file for this model and use an \texttt{initval} block to compute the steady-state.
\item Notice that Dynare's preprocessor creates a folder with a + and the name of your mod file.
Inside the folder you can find different files.
Briefly explain what the script files \texttt{driver.m}, \texttt{dynamic\_resid.m}, \texttt{dynamic\_g1.m}, \texttt{static\_resid.m} and \texttt{static\_g1.m} do.
\item Briefly explain Dynare's \texttt{M\_.lead\_lag\_incidence} matrix.
\item Use MATLAB's Symbolic Math Toolbox to process the same Model without Dynare. To this end:
	\begin{enumerate}
	\item Declare the names of the endogenous and exogenous variables as well as the parameters as string arrays called
		\texttt{endo\_names}, \texttt{exo\_names}, and \texttt{param\_names}.
 		Store the length of these vectors to variables called \texttt{endo\_names\_nbr}, \texttt{exo\_names\_nbr}, and \texttt{param\_names\_nbr}.
	\item Create symbolic variables in the workspace with a \texttt{\_back}, \texttt{\_curr}, \texttt{\_fwrd}, and \texttt{\_stst} suffix,
	    using the names in \texttt{endo\_names}.
	  That is, \texttt{c\_back} should be a symbolic variable denoting $c_{t-1}$
	    \texttt{c\_curr} should be a symbolic variable denoting $c_{t}$,
		\texttt{c\_fwrd} should be a symbolic variable denoting $c_{t+1}$,
		and \texttt{c\_stst} should be a symbolic variable denoting the steady-state $c$.
	\item Create symbolic variables in the workspace using the names in \texttt{exo\_names}.
    \item Create symbolic variables in the workspace using the names in \texttt{param\_names}.
    \item Create a symbolic vector \texttt{dynamic\_model\_eqs} with the dynamic model equations given in Table \ref{tbl:RBC.Model}
      and using the just declared convention for variables and parameters.
	\item Create the \texttt{lead\_lag\_incidence} matrix. Use it to distinguish the following types of variables:
 		\begin{itemize}
	 	\item static variables, which appear only at $t$, but neither at $t-1$ nor at $t+1$.
        \item predetermined variables, which appear only at $t-1$, possibly at $t$, but not at $t+1$.
        \item forward variables, which appear only at $t+1$, possibly at $t$, but not at $t-1$.
        \item mixed variables, which appear at $t-1$ and $t+1$, and possibly at $t$.
        \item dynamic variables, which actually appear in the dynamic model equations.
 		\end{itemize}
	\item Compute the static model equations using the \texttt{subs} command
	  to substitute the dynamic variables with their corresponding name without the \texttt{\_back}, \texttt{\_curr}, or \texttt{\_fwrd} suffix.
	Store the static model equations in the symbolic variable \texttt{static\_model\_eqs}.
	\item Compute the Jacobian of \texttt{static\_model\_eqs} with respect to symbolic endogenous variables.
    \item Compute the Jacobian of \texttt{dynamic\_model\_eqs} with respect to symbolic dynamic variables and the symbolic exogenous variables.
    \item Write out the static and dynamic model equations and Jacobians to script files:
\begin{lstlisting}
write_out(static_model_eqs, 'rbc_static_resid', 'residual', true, dynamic_names, endo_names, exo_names, param_names);
write_out(static_g1, 'rbc_static_g1', 'g1', true, dynamic_names, endo_names, exo_names, param_names);
write_out(dynamic_model_eqs, 'rbc_dynamic_resid', 'residual', false, dynamic_names, endo_names, exo_names, param_names);
write_out(dynamic_g1, 'rbc_dynamic_g1', 'g1', false, dynamic_names, endo_names, exo_names, param_names);
\end{lstlisting}
	The function \texttt{write\_out.m} looks like this:
	\lstinputlisting{progs/matlab/write_out.m}
	\item Make the whole script a function called \texttt{matlab\_rbc\_nonlinear\_preprocessing.m} with an output variable MODEL,
	  which is a structure containing information on the names and numbers of the endogenous and exogenous variables,
  	  the names and numbers of the parameters, and also the \texttt{lead\_lag\_incidence} matrix.
	\end{enumerate}
\item Compare the script files you just created with the one's from Dynare.
	\begin{enumerate}
	\item First, run dynare on the mod file to create the preprocessing files and to compute the steady-state.
	Store the steady-state for the endogenous, exogenous and dynamic variables:
\begin{lstlisting}
[I,~]     = find(M_.lead_lag_incidence');
ys        = oo_.steady_state;
yy0       = oo_.steady_state(I);
ex0       = oo_.exo_steady_state';
\end{lstlisting}
	\item Evaluate Dynare's script files at the steady-state:
\begin{lstlisting}
[dynare_resid, dynare_g1] = feval([M_.fname,'.dynamic'], yy0, ex0, M_.params, ys, 1);
[dynare_resid_static, dynare_g1_static] = feval([M_.fname,'.static'], ys, ex0, M_.params);		
\end{lstlisting}
	\item Evaluate our just created script files at the steady-state:
\begin{lstlisting}
matlab_rbc_nonlinear_preprocessing;
our_resid        = rbc_dynamic_resid(yy0,ex0,M_.params,ys);
our_resid_static = rbc_static_resid(ys,ex0,M_.params);
our_g1           = rbc_dynamic_g1(yy0,ex0,M_.params,ys);
our_g1_static    = rbc_static_g1(ys,ex0,M_.params);
\end{lstlisting}
	\item Compare the outputs.
	\end{enumerate}
\end{enumerate}


\begin{solution}\textbf{Solution to \nameref{ex:RBCModelPreprocessMATLAB}}
\ifDisplaySolutions
\begin{enumerate}
\item \texttt{rbc\_nonlinear.mod}:
	\lstinputlisting{progs/dynare/rbc_nonlinear.mod}
\item Dynare's preprocessor creates the following script files:
	\begin{itemize}
	\item \texttt{driver.m}: the preprocessor reads the text and information you provide in your mod file 
	  and creates MATLAB code from this.
	  The \texttt{driver.m} contains these transformations and it is MATLAB code, meaning that you can simply run it in MATLAB (e.g. hit the green run button).
	  In this file the global structures \texttt{M\_} (which contains model information),
	    \texttt{options\_} (which contains default values for options),
		and \texttt{oo\_} (which contains results) are initialized
		(and some other structures as well depending on the commands you run in your mod file).
	\item \texttt{dynamic\_resid.m}: this is a script file with MATLAB code that evaluates the residuals of the dynamic model equations,
		i.e. what we get when we put everything on the right hand side
		and evaluate the equation for some arbitrary values of the dynamic variables and the parameters.
		That is dynamic files take into account that variables can appear at $t-1$, $t$ or $t+1$.
	\item \texttt{static\_resid.m}: this is a script file with MATLAB code that evaluates the residuals of the static model equations.
		The static model equations are given when we get rid of the $t-1$, $t$ or $t+1$ subindex of the variables.
		The file the computes the residuals, i.e. when we put everything on the right hand side
		and evaluate the static equations for some arbitrary value of the static variables and the parameters.
	\item \texttt{dynamic\_g1.m}: this is a script file with MATLAB code that evaluates the Jacobian of the dynamic model equations
	  with respect to the dynamic model variables and the exogenous shock.
	  That is, let $f(z)$ denote the model equations and $z$ the vector of the dynamic variables and the exogenous variables,
	    then $g1$ computes $\partial f(z) \ \partial z$.
	\item \texttt{static\_g1.m}: this is a script file with MATLAB code that evaluates the Jacobian of the static model equations
		with respect to the model variables.
		That is, let $\bar{f}(y)$ denote the model equations and $y$ the vector of the model variables,
		  then this file computes $\partial \bar{f}(x) \ \partial y$.
	\end{itemize}
\item When computing the Jacobian of the dynamic model,
  the order of the endogenous variables in the columns is stored in \texttt{M\_.lead\_lag\_incidence}.
The rows of this matrix represent time periods: the first row denotes a lagged (time $t-1$) variable,
  the second row a contemporaneous (time $t$) variable,
  and the third row a leaded (time $t+1$) variable.
The columns of the matrix represent the endogenous variables in their order of declaration.
A zero in the matrix means that this endogenous does not appear in the model in this time period.
The value in the \texttt{M\_.lead\_lag\_incidence} matrix corresponds to the column of that variable in the Jacobian of the dynamic model.
\item \texttt{matlab\_rbc\_nonlinear\_preprocessing.m}:
\lstinputlisting{progs/matlab/matlab_rbc_nonlinear_preprocessing.m}
\end{enumerate}
\fi
\newpage
\end{solution}