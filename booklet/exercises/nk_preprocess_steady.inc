\section[Basic New Keynesian Model: preprocessing and steady-state in Dynare]{New Keynesian Model: preprocessing and steady-state in Dynare\label{ex:NewKeynesianModelPreprocessSteady}}
Consider the just derived basic New Keynesian (NK) model without capital and a linear production function.
Assume that the parameters have the following values:
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
      ${\rho_{\nu}}$ 	 & 	 0.500\\
      ${\sigma}$ 	 & 	 1.000\\
      ${\varphi}$ 	 & 	 5.000\\
      ${\theta}$ 	 & 	 0.750\\
      ${\epsilon}$ 	 & 	 9.000\\
      ${\phi_{\pi}}$ 	 & 	 1.500\\
      ${\phi_{y}}$ 	 & 	 0.125\\
      ${\Pi^*}$ 	 & 	 1.005\\
      \bottomrule%
      \end{longtable}

Write a Dynare mod file for this model and compute the steady state of the model either analytically or numerically.
Hint: The model equations are 
\eqref{eq:NewKeynesianNominalInterestRate}, 
\eqref{eq:NewKeynesianRealInterestRate},
\eqref{eq:NewKeynesianLaborSupply},
\eqref{eq:NewKeynesianEuler},     
\eqref{eq:NewKeynesianRealMarginalCosts},
\eqref{eq:NewKeynesianPriceSetting}, 
\eqref{eq:NewKeynesianPriceSettingSum1}, 
\eqref{eq:NewKeynesianPriceSettingSum2},
\eqref{eq:NewKeynesianLoMPriceDispersion},
\eqref{eq:NewKeynesianMonetaryPolicyRule},
\eqref{eq:NewKeynesianLoMPreferenceShifter}, 
\eqref{eq:NewKeynesianLoMTechnology},
\eqref{eq:NewKeynesianLoMMonPol},
\eqref{eq:NewKeynesianAggregateProfits}, 
\eqref{eq:NewKeynesianAggregateDemand}, 
\eqref{eq:NewKeynesianAggregateSupply}, 
and
\eqref{eq:NewKeynesianLoMPriceInefficiency}.
Additionally, for reporting purposes, add the following equations:
\begin{align*}
\widehat{y}_t &= \log\left(y_{t}\right) - \log\left(y\right) &&
\widehat{w}_t =\log\left(w_t\right) - \log\left(w\right)&&
\widehat{n}_t = \log\left(n_{t}\right) - \log\left(n\right) \\
\widehat{\Pi}^{an}_{t}&=4 \left( \log\left(\Pi_{t}\right) - \log\left(\Pi\right) \right)&&
\widehat{R}^{an}_{t} =4 \left( \log\left(R_{t}\right) - \log\left(R\right)\right)&&
\widehat{r}^{an}_{t} =4 \left( \log\left(r_{t}\right) - \log\left(r\right) \right)\\
\widehat{mc}_t &= \log\left(mc_{t}\right) - \log\left(mc\right) &&
\widehat{a}_t = \log\left(a_{t}\right) - \log\left(a\right)&&
\widehat{z}_t = \log\left(z_{t}\right) - \log\left(z\right)
\end{align*}    
where variables without a time subscript denote steady-state values.


\begin{solution}\textbf{Solution to \nameref{ex:NewKeynesianModelPreprocessSteady}}
\ifDisplaySolutions
\subsection*{Steady-State:}
The steady-state can be computed analytically for all model variables.

In the non-stochastic steady-state $\varepsilon_{z,t}=\varepsilon_{a,t}=\varepsilon_{\nu,t}=0$.
Accordingly, equations \eqref{eq:NewKeynesianLoMPreferenceShifter}, \eqref{eq:NewKeynesianLoMTechnology} and \eqref{eq:NewKeynesianLoMMonPol} become:
\begin{align*}
z = 1, \qquad a=1, \qquad \nu = 0
\end{align*}

From equation \eqref{eq:NewKeynesianMonetaryPolicyRule} we can infer
\begin{align*}
\Pi = \Pi^*
\end{align*}
Note that the following derivations would simplify immensely if one considers price stability in steady-state, i.e. $\Pi^*=1$.
However, in the following we'll allow for trend inflation,
  e.g. an annualized inflation target of 2\% which for quarterly models would equal to $\Pi^*=1.005$.

