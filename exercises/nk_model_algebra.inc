\section[The Algebra of New Keynesian Models]{The Algebra of New Keynesian Models\label{ex:AlgebraNewKeynesianModels}}
Consider a New Keynesian (NK) model with capital and \textcite{Calvo_1983_StaggeredPricesUtilitymaximizing} price frictions.

\paragraph{Households: Utility}
The economy is assumed to be inhabited by a large representative family with a continuum of members.
Consumption and hours worked are identical across family members.
The household's preferences are defined over per capita consumption $c_t$,
  and per capita labor effort $h_t$.
The representative household maximizes present as well as expected future utility
\begin{align}
	\max E_t \sum_{s=0}^{\infty} \beta^{s} \zeta_{t+s} U(c_{t+s}, h_{t+s}) \label{eq:NewKeynesian.UtilityLifetime}
\end{align}
where $E_t$ is the expectation operator conditional on information at time $t$
  and $\zeta_t$ denotes an exogenous shifter to the discount factor $\beta <1$.
Consider the following functional form for the contemporaneous utility function
\begin{align}
U(c_t, h_t) = \frac{c_t^{1-\sigma_c}}{1-\sigma_c} - \chi_h \frac{h_t^{1+\sigma_h}}{1+\sigma_h} \label{eq:NewKeynesian.UtilityMomentary}
\end{align}
We denote the marginal utilities with respect to consumption and labor as:

{\footnotesize
\begin{align}
U^c_t \equiv \frac{\partial U(c_t,h_t)}{\partial c_t},
\quad
U^h_t \equiv \frac{\partial U(c_t,h_t)}{\partial h_t},
\quad
U^{cc}_t \equiv \frac{\partial^2 U(c_t,h_t)}{\partial^2 c_t},
\quad
U^{ch}_t \equiv \frac{\partial^2 U(c_t,h_t)}{\partial c_t \partial h_t},
\quad
U^{hh}_t \equiv \frac{\partial^2 U(c_t,h_t)}{\partial^2 h_t}
\label{eq:NewKeynesian.UtilityMarginalNotation}
\end{align}
}%
Note that the marginal utility of consumption is positive,
  whereas more labor reduces utility.
Moreover, the chosen utility function \eqref{eq:NewKeynesian.UtilityMomentary} is concave.

~\\\noindent\emph{Exercises:}
\begin{enumerate}
\item Show that $1/\sigma_c$ is the intertemporal elasticity of substitution defined as $IES = -\frac{U_t^c}{U_t^{cc} c_t}$.  
\end{enumerate}

\paragraph{Households: Consumption Bundle}
The consumption good is assumed to be a composite made of a continuum of differentiated goods $c_t(j)$
  represented on the interval $j\in [0,1]$ via a constant elasticity of substitution (CES) aggregation technology as in \textcite{Dixit.Stiglitz_1977_MonopolisticCompetitionOptimum}:
\begin{align}
	c_t = \left(\int_0^1 c_t(j)^{\frac{\epsilon-1}{\epsilon}} dj \right)^{\frac{\epsilon}{\epsilon-1}} \label{eq:NewKeynesian.ConsumptionAggregator}
\end{align}
$\epsilon>1$ is the intratemporal elasticity of substitution across different varieties of consumption goods.
The household decides how to allocate its consumption expenditures among the different goods by taking the price $P_t(j)$ of good $c_t(j)$ as given.

~\\\noindent\emph{Exercises:}
\begin{enumerate}[resume]
\item Show that cost minimization of consumption expenditures implies
\begin{align}
c_t(j) &= \left(\frac{P_t(j)}{P_t}\right)^{-\epsilon} c_t \label{eq:NewKeynesian.ConsumptionDemand}
\\
P_t &= \left(\int_0^1 P_t(j)^{1-\epsilon}dj\right)^{\frac{1}{1-\epsilon}} \label{eq:NewKeynesian.AggregatePriceIndex}
\\
P_t c_t &= \int_0^1 c_t(j) P_t(j) dj \label{eq:NewKeynesian.AggregateConsumptionExpenditures}
\end{align}
Interpret these equations.
\end{enumerate} 

