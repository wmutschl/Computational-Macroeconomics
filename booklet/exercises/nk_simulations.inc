\section[Basic New Keynesian Model: Simulations in Dynare]{New Keynesian Model: Simulations in Dynare\label{ex:NewKeynesianModelSimulationsDynare}}
Consider the basic New Keynesian (NK) model without capital and a linear production function
  which is given in the following Dynare file called \texttt{new\_keynesian\_common.inc:}\\
\lstinputlisting[basicstyle=\tiny]{progs/dynare/new_keynesian_common.inc}

\noindent Assume that the parameters have the following values:
\begin{longtable}{cc}
  \caption{Parameter Values}\\%
  \toprule%
  \multicolumn{1}{c}{\textbf{Parameter}} &
  \multicolumn{1}{c}{\textbf{Value}} \\%
  \midrule%
  \endfirsthead
  \multicolumn{2}{c}{{\tablename} \thetable{} -- Continued}\\%
  \midrule%
  \multicolumn{1}{c}{\textbf{Parameter}} &
  \multicolumn{1}{c}{\textbf{Value}} \\%
  \midrule%
  \endhead
  ${\beta}$ 	 & 	 0.990\\
  ${\rho_a}$ 	 & 	 0.900\\
  ${\rho_z}$ 	 & 	 0.500\\
  ${\rho_{\nu}}$ 	 & 	 0.400\\
  ${\sigma}$ 	 & 	 1.000\\
  ${\varphi}$ 	 & 	 5.000\\
  ${\theta}$ 	 & 	 0.750\\
  ${\epsilon}$ 	 & 	 9.000\\
  ${\phi_{\pi}}$ 	 & 	 1.500\\
  ${\phi_{y}}$ 	 & 	 0.125\\
  ${\Pi^*}$ 	 & 	 1.000\\
  \bottomrule%
\end{longtable}

\begin{enumerate}
  \item Use stochastic simulations (i.e. the \texttt{stoch\_simul(order=1,irf=30)} command) for the \emph{hat} variables to study the effects of a
  \begin{enumerate}
    \item unit shock to technology $\varepsilon_{a,t}$.
    \item contractionary monetary policy shock of an increase of 25 basis points in $\varepsilon_{\nu,t}$
    \item discount factor shock by setting the size of the initial shock $\varepsilon_{z,t}$ to -0.5 percentage points.      
  \end{enumerate}
  Try to explain the responses of the agents and model variables in your own words using the economic mechanisms of this model.
  \item Redo the previous exercise using deterministic simulations,
    i.e.\ using \texttt{perfect\_foresight\_setup} and \texttt{perfect\_foresight\_solver}.
\end{enumerate}



