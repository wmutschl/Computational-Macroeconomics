\begin{enumerate}
\item \lstinputlisting[style=Matlab-editor,basicstyle=\mlttfamily\scriptsize,title=\lstname]{progs/dynare/rbc.mod}
\item Dynare's preprocessor creates the following script files:
\begin{itemize}
	\item \texttt{driver.m}: the preprocessor reads the text and information provided in the mod file 
	  and creates MATLAB code from this.
	The \texttt{driver.m} contains these transformations and it is pure MATLAB code, meaning that you can simply run it in MATLAB (e.g. hit the green run button).
	In this script all model information is stored into structures.
	Particularly, the global structures \texttt{M\_} (which contains model information),
	  \texttt{options\_} (which contains default values for options),
	  and \texttt{oo\_} (which contains results) are initialized
	  (and some other structures as well depending on the commands you run in your mod file).
	\item \texttt{dynamic\_resid.m}: this is a script file with MATLAB code that evaluates the residuals of the dynamic model equations,
	  i.e.\ what we get when we put all model equations on the right hand side
	  and evaluate this system of equations for arbitrary values of the dynamic variables and the parameters.
	Note that the dynamic files distinguish that variables can appear at different timings $t-1$, $t$ or $t+1$.
	\item \texttt{static\_resid.m}: this is a script file with MATLAB code that evaluates the residuals of the static model equations.
	The static model equations are given when we strip of the timings of the variables.
	The file then computes the residuals, i.e.\ when we put all model equations on the right hand side
	  and evaluate the static system of equations for arbitrary values of the static variables and parameters.
	\item \texttt{dynamic\_g1.m}: this is a script file with MATLAB code that evaluates the Jacobian of the dynamic model equations
	  with respect to the dynamic model variables and the exogenous shock.
	That is, let $f(z)$ denote the model equations and $z$ the vector of the dynamic variables and the exogenous variables,
	  then $g1$ computes $\partial f(z) \ \partial z$.
	\item \texttt{static\_g1.m}: this is a script file with MATLAB code that evaluates the Jacobian of the static model equations
	  with respect to the model variables.
	That is, let $\bar{f}(y)$ denote the model equations and $y$ the vector of the model variables,
	  then this file computes $\partial \bar{f}(y) \ \partial y$.
	\end{itemize}
\item The Jacobian $g_1$ of the dynamic model is a key matrix for solving and simulating DSGE models.
It's row dimension is equal to the number of equations,
  and the columns correspond to which endogenous variable the derivative is taken with respect to.
First come the $t-1$ variables (that actually appear in the model equations at $t-1$),
  then the $t$ variables (that actually appear in the model equations at $t$),
  then the $t+1$ variables (that actually appear in the model equations at $t+1$),
  and lastly the exogenous variables.
When computing the Jacobian of the dynamic model,
  the order of the endogenous variables in the columns is stored in \texttt{M\_.lead\_lag\_incidence}.
The rows of this matrix represent time periods: the first row denotes a lagged (time $t-1$) variable,
  the second row a contemporaneous (time $t$) variable,
  and the third row a leaded (time $t+1$) variable.
The columns of the matrix represent the endogenous variables in their order of declaration.
A zero in the matrix means that this endogenous does not appear in the model in this time period.
The value in the \texttt{M\_.lead\_lag\_incidence} matrix corresponds to the column of that variable in the Jacobian $g_1$ of the dynamic model.
\item A preprocessing script:
\lstinputlisting[style=Matlab-editor,basicstyle=\mlttfamily\scriptsize,title=\lstname]{progs/matlab/preprocessing_matlab_rbc.m}
\item A script for comparison:
\lstinputlisting[style=Matlab-editor,basicstyle=\mlttfamily\scriptsize,title=\lstname]{progs/matlab/preprocessing_matlab_rbc_comparison.m}
\end{enumerate}