\paragraph{Households: Capital Accumulation}
The household owns the (end of period) capital stock $k_t$ which evolves according to
\begin{align}
k_t = (1-\delta)k_{t-1} + \Biggl( 1 - \underbrace{\frac{\phi_i}{2} \left(\frac{i_t}{i_{t-1}} - 1 \right)^2}_{S\left(\frac{i_t}{i_{t-1}}\right)} \Biggr) i_t \label{eq:NewKeynesian.CapitalAccumulation}
\end{align}
$\delta$ is the depreciation rate and $\phi_i \geq 0$.
$i_t$ denotes gross investment and is assumed to be a composite good made with the same aggregation technology as in equation \eqref{eq:NewKeynesian.ConsumptionAggregator}.
Therefore, bundling is isomorphic to equations \eqref{eq:NewKeynesian.ConsumptionDemand} and \eqref{eq:NewKeynesian.AggregateConsumptionExpenditures}:
\begin{align}
i_t(j) &= \left(\frac{P_t(j)}{P_t}\right)^{-\epsilon} i_t \label{eq:NewKeynesian.InvestmentDemand}
\\
P_t i_t &= \int_0^1 i_t(j) P_t(j) dj \label{eq:NewKeynesian.AggregateInvestmentExpenditures}
\end{align}

~\\\noindent\emph{Exercises:}
\begin{enumerate}[resume]
\item What does the introduction of the function $S\left(\frac{i_t}{i_{t-1}}\right)$ imply for the law of motion of capital?
\end{enumerate}

\paragraph{Households: Budget}
Capital is rented to the intermediate firms at a nominal rate of $R^k_{t}$ which the household takes as given when forming optimal plans.
Similarly, in each period the household takes the nominal wage $W_t$ as given and supplies perfectly elastic labor service $h_t$ to the firm sector.
In return she receives nominal labor income $W_t h_t$.
All firms are owned by the household so that nominal profits and dividends from firms in the final good sector, $ Div^{Fin}_t$,
  as well as from each firm $f\in[0,1]$ in the intermediate goods sector, $\int_0^1 {Div}^{Int}_t(f)df$,
  are received by the household.
Lastly, the household purchases a quantity of one-period nominally risk-free bonds $B_t$ at price $P^B_t$.
The bond matures the following period and pays one unit of money at maturity.
Income and wealth are used to finance consumption expenditures.
In total this defines the \emph{nominal} budget constraint of the household
\begin{align}
\int_0^1 P_t(j) c_t(j) dj + \int_0^1 P_t(j) i_t(j) dj + P^B_t B_t \leq B_{t-1} + W_t h_t + R^k_tk_{t-1} + Div^{Fin}_t + \int_0^1 Div^{Int}_t(f) df
\label{eq:NewKeynesian.BudgetNominal}
\end{align}
In what follows, let lower case letters denote real variables, i.e.\
\begin{align*}
b_t=\frac{B_t}{P_t},~~ w_t=\frac{W_t}{P_t},~~ r^k_t = \frac{R^k_t}{P_t},~~ div^{Fin}_t = \frac{Div^{Fin}_t}{P_t},~~ div^{Int}_t = \frac{Div^{Int}_t}{P_t}
\end{align*}

~\\\noindent\emph{Exercises:}
\begin{enumerate}[resume]

\item Explain the economic intuition behind the following relationships for the nominal interest rate $R_t$ and the real interest rate $r_t$:
\begin{align}
P^B_t &= \frac{1}{R_t} \label{eq:NewKeynesian.NominalInterestRate}
\\
R_t &= r_t E_t \Pi_{t+1} \label{eq:NewKeynesian.RealInterestRate}
\end{align}

\item Derive the intratemporal and intertemporal optimality conditions:
\begin{align}
\lambda_t &= \zeta_t c_t^{-\sigma_c} \label{eq:NewKeynesian.MarginalUtility}
\\
w_t &= \chi_h h_t^{\sigma_h} c_t^{\sigma_c}
\label{eq:NewKeynesian.LaborSupply}
\\
\lambda_t &= \beta E_t \left[\lambda_{t+1} r_t\right]
\label{eq:NewKeynesian.EulerBond}
\\
1 &= q_t \left( 1 - \frac{\phi_i}{2} \left(\frac{i_t}{i_{t-1}}-1\right)^2 - \phi_i \left(\frac{i_t}{i_{t-1}}-1\right)\left(\frac{i_t}{i_{t-1}}\right) \right)
  + \beta E_t \frac{\lambda_{t+1}}{\lambda_t} q_{t+1} \phi_i \left(\frac{i_{t+1}}{i_{t}}-1\right)\left(\frac{i_{t+1}}{i_{t}}\right)^2
