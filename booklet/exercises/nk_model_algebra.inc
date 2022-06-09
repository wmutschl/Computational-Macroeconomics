\section[The Algebra of New Keynesian Models]{The Algebra of New Keynesian Models\label{ex:NewKeynesianModelAlgebra}}
Consider the basic New Keynesian (NK) model without capital, a linear production function and \textcite{Calvo_1983_StaggeredPricesUtilitymaximizing} price frictions.

\subsection*{Model description}
\paragraph{Households}
The economy is assumed to be inhabited by a large number of identical households.
The representative household maximizes present as well as expected future utility
\begin{align*}
	\max E_t \sum_{j=0}^{\infty} \beta^{j} U(c_{t+j}, n_{t+j}^s, z_{t+j})
\end{align*}
with $\beta <1$ denoting the discount factor and 
  $E_t$ is the expectation operator conditional on information at time $t$.
The contemporaneous utility function 
\begin{align*}
	U(c_t, n_t^s, z_t) = \left( \frac{c_t^{1-\sigma}}{1-\sigma} - \frac{({n^s_t})^{1+\varphi}}{1+\varphi} \right) z_t
\end{align*}
has three arguments: a consumption index $c_t$,
  a labor index $n_t$ which corresponds to either hours worked or employed household members,
  and an exogenous preference shifter $z_t$.
Note that the marginal utility of consumption is positive,
  whereas more labor reduces utility.
The inverse of $\sigma$ is the intertemporal elasticity of substitution,
  whereas the inverse of $\varphi$ is the Frisch elasticity of labor.
Note that the exogenous preference shifter influences only intertemporal decisions but not intratemporal ones.
The consumption index is formed by assuming a continuum of goods represented by the interval $h\in [0,1]$
  and aggregated to a single consumption good using a \textcite{Dixit.Stiglitz_1977_MonopolisticCompetitionOptimum} aggregation technology:
\begin{align*}
	c_t = \left(\int_0^1 c_t(h)^{\frac{\epsilon-1}{\epsilon}} dh \right)^{\frac{\epsilon}{\epsilon-1}}
\end{align*}
That is, $c_t(h)$ denotes the quantity of good $h$ consumed by the household in period $t$.
$\epsilon>1$ is an elasticity parameter measuring the \emph{love-of-variety}.
The household decides how to allocate its consumption expenditures among the different goods
  by taking the price $P_t(h)$ of good $h$ as given and maximizing the consumption index $c_t$ for any given level of expenditures.
Similarly, in each period the household takes the nominal wage $W_t$ as given
and supplies perfectly elastic labor service to the firm sector.
In return she receives nominal labor income $W_t n_t^s$
  and, additionally, nominal profits and dividends $P_t \int_0^1 div_t(f)df$ from each firm $f\in[0,1]$ in the intermediate goods sector,
  because the firms are owned by the household.
Moreover, the household purchases a quantity of one-period nominally risk-less bonds $B_t$ at price $Q_t$.
The bond matures the following period and pays one unit of money at maturity.
Income and wealth are used to finance consumption expenditures.
In total this defines the (nominal) budget constraint of the household
\begin{align*}
	\int_0^1 P_t(h) c_t(h) dh + Q_t B_t \leq B_{t-1} + W_t n_t^s + P_t \int_0^1 div_t(f) df
\end{align*}
In addition, it is assumed that the household is subject to a solvency constraint
  that prevents it from engaging in Ponzi-type schemes:
\begin{align*}
	\lim_{T \rightarrow \infty} E_t \left\{\Lambda_{t,T} \frac{B_T}{P_T}\right\} \geq 0
\end{align*}
for all periods $t$, where
\begin{align}
\Lambda_{t,T} = \beta^{T-t} \frac{\partial{U(c_{T},n^s_{T},z_T)}/\partial c_T}{\partial{U(c_{t},n^s_{t},z_T)}/\partial c_t} \label{eq:StochasticDiscountFactor}
\end{align}
denotes the stochastic discount factor.

Furthermore, let $\Pi_t=P_t/P_{t-1}$ denote the gross inflation rate,
  then the following relationships for the nominal interest rate $R_t$ and the real interest rate $r_t$ hold:
\begin{align}
Q_t &= \frac{1}{R_t} \label{eq:NewKeynesianNominalInterestRate}\\
R_t &= r_t E_t \Pi_{t+1} \label{eq:NewKeynesianRealInterestRate}
\end{align}

\begin{enumerate}
	\item Explain the economics behind equation \eqref{eq:NewKeynesianNominalInterestRate} that determines the nominal interest rate
    and equation \eqref{eq:NewKeynesianRealInterestRate} that determines the real interest rate.
	\item Is there debt in this model? In other words, what is the optimal path for $B_t$ in this model?
	\item Explain the difference between the solvency constraint
    $\lim_{T \rightarrow \infty} E_t \left\{\Lambda_{t,T} \frac{B_T}{P_T}\right\} \geq 0$
    and the transversality condition
    $\lim_{T \rightarrow \infty} E_t \left\{\Lambda_{t,T} \frac{B_T}{P_T}\right\} = 0$
    which holds in the optimum allocation.
	\item Show that cost minimization of consumption expenditures implies
	\begin{align*}
		c_t(h) &= \left(\frac{P_t(h)}{P_t}\right)^{-\epsilon} c_t
		\\
		P_t &= \left(\int_0^1 P_t(h)^{1-\epsilon}dh\right)^{\frac{1}{1-\epsilon}}
	\end{align*}
	Interpret these equations. What does this imply for the budget constraint?
	\item Derive the intratemporal and intertemporal optimality conditions:
	\begin{align}
		w_t &:= \frac{W_t}{P_t} = - \frac{ \frac{\partial U(c_t,n^s_t,z_t)}{\partial n^s_t}}{ \frac{\partial U(c_t,n^s_t,z_t)}{\partial c_t}}
		\label{eq:NewKeynesianLaborSupply}
		\\
		\frac{\partial U(c_t,n_t^s,z_t)}{\partial c_t} &= \beta E_t \left[\frac{\partial U(c_{t+1},n_{t+1}^s,z_{t+1})}{\partial c_{t+1}} r_t \right]
		\label{eq:NewKeynesianEuler}
	\end{align}
	where $w_t$ denotes the real wage and $\Pi_{t+1} = P_{t+1}/P_t$ the gross inflation rate.
    Interpret these equations.
\end{enumerate}

\paragraph{Firms}
The economy is populated by a continuum of firms indexed by $f \in [0,1]$ that produce differentiated goods $y_t(f)$.
The technology for transforming these intermediate goods into the final output good $y_t$
  has the \textcite{Dixit.Stiglitz_1977_MonopolisticCompetitionOptimum} form:
