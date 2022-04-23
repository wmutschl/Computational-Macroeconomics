\section[DSGE Models: Definition, Key Challenges, And Basic Structure]{DSGE Models: Definition, Key Challenges, And Basic Structure\label{ex:DSGEModelsDefinitionChallengesStructure}}
\begin{enumerate}
	\item Briefly define the term and key challenges of Dynamic Stochastic General Equilibrium (DSGE) models.
	What are DSGE models useful for?
 	\item Outline the common structure of a DSGE model.
	 How do Neo-Classical, New-Classical and New-Keynesian models differ?
 	\item Comment whether or not the assumptions underlying DSGE models should be as realistic as possible.
	 For example, a very common assumption is that all agents live forever.
\end{enumerate}

\paragraph{Readings}
\begin{itemize}
	\item \textcite[Ch. 1]{Fernandez-Villaverde.Rubio-Ramirez.Schorfheide_2016_SolutionEstimationMethods}
	\item \textcite[Ch.~1]{Torres_2013_IntroductionDynamicMacroeconomic}
\end{itemize}

\begin{solution}\textbf{Solution to \nameref{ex:DSGEModelsDefinitionChallengesStructure}}
\ifDisplaySolutions
\begin{enumerate}
\item DSGE models use modern macroeconomic theory to explain 
	and predict co-movements of aggregate time series. 
	DSGE models start from what we call the micro-foundations of macroeconomics
	  (i.e. to be consistent with the underlying behavior of economic agents),
	  with a heart based on the rational expectation forward-looking economic behavior of agents.
	In reality all macro variables are related to each other, either directly or indirectly, 
	so there is no \enquote{cetribus paribus}, but a dynamic stochastic general equilibrium system.
	\begin{itemize}
		\item General Equilibrium (GE): equations must always hold.
		\\
		Short-run: decisions, quantities and prices adjust such that equations are full-filled.
		\\
		Long-run: steady-state, i.e. a condition or situation 
		where variables do not change their value 
		(e.g. balanced-growth path where the rate of growth is constant). 
		\item Stochastic (S): disturbances (or shocks) make the system deviate from its steady-state, 
		we get business cycles or, more general, a data-generating process
		\item Dynamic (D): Agents are forward-looking and solve intertemporal optimization problems. 
		When a disturbance hits the economy, 
		macroeconomic variables do not return to equilibrium instantaneously, 
		but change very slowly over time, producing complex reactions. 
		Furthermore, some decisions like investment or saving only make sense in a dynamic context.
		We can analyze and quantify the effects after
		(i) a temporary shock: how does the economy return to its steady-state, or 
		(ii) a permanent shock: how does the economy move to a new steady-state.
	\end{itemize}
	Basic structure:
	$$ E_t \left[f(y_{t+1}, y_t, y_{t-1},u_t)\right]=0$$
	where $E_t$ is the expectation operator with information conditional up to and including period $t$,
	$y_t$ is a vector of endogenous variables at time $t$,
	$u_t$ a vector of exogenous shocks or random disturbances with proper density functions.
	$f(\cdot)$ is what we call economic theory.
	
	\textbf{First key challenge:} values of endogenous variables in a given period of time 
	  depend on future expected values.
	We need dynamic programming techniques to find the optimality conditions
	which define the economic behavior of the agents.
	The solution to this system is called a decision or policy function:
	$$y_t = g(y_{t-1},u_t)$$
	describing optimal behavior of all agents given the current state of the world $y_{t-1}$
	and after observing current shocks $u_t$.
	
	\textbf{Second key challenge}: DSGE models cannot be solved analytically, 
	except for some very simple and unrealistic examples.
	We have to resort to numerical methods and a computer to find an approximated solution.
	This is the focus of the course on \texttt{Computational Macroeconomics}.

	Once the theoretical model and solution is at hands, 
	the next step is the\\
	\textbf{third key challenge}: application to the data.
	The usual procedure consists in the calibration of the parameters of the model
	using previous information or matching some key ratios or moments provided by the data.
	More recently, within the field of quantitative macroeconomics or macroeconometrics,
	researchers have applied formal statistical methods to estimate the parameters
	using maximum likelihood, Bayesian techniques, indirect inference, or a method of moments.
	This is the focus of the course on \texttt{Quantitative Macroeconomics}.
	