Anyways, from \eqref{eq:NewKeynesianLoMPriceDispersion} we get:
\begin{align*}
{\widetilde{p}} = \left(\frac{1-{{\theta}}\, {{\Pi}}^{{{\epsilon}}-1}}{1-{{\theta}}}\right)^{\frac{1}{1-{{\epsilon}}}}
\end{align*}
Obviously, for $\Pi^*=1$ we'd get ${\widetilde{p}} =1$.

Now comes the messy part.
Evaluating \eqref{eq:NewKeynesianPriceSettingSum1} and \eqref{eq:NewKeynesianPriceSettingSum2} in steady-state,
  we can combine them to get an expression for $s_1/s_2$.
Evaluating \eqref{eq:NewKeynesianPriceSetting} in steady-state in terms of $s_1/s_2$,
  we can rearrange to get marginal costs in steady-state:
\begin{align*}
{mc} = \frac{\frac{{{\epsilon}}-1}{{{\epsilon}}}\, {{\widetilde{p}}}\, \left(1-{{\theta}}\, {{\beta}}\, {{\Pi}}^{{{\epsilon}}}\right)}{1-{{\theta}}\, {{\beta}}\, {{\Pi}}^{{{\epsilon}}-1}}
\end{align*}
Again, for $\Pi^*=1$, this looks much more familiar as $mc =\frac{{{\epsilon}}-1}{{{\epsilon}}}$.

Now we are able to evaluate \eqref{eq:NewKeynesianLoMPriceInefficiency} in steady state, which becomes:
\begin{align*}
{p^*} = {{\widetilde{p}}}^{-{{\epsilon}}} \,\frac{1-{{\theta}}}{1-{{\theta}}\, {{\Pi}}^{{{\epsilon}}}}
\end{align*}
Obviously, for $\Pi^*=1$ this would imply $p^*=1$.

Now comes the easy part: evaluating equations \eqref{eq:NewKeynesianEuler}, \eqref{eq:NewKeynesianNominalInterestRate} and \eqref{eq:NewKeynesianRealInterestRate} in steady state yields:
\begin{align*}
Q = \frac{\beta}{\Pi}, \qquad R = \frac{1}{Q}, \qquad r = \frac{R}{\Pi}
\end{align*}
Steady-state wages can be computed from \eqref{eq:NewKeynesianRealMarginalCosts} (as $mc_t(f)=mc_t$):
\begin{align*}
  w = mc \cdot a
\end{align*}
To get labor in steady-state, we start with evaluating labor supply \eqref{eq:NewKeynesianLaborSupply} in steady-state:
\begin{align}
  w &= - \frac{-z n^\varphi}{z c^{-\sigma}} 
  = n^\varphi c^\sigma 
  \overset{\eqref{eq:NewKeynesianAggregateDemand}}{=} n^\varphi y^\sigma
  \overset{\eqref{eq:NewKeynesianAggregateSupply}}{=} n^\varphi \left(\frac{a n}{p^*}\right)^\sigma
  = n^{\varphi+\sigma} \left(\frac{a}{p^*}\right)^\sigma
  \\
  \Leftrightarrow
  n &= \left(\frac{w}{\left(\frac{a}{p^*}\right)^\sigma}\right)^{\frac{1}{\varphi+\sigma}}
\end{align}
The remaining variables follow accordingly:
\begin{align*}
y = a n/p^*, \qquad
c = y,\qquad
{div} = {{y}}-{{n}}\, {{w}}, \qquad
{s_1} = \frac{{{y}}\, {{c}}^{-{{\sigma}}}}{1-{{\Pi}}^{{{\epsilon}}-1}\, {{\theta}}\, {{\beta}}}, \qquad
{s_2} = \frac{{{mc}}\cdot\, {{y}}\, {{c}}^{-{{\sigma}}}}{1-{{\theta}}\, {{\beta}}\, {{\Pi}}^{{{\epsilon}}}}
\end{align*}
Lastly, all hat variables have a steady-state of 0 by definition.

\lstinputlisting{../progs/dynare/new_keynesian_common.inc}

\lstinputlisting{../progs/dynare/new_keynesian_steady.mod}
Run the mod file.

\fi
\newpage
\end{solution}