\begin{align}
y_t = \left[\int\limits_0^1 y_t(f)^{\frac{\epsilon-1}{\epsilon}}df\right]^{\frac{\epsilon}{\epsilon-1}} \label{eq:Firms_DS_Aggregator}
\end{align}
where $\epsilon>1$ is the substitution elasticity between inputs, the so-called \emph{love-of-variety}. 

Intermediate firm $f$ uses the following linear production function to produce their differentiated good
\begin{align}
y_t(f) = a_t n_t^d(f) \label{eq:Firms_ProductionFunction}
\end{align}
where $a_t$ denotes the common technology level available to all firms.
Firms face perfectly competitive factor markets for hiring labor $n_t^d(f)$.
Real profit of firm $f$ is equal to revenues from selling its differentiated good at price $P_t(f)$
  minus costs from hiring labor at wage $w_t$
\begin{align}
div_t(f) = \frac{P_t(f)}{P_t} y_t(f) - w_t n_t^d(f) \label{eq:Firms.Profits}
\end{align}
The objective of the firm is to choose contingent plans for $P_t(f)$ and $n^d_t(f)$
  so as to maximize the present discounted value of nominal dividend payments given by
\begin{align*}
E_t \sum_{j=0}^{\infty}\Lambda_{t,t+j} P_{t+j} div_{t+j}(f) 
\end{align*}
where household's stochastic discount factor $\Lambda_{t,t+j}$ takes into account that firms are owned by the household.

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
	\label{eq:NewKeynesianCalvoMechanism}
\end{align}
where $\widetilde{P}_t(f)$ is the re-optimized price in period $t$.
Accordingly, when a firm cannot re-set its price for $j$ periods,
  its price in period $t+j$ is given by $\widetilde{P}_t(f)$ and stays there until the firm can optimize it again.
Hence, the firm's objective in $t$ is to set $\widetilde{P}_t(f)$ to maximize expected profits
  until it can re-optimize the price again in some future period $t+j$.
The probability to be stuck at the same price for $j$ periods is given by $\theta^j$. 


\begin{enumerate}[resume]
	\item Show that profit maximization in the final goods sector implies:
	\begin{align*}
		y_t(f) &= \left(\frac{P_t(f)}{P_t}\right)^{-\epsilon} y_t
		\\
		P_t &= \left[\int_{0}^{1} P_t(f)^{1-\epsilon}df\right]^{\frac{1}{1-\epsilon}}
	\end{align*}
	Interpret these equations.
	\item Derive the following expression for the stochastic discount factor:
	$$\Lambda_{t,t+1+j} = \beta \frac{\lambda_{t+1}}{\lambda_t} \Pi_{t+1}^{-1} \Lambda_{t+1,t+1+j}$$
	\item Show that the optimal labor demand schedule of intermediate good firm $f$ is given by:
	\begin{align}
		w_t = mc_t(f) a_t = mc_t(f) \frac{y_t(f)}{n^d_t(f)} \label{eq:NewKeynesianRealMarginalCosts}
	\end{align}	
	where $mc_t(f)$ are real marginal costs of firm $f$.
    What does this imply for aggregate real marginal costs $mc_t=\int_0^1 mc_t(f)df$?
	\item Denote $\widetilde{p}_t := \frac{\widetilde{P}_t(f)}{P_t}$ and 
    show that optimal price setting of intermediate firms must satisfy:
	\begin{align}
		\widetilde{p}_t \cdot s_{1,t} &= \frac{\epsilon}{\epsilon-1} \cdot s_{2,t} \label{eq:NewKeynesianPriceSetting}\\
		s_{1,t}&=y_t \frac{\partial U(c_t,n^s_t,z_t)}{\partial c_t} + \beta \theta E_t \Pi_{t+1}^{\epsilon-1}s_{1,t+1} \label{eq:NewKeynesianPriceSettingSum1} \\
		s_{2,t}&= mc_t y_{t} \frac{\partial U(c_t,n^s_t,z_t)}{\partial c_t} + \beta \theta E_t \Pi_{t+1}^{\epsilon} s_{2,t+1} \label{eq:NewKeynesianPriceSettingSum2}
	\end{align}
	Explain why firms that reset prices set the same price,
    i.e. $\widetilde{P}_t(f) =\widetilde{P}_t$ or in other words we can drop the $f$.
	\item Show that the law of motion for the optimal re-set price
    $\widetilde{p}_t = \frac{\widetilde{P}_t(f)}{P_t}$
    is given by:
	\begin{align}
		1&=\theta \Pi_{t}^{\epsilon-1}+\left(1-\theta\right) \widetilde{p}_t^{1-\epsilon} \label{eq:NewKeynesianLoMPriceDispersion}
	\end{align}
\end{enumerate}

\paragraph{Monetary Policy}
The central bank adjusts the nominal interest rate $R_t$ according to an interest rate rule
  in response to deviations of (i) gross inflation $\Pi_t$ from a target $\Pi^*$
  and (ii) output $y_t$ from steady-state output $y$:
\begin{align}
    R_t = R \left(\frac{\Pi_t}{\Pi^*}\right)^{\phi_\pi} \left(\frac{y_t}{y}\right)^{\phi_y} e^{\nu_t} \label{eq:NewKeynesianMonetaryPolicyRule}
\end{align}
where $R$ denotes the nominal interest rate in steady state,
  $\phi_\pi$ the sensitivity parameter to inflation deviations,
  $\phi_y$ the feedback parameter of the output gap
  and $\nu_t$ an exogenous deviation to the rule.


\paragraph{Exogenous variables and stochastic shocks}
The exogenous preference shifter $z_t$, the level of technology $a_t$
  and the exogenous deviations $\nu_t$ from the monetary rule evolve according to
\begin{align}
    \log{z_t} &= \rho_z \log{z_{t-1}} + \varepsilon_{z,t} \label{eq:NewKeynesianLoMPreferenceShifter}\\
    \log{a_t} &= \rho_a \log{a_{t-1}} + \varepsilon_{a,t} \label{eq:NewKeynesianLoMTechnology}\\
    \nu_t &= \rho_\nu \nu_{t-1} + \varepsilon_{\nu,t} \label{eq:NewKeynesianLoMMonPol}
\end{align}
with persistence parameters $\rho_z$, $\rho_a$ and $\rho_\nu$.
The preference shock $\varepsilon_{z,t}$, the productivity shock $\varepsilon_{a,t}$
  and the monetary policy shock $\varepsilon_{\nu,t}$ are iid Gaussian:
