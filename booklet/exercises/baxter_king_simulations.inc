\section[Fiscal Policy in General Equilibrium: Simulations in Dynare]{Fiscal Policy in General Equilibrium: Simulations in Dynare\label{ex:BaxterKingSimulationsDynare}}
Consider a version of the \textcite{Baxter.King_1993_FiscalPolicyGeneral} model
  which is given in the following Dynare file called \texttt{Baxter\_King\_common.inc:}\\
\lstinputlisting[basicstyle=\tiny]{progs/dynare/Baxter_King_common.inc}

\begin{enumerate}
  \item Use stochastic simulations (i.e. the \texttt{stoch\_simul(order=1,irf=30)} command) for the \emph{obs} variables to study the effects
    of a 1\% shock to (i) public consumption and (ii) public investment.
  Try to explain the responses of the agents and model variables in your own words using the economic mechanisms of this model.  
  \item What is the productivity effect of public capital on the private sector?
  To answer this, redo the previous exercise but with a lower value for $\eta$ (e.g.\ 0.05) and compare results.
%  \item Now let's introduce government bonds into the model.
%    To this end, households can buy an amount $B_t$ of such bonds with face value of 1 in period $t$.
%    The bonds mature next period and the government must pay it back with interest,
%      i.e.\ the household receives $R_t B_t$ from the government in $t+1$.    
%  \begin{itemize}
%    \item Make a copy of the original Dynare file with the model equations.
%    \item Add two new endogenous variables \texttt{debt} and \texttt{r} for government bonds and gross interest payments.
%    \item Add three new parameters \texttt{DEBT\_BAR=0}, \texttt{RHO\_TR=0.75}, and \texttt{XI\_TR}.
%      for the target debt level, the persistence of the new transfer rule and the elasticity of transfers with respect to outstanding debt.
%    \item Add the Euler equation for government bonds to the model equations:
%\begin{lstlisting}
%[name='bond savings decision']
%lam = BETA*lam(+1)*r;
%\end{lstlisting}
%    \item Add the fiscal rule for transfers:
%\begin{lstlisting}
%[name='fiscal rule: transfers']
%tr - TR_BAR = RHO_TR*(tr(-1)-TR_BAR) + XI_TR*(debt-DEBT_BAR);
%\end{lstlisting}
%    \item Add government bonds to the government budget restriction:
%\begin{lstlisting}
%[name='government budget constraint']
%r(-1)*debt(-1) + g + ivg + tr = debt + tau*(w*n + rk*k(-1));
%\end{lstlisting}
%    \item Redo the stochastic simulations for three different values for \texttt{XI\_TR}=$\{-0.1,0,0.1\}$.
%    Which value works and why?
%    \item Compare your results for government spending shocks to the previous case without government bonds.
%    What does this imply for \emph{Ricardian Equivalence}.
%    \\\emph{Hint: transfers are usually considered a non-distortionary fiscal instrument.}
%    \item Now set \texttt{XI\_TR}=0 and introduce debt in the tax rate rule:
%\begin{lstlisting}
%[name='fiscal rule: tax rate']
%log(tau/TAU_BAR) = RHO_TAU*log(tau(-1)/TAU_BAR) + XI_TAU*(debt-DEBT_BAR) + e_tau;
%\end{lstlisting}
%    Try out different values of \texttt{XI\_TR}=$\{-0.1,0,0.1\}$ and redo the previous exercise.
%    What does this imply for \emph{Ricardian Equivalence}.    
%  \end{itemize}
%\item Study the long-run effects of an increase in the tax rate.
%That is, compare the old and new steady-state values and use deterministic simulations to depict the transition paths.
\end{enumerate}



\begin{solution}\textbf{Solution to \nameref{ex:BaxterKingSimulationsDynare}}
\ifDisplaySolutions
\begin{enumerate}
\item The following code can be used to compare the impulse response functions with respect to
  government spending and investment shocks.\\\texttt{Baxter\_King\_irfs.mod:}\\
  \lstinputlisting[basicstyle=\tiny]{progs/dynare/Baxter_King_irfs.mod}
  
  \textbf{Comparison government spending vs government investment shock}\\
  \begin{figure}[h]
    \centering 
    \includegraphics[width=0.70\textwidth]{graphs/Baxter_King_irfs_IRF_comparison.eps}
    \caption{Impulse response functions of unit government shocks.}
    \label{fig:BaxterKingIrfs}
  \end{figure}
  \noindent Figure \ref{fig:BaxterKingIrfs} shows the IRFs for both government spending and government investment shocks.
  
  Let us focus first on government spending.
  We see that there is on impact a positive effect on output, labor and the interest rate;
  whereas consumption, investment and wages decrease.
  The return to steady-state happens gradually but rather quickly.
  In more detail, when government spending goes up, the household feels poorer,
    because it has to pay more taxes either now or in the future (see the transfers irf).
  This makes it want to consume less and work more.
  Working more raises output.
  So the mechanism through which government spending impacts output in this model is not by stimulating demand,
    but rather through a wealth effect channel wherein people feel poorer and supply more labor.
  As the drop in consumption is persistent,
    we see from the aggregate resource constraint that private investment must fall due to the increase in government spending.
  Therefore, a shock to government spending will crowd out private investment.
  By how much depends largely on the the persistence parameter of the government spending process.
  Because of perfectly competitive factor prices, the decrease in investment and increase in labor supply is reflected in
    a decreasing marginal productivity of labor (wage goes down)
    and increasing marginal productivity of capital (interest rate goes up).

  Now turning to government investment, we see several differences both in the magnitude and direction of the responses.
  Keep in mind that government investment spills over to the private sector by increasing overall productivity and
     the marginal products of labor and capital rise and so do wages and interest rates.
  This is very similar to a TFP shock in the basic RBC model,
    as the increase in government investment has a direct positive effect in the public capital stock which is an input in the production function.
  Therefore, even though the effect on output is on impact slightly negative,
    the following periods we actually see a high and hump-shaped increase in output.  
  On the other hand, as mentioned above, there is a negative wealth effect,
    because these increases have to be paid by more taxes either now or in the future.
  However, the productivity boost outweighs in this parametrization the negative wealth effect.
  Even though the stock of public capital accumulate over time (and hence directly and persistently increases output),
    the schedules for private labor supply and investment shift over time the sign of their reaction as a result of the rising stock of public capital.    
  Note that public capital competes with private capital.
  With an increase of the former, the interest rate increases on impact and there is an incentive for private agents to slowdown investment.
  However, in this case, the negative substitution effect is dominated by a positive wealth effect and investment stays positive.

\item The following code can be used to compare the impulse response functions with respect to
  investment shocks for different values of $\eta$.\\\texttt{Baxter\_King\_irfs\_eta.mod:}\\
  \lstinputlisting[basicstyle=\tiny]{progs/dynare/Baxter_King_irfs_eta.mod}
  \textbf{Comparison productivity of government investment}\\
  \begin{figure}[h]
    \centering 
    \includegraphics[width=0.70\textwidth]{graphs/Baxter_King_irfs_eta_IRF_comparison.eps}
    \caption{Productivity of government investment}
    \label{fig:BaxterKingIrfsEta}
  \end{figure}
  \noindent Figure \ref{fig:BaxterKingIrfsEta} shows the IRFs of a government investment shock with two different productivity values.
  Not surprisingly, the higher the productivity parameter, the more clearly government investment acts like a TFP process.
  
\end{enumerate}

\fi
\newpage
\end{solution}