\begin{solution}\textbf{Solution to \nameref{ex:NewKeynesianModelSimulationsDynare}}
\ifDisplaySolutions
\begin{enumerate}
  \item First of all, we put a minus sign in front of the preference shifter \texttt{eps\_z} to answer c):
  \begin{lstlisting}
  [name='preference shifter']
  log(z) = RHO_Z*log(z(-1)) - eps_z;
  \end{lstlisting}
  Then we can include the model equations in the following mod file called \texttt{new\_keynesian\_irfs\_stoch.mod:}
  \lstinputlisting{progs/dynare/new_keynesian_irfs_stoch.mod}

  Before we dive in, keep in mind that all variables are simultaneously determined;
    any description of the transmission channels can only be a cursory way to provide intuition,
    rather than an accurate characterization of the model's dynamics.
  The magic clearly happens through the equations, macroeconomists then try to tell an economic story behind the dynamics (depending on the focus of their analysis).
  \\
  \textbf{General remarks for intuition:}
  \begin{itemize}
    \item Keep in mind that we are in an environment of monopolistic competition,
      constant elasticity demand curves and randomly arriving opportunities to adjust prices.
    \item When firms set prices, they are concerned about future inflation,
      because there is a chance that they won't be able to adjust prices for several periods.			
    \item The inflation process is forward-looking, current inflation is a function of expected future inflation.
    More specifically, inflation is the present discounted value of current and future real marginal costs.
    \item We have a linear production function.
    \item Real marginal cost is equal to real wage divided by marginal product of labor. 
    \item Real wage is equal to marginal rate of substitution between leisure and consumption.
    \item \emph{Taylor principle}: When inflation rises, the central bank rises the nominal interest rate more than one-to-one.
    In other words, it guarantees that the real interest rate eventually rises with inflation.
    The increase in the real interest rate creates a counter-effect to inflation,
      since a higher real interest rate causes a fall in the output gap and in deviations of the marginal cost from the steady state.
    This is the underlying economic principle behind the ability of monetary policy to anchor inflation expectations.
  \end{itemize}
  Note that in the mod file, we focus on the hat variables which are defined as \textbf{log deviations from steady-state}.
  This is useful for interpreting the Impulse Response Functions as Dynare plots these in \textbf{deviation from steady-state}.
  So for hat variables this corresponds (at \texttt{order=1}) to \textbf{percentage deviations} from the original level variables from steady state.
  
  \textbf{Technology shock}\\
  \begin{figure}[h]
    \centering 
    \includegraphics[width=0.80\textwidth]{graphs/new_keynesian_irfs_stoch_IRF_eps_a.eps}
    \caption{Impulse response functions (orthogonalized shock to ${\varepsilon_a}$).}
    \label{Fig:IRF:eps_a}
  \end{figure}
  The positive unit shock on total factor productivity has on impact a positive effect on output (and also consumption),
    which then follows a downward sloping path due to the persistence of the technological process.
  On the other hand, we see on impact deflation, higher wages, lower hours worked,
    and lower interest rates (both the nominal interest rate and the real interest rate),
    which then all follow an upward-sloping path back to steady-state.

  The intuition is that the boost in productivity increases the marginal productivity of labor,
    which affects not only the consumption-saving and labor-leisure decision,
    but also the price-setting decision of firms.
  In more detail, marginal cost of firms falls and this creates incentives for firms to cut their prices.
  The firms that can reset their price are concerned about not being able to reset it again during the future productivity boost period,
    so they lower their prices more than they would under flexible prices,
    implying a larger drop in inflation (compared to the flex-price case) and a large drop in real marginal costs.
  Likewise, the increase in output is not as large as with flexible prices as the firms that cannot lower their price lower output.
  According to the Taylor rule, the central bank reacts to the deflationary pressure by lowering the nominal interest rate more than one-to-one.
  In accordance, the real interest rate falls on impact (but not as much as with flexible-prices)
    and then follows an upward sloping path.
  This reflects the wish of the households to smooth consumption via the Euler equation,
    as consumption in the future becomes less attractive and households prefer to consume more during the periods of productivity boost.
    
  The effect on wages and hours worked depends on the production function (in our case linear) and the calibration of the model;
    particularly, the Calvo probability, the utility elasticity parameters and the feedback parameters in the Taylor rule.
  In the chosen calibration, we see an increase in wages,
    because the increase in the marginal productivity of labor is higher than the reduction in marginal costs.
  A different Calvo probability might flip this around.
  Similarly, the effect on hours worked, is in principle ambiguous.
  A sufficient condition to cause a decline in hours worked is $\sigma\geq 1$ or a sufficiently large feedback coefficient $\phi_\pi$,
    which in the chosen calibration is both fulfilled.

  \textbf{Preference shifter shock}\\
  \begin{figure}[h]
    \centering 
    \includegraphics[width=0.80\textwidth]{graphs/new_keynesian_irfs_stoch_IRF_eps_z.eps}
    \caption{Impulse response functions (orthogonalized shock to ${\varepsilon_z}$).}
    \label{Fig:IRF:eps_z}
  \end{figure}   

  The decrease in the preference shifter means that the effective discount factor ($z_t \beta^t$ for $t=0,1,2...$) becomes lower;
    in other words, households are temporarily becoming more patient and prefer to postpone their consumption, output drops.
  This decreased demand creates incentives for firms to decrease their price and inflation falls.
  Note though, that not all firms can reset their price.
  Nevertheless, lower prices imply lower marginal costs and lower wages.
  According to the Taylor rule, the central bank reacts to the deflationary pressure and decline in output
    by decreasing the nominal interest rate more-than-one-for-one ($\phi_\pi>1$).
  In accordance to the Fisherian equation,
    the real interest rate decreases on impact and then follows an upward sloping path.
  This reverses the effect on the consumption-savings decision of the households via the Euler equation,
    as consumption in the present becomes again more attractive.
  However, the decline in the real interest rate is not sufficient to prevent the overall contraction in economic activity (as in the flex-price model).
  Again the effect on hours worked, is in principle ambiguous dependent on the production function and the values of $\sigma$ and $\phi_\pi$.
  
  \textbf{Monetary policy shock}\\
  \begin{figure}[h]
    \centering 
    \includegraphics[width=0.80\textwidth]{graphs/new_keynesian_irfs_stoch_IRF_eps_nu.eps}
    \caption{Impulse response functions (orthogonalized shock to ${\varepsilon_\nu}$).}
    \label{Fig:IRF:eps_nu}
  \end{figure}

  From the empirical VAR literature we can motivate the \emph{real rate channel of monetary policy}:
    the central bank controls the short-term nominal interest rate and has leverage over the ex-ante real interest rate,
    because nominal prices are sticky.
  
  Now let's look at this evidence through the lens of our Baseline New-Keynesian model.
  An exogenous tightening of monetary policy, i.e. a positive realization of $v_t$,
    indeed replicates all these facts, i.e. output and inflation decline,
    whereas the nominal and real interest rates increase.
  In other words, a monetary tightening, in the form of a positive shock to the Taylor rule
    that increases the short-term nominal interest rate translates into an increase in the real interest rate
    as well when nominal prices move sluggishly due to costly or staggered price setting.
  This rise in the real interest rate then causes households to cut back on their current consumption spending.
  Finally, the decline in output puts downward pressure on inflation, which adjusts only gradually after the shock.

  Some notes of caution with this interpretation:
  \begin{itemize}
    \item One can show, that for higher values of $\rho_\nu$ the nominal interest rate can decline
        in response to a contractionary monetary policy shock.
      The intuition is the following:
      Assume the initial monetary policy shock increases the nominal and thus the real interest rate.
      The central bank then reacts to lower output and inflation endogenously by lowering the nominal interest rate.
      If the response is strong enough, it overcompensates the initial increase due to the shock.
      The ex-ante real rate, however, always increases, irrespective of the shock persistence in the baseline New Keynesian model,
        as it is inversely related to monetary policy shocks.
    \item A challenge to this \emph{real rate channel of monetary policy} is given by e.g. \textcite{Rupert.Sustek_2019_MechanicsNewKeynesianModels}
      who show that similar to the flexible-price case, inflation is determined by current and expected future monetary policy shocks.
    According to the New-Keynesian Phillips-curve output temporarily drops when inflation temporarily declines.
    The reason is that firms that cannot adjust prices reduce output.
    The real interest rate only reflects the desire and ability of households to keep consumption smooth in face of such temporary changes,
      but it is not the actual driving force of the dynamics.
    Particularly, they show that when introducing capital into the model,
      monetary policy shocks can generate a decline in output and inflation,
      while the reaction of the real interest rate depends on the calibration: it can increase, decline or stay constant.
    \item To sum up, don't look solely at interest rates to see whether monetary policy is expansionary or contractionary.
  \end{itemize}