\begin{align*}
    \begin{pmatrix}
        \varepsilon_{z,t}\\\varepsilon_{a,t}\\\varepsilon_{\nu,t}
    \end{pmatrix}
    \sim N\left(\begin{pmatrix} 0\\0\\0\end{pmatrix}, \begin{pmatrix} \sigma_z^2 & 0& 0\\0 & \sigma_{a}^2& 0\\0 & 0 & \sigma_{\nu}^2\end{pmatrix}\right)
\end{align*}

\paragraph{Market clearing}
\begin{enumerate}[resume]
	\item What does market clearing imply for private bonds $B_t$?
	\item Explain why labor market clearing implies:
	\begin{align*}
		n^s_t = \int_0^1 n^d_t(f) df = n_t
	\end{align*}
	where $n_t$ is the equilibrium amount of labor.
	\item Show that aggregate real profits are given by
	\begin{align}
	div_t \equiv \int_{0}^{1} div_t(f) df = y_t - w_t n_t \label{eq:NewKeynesianAggregateProfits}
	\end{align}
	\item Show that aggregate demand is given by
	\begin{align}
	y_t = c_t \label{eq:NewKeynesianAggregateDemand}
	\end{align}
	\item Denote $p_t^* = \int_{0}^1 \left(\frac{P_t(f)}{P_t}\right)^{-\epsilon} df$.
    Show that aggregate supply is given by
	\begin{align}
		p_t^* y_t = a_t n_t \label{eq:NewKeynesianAggregateSupply}
	\end{align}
	Explain why $p_t^*$ is called the price inefficiency distortion.
	\item Derive the law of motion for the price inefficiency distortion $p_t^*$:
	\begin{align}
	  p_{t}^*=\left(1-\theta\right) \widetilde{p}_t^{-\epsilon}+\theta \Pi_{t}^{\epsilon} p_{t-1}^* \label{eq:NewKeynesianLoMPriceInefficiency}
	\end{align}
\end{enumerate}

\paragraph{Readings}
\begin{itemize}
	\item \textcite[Ch.3]{Gali_2015_MonetaryPolicyInflation}
	\item \textcite[Ch.19]{Heijdra_2017_FoundationsModernMacroeconomics}
	\item \textcite[Ch.7]{Romer_2019_AdvancedMacroeconomics}
	\item \textcite[Ch.8]{Walsh_2017_MonetaryTheoryPolicy}
	\item \textcite[Ch.3]{Woodford_2003_InterestPricesFoundations}
\end{itemize}



\begin{solution}\textbf{Solution to \nameref{ex:NewKeynesianModelAlgebra}}
\ifDisplaySolutions
\begin{enumerate}
\item Equation \eqref{eq:NewKeynesianNominalInterestRate} captures that bond prices are inversely related to interest rates.
    When the interest rate goes up, the price of bonds falls.
    Intuitively, this makes sense because if you are paying less for a fixed nominal return (at par),
      your expected return should be higher.
    More specifically to our model, we consider so-called zero-coupon bonds or discount bonds.
    These bonds don't pay any interest but derive their value from the difference between the purchase price
      and the par value (or the face value) paid at maturity.
    On maturity the bondholder receives the face value of his investment.
    So instead of interest payments, you get a large discount on the face value of the bond,
      that is the price is lower than the face value.
    In other words, investors profit from the difference between the buying price
      and the face value, contrary to the usual interest income.
    In our model, we consider zero-coupon bonds with a face value of 1.
    So suppose that you buy such a bond at a price of 0.8, then although the bond pays no interest,
      your compensation is the difference between the initial price and the face value.
    Let $R_t$ denote the \emph{gross yield to maturity} of a zero-coupon bond,
      that is the discount rate that sets the present value of the promised bond payments equal to the current market price of the bond.
    So the price of a Zero-Coupon bond is equal to
    $$Q_t = \frac{1}{R_t}$$
    In our example this would imply $R_t=1.25$.
    As there are no other investment opportunities in this model $R_t$ is also equal to the nominal interest rate in the economy.
	
    Equation \eqref{eq:NewKeynesianRealInterestRate} is the so-called Fisherian equation
      which states that the gross real return on a bond $r_t$
      is equivalent to the gross nominal interest rate divided by the expected gross inflation rate.
    Inflation expectations are responsible for the difference between nominal and real interest rates,
      showing that future expectations matter for the economy.
\item In equilibrium, bond-holding is always zero in all periods: $B_t=0$.
    This is due to the fact that in this model we have a representative agent and only private bonds.
    If all agents were borrowing, there would be nobody they could be borrowing from.
    If all were lenders, nobody would like to borrow from them.
    So bonds across all agents need to be in 0 net supply as markets need to clear in equilibrium.
    Note, though, that this bond market clearing condition is imposed \emph{after} you derive the households optimality conditions
      as household savings behavior in equilibrium still needs to be consistent with the bond market clearing.
\item The \emph{No-Ponzi-Game} or \emph{solvency} condition is an external constraint imposed on the individual by the market or other participants.
    You forbid your agent from acquiring infinite debt that is never re-paid, a so-called Ponzi-scheme.
    That is, the individual is restricted from financing consumption
      by raising debt and then raising debt again to re-pay the previous debt
      and finance again consumption and so on.
    The individual would very much like to violate it, though, so we need to impose this constraint.
    In short: the \emph{solvency} condition prevents that households consume more than they earn
      and refinance their additional consumption with excessive borrowing.
    The \emph{transversality condition} is an optimality condition that states
      that it is not optimal to start accumulating assets and never consume them,
      i.e. $\lim_{T \rightarrow \infty} E_t \left\{\Lambda_{t,T} \frac{B_T}{P_T}\right\} \leq 0$.
    But with respect to optimality you would still want to run a Ponzi-scheme if allowed one.
      $\lim_{T \rightarrow \infty} E_t \left\{\Lambda_{t,T} \frac{B_T}{P_T}\right\} \leq 0$
      combined with $\lim_{T \rightarrow \infty} E_t \left\{\Lambda_{t,T} \frac{B_T}{P_T}\right\} \geq 0$ yields
      $\lim_{T \rightarrow \infty} E_t \left\{\Lambda_{t,T} \frac{B_T}{P_T}\right\} = 0$.
    This condition must be satisfied in order for the individual to maximize intertemporal utility implying
      that at the limit wealth should be zero.
    In other words, if at the limit wealth is positive it means that the household could have increased its consumption without necessarily needing to work more hours,
      thus implying that consumption was not maximized and therefore contradicting the fact that the household behaves optimally.
    In short: transversality conditions make sure that households do no have any leftover savings (in terms of bonds or capital)
      as this does not correspond to an optimal path of utility-enhancing consumption.
	
	We never need to actually include this condition into our codes,
      but implicitly we use it to pick a certain steady state or trajectory.
    For instance in the RBC model we have three possible steady states $(k_t=0,c_t=0)$, $k_t>0,c_t=0$ or $k_t>0,c_t>0$.
    We do not consider the first one because in this case the economy does not exist.
    All the trajectories leading to the second one violate the transversality condition,
      so finally we select the third steady state as the \emph{good one}
      and this is exactly the one that is most interesting from an economic point of view.

	Coming back to our model, both the \emph{solvency} and \emph{transversality condition} are actually full-filled already
      as bond-holding is always zero in all periods including the hypothetical asymptotic end of life: $B_t=0$ for all $t$.
    So these conditions are rather trivial in this model setting, but are important in more sophisticated models.
