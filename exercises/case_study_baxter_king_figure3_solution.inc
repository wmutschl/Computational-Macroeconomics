\begin{enumerate}
\item[2. and 3.] The mod file might look like this:
\lstinputlisting[style=Matlab-editor,basicstyle=\mlttfamily\scriptsize,title=\lstname]{progs/replications/Baxter_King_1993/Baxter_King_1993_figure_3.mod}
\item[4.] No, for many reasons. To name just two:
\begin{itemize}
    \item A war is a large shock with unknown duration.
    Perfect foresight simulations do not capture this as in period 1 everything is revealed to the agents.
    A solution to this would be a perfect-foresight simulation with expectation errors (sometimes called MIT-shock).
    To this end, one simulates the sequence of shocks but alters the information set of the agents in each period before the onset of another shock.
    Algorithmically, we repeat the simulation cycle four times and then combine the simulations,
      utilizing the first one for periods $1$ to $2$, the second one for $2$ to $3$, the third one for $3$ to $4$ ..., and the fourth one for $4$ to $T$.
    In Dynare 6.0 there is a new command for such a simulation called ``perfect foresight with expectation errors''.
    For older versions of Dynare this type of simulation can be done by running a sequence of perfect foresight simulations while adjusting initial conditions manually.
    Intuitively, this captures the belief that guides agents during times of war;
      namely that the conflict will last only one year (the surprise shock on impact) and will not occur again.
    However, this belief is challenged when the war continues beyond the expected duration,
      and agents are surprised by the ongoing conflict (restart the simulation with a new surprise shock in the next period).
    Despite this surprise, the belief in a one-year duration persists, leading to ongoing cycles of surprise shocks (and expectation errors).
    \item A war shock has many channels; solely relying on a demand-side effect via government spending reflects a very US-specific view.
    There is some research that war shocks are rather dominated by supply-side effects
      and also accompanied by different policy stances during war times.
    One could argue that the current simulation is for a neighboring country,
      the US being mostly a very distant country to warsites.
\end{itemize}
\end{enumerate}
