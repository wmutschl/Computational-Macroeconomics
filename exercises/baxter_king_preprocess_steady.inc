\section[Fiscal Policy in General Equilibrium: preprocessing and steady-state]{Fiscal Policy in General Equilibrium: preprocessing and steady-state\label{ex:BaxterKingPreprocessSteady}}
Consider a RBC model augmented with fiscal policy as in \textcite{Baxter.King_1993_FiscalPolicyGeneral}.

\paragraph*{Households}
Let $C_t$ denote real consumption, $L_t$ time devoted to leisure, $I_t$ private investment and $K_t$ the end-of-period private capital stock.
The representative household maximizes its expected life-time utility
\begin{align*}
\max E_0 \sum_{t=0}^\infty \beta^t \left[log(C_t)+\theta_L log(L_t) + \Gamma(G_t^B,K_t^G)\right]
\end{align*}
where $\beta$ denotes the discount rate, $\theta_L$ a preference weight for leisure.\footnote{
For simplicity, we do not distinguish between \emph{planning time} for the household and \emph{calendar time} for the economy.
Alternatively, one could write the objective as $E_t \sum_{j=0}^\infty \beta^j U(C_{t+j},L_{t+j},G_{t+j}^B,K_{t+j}^G)$.
}
$\Gamma(G_t^B,K_t^G)$ is a general non-decreasing function in each of its arguments: basic government purchases $G_t^B$
  and the stock of publicly provided capital $K_t^G$.\footnote{
Basic purchases correspond to a spending that absorbs resources without affecting private production or consumption decisions.
\textcite{Baxter.King_1993_FiscalPolicyGeneral} consider military spending as an example.
}
The private and public capital stocks evolve according to
\begin{align}
K_{t} &= (1-\delta_K)K_{t-1} + I_t \label{eq:BaxterKing:PrivateCapital}\\
K_{t}^G &= (1-\delta_K)K_{t-1}^G + I_t^G \label{eq:BaxterKing:PublicCapital}
\end{align}
with $\delta_K$ denoting the common depreciation rate, $I_t$ is private investment and $I_t^G$ government investment.
Total uses of goods for consumption and investment cannot exceed disposable income from labor and private capital rentals:
\begin{align*}
C_t + I_t \leq (1-\tau_t)(W_t N_t + R^K_{t} K_{t-1}) + {TR}_t
\end{align*}
where $W_t$ is the real wage, $R^K_t$ the real rental rate of capital, $\tau_t$ the uniform tax rate on income and $TR_t$ are real lump-sum transfer payments.
The time $N_t$ devoted to work is constraint by a normalized time budget:
\begin{align*}
L_t + N_t = 1
\end{align*}
Optimality is given by the consumption-leisure choice
\begin{align}
(1-\tau_t) W_t = \theta_L \frac{C_t}{1-N_t} \label{eq:BaxterKing:ConsumptionLeisure}
\end{align}
and the savings decision
\begin{align}
E_t \left[ \frac{C_{t+1}}{C_t}\right] = \beta E_t \left[ 1-\delta_K + (1-\tau_{t+1})R^K_{t+1}\right] \label{eq:BaxterKing:SavingsDecision}
\end{align}

\paragraph*{Firms}
Firms maximize profits
\begin{align*}
\max Y_t - W_t N_t - R^K_{t} K_{t-1}
\end{align*}
by choosing factor inputs $N_t$ and $K_{t-1}$ and subject to a Cobb-Douglas production function for output $Y_t$:
\begin{align}
Y_t = (N_t)^{\theta_N} (K_{t-1})^{\theta_K} (K_{t-1}^G)^{\theta_G} \label{eq:BaxterKing:CobbDouglasProductionFunction}
\end{align}
where $\theta_N$, $\theta_K$ and $\theta_G$ denote, respectively, the productivity of labor, private and public capital in production.
Taking factor prices as given, optimal factor demand is given by
\begin{align}
W_t N_t &= \theta_N Y_t \label{eq:BaxterKing:LaborDemand}\\
R^K_{t} K_{t-1}&= \theta_K Y_t \label{eq:BaxterKing:PrivateCapitalDemand}
\end{align}

\paragraph*{Fiscal authority}
The fiscal authority faces the budget constraint
\begin{align}
G_t \equiv G_t^B + I_t^G = \tau_t(W_t N_t + R^K_{t} K_{t-1}) - TR_t\label{eq:BaxterKing:FiscalBudget}
\end{align}
and its behavior is described by exogenous AR(1) processes
\begin{align}
G_t^B-\bar{G}^B &= \rho_{G^B} \left(G_{t-1}^B - \bar{G}^B\right) +  \varepsilon_t^{G^B} \label{eq:BaxterKing:GovernmentSpendingRule}\\
I_t^G-\bar{I}^G &= \rho_{I^G} \left(I_{t-1}^G - \bar{I}^G\right) +  \varepsilon_t^{I^G} \label{eq:BaxterKing:GovernmentInvestmentRule}\\
\log\left(\frac{\tau_t}{\bar{\tau}}\right) &= \rho_\tau \log\left(\frac{\tau_{t-1}}{\bar{\tau}}\right) +  \varepsilon_t^\tau \label{eq:BaxterKing:GovernmentTaxRule}
\end{align}
where $\rho_{G^B}, \rho_{I^G}, \rho_{\tau}$ are smoothing parameters and
\begin{align*}
\varepsilon_t^{G^B}\overset{iid}{\sim} N(0,\sigma_{G^B}^2), \qquad
\varepsilon_t^{I^G}\overset{iid}{\sim} N(0,\sigma_{I^G}^2), \qquad
\varepsilon_t^\tau\overset{iid}{\sim} N(0,\sigma_{\tau}^2)
\end{align*}
Notice that the inclusion of $TR_t$ implies a balanced budget rule, i.e. there is no debt in the model.