\item The household minimizes her consumption expenditures $\int_0^1 P_t(h) c_t(h)dh$ by choosing $c_t(h)$
      and taking the aggregation technology into account.
    That is, the Lagrangian is given by:
	\begin{align*}
		\pounds^c = \int_0^1 P_t(h) c_t(h)dh + P_t \left( c_t - \left[\int_0^1 c_t(h)^{\frac{\epsilon-1}{\epsilon}}dh\right]^{\frac{\epsilon}{\epsilon-1}} \right)
	\end{align*}
	where $P_t$ denotes the Lagrange multiplier, i.e. the cost of an additional unit in the index $c_t$.
    Setting the derivative with respect to $c_t(h)$ equal to zero yields:
	\begin{align*}
		\frac{\partial \pounds^c}{\partial c_t(h)} = P_t(h) - P_t \left(\frac{\epsilon}{\epsilon-1}\right) \underbrace{\left[\int_0^1 c_t(h)^{\frac{\epsilon-1}{\epsilon}}dh\right]^{\frac{\epsilon}{\epsilon-1}-1}}_{c_t^{1/\epsilon}} \left(\frac{\epsilon-1}{\epsilon}\right) c_t(h)^{\frac{\epsilon-1}{\epsilon}-1} = 0
	\end{align*}
	which can be simplified to:
	\begin{align*}
		c_t(h) = \left(\frac{P_t(h)}{P_t}\right)^{-\epsilon} c_t
	\end{align*}
	Note that this is the demand function for each consumption good $c_t(h)$.
    Accordingly, $\epsilon$ is the (constant) demand elasticity.
    Other aggregation technologies can change this,
      see e.g. the \textcite{Kimball_1995_QuantitativeAnalyticsBasic} aggregation technology in \textcite{Smets.Wouters_2007_ShocksFrictionsUS}-type models.
	
	Plugging this expression into the aggregation technology yields:
	\begin{align*}
		&c_t^{\frac{\epsilon-1}{\epsilon}} = \int_0^1 c_t(h)^{\frac{\epsilon-1}{\epsilon}}dh = \int_0^1 \left(\left(\frac{P_t(h)}{P_t}\right)^{-\epsilon} c_t\right)^{\frac{\epsilon-1}{\epsilon}}dh = c_t^{\frac{\epsilon-1}{\epsilon}} P_t^{\epsilon-1} \int_0^1 P_t(h)^{1-\epsilon}dh
		\\
		\Leftrightarrow &
		P_t = \left[\int_0^1 P_t(h)^{1-\epsilon}dh\right]^{\frac{1}{1-\epsilon}}
		\\
		\Leftrightarrow &
		1 = \int_0^1 \left(\frac{P_t(h)}{P_t}\right)^{1-\epsilon}dh
	\end{align*}
	Similar to the aggregation technology for the consumption index $c_t$,
      $P_t$ can be interpreted as the aggregation technology for the different prices $P_t(h)$.

	In the budget constraint, we can now get rid of one integral $\int_0^1 c_t(h) P_t(h) dh = P_t c_t$, because:
	\begin{align*}
		\int_0^1 c_t(h) P_t(h) dh = \int_0^1 \left(\frac{P_t(h)}{P_t}\right)^{-\epsilon} c_t P_t(h) dh = P_t c_t \underbrace{\int_0^1 \left(\frac{P_t(h)}{P_t}\right)^{1-\epsilon}  dh}_{=1} = P_t c_t
	\end{align*}
	That is, conditional on optimal behavior of households, total consumption expenditures can be rewritten
      as the product of the aggregate price index times the aggregate consumption quantity index.

	\item Due to our assumptions, the solvency and transversality conditions as well as the concave optimization problem,
      we can rule out corner solutions and neglect the non-negativity constraints in the variables and the budget constraint;
	  hence, we only need to focus on the first-order conditions.
	  The Lagrangian for the household's problem is:
	\begin{align*}
		\pounds^{HH} &= E_t \sum_{j=0}^{\infty} \beta^j \left\{	U\left({c}_{t+j},n^s_{t+j},z_{t+j}\right) \right\}
			\\
			& + \beta^j \lambda_{t+j} \left\{ \int_0^1 div_{t+j}(f) df + w_{t+j} n^s_{t+j} + \underbrace{\frac{B_{t-1+j}}{P_{t-1+j}}}_{b_{t-1+j}} \underbrace{\frac{P_{t-1+j}}{P_{t+j}}}_{\Pi_{t+j}^{-1}} - Q_{t+j} \underbrace{\frac{B_{t+j}}{P_{t+j}}}_{b_{t+j}} - c_{t+j} 
			\right\}
	\end{align*}
	where $\beta^j\lambda_{t+j}$ are the Lagrange multipliers corresponding to period $t+j$'s \textbf{real} budget constraint
      (be aware of the difference between nominal and real variables and constraints;
      for instance, $b_t=B_t/P_t$ is real debt).
    The problem is not to choose $\{c_t,n_t^s,b_{t}\}_{t=0}^\infty$ all at once in an open-loop policy,
      but to choose these variables sequentially given the information at time $t$ in a closed-loop policy,
      i.e. at period $t$ decision rules for $\{c_t,n^s_t,b_{t}\}$ given the information set at period $t$;
      at period $t+1$ decision rules for $\{c_{t+1},n^s_{t+1},b_{t+1}\}$ given the information set at period $t+1$, etc.
	
	\paragraph{First-order condition with respect to $c_t$}
	\begin{align}
		\lambda_t = \frac{\partial U(c_t,n_t^s,z_t)}{\partial c_t} = z_t c_t^{-\sigma} \label{eq:MarginalUtility}
	\end{align}
	This is the marginal utility function,
      i.e. the shadow price of an additional unit of revenue (e.g. dividends or labor income) in the budget constraint.
	
	\paragraph{First-order condition with respect to $n_t^s$}
	\begin{align}
	w_t = - \frac{\partial U(c_t,n_t^s,z_t)/\partial n^s_t}{\lambda_t} = - \frac{\partial U(c_t,n_t^s,z_t)/\partial n^s_t}{\partial U(c_t,n_t^s,z_t)/\partial c_t} = n_t^{\varphi} c_t^{\sigma}
	\end{align}
	This is the intratemporal optimality condition, i.e. labor supply of the household.
    Note that the preference shifter $z_t$ has no effect on the intratemporal decision.
	
	\paragraph{First-order condition with respect to $b_t$}
	\begin{align}
	\lambda_t Q_t &= \beta E_t \left[\lambda_{t+1} \Pi_{t+1}^{-1} \right]
	\end{align}
	Combined with \eqref{eq:NewKeynesianNominalInterestRate} and \eqref{eq:NewKeynesianRealInterestRate} this yields the so-called Euler equation,
      i.e. the intratemporal choice between consumption and saving:
	\begin{align}
		\frac{\partial U(c_t,n_t^s,z_t)}{\partial c_t} &= \beta E_t \left[\frac{\partial U(c_{t+1},n_{t+1}^s,z_{t+1})}{\partial c_{t+1}} R_t \Pi_{t+1}^{-1} \right]
		\\
		z_t c_t^{-\sigma} &= \beta E_t \left[z_{t+1} c_{t+1}^{-\sigma} \right] r_t
		\label{eq:HH.Euler}	
	\end{align}
	In words, intertemporal optimality is characterized by an indifference condition:
    An additional unit of consumption yields either marginal utility today in the amount of
      $\frac{\partial U(c_t,n_t^s,z_t)}{\partial c_t}$ (left-hand side).
    Or, alternatively, this unit of consumption can be saved given the real interest rate $r_t$.
    This saved consumption unit has a present marginal utility value of $\beta E_t \left[z_{t+1} c_{t+1}^{-\sigma} \right] r_t$ (right-hand side).
    An optimal allocation equates these two choices.