\label{eq:NewKeynesian.EulerInvestment}
\\
q_t &= \beta E_t \frac{\lambda_{t+1}}{\lambda_t} \left( r^k_{t+1} + q_{t+1}(1-\delta) \right)
\label{eq:NewKeynesian.EulerCapital}
\end{align}
where $\beta^s\lambda_{t+s}$ and $\beta^s \lambda_{t+s} q_{t+s}$ are the discounted Lagrange multipliers
  corresponding to period $t+s$'s budget constraint \eqref{eq:NewKeynesian.BudgetNominal} in real terms
   and capital accumulation equation \eqref{eq:NewKeynesian.CapitalAccumulation}, respectively.
Interpret these equations.

\item Show that $1/\sigma_h$ is the Frisch elasticity of labor.

\end{enumerate}


\paragraph{Households: Transversality And Solvency Conditions}
It is assumed that the household is subject to a transversality condition
\begin{align*}
	\lim_{T \rightarrow \infty} E_t \left\{\Lambda_{t,T} k_T\right\} = 0
\end{align*}
and a solvency constraint that prevents it from engaging in Ponzi-type schemes:
\begin{align*}
	\lim_{T \rightarrow \infty} E_t \left\{\Lambda_{t,T} \frac{B_T}{P_T}\right\} \geq 0
\end{align*}
for all periods $t$, where
\begin{align}
\Lambda_{t,t+s} = \beta^{s} \frac{\lambda_{t+s}}{\lambda_t} \label{eq:NewKeynesian.StochasticDiscountFactor}
\end{align}
denotes the stochastic discount factor.

~\\\noindent\emph{Exercises:}
\begin{enumerate}[resume]

\item Is there debt in this model? In other words, explain why an optimal path implies
\begin{align}
B_t = 0 \label{eq:NewKeynesian.MarketClearing.Bonds}
\end{align}

\item Explain the difference between the solvency constraint
  $\lim_{T \rightarrow \infty} E_t \left\{\Lambda_{t,T} \frac{B_T}{P_T}\right\} \geq 0$
  and the transversality condition
  $\lim_{T \rightarrow \infty} E_t \left\{\Lambda_{t,T} \frac{B_T}{P_T}\right\} = 0$.
  which holds in the optimum allocation.

\item Derive the following expression for the stochastic discount factor:
\begin{align}
\Lambda_{t,t+1+s} = \beta \frac{\lambda_{t+1}}{\lambda_t} \Pi_{t+1}^{-1} \Lambda_{t+1,t+1+s} \label{eq:NewKeynesian.StochasticDiscountFactorRecursive}
\end{align}

\end{enumerate}

\paragraph{Final Good Firm (Retail Sector): Profit Maximization}
The economy is populated by a continuum of firms indexed by $f \in [0,1]$ that produce differentiated goods $y_t(f)$ in monopolistic competition.
The technology for transforming these intermediate goods into the final output good $y_t$ that can be used for consumption and investment
  has the \textcite{Dixit.Stiglitz_1977_MonopolisticCompetitionOptimum} form:
\begin{align}
y_t = \left[\int\limits_0^1 y_t(f)^{\frac{\epsilon-1}{\epsilon}}df\right]^{\frac{\epsilon}{\epsilon-1}} \label{eq:NewKeynesian.Firms.Aggregator}
\end{align}
where $\epsilon>1$ is the same substitution elasticity as in \eqref{eq:NewKeynesian.ConsumptionAggregator}.

~\\\noindent\emph{Exercises:}
\begin{enumerate}[resume]
\item Show that profit maximization in the final goods sector implies:
\begin{align}
y_t(f) &= \left(\frac{P_t(f)}{P_t}\right)^{-\epsilon} y_t \label{eq:NewKeynesian.Firms.Demand}
\\
P_t y_t &= \int_{0}^{1} P_t(f) y_t(f) df \label{eq:NewKeynesian.Firms.ZeroProfit}
\end{align}
Interpret the equation.
What does this imply for real profits $div_t^{Fin}$ in the final goods sector?
\end{enumerate}

