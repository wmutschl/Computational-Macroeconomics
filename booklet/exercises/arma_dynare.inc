\section[ARMA(1,1) simulation]{ARMA(1,1) simulation\label{ex:ARMASimulation}}
Consider the ARMA(1,1) model:
$$ x_t - \theta x_{t-1} = \varepsilon_t - \phi \varepsilon_{t-1}$$
where $\varepsilon_t \sim N(0,1)$.

\begin{enumerate}
\item Compute the non-stochastic steady-state with pen and paper, i.e. what is the value of $x_t$ if $\varepsilon_t = 0$ for all $t$?
\item Write a Dynare mod file for this model:
\begin{itemize}
	\item $x$ is the endogenous variable, $\varepsilon$ the exogenous variabel, and $\theta$ and $\phi$ are the parameters.
	\item Set $\theta=\phi=0.4$.
	\item Write either a \texttt{steady\_state\_model} or \texttt{initval} block and compute the steady-state.
	\item Start at the non-stochastic steady-state and simulate 200 data points using a \texttt{shocks} block 
	and the \texttt{stoch\_simul} command. Drop the first 50 observations and plot both $x$ as well as $\varepsilon$.
	\item Try out different values for $\theta$ and $\phi$. What do you notice?
\end{itemize}
\item Redo the exercise in MATLAB without using Dynare.	
\end{enumerate}
\emph{Hints}:
\begin{itemize}
	\item Don't forget to add Dynare's matlab path:
	\texttt{addpath C:/dynare/5.1/matlab} for Windows,
	\texttt{addpath /Applications/Dynare/5.1/matlab} for macOS,
	\texttt{addpath /opt/dynare/5.1/matlab} for Linux machines.
	If you installed Dynare to a different folder, adapt the path accordingly.
	\item When saving your Dynare script as a mod file, try to use a simple name.
	That is, don't use special characters or spaces in the filename,
	  e.g. \texttt{arma(1,1).mod} as well as \texttt{arma 1 1.mod} are not valid filenames, 
	  whereas \texttt{arma.mod} or \texttt{arma\_1\_1.mod} are valid.
	\item It is advised to save the mod file directly on your hard drive and not on a cloud storage drive.
	If you do save it to a folder that is in sync with e.g. Dropbox, iCloud, Nextcloud, OneDrive (etc),
	  please (temporarily) deactivate sync activities,  
	  to prevent sync conflicts and weird errors when running Dynare.	
\end{itemize}


\begin{solution}\textbf{Solution to \nameref{ex:ARMASimulation}}
\ifDisplaySolutions
\begin{enumerate}
\item As for all $t$ the shocks are zero, i.e. $\varepsilon_t = 0$, we get
  $x - \theta x = 0 \Leftrightarrow x = 0$,
  where $x$ denotes the non-stochastic steady-state
  (we drop the time subscript in the original equation when computing the steady-state).
\item \texttt{arma\_1\_1\_dynare.mod}
\lstinputlisting{progs/dynare/arma_1_1_dynare.mod}
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
\item \texttt{arma\_1\_1\_matlab.m}
	\lstinputlisting{progs/matlab/arma_1_1_matlab.m}
\end{enumerate}
\fi
\newpage
\end{solution}