\item The output packers maximize profits $P_t y_t - \int_{0}^{1} P_t(f) y_t(f) df$ subject to \eqref{eq:Firms_DS_Aggregator}.
    The Lagrangian is
	\begin{align*}
	\pounds^{p} = P_t y_t - \int_{0}^{1} P_t(f) y_t(f) df + \Lambda_t^p \left\{\left[\int\limits_0^1 y_t(f)^{\frac{\epsilon-1}{\epsilon}}df\right]^{\frac{\epsilon}{\epsilon-1}} - y_t\right\}
	\end{align*}
	  where $\Lambda_t^p$ is the Lagrange multiplier corresponding to the aggregation technology.
	The first-order condition w.r.t $y_t$ is
	\begin{align}
	P_t = \Lambda_{t}^p
	\end{align}
	  $\Lambda_{t}^p$ is the gain of an additional output unit, hence, equal to the aggregate price index $P_t$.

	The first-order condition w.r.t. $y_t(f)$ yields:
	\begin{align}
	\frac{\partial \pounds^{p} }{\partial y_t(f)} & = -P_t(f) + \Lambda_{t}^p \frac{\epsilon}{\epsilon-1} \left[\int_{0}^1 y_t(f)^{\frac{\epsilon-1}{\epsilon}}df\right]^{\frac{\epsilon}{\epsilon-1}-1} \frac{\epsilon-1}{\epsilon} y_t(f)^{\frac{\epsilon-1}{\epsilon}-1} = 0
	\label{eq:Firms_Relative_Demand}
	\end{align}
	Note that $\left[\int_{0}^1 y_t(f)^{\frac{\epsilon-1}{\epsilon}}df\right] = y_t^{\frac{\epsilon-1}{\epsilon}}$ and $\Lambda_{t}^p=P_t$. Therefore:
	\begin{align}
	P_t(f) = P_t \left[y_t^{\frac{\epsilon-1}{\epsilon}}\right]^{\frac{\epsilon-\epsilon+1}{\epsilon-1}} y_t(f)^{\frac{\epsilon-1-\epsilon}{\epsilon}} = P_t \left(\frac{y_t(f)}{y_t}\right)^{\frac{-1}{\epsilon}}
	\end{align}
	Reordering yields
	\begin{align}
	y_t(f) = \left(\frac{P_t(f)}{P_t}\right)^{-\epsilon} y_t \label{eq:firms_demand}
	\end{align}
	This is the demand curve for intermediate good $y_t(f)$.
    Again we see that $\epsilon$ is the constant demand elasticity.
	
	The aggregate price index is implicitly determined by inserting the demand curve \eqref{eq:firms_demand}
      into the aggregator \eqref{eq:Firms_DS_Aggregator}
	\begin{align}
	y_t &= \left[\int\limits_0^1 \left(\left(\frac{P_t(f)}{P_t}\right)^{-\epsilon} y_t\right)^{\frac{\epsilon-1}{\epsilon}}df\right]^{\frac{\epsilon}{\epsilon-1}}
	\\
	\Leftrightarrow
	P_t &= \left[\int_{0}^{1} P_t(f)^{1-\epsilon}df\right]^{\frac{1}{1-\epsilon}} \label{eq:Firms_DS_Pricing}
	\end{align}

\item As the firms are owned by the households, the nominal stochastic discount factor,
      $\Lambda_{t,t+j}$, between $t$ and $t+j$ is derived from the Euler equation \eqref{eq:HH.Euler} of the households
      $\lambda_t = \beta E_t \left[\lambda_{t+1} R_t \Pi_{t+1}^{-1} \right]$ which implies for the stochastic discount factor:
	$$E_t \Lambda_{t,t+j} = E_t 1/R_{t+j} = E_t\beta^j \frac{\lambda_{t+j}}{\lambda_{t}}\frac{P_t}{P_{t+j}}$$	
	From here, we can establish the following relationships:
	\begin{align}
	\Lambda_{t,t} &= 1 \label{eq:Firms.Stochastic.Discount.Current}\\
	\Lambda_{t+1,t+1+j} & = \beta^j \frac{\lambda_{t+1+j}}{\lambda_{t+1}} \frac{P_{t+1}}{P_{t+1+j}}\\
	\Lambda_{t,t+1+j} & = \beta^{j+1} \frac{\lambda_{t+1+j}}{\lambda_{t}} \frac{P_{t}}{P_{t+1+j}} = \beta \frac{\lambda_{t+1}}{\lambda_{t}} \frac{P_{t}}{P_{t+1}} \beta^j \frac{\lambda_{t+1+j}}{\lambda_{t+1}} \frac{P_{t+1}}{P_{t+1+j}} = \beta \frac{\lambda_{t+1}}{\lambda_t} \Pi_{t+1}^{-1} \Lambda_{t+1,t+1+j} \label{eq:Firms.Stochastic.Discount.Relationship}
	\end{align}
	We will need the last relationship later to derive the recursive nonlinear price setting equations.