\item Consider the following mod file called \texttt{new\_keynesian\_irfs\_det.mod:}
\lstinputlisting{progs/dynare/new_keynesian_irfs_det.mod}

\noindent The helper plotting function is given by \texttt{new\_keynesian\_irfs\_do\_plots.mod:}
\lstinputlisting{progs/dynare/new_keynesian_irfs_do_plots.m}

\begin{figure}[H]
    \centering 
    \includegraphics[width=0.60\textwidth]{graphs/new_keynesian_irfs_det_IRF_eps_a.eps}
    \caption{Deterministic Simulations: Impulse response functions (shock to ${\varepsilon_a}$).}
    \label{fig:NKdet.epsa}
\end{figure}
\begin{figure}[H]
    \centering 
    \includegraphics[width=0.60\textwidth]{graphs/new_keynesian_irfs_det_IRF_eps_z.eps}
    \caption{Deterministic Simulations: Impulse response functions (shock to ${\varepsilon_z}$).}
    \label{fig:NKdet.epsz}
\end{figure}   
\begin{figure}[H]
    \centering 
    \includegraphics[width=0.60\textwidth]{graphs/new_keynesian_irfs_det_IRF_eps_nu.eps}
    \caption{Deterministic Simulations: Impulse response functions (shock to ${\varepsilon_\nu}$).}
    \label{fig:NKdet.epsnu}
\end{figure}

The impulse response functions of the deterministic simulation are given in figures \ref{fig:NKdet.epsa}, \ref{fig:NKdet.epsz}, and \ref{fig:NKdet.epsnu}.
Overall, the dynamics are very similar in the sign of the reactions,
  but not so much in the size of the deviation from steady-state,
  as the deterministic simulation tends to be somewhat more muted compared to the stochastic impulse-response functions.
Also for some variables there is some short overshooting in the adjustment dynamics,
  and the reaction of wages and employment slightly differs even though the magnitude is very small.
To sum up, there are slight differences between whether one is more concerned about non-linearities or stochastics.
\end{enumerate}
\fi
\newpage
\end{solution}