\paragraph{Intermediate Goods Firms (Wholesale Sector): Profit Maximization}
Intermediate firm $f\in[0,1]$ uses the following production function to produce their differentiated good
\begin{align}
y_t(f) = a_t (k_{t-1}(f))^\alpha (n_t(f))^{1-\alpha} \label{eq:NewKeynesian.IntermediateFirms.ProductionFunction}
\end{align}
where $a_t$ denotes the common technology level available to all firms.
Firms face perfectly competitive factor markets for renting capital $k_{t-1}(f)$ and hiring labor $n_t(f)$ with $\alpha$ being a productivity parameter.
Nominal profits of firm $f$ are equal to revenues from selling its differentiated good at self-determined price $P_t(f)$
  minus costs from hiring labor at real wage $w_t$ and real renting rate of capital $r^k_t$:
\begin{align}
{Div}^{Int}_t(f) = P_t(f) y_t(f) - P_t w_t n_t(f) - P_t r^k_t k_{t-1}(f) \label{eq:NewKeynesian.Firms.Profits}
\end{align}
The objective of the firm is to choose contingent plans for $P_t(f)$, $n_t(f)$ and $k_{t-1}(f)$
  so as to maximize the present discounted value of nominal dividend payments given by
\begin{align*}
E_t \sum_{s=0}^{\infty} \Lambda_{t,t+s} Div^{Int}_{t+s}(f)
\end{align*}

~\\\noindent\emph{Exercises:}
\begin{enumerate}[resume]
\item Why are future profits discounted by the household's stochastic discount factor $\Lambda_{t,t+s} = \beta^s \lambda_{t+s}/\lambda_{t}$?
\end{enumerate}

\paragraph{Intermediate Goods Firms (Wholesale Sector): Optimal Factor Inputs}

~\\\noindent\emph{Exercises:}
\begin{enumerate}[resume]

\item Derive the optimal capital and labor demand schedules of intermediate good firm $f$:
\begin{align}
r^k_t  &= mc_t(f) \alpha a_t \left( \frac{n_t(f)}{k_{t-1}(f)}\right)^{1-\alpha}
\label{eq:NewKeynesian.IntermediateFirms.CapitalDemand}
\\
w_t  &= mc_t(f) (1-\alpha) a_t \left(\frac{n_t(f)}{k_{t-1}(f)}\right)^{-\alpha}
\label{eq:NewKeynesian.IntermediateFirms.LaborDemand}
\end{align}
where $mc_t(f)$ is the Lagrange multiplier corresponding to constraint \eqref{eq:NewKeynesian.IntermediateFirms.ProductionFunction}.
Interpret the equations and the explain why $mc_t(f)$ is a measure of real marginal costs.

\item Show that all intermediate firms choose the same capital to labor ratio in production
\begin{align}
\left(\frac{k_{t-1}(f)}{n_t(f)}\right) = \left(\frac{w_t}{1-\alpha}\right) \left(\frac{\alpha}{r^k_t}\right) \label{eq:NewKeynesian.IntermediateFirms.CapitalLaborRatio}
\end{align}

\item Show that marginal costs are independent of $f$:
\begin{align}
mc_t \equiv mc_t(f) = \frac{1}{a_t} \left(\frac{w_t}{1-\alpha}\right)^{1-\alpha} \left(\frac{r^k_t}{\alpha}\right)^{\alpha} \label{eq:NewKeynesian.RealMarginalCosts}
\end{align}

\end{enumerate}

\paragraph{Intermediate Goods Firms (Wholesale Sector): Price Setting}

Prices of intermediate goods are determined by nominal contracts as in \textcite{Calvo_1983_StaggeredPricesUtilitymaximizing} and \textcite{Yun_1996_NominalPriceRigidity}.
In each period firm $f$ faces a constant probability $1-\theta, 0\leq \theta \leq 1$,
  of being able to re-optimize the price $P_t(f)$ of its good $y_t(f)$.
The probability is independent of the time it last reset its price.
Formally:
\begin{align}
P_t(f) = \begin{cases}
\widetilde{P}_t(f) & \text{with probability } 1-\theta\\
P_{t-1}(f) & \text{with probability } \theta
\end{cases}
\label{eq:NewKeynesian.CalvoMechanism}
\end{align}
where $\widetilde{P}_t(f)$ is the reset price in period $t$.
Accordingly, when a firm cannot adjust its price for $s$ periods,
  its price in period $t+s$ is given by $\widetilde{P}_t(f)$ and stays there until the firm can re-optimize again.