\item The Lagrangian of the intermediate firm is 
	\begin{align*}
	\pounds^f &= E_t \sum_{j=0}^{\infty}\Lambda_{t,t+j} P_{t+j} \left[\frac{P_{t+j}(f)}{P_{t+j}} y_{t+j}(f) - w_{t+j} n^d_{t+j}(f) + mc_{t+j}(f)\left(a_{t+j}n^d_{t+j}(f) - y_{t+j}(f)\right)\right]
	\end{align*}
	$mc_t(f)$ denotes the Lagrange multiplier which is the shadow price of producing an additional output unit in the optimum;
      obviously, this is our notion of real marginal costs.
    Taking the derivative wrt $n_t^d(f)$ actually boils down to a static problem (as we only need to evaluate for $j=0$) and yields:
	\begin{align}
		w_t &= mc_t(f) a_t = mc_t(f) \frac{y_t(f)}{n^d_t(f)} \label{eq:Firms.Labor.Demand}
	\end{align}
	  where we substituted the production function \eqref{eq:Firms_ProductionFunction} for $a_t$.
    This is the labor demand function, which implies that the labor-to-output ratio is the same across firms and equal to $a_t$.
    Note that all firms face the same factor prices and all have access to the same production technology $a_t$;
      hence, from the above equation it is evident that marginal costs are identical across firms
	\begin{align}
	mc_t(f) = \frac{w_t}{a_t}\label{eq:Firms.Marginal.Costs}
	\end{align}
	This means that aggregate marginal costs are also equal to the ratio between the real wage and technology:
	$$mc_t = \int_0^1 mc_t(f) df = \frac{w_t}{a_t}$$
	