\item The dynamic equilibrium is the result from the combination of economic decisions
taken by all economic agents.
For example the following agents or sectors are commonly included:
	\begin{itemize}
		\item Households: benefit from private consumption, leisure and possibly other things
		  like money holdings or state services;
		  subject to a budget constraint in which they finance their expenditures 
		  via (utility-reducing) work, renting capital and buying (government) bonds
		  $\hookrightarrow$ maximization of utility
		\item Firms produce a variety of products with the help of rented equipment (capital) and labor.
		They (possibly) have market power over their product and are responsible for
		  the design, manufacture and price of their products.
		  $\hookrightarrow$ cost minimization or profit maximization
		\item Monetary policy follows a feedback rule, so-called Taylor rule, for instance: 
		nominal interest rate reacts to deviations of the current (or lagged) inflation rate
		from its target and of current output from potential output
		\item Fiscal policy (the government) collects taxes from households and companies 
		in order to finance government expenditures (possibly utility-enhancing) 
		and government investment (possibly productivity-enhancing).
		In addition, the government can issue debt securities
		and might face a probability of sovereign default.
	\end{itemize}
	There is no limitation, i.e. you can also add other sectors,
	e.g. current models feature a financial sector, international trade, research \& development, etc.
\item Neoclassical or New-Classical models are basically the same terminology
  (unless you study economic history or really want to dive into the different school of thoughts).
  Basically, both approaches focus on microfoundations,
  the one more in a classical sense (focus on real rigidities)
  and the other one more in a Keynesian sense (focus on nominal rigidities).
  In principle this is already evident in the baseline RBC model and the baseline New-Keynesian model.
	\begin{itemize}
		\item Canonical neoclassical model (aka RBC model):
		reduce economy to the interaction of just one (representative) consumer/household
		and just one (representative) firm.
		Representative household takes decisions in terms of how much to consume (or save)
		and how much time is devoted to work (or leisure).
		Representative firm decides how much it will produce.
		Equilibrium of the economy will be defined by a situation
		in which all decisions taken by all economic agents are compatible and feasible.
		One can show that business cycles can be generated by one special disturbance:
		total factor productivity or neutral technological shock;
		hence, model generates real business cycles without any nominal frictions.
		Of course, one can add real frictions like time-to-built or preference shocks.
		\item New-Keynesian models have the same foundations as New-Classical general equilibrium models, 
		but incorporate different types of rigidities in the economy.
		Whereas new classical DSGE models are constructed on the basis of a perfect competition environment, 
		New-Keynesian models include additional elements to the basic model such as 
		imperfect competitions, existence of adjustment costs in investment process, 
		liquidity constraints or rigidities in the determination of prices and wages.
	\end{itemize}	
	Noth that the scale of DSGE models has grown over time
	with incorporation of a large number of features.
	To name a few: consumption habit formation, nominal and real rigidities, 
	non-Ricardian agents, investment adjustment costs, investment-specific technological change, 
	taxes, public spending, public capital, human capital, household production, 
	imperfect competition, monetary union, steady-state unemployment etc.
	Moreover, New-Keynesian models have become the leading macroeconomic paradigm.

\item The degree of realism offered by an economic model is not a goal per se to be pursued by macroeconomists;
	typically we are focused on the model's \textbf{usefulness} in explaining macroeconomic reality.
	General strategy is the construction of formal structures through equations
	that reflect the interrelationships between the different economic variables.
	These simplified structures is what we call a model.
	The essential question is not that these theoretical constructions are 
	realistic descriptions of the economy,
	but that they are able to explain the dynamics observed in the economy.
	Therefore, in my opinion, it is not correct to outright reject a model ex-ante just
	because it is based on assumptions that we believe are not realistic.
	Rather, the validations must be based on the usefulness of these models to explain reality,
	and whether they are more useful than other models.
	Of course, most of the times unrealistic assumptions will yield non-useful models:
	often, however, simplified assumptions that are a very rough approximation of reality
	yield quite useful models.
	Either way, the DSGE model paradigm is EXTREMELY UP-FRONT with our assumptions 
	and provide the EXACT model dynamics in terms of mathematical formulations that can be challenged,
	adapted and, ideally, improved.
	
	Regarding the assumption that the lifetime of economic agents is assumed to be infinite:
	We know that the lifetime of consumers, businesses and governments is in fact finite.
	However, in most models this is a valid approximation,
	because for solving and simulating these models it is not important that agents actually live forever,
	but that they use the infinite time as \textbf{the reference period for taking economic decisions}.
	This is highly realistic!
	No government thinks it will cease to exist at some point in the future
	and no entrepreneur takes decisions based on the idea
	that the firm will go bankrupt sometime in the future.
	Granted, for consumers this is rather weak;
	however, we may think about families, dynasties or households rather than consumers,
    then the infinite time planning horizon assumption is a feasible one.
	Of course, to study the finite life cycle of an agent (school-work-retirement) or pension schemes,
	the so-called Overlapping Generations (OLG) framework is probably more adequate.
	But, we need the same methods and techniques to deal with OLG models as with New-Keynesian or RBC models,
	because all these models belong to the the same class, i.e. are all DSGE models.
\end{enumerate}

\fi
\newpage
\end{solution}