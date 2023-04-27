\section[New Keynesian Model: preprocessing and steady-state in Dynare]{New Keynesian Model: preprocessing and steady-state in Dynare\label{ex:NewKeynesianModelPreprocessSteady}}
Consider the New Keynesian (NK) model of exercise \ref{ex:AlgebraNewKeynesianModels}.
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
      ${\delta}$   &   0.025\\
      ${\phi_i}$   &   4.000 \\
      ${\alpha}$   &   0.300\\
      ${\sigma_c}$ 	 & 	 1.000\\
      ${\sigma_h}$ 	 & 	 1.000\\
      $\chi_h$       & 5.000\\
      ${\theta}$ 	 & 	 0.750\\
      ${\epsilon}$ 	 & 	 9.000\\
      ${\phi_{\pi}}$ 	 & 	 1.500\\
      ${\phi_{y}}$ 	 & 	 0.125\\
      ${\Pi^*}$ 	 & 	 1.005\\
      ${\rho_a}$ 	 & 	 0.900\\
      ${\rho_\zeta}$ 	 & 	 0.500\\
      ${\rho_{\nu}}$ 	 & 	 0.500\\
      \bottomrule%
      \end{longtable}

\noindent
Write a Dynare mod file for this model and compute the steady state of the model either analytically using a \texttt{steady\_state\_model} block
  or numerically using an \texttt{initval} block.
%Hint: The model equations are 
%\eqref{eq:NewKeynesianNominalInterestRate}, 
%\eqref{eq:NewKeynesianRealInterestRate},
%\eqref{eq:NewKeynesianLaborSupply},
%\eqref{eq:NewKeynesianEuler},     
%\eqref{eq:NewKeynesianRealMarginalCosts},
%\eqref{eq:NewKeynesianPriceSetting}, 
%\eqref{eq:NewKeynesianPriceSettingSum1}, 
%\eqref{eq:NewKeynesianPriceSettingSum2},
%\eqref{eq:NewKeynesianLoMPriceDispersion},
%\eqref{eq:NewKeynesianMonetaryPolicyRule},
%\eqref{eq:NewKeynesianLoMPreferenceShifter}, 
%\eqref{eq:NewKeynesianLoMTechnology},
%\eqref{eq:NewKeynesianLoMMonPol},
%\eqref{eq:NewKeynesianAggregateProfits}, 
%\eqref{eq:NewKeynesianAggregateDemand}, 
%\eqref{eq:NewKeynesianAggregateSupply}, 
%and
%\eqref{eq:NewKeynesianLoMPriceInefficiency}.

\noindent Additionally, for reporting purposes, add the following equations:
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
%\input{exercises/nk_preprocess_steady_solution.inc}
\fi
\newpage
\end{solution}