\item The Lagrangian of the intermediate firm is
	\begin{align}
	\pounds^f &= E_t \sum_{j=0}^{\infty}\Lambda_{t,t+j} P_{t+j} \left[ \left(\frac{P_{t+j}(f)}{P_{t+j}}\right)^{1-\epsilon} y_{t+j} - w_{t+j} n^d_{t+j}(f) + mc_{t+j}(f)\left(a_{t+j}n^d_{t+j}(f) - \left(\frac{P_{t+j}(f)}{P_{t+j}}\right)^{-\epsilon} y_{t+j}\right)\right]
		\label{eq:Firms.Lagrangian}
	\end{align}
	  where (compared to above) we used the demand curve \eqref{eq:firms_demand} to substitute for $y_t(f)$.
    When firms decide how to set their price they need to take into account
      that due to the Calvo mechanism they might get stuck at $\widetilde{P}_t(f)$ for a number of periods $j=1,2,...$
      before they can re-optimize again.
    The probability of such a situation is $\theta^j$.
    Therefore, when firms are able to change prices in period $t$,
      they take this into account and the above Lagrangian of the expected discounted sum of nominal profits becomes:
	\begin{align}
    \pounds^{f^c} &= E_t \sum_{j=0}^{\infty}\theta^j \Lambda_{t,t+j} P_{t+j}\left[ \left(\frac{\widetilde{P}_{t}(f)}{P_{t+j}}\right)^{1-\epsilon} y_{t+j} - w_{t+j} n^d_{t+j}(f) + mc_{t+j}\left(a_{t+j}n^d_{t+j}(f) - \left(\frac{\widetilde{P}_{t}(f)}{P_{t+j}}\right)^{-\epsilon} y_{t+j}\right)\right]\\
    &= E_t \sum_{j=0}^{\infty}\theta^j \Lambda_{t,t+j} P_{t+j}^\epsilon y_{t+j} \left[ \widetilde{P}_{t}(f)^{1-\epsilon}  - P_{t+j} \cdot mc_{t+j} \cdot \widetilde{P}_{t}(f)^{-\epsilon} \right] + ...
    \label{eq:Firms.Lagrangian.Calvo}
    \end{align}
      where in the second line we focus only on relevant parts for the optimization wrt to $\widetilde{P}_t(f)$.
    Moreover, we took into account that $mc_t(f) = mc_t$.
		
    The first-order condition of maximizing $\pounds^{f^c}$ wrt to $\widetilde{P}_t(f)$ is
    \begin{align}
    0= E_t \sum_{j=0}^{\infty}\theta^j \Lambda_{t,t+j} P_{t+j}^\epsilon y_{t+j} \left[ (1-\epsilon)\cdot \widetilde{P}_{t}(f)^{-\epsilon}  +\epsilon \cdot P_{t+j} \cdot mc_{t+j} \widetilde{P}_{t}(f)^{-\epsilon-1}\right]
    \end{align}
    As $\widetilde{P}_t(f)>0$ does not depend on $j$, we multiply by $\widetilde{P}_t(f)^{\epsilon+1}$:
    \begin{align}
    0= E_t \sum_{j=0}^{\infty}\theta^j \Lambda_{t,t+j} P_{t+j}^{\epsilon} y_{t+j} \left[ (1-\epsilon)\cdot\widetilde{P}_t(f) +\epsilon \cdot P_{t+j} \cdot mc_{t+j}  \right]
    \end{align}
    Rearranging
    \begin{align}
    \widetilde{P}_t(f) \cdot E_t \sum_{j=0}^{\infty}\theta^j \Lambda_{t,t+j} P_{t+j}^{\epsilon} y_{t+j}  = \frac{\epsilon}{\epsilon-1} \cdot E_t \sum_{j=0}^{\infty}\theta^j \Lambda_{t,t+j} P_{t+j}^{\epsilon+1} y_{t+j} mc_{t+j}
    \end{align}
    Dividing both sides by $P_t^{\epsilon+1}$
    \begin{align}
    \underbrace{\frac{\widetilde{P}_t(f)}{P_t}}_{\widetilde{p}_t} \cdot  \underbrace{E_t\sum_{j=0}^{\infty}\theta^j \Lambda_{t,t+j} \left(\frac{P_{t+j}}{P_t}\right)^{\epsilon} y_{t+j}}_{S_{1,t}}  = \frac{\epsilon}{\epsilon-1} \cdot \underbrace{E_t \sum_{j=0}^{\infty}\theta^j \Lambda_{t,t+j} \left(\frac{P_{t+j}}{P_t}\right)^{\epsilon+1} y_{t+j} mc_{t+j}}_{S_{2,t}}
    \end{align}
    Note that all firms that reset prices face the same problem and therefore set the same price, $\widetilde{P}_t(f) =\widetilde{P}_t$.
    This is also evident by looking at the infinite sums, $S_{1,t}$ and $S_{2,t}$, because these do not depend on $f$.
    Therefore, we can drop the $f$ in $\widetilde{P}_t(f)$ and define $\widetilde{p}_t:= \frac{\widetilde{P}_t}{P_t}$.
    The first-order condition can thus be written compactly:
    \begin{align}
    \widetilde{p}_t \cdot S_{1,t} = \frac{\epsilon}{\epsilon-1} \cdot S_{2,t}
    \end{align}

    Moreover, the two infinite sums can be written recursively. For this we make use of the relationships for the stochstic discount factor \eqref{eq:Firms.Stochastic.Discount.Current} and \eqref{eq:Firms.Stochastic.Discount.Relationship}. The first recursive sum can be written as:
    \begin{align*}
    S_{1,t} &= 
        E_t\sum_{j=0}^{\infty}\theta^j \Lambda_{t,t+j} \left(\frac{P_{t+j}}{P_t}\right)^{\epsilon} y_{t+j}
    \\
        &= y_t + E_t\sum^{\infty}_{\color{red}{j=1}}\theta^{\color{red}{j}} \Lambda_{t,t+\color{red}{j}} \left(\frac{P_{t+\color{red}{j}}}{P_t}\right)^{\epsilon} y_{t+\color{red}{j}}
    \\
        &= y_t + E_t\sum^{\infty}_{\color{red}{j=0}}\theta^{\color{red}{j+1}} \Lambda_{t,t+\color{red}{j+1}} \left(\frac{P_{t+\color{red}{j+1}}}{P_t}\right)^{\epsilon} y_{t+\color{red}{j+1}}
    \\
        &= y_t + E_t\sum^{\infty}_{j=0}\theta^{j+1} {\color{blue}{\Lambda_{t,t+j+1}}} \left({\color{green}{\frac{P_{t+j+1}}{P_{t+1}}\frac{P_{t+1}}{P_{t}}}}\right)^{\epsilon} y_{t+j+1}
    \\
        &= y_t + E_t\sum^{\infty}_{j=0}\theta^{j+1} {\color{blue}{\beta \frac{\lambda_{t+1}}{\lambda_t}\Pi_{t+1}^{-1} \Lambda_{t+1,t+1+j}}} \left({\color{green}{\frac{P_{t+j+1}}{P_{t+1}}\Pi_{t+1}}}\right)^{\epsilon} y_{t+j+1}
    \\
        &= y_t + \theta\beta E_t\frac{\lambda_{t+1}}{\lambda_t}\Pi_{t+1}^{\epsilon-1} \underbrace{E_t\sum^{\infty}_{j=0}\theta^{j} \Lambda_{t+1,t+1+j} \left(\frac{P_{t+j+1}}{P_{t+1}}\right)^{\epsilon} y_{t+j+1}}_{=S_{1,t+1}}
    \end{align*}
    The second recursive sum can be written as
    \begin{align*}
    S_{2,t} &= 
    E_t\sum_{j=0}^{\infty}\theta^j \Lambda_{t,t+j} \left(\frac{P_{t+j}}{P_t}\right)^{\epsilon+1} y_{t+j} mc_{t+j}
    \\
    &= y_t mc_t + E_t\sum^{\infty}_{\color{red}{j=1}}\theta^{\color{red}{j}} \Lambda_{t,t+\color{red}{j}} \left(\frac{P_{t+\color{red}{j}}}{P_t}\right)^{\epsilon+1} y_{t+\color{red}{j}} mc_{t+\color{red}{j}}
    \\
    &= y_t mc_t + E_t\sum^{\infty}_{\color{red}{j=0}}\theta^{\color{red}{j+1}} \Lambda_{t,t+\color{red}{j+1}} \left(\frac{P_{t+\color{red}{j+1}}}{P_t}\right)^{\epsilon+1} y_{t+\color{red}{j+1}} mc_{t+\color{red}{j+1}}
    \\
    &= y_t mc_t + E_t\sum^{\infty}_{j=0}\theta^{j+1} {\color{blue}{\Lambda_{t,t+j+1}}} \left({\color{green}{\frac{P_{t+j+1}}{P_{t+1}}\frac{P_{t+1}}{P_{t}}}}\right)^{\epsilon+1} y_{t+j+1} mc_{t+j+1}
    \\
    &= y_t mc_t + E_t\sum^{\infty}_{j=0}\theta^{j+1} {\color{blue}{\beta \frac{\lambda_{t+1}}{\lambda_t}\Pi_{t+1}^{-1}\Lambda_{t+1,t+1+j}}} \left({\color{green}{\frac{P_{t+j+1}}{P_{t+1}}\Pi_{t+1}}}\right)^{\epsilon+1} y_{t+j+1} mc_{t+j+1}
    \\
    &= y_t mc_t + 
    \theta\beta E_t\frac{\lambda_{t+1}}{\lambda_t}\Pi_{t+1}^{\epsilon} \underbrace{E_t\sum^{\infty}_{j=0}\theta^{j} \Lambda_{t+1,t+1+j} \left(\frac{P_{t+j+1}}{P_{t+1}}\right)^{\epsilon+1} y_{t+j+1} mc_{t+j+1}}_{=S_{2,t+1}}
    \end{align*}
    To sum up:
    \begin{align*}
	\widetilde{p}_t &\cdot S_{1,t} = \frac{\epsilon}{\epsilon-1} \cdot S_{2,t}\\
    S_{1,t} &= y_t + \theta \beta E_t \frac{\lambda_{t+1}}{\lambda_{t}} \Pi_{t+1}^{\epsilon-1} S_{1,t+1}\\
    S_{2,t} &= y_t mc_t + \theta \beta E_t \frac{\lambda_{t+1}}{\lambda_{t}} \Pi_{t+1}^{\epsilon} S_{2,t+1}
    \end{align*}
	Now, let us make note of equation \eqref{eq:MarginalUtility} and define lower-case variables as $s_{1,t}=\lambda_t S_{1,t}$ and $s_{2,t}=\lambda_t S_{2,t}$,
	  then we can re-write this as:
	\begin{align*}
		\widetilde{p}_t &\cdot s_{1,t} = \frac{\epsilon}{\epsilon-1} \cdot s_{2,t}\\
		s_{1,t} &= y_t \frac{\partial U(c_t,n_t^s,z_t)}{\partial c_t} + \theta \beta E_t \Pi_{t+1}^{\epsilon-1} s_{1,t+1}\\
		s_{2,t} &= y_t mc_t \frac{\partial U(c_t,n_t^s,z_t)}{\partial c_t} + \theta \beta E_t \Pi_{t+1}^{\epsilon} s_{2,t+1}
	\end{align*}
		
