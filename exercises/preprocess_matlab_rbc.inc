\section[RBC model: preprocessing in MATLAB]{RBC model: preprocessing in MATLAB\label{ex:PreprocessMATLABRBC}}
Consider the basic Real Business Cycle (RBC) model with leisure and log utility function.
The dynamic model equations are given in Table \ref{tbl:RBC.Model},
  the variable description in Table \ref{tbl:RBC.Variables},
  and the description and calibration of parameters in Table \ref{tbl:RBC.Parameters}.

{\footnotesize
\input{exercises/rbc_model_description_short.inc}
}%
\begin{enumerate}

\item Create a Dynare mod file for this model and compute the steady-state.

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
	    using the names in \texttt{endo\_names} and the \texttt{syms} command.
	  That is, \texttt{a\_back} should be a symbolic variable denoting $a_{t-1}$,
	    \texttt{a\_curr} should be a symbolic variable denoting $a_{t}$,
		\texttt{a\_fwrd} should be a symbolic variable denoting $a_{t+1}$,
		and \texttt{a\_stst} should be a symbolic variable denoting the steady-state $a$.
	\item Create symbolic variables using the names in \texttt{exo\_names} and the \texttt{syms} command.
    \item Create symbolic variables using the names in \texttt{param\_names} and the \texttt{syms} command.
    \item Create a symbolic vector \texttt{dynamic\_eqs} with the dynamic model equations given in Table \ref{tbl:RBC.Model} (put everything on the left-hand side).
    Use the just declared convention for symbolic variables and parameters.
	\item Create the \texttt{lead\_lag\_incidence} matrix and use it to distinguish the following types of variables:
 		\begin{itemize}
	 	\item static variables, which appear only at $t$, but neither at $t-1$ nor at $t+1$.
        \item predetermined variables, which appear only at $t-1$, possibly at $t$, but not at $t+1$.
        \item forward variables, which appear only at $t+1$, possibly at $t$, but not at $t-1$.
        \item mixed variables, which appear at $t-1$ and $t+1$, and possibly at $t$.
        \item dynamic variables, which actually appear in the dynamic model equations
        \item exogenous variables
 		\end{itemize}
	\item Compute the Jacobian of \texttt{dynamic\_eqs} with respect to symbolic dynamic variables and the symbolic exogenous variables.
	\item Compute the static model equations using the \texttt{subs} command
	  to substitute the dynamic variables with their corresponding name without the \texttt{\_back}, \texttt{\_curr}, or \texttt{\_fwrd} suffix.
	Store the static model equations in the symbolic variable \texttt{static\_eqs}.
	\item Compute the Jacobian of \texttt{static\_eqs} with respect to symbolic endogenous variables.    
    \item Write out the static and dynamic model equations and Jacobians to script files:
\begin{lstlisting}[style=Matlab-editor,basicstyle=\mlttfamily\scriptsize]
write_out(static_eqs,'rbc_static_resid','residual',1,dynamic_names,endo_names,exo_names,param_names);
write_out(static_g1,'rbc_static_g1','g1',1,dynamic_names,endo_names,exo_names,param_names);
write_out(dynamic_eqs,'rbc_dynamic_resid','residual',0,dynamic_names,endo_names,exo_names,param_names);
write_out(dynamic_g1,'rbc_dynamic_g1','g1',0,dynamic_names,endo_names,exo_names,param_names);
\end{lstlisting}
	The function \texttt{write\_out.m} is given in appendix \ref{app:write_out}.
	\item Make the whole script a function called \texttt{preprocessing\_matlab\_rbc.m} with an output variable MODEL,
	  which is a structure containing information on the names and numbers of the endogenous and exogenous variables,
  	  the names and numbers of the parameters, and also the \texttt{lead\_lag\_incidence} matrix.
	\end{enumerate}
\item Compare Dynare's preprocessing and the manual preprocessing done in MATLAB. To this end:
	\begin{enumerate}
	\item Run dynare on the mod file to create the preprocessing files and to compute the steady-state.
	Append the following code at the end of your mod file:
\begin{lstlisting}[style=Matlab-editor,basicstyle=\mlttfamily\scriptsize]
% create steady-state vectors
[I,~] = find(M_.lead_lag_incidence');
y_ss   = oo_.steady_state;      % steady-state of endogenous variables
zzz_ss = oo_.steady_state(I);   % steady-state of dynamic variables
ex_ss  = oo_.exo_steady_state'; % steady-state of exogenous variables

% evaluate dynamic model residuals and Jacobian at steady-state
[dynare_resid, dynare_g1] = feval([M_.fname,'.dynamic'], zzz_ss, ex_ss, M_.params, y_ss, 1);
% evaluate static model residuals and Jacobian at steady-state
[dynare_resid_static, dynare_g1_static] = feval([M_.fname,'.static'], y_ss, ex_ss, M_.params);
\end{lstlisting}
	\item Preprocess the model with MATLAB and evaluate the script files at the steady-state:
	\item Look at the differences of the computed residuals and Jacobians of both dynamic and static model equations
	  between Dynare's and MATLAB's preprocessing.
	\end{enumerate}
\end{enumerate}


\begin{solution}\textbf{Solution to \nameref{ex:PreprocessMATLABRBC}}
\ifDisplaySolutions
\input{exercises/preprocess_matlab_rbc_solution.inc}
\fi
\newpage
\end{solution}