\paragraph*{Market clearing}
Market clearing implies that whatever is consumed by households must also be produced
\begin{align}
Y_t = C_t + I_t + G_t \label{eq:BaxterKing:MarketClearing}
\end{align}

\paragraph{Summary}
Overall, the model can be summarized through equations
  \eqref{eq:BaxterKing:PrivateCapital},
  \eqref{eq:BaxterKing:PublicCapital},
  \eqref{eq:BaxterKing:ConsumptionLeisure},
  \eqref{eq:BaxterKing:SavingsDecision},
  \eqref{eq:BaxterKing:CobbDouglasProductionFunction},
  \eqref{eq:BaxterKing:LaborDemand},
  \eqref{eq:BaxterKing:PrivateCapitalDemand},
  \eqref{eq:BaxterKing:FiscalBudget},
  \eqref{eq:BaxterKing:GovernmentSpendingRule},
  \eqref{eq:BaxterKing:GovernmentInvestmentRule},
  \eqref{eq:BaxterKing:GovernmentTaxRule},
  and
  \eqref{eq:BaxterKing:MarketClearing}.




\subsection*{Exercises}
\begin{enumerate}

\item As a first step it is always important to distinguish between variables and parameters.
What are the endogenous variables, the exogenous variables and the model parameters?  

\item Calibrate the model parameters so that a period corresponds to a \textbf{quarter}.
Select the parameter values so that the steady state of the model matches the specifications in the following table:
\begin{center}
\begin{tabular}{lcc}
Target & Symbol & Value \\\hline
steady-state output level          & $Y$ & 1 \\
steady-state public consumption    & $G^B$ & 0.2$Y$ \\
steady-state public investment     & $I^G$ & 0.02$Y$ \\
steady-state transfers             & $TR$ & 0 \\
steady-state real wage             & $W$ & 2\\
steady-state labor                 & $N$ & 1/3\\
\hline
\end{tabular}
\end{center}
Furthermore, assume constant returns to scale over privately provided inputs in the production function
  and impose that public capital productivity is \textbf{lower} than private capital productivity.
Moreover, both capital stocks should depreciate with a rate equal to 2.5\%.
Regarding the fiscal policy rules, set all persistence parameters to 0.75.

\item Write a Dynare mod-file for this model with the above calibration and compute the steady-state.
Comment each block so that the structure of the code is made explicit.

\newpage

\item Now assume that the production function incorporates labor-augmenting technical progress at the constant gross rate $\gamma_X>1$:
\begin{align}
  Y_t &= (X_t N_t)^{\theta_N} (K_{t-1})^{\theta_K} (K_{t-1}^G)^{\theta_G} \label{eq:BaxterKing:ProductionFunctionGrowth}
  \\
  X_{t+1} &= \gamma_X X_t \nonumber
\end{align}
  \begin{enumerate}
  \item What is a \emph{balanced growth path}?
  \item What restriction on the parameters is required such that the model features a balanced growth path for the model variables?
  \item Show how to eliminate the steady-state growth by rescaling all of the trending variables by $X_t$.
  \item Adjust your mod file and calibrate $\gamma_X$ such that the economy growths at 1.6\% \textbf{per annum}.
  \end{enumerate}
\emph{Hint: See section 3.1 in \textcite{King.Rebelo_1999_ResuscitatingRealBusiness} for the intuition and steps.
For extensive technical details on assumptions and required functional forms have a look at \textcite{King.Plosser.Rebelo_1988_ProductionGrowthBusiness}
  and its technical appendix \textcite{King.Plosser.Rebelo_2002_ProductionGrowthBusiness}. }
\end{enumerate}

\paragraph{Readings}
\begin{itemize}
\item \textcite{Baxter.King_1993_FiscalPolicyGeneral}
\item \textcite{King.Rebelo_1999_ResuscitatingRealBusiness}
\item \textcite{King.Plosser.Rebelo_1988_ProductionGrowthBusiness}
\item \textcite{King.Plosser.Rebelo_2002_ProductionGrowthBusiness}
\end{itemize}

\begin{solution}\textbf{Solution to \nameref{ex:BaxterKingPreprocessSteady}}
\ifDisplaySolutions
\input{exercises/baxter_king_preprocess_steady_solution.inc}
\fi
\newpage
\end{solution}