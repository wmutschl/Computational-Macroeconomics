\begin{enumerate}
\item As for all $t$ the shocks are zero, i.e. $\varepsilon_t = 0$, we get
  $x - \theta x = 0 \Leftrightarrow x = 0$,
  where $x$ denotes the non-stochastic steady-state
  (we drop the time subscript in the original equation when computing the steady-state).
\item \lstinputlisting[style=Matlab-editor,basicstyle=\mlttfamily,title=\lstname]{progs/dynare/arma_1_1.mod}
Some notes:
\begin{itemize}
	\item we used MATLAB codes for plotting.
	\item whenever the parameters are equal to each other,
		the simulated series for $x_t$ is always equal to the drawn shocks $\varepsilon_t$.
	\item for some parameter combinations, e.g. $\theta=1.5$ and $\theta=0.4$,
		Dynare prints an error \texttt{Blanchard \& Kahn conditions are not satisfied: no stable equilibrium.}
	If you are familiar with time series models,
		this is due to the fact that this parameter combination provides a non-stationary process,
		i.e. the process explodes and does not return to the equilibrium/steady-state.
\end{itemize}

\item \lstinputlisting[style=Matlab-editor,basicstyle=\mlttfamily,title=\lstname]{progs/matlab/arma_1_1.m}
\end{enumerate}