\item The law of motion for $\widetilde{p}_t=\frac{\widetilde{P}_t}{P_t}$ is given
      by the aggregate price index \eqref{eq:Firms_DS_Pricing} which can be re-arranged to
	\begin{align}
    1 &= \int_{0}^{1} \left(\frac{P_t(f)}{P_t}\right)^{1-\epsilon}df \label{eq:Aggregate.Price}
	\end{align}
	Due to the Calvo mechanism, we note that $(1-\theta)$ firms are able re-set their price to $\widetilde{P}_t$,
      whereas the remaining $\theta$ firms cannot do so.
    Therefore:
	\begin{align}
	1 &= \int_{optimizers} \left(\frac{P_t(f)}{P_t}\right)^{1-\epsilon} df  + \int_{non-optimizers} \left(\frac{P_t(f)}{P_t}\right)^{1-\epsilon} df \\
	1&= (1-\theta) \left(\frac{\widetilde{P}_t}{P_t}\right)^{1-\epsilon} + \theta \int_{0}^1 \left(\frac{P_{t-1}(f)}{P_t}{\color{red}{\frac{P_{t-1}}{P_{t-1}}}}\right)^{1-\epsilon}df\\
	1&= (1-\theta) \widetilde{p}_t^{1-\epsilon} + \theta \left(\frac{P_{t-1}}{P_{t}}\right)^{1-\epsilon} \int_{0}^1 \left(\frac{P_{t-1}(f)}{P_{t-1}}\right)^{1-\epsilon}df\\
	1&=(1-\theta) \widetilde{p}_t^{1-\epsilon}  + \theta \Pi_t^{1-\epsilon} \underbrace{\int_{0}^{1} \left(\frac{P_{t-1}(f)}{P_{t-1}} \right)^{1-\epsilon}df}_{\overset{\eqref{eq:Aggregate.Price}}{=}1}\\
	1&=(1-\theta) \widetilde{p}_t^{1-\epsilon}  + \theta \Pi_t^{\epsilon-1}
	\end{align}
	
\item Private bonds $B_t$ are in zero net supply on the budget constraint.
    Note that this condition can only be imposed after taking first order conditions.
    It would be invalid to eliminate bonds already in the budget constraint of the household.
    Even if bonds are in zero net supply, households savings behavior in equilibrium still needs to be consistent with the bond market clearing.
	
\item In an equilibrium, labor demand from the intermediate firms needs to be equal to the labor supply of the households; hence:
	\begin{align}
    n^s_t = \int_{0}^1 n^d_t(f) df = n_t
	\end{align}
	  We label the equilibrium hours worked with $n_t$.

\item Given the demand for good $y_t(f)$ and the Dixit-Stiglitz aggregation technology, we get:
	\begin{align*}
    \int_0^1 y_t(f) P_t(f) df = \int_0^1 \left(\frac{P_t(f)}{P_t}\right)^{-\epsilon} y_t P_t(f) df = P_t y_t \underbrace{\int_0^1 \left(\frac{P_t(f)}{P_t}\right)^{1-\epsilon}  df}_{=1} = P_t y_t
	\end{align*}
	Moreover, from the labor market we have $n_t = \int_{0}^1 n_t(f) df$.
    Plugging both expressions into aggregate real profits:
	\begin{align*}
    div_t = \int_0^1 div_t(f) df = \int_0^1 \frac{P_t(f)}{P_t} y_t(f) df - \int_0^1 w_t n_t^d(f) df = y_t - w_t n_t
	\end{align*}

\item Revisit the budget constraint in real terms:
	\begin{align*}
    \int_0^1 \frac{P_t(h)}{P_t} c_t(h) dh + Q_t b_t \leq b_{t-1}\Pi_t^{-1} + w_t n_t^s + \int_0^1 div_t(f) df
	\end{align*}
	which becomes 
	\begin{align*}
    c_t = w_t n_t + (y_t - w_t n_t) = y_t
	\end{align*}
	in an optimal allocation with cleared markets.
    This is the aggregate demand equation.
	
\item Define $y_t^{sum} = \int_{0}^1 y_t(f) df$.
    Using the production function \eqref{eq:Firms_ProductionFunction} and labor market clearing we get:
	\begin{align}
	y_t^{sum} = \int_{0}^1 a_t n^d_t(f) df = a_t n_t
	\end{align}
	Furthermore, due to the demand for intermediate good $y_t(f)$ in \eqref{eq:firms_demand} we get:
	\begin{align}
	y_t^{sum} = y_t \underbrace{\int_{0}^1 \left(\frac{P_t(f)}{P_t}\right)^{-\epsilon} df}_{=p_t^*}
	\end{align}
	Equating both yields:
	\begin{align}
		p_t^* y_t =  a_t n_t
	\end{align}
	This is the aggregate supply equation.
    Price frictions, however, imply that resources will not be efficiently allocated
      as prices are too high because not all firms can re-optimize their price in every period.
    This inefficiency is measured by $p_t^*\leq 1$.

\item The law of motion for the inefficiency distortion $p_t^*$ is given due to the Calvo price mechanism, i.e.:
	\begin{align*}
	p_t^* &= \int_0^1\left(\frac{P_t(f)}{P_t}\right)^{-\epsilon} df\\
	p_t^* &= \int_{optimizers} \left(\frac{P_t(f)}{P_t}\right)^{-\epsilon} df + \int_{non-optimizers}\left(\frac{P_t(f)}{P_t}\right)^{-\epsilon} df\\
	p_t^* & = (1-\theta) \widetilde{p}_t^{-\epsilon} + \theta \int_0^1 \left(\frac{P_{t-1}(f)}{P_t}\right)^{-\epsilon} df\\
	p_t^* & = (1-\theta) \widetilde{p}_t^{-\epsilon} + \theta \int_0^1 \left(\frac{P_{t-1}(f)}{P_t }\frac{P_{t-1}}{P_{t-1}}\right)^{-\epsilon} df\\
	p_t^* & = (1-\theta) \widetilde{p}_t^{-\epsilon} + \theta \left(\frac{P_{t-1}}{P_{t}}\right)^{-\epsilon} \int_0^1 \left(\frac{P_{t-1}(f)}{P_{t-1} }\right)^{-\epsilon} df\\
	p_t^* & = (1-\theta) \widetilde{p}_t^{-\epsilon} + \theta \Pi_t^{\epsilon} \underbrace{\int_0^1 \left(\frac{P_{t-1}(f)}{P_{t-1} }\right)^{-\epsilon} df}_{=p_{t-1}^*}\\
	p_t^* & = (1-\theta) \widetilde{p}_t^{-\epsilon} + \theta \Pi_t^{\epsilon} p_{t-1}^*
	\end{align*}
\end{enumerate}

\fi
\newpage
\end{solution}