Hence, the firm's objective in $t$ is to set $\widetilde{P}_t(f)$ to maximize expected profits
  until it can re-optimize the price again in some future period $t+s$.
The probability to be stuck at the same price for $s$ periods is given by $\theta^s$.

\newpage
~\\\noindent\emph{Exercises:}
\begin{enumerate}[resume]

\item Denote the relative reset price as $\widetilde{p}_t := \frac{\widetilde{P}_t(f)}{P_t}$ and 
  show that optimal price setting of intermediate firms must satisfy:
\begin{align}
\widetilde{p}_t \cdot s_{1,t} &= \frac{\epsilon}{\epsilon-1} \cdot s_{2,t} \label{eq:NewKeynesian.IntermediateFirms.PriceSetting}
\end{align}
where
\begin{align*}
s_{1,t} &= E_t\sum_{s=0}^{\infty}\theta^s \Lambda_{t,t+s} \left(\frac{P_{t+s}}{P_t}\right)^{\epsilon} y_{t+s}
\\
s_{2,t} &= E_t \sum_{s=0}^{\infty}\theta^s \Lambda_{t,t+s} \left(\frac{P_{t+s}}{P_t}\right)^{\epsilon+1} y_{t+s} mc_{t+s}
\end{align*}
Why can we drop the $f$ in the definition of $\widetilde{p}_t$?

\item Show that the infinite sums $s_{1,t}$ and $s_{2,t}$ can be written recursively:
\begin{align}
s_{1,t} &= y_t             + \beta \theta E_t \frac{\lambda_{t+1}}{\lambda_t} \Pi_{t+1}^{\epsilon-1}s_{1,t+1}
\label{eq:NewKeynesian.IntermediateFirms.PriceSettingSum1}
\\
s_{2,t} &=  mc_t y_{t}  + \beta \theta E_t \frac{\lambda_{t+1}}{\lambda_t} \Pi_{t+1}^{\epsilon} s_{2,t+1}
\label{eq:NewKeynesian.IntermediateFirms.PriceSettingSum2}
\end{align}

\item Show that according to the Calvo mechanism the law of motion for the optimal reset price $\widetilde{p}_t = \widetilde{P}_t(f) / P_t$ is given by:
\begin{align}
1&=\theta \Pi_{t}^{\epsilon-1}+\left(1-\theta\right) \widetilde{p}_t^{1-\epsilon}
\label{eq:NewKeynesian.ResetPriceLoM}
\end{align}
\end{enumerate}

\paragraph{Aggregation and Market Clearing}
Note that the capital and labor resource constraints imply that aggregated demands by the intermediate firms need to be equal to the supplies provided by the households:
\begin{align}
h_t = \int_0^1 n_t(f) df \label{eq:NewKeynesian.LaborMarketClearing}
\\
k_{t} = \int_0^1 k_t(f) df \label{eq:NewKeynesian.CapitalMarketClearing}
\end{align}

~\\\noindent\emph{Exercises:}
\begin{enumerate}[resume]

\item Show that the aggregated capital to labor ratio becomes:
\begin{align}
\left(\frac{k_{t-1}}{h_t}\right) = \left(\frac{w_t}{1-\alpha}\right) \left(\frac{\alpha}{r^k_t}\right) \label{eq:NewKeynesian.IntermediateFirms.CapitalLaborRatioAggregated}
\end{align}
Explain the difference between $h_t$ and $n_t(f)$ as well as the difference between $k_t$ and $k_t(f)$.

\item Show that aggregate real profits of the intermediate firms are given by
\begin{align}
div^{Int}_t \equiv \int_{0}^{1} div_t(f) df = y_t - w_t h_t - r^k_t k_{t-1}\label{eq:NewKeynesian.IntermediateFirms.AggregateProfits}
\end{align}
Why is $div^{Int}_t>0$ in this model?

\item Show that aggregation and market clearing implies:
\begin{align}
y_t = c_t + i_t \label{eq:NewKeynesian.AggregateDemand}
\end{align}
Interpret the equation.

