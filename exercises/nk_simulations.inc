\section[Basic New Keynesian Model: Simulations in Dynare]{New Keynesian Model: Simulations in Dynare\label{ex:NewKeynesianModelSimulationsDynare}}
Consider the basic New Keynesian (NK) model with capital, monopolistic competition, Calvo price rigidities, and investment adjustment costs,
  which is given in the Dynare mod file called \texttt{nk.mod}.

\begin{enumerate}

\item Use stochastic simulations (i.e. the \texttt{stoch\_simul(order=1,irf=30)} command) for the \emph{hat} variables to study the effects of a
\begin{enumerate}
  \item unit shock to technology $\varepsilon_{a,t}$.
  \item contractionary monetary policy shock of an increase of 25 basis points in $\varepsilon_{\nu,t}$.
  \item discount factor shock by setting the size of the initial shock $\varepsilon_{\zeta,t}$ to -0.5 percentage points.
\end{enumerate}
Try to explain the responses of the agents and model variables in your own words using the economic mechanisms of this model.

\item Redo the previous exercise using deterministic simulations,
  i.e.\ using \texttt{perfect\_foresight\_setup} and \texttt{perfect\_foresight\_solver}.
Compare both simulation approaches.
\end{enumerate}

\paragraph{Readings}
\begin{itemize}
  \item \textcite[Ch.~3]{Gali_2015_MonetaryPolicyInflation}
  \item \textcite{Rupert.Sustek_2019_MechanicsNewKeynesianModels}	
\end{itemize}

\begin{solution}\textbf{Solution to \nameref{ex:NewKeynesianModelSimulationsDynare}}
\ifDisplaySolutions
\input{exercises/nk_simulations_solution.inc}
\fi
\newpage
\end{solution}