\item Show that aggregation of equations \eqref{eq:NewKeynesian.Firms.Demand} and \eqref{eq:NewKeynesian.IntermediateFirms.ProductionFunction} implies:
\begin{align}
p_t^* y_t = a_t k_{t-1}^\alpha h_t^{1-\alpha} \label{eq:NewKeynesian.AggregateSupply}
\end{align}
where
\begin{align}
p_t^* &= \int_{0}^1 \left(\frac{P_t(f)}{P_t}\right)^{-\epsilon} df \label{eq:NewKeynesian.PriceDistortionDefinition}
\end{align}
Interpret the equation and explain why $p_t^*$ is called the \emph{price efficiency distortion}.

\item Using the Calvo mechanism, derive the law of motion for the price efficiency distortion:
\begin{align}
p_{t}^*=\left(1-\theta\right) \widetilde{p}_t^{-\epsilon}+\theta \Pi_{t}^{\epsilon} p_{t-1}^* \label{eq:NewKeynesian.PriceDistortionLoM}
\end{align}

\end{enumerate}

\paragraph{Monetary Policy}
The central bank adjusts the nominal interest rate $R_t$ according to an interest rate rule
  in response to deviations of (i) gross inflation $\Pi_t$ from a target $\Pi^*$
  and (ii) output $y_t$ from steady-state output $y$:
\begin{align}
R_t = R \left(\frac{\Pi_t}{\Pi^*}\right)^{\psi_\pi} \left(\frac{y_t}{y}\right)^{\psi_y} e^{\nu_t} \label{eq:NewKeynesian.MonetaryPolicyRule}
\end{align}
where $R$ denotes the nominal interest rate in steady state,
  $\psi_\pi$ the sensitivity parameter to inflation deviations,
  $\psi_y$ the feedback parameter of the output gap
  and $\nu_t$ an exogenous deviation to the rule.

~\\\noindent\emph{Exercises:}
\begin{enumerate}[resume]
\item Why is such a feedback rule often called a Taylor rule?
\end{enumerate}

\paragraph{Exogenous variables and stochastic shocks}
The exogenous preference shifter $\zeta_t$, the level of technology $a_t$
  and the exogenous deviations $\nu_t$ from the monetary rule evolve according to
\begin{align}
\log{\zeta_t} &= \rho_\zeta \log{\zeta_{t-1}} + \varepsilon_{\zeta,t} \label{eq:NewKeynesian.LoM.PreferenceShifter}\\
\log{a_t} &= \rho_a \log{a_{t-1}} + \varepsilon_{a,t} \label{eq:NewKeynesian.LoM.TFP}\\
\nu_t &= \rho_\nu \nu_{t-1} + \varepsilon_{\nu,t} \label{eq:NewKeynesian.LoM.MonPol}
\end{align}
with persistence parameters $\rho_\zeta$, $\rho_a$ and $\rho_\nu$.
The preference shock $\varepsilon_{\zeta,t}$, the productivity shock $\varepsilon_{a,t}$
  and the monetary policy shock $\varepsilon_{\nu,t}$ are iid Gaussian:
\begin{align*}
\begin{pmatrix}
\varepsilon_{\zeta,t}\\\varepsilon_{a,t}\\\varepsilon_{\nu,t}
\end{pmatrix}
\sim N\left(\begin{pmatrix} 0\\0\\0\end{pmatrix}, \begin{pmatrix} \sigma_\zeta^2 & 0& 0\\0 & \sigma_{a}^2& 0\\0 & 0 & \sigma_{\nu}^2\end{pmatrix}\right)
\end{align*}

\paragraph{Readings}
\begin{itemize}
	\item \textcite{Christiano.Trabandt.Walentin_2010_DSGEModelsMonetary}
	\item \textcite[Ch.3]{Gali_2015_MonetaryPolicyInflation}
	\item \textcite[Ch.19]{Heijdra_2017_FoundationsModernMacroeconomics}
	\item \textcite[Ch.7]{Romer_2019_AdvancedMacroeconomics}
	\item \textcite[Ch.8]{Walsh_2017_MonetaryTheoryPolicy}
	\item \textcite[Ch.3]{Woodford_2003_InterestPricesFoundations}
\end{itemize}

\begin{solution}\textbf{Solution to \nameref{ex:AlgebraNewKeynesianModels}}
\ifDisplaySolutions
\input{exercises/nk_model_algebra_solution.inc}
\fi
\newpage
\end{solution}