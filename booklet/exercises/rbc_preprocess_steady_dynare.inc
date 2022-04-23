\section[RBC model: preprocessing and steady-state in Dynare]{RBC model: preprocessing and steady-state in Dynare\label{ex:RBCModelPreprocessSteady}}
Consider the basic Real Business Cycle (RBC) model with leisure.
The representative household maximizes present as well as expected future utility
\begin{align*}
	\max E_t \sum_{j=0}^{\infty} \beta^{j} U_{t+j}
\end{align*}
with $\beta <1$ denoting the discount factor and $E_t$ is expectation given information at time $t$.
The contemporaneous utility function 
\begin{align*}
	U_t = \gamma \log(C_t) + \psi \log{(1-L_t)}
\end{align*}
is additively separable and has two arguments: consumption $C_t$ and labor $L_t$.
The marginal utility of consumption is positive, whereas more labor reduces utility. Accordingly, $\gamma$ is the consumption utility parameter and $\psi$ the labor disutility parameter. In each period the household takes the real wage $W_t$ as given and supplies perfectly elastic labor service to the representative firm. In return, she receives real labor income in the amount of $W_t L_t$ and, additionally, real profits $DIV_t$ from the firm as well as revenue from lending capital $K_{t-1}$ at interest rate $R_t$ to the firms, as it is assumed that the firm and capital stock are owned by the household. Income and wealth are used to finance consumption $C_t$ and investment $I_t$. In total, this defines the (real) budget constraint of the household:
\begin{align*}
C_t + I_t = W_t L_t + R_t K_{t-1} + DIV_t
\end{align*}

The law of motion for capital $K_t$ at the end of period $t$ is given by
\begin{align*}
K_{t} = (1-\delta)K_{t-1} + I_t
\end{align*}
and $\delta$ is controling depreciations.
\footnote{Note that we use the end-of-period timing for capital, i.e. $K_t$ instead of $K_{t+1}$,
  because the investment decision is done in period $t$ and hence capital is also determined in $t$.
In older papers you will often find beginning-of-period timing for capital,
  so always think about when it is decided and determined.}
Assume that the transversality condition is full-filled.
	
Productivity $A_t$ is the driving force of the economy and evolves according to
\begin{align*}
	\log{A_{t}} &= \rho_A \log{A_{t-1}}  + \varepsilon_t^A
\end{align*}
where $\rho_A$ denotes the persistence parameter and
  $\varepsilon_t^A$ is assumed to be normally distributed with mean zero and variance $\sigma_A^2$.
	
Real profits $DIV_t$ of the representative firm are revenues from selling output $Y_t$
  minus costs from labor $W_t L_t$ and renting capital $R_t K_{t-1}$:
\begin{align*}
DIV_t = Y_{t} - W_{t} L_{t} - R_{t} K_{t-1}
\end{align*}	
The representative firm maximizes expected profits
\begin{align*}
	\max E_t \sum_{j=0}^{\infty} \beta^j Q_{t+j} DIV_{t+j}
\end{align*}
subject to a Cobb-Douglas production function
\begin{align*}
f(K_{t-1}, L_t) = Y_t = A_t K_{t-1}^\alpha L_t^{1-\alpha}
\end{align*}
The discount factor takes into account that firms are owned by the household,
  i.e. $\beta^j Q_{t+j}$ is the present value of a unit of consumption in period $t+j$ or, 
  respectively, the marginal utility of an additional unit of profit;
  therefore $Q_{t+j}=\frac{\partial U_{t+j}/\partial C_{t+j}}{\partial U_{t}/\partial C_{t}}$.
	
Finally, we have the non-negativity constraints	$K_t \geq0$, $C_t \geq 0$ and $0\leq L_t \leq 1$
  and clearing of the labor as well as goods market in equilibrium, i.e.
\begin{align*}
Y_t = C_t + I_t
\end{align*}

\begin{enumerate}
	\item Briefly provide intuition behind the transversality condition.
	\item Show that the first-order conditions of the representative household are given by
	\begin{align*}
	 U_t^C &= \beta E_t\left[U_{t+1}^C\left(1-\delta + R_{t+1}\right)\right]\\
     W_t &= -\frac{U_t^L}{U_t^C}
	\end{align*}
	where $U_t^C=\gamma C_t^{-1}$ and $U_t^L = \frac{-\psi}{1-L_t}$.
	Interpret these equations in economic terms.
	\item Show that the first-order conditions of the representative firm are given by
	\begin{align*}
	W_t &= f_L\\
	R_t &= f_K
	\end{align*}
	where $f_L = (1-\alpha) A_t \left(\frac{K_{t-1}}{L_t}\right)^\alpha$ and 
	$f_K = \alpha A_t \left(\frac{K_{t-1}}{L_t}\right)^{1-\alpha}$.
	Interpret these equations in economic terms.
	\item Derive the steady-state of the model, in the sense that there is a set of values for the endogenous variables
	  that in equilibrium remain constant over time.
	\item Discuss how to calibrate the following parameters $\alpha$,  $\beta$, $\delta$, $\gamma$, $\psi$, $\rho_A$ and $\sigma_A$.
	\item Write a script for this RBC model with a feasible calibration for an OECD country that computes the steady-state of the model.
	\item Write a Dynare mod file for this RBC model with a feasible calibration for an OECD country and compute the steady-state of the model by using a \texttt{steady\_state\_model} block. Compare this to the steady-state computed above.
	\item Now assume a contemporaneous utility function of the CRRA (constant Relative Risk Aversion) type:
	\footnote{Note that due to L'Hopital's rule $\eta_C=\eta_L=1$ implies the original specification,
	$U_t=\gamma \log C_t + \psi \log(1-L_t)$.}
 	\begin{align*}
 		U_t = \gamma \frac{C_{t}^{1-\eta_C}-1}{1-\eta_C} +\psi \frac{(1-L_{t})^{1-\eta_L}-1}{1-\eta_L}
 	\end{align*}
	\begin{enumerate}
 		\item Derive the model equations and steady-state analytically.
 		\item Write a script to compute the steady-state for this model.
 		\item Write a Dynare mod file and compute the steady-state for this model
		   by using a helper function in the \texttt{steady\_state\_model} block.
 	\end{enumerate}
\end{enumerate}

\paragraph{Readings}
\begin{itemize}
	\item \textcite{McCandless_2008_ABCsRBCsIntroduction}.
\end{itemize}



\begin{solution}\textbf{Solution to \nameref{ex:RBCModelPreprocessSteady}}
\ifDisplaySolutions
\begin{enumerate}
	\item The transversality condition for an infinite horizon dynamic optimization problem is the boundary condition determining a solution to the problem's first-order conditions together with the initial condition. The transversality condition requires the present value of the state variables (here $K_t$ and $A_t$) to converge to zero as the planning horizon recedes towards infinity. The first-order and transversality conditions are sufficient to identify an optimum in a concave optimization problem. Given an optimal path, the necessity of the transversality condition reflects the impossibility of finding an alternative feasible path for which each state variable deviates from the optimum at each time and increases discounted utility.	
	These conditions are implicit only, we don't enter them in a computer program. But implicitly we do consider them when we focus on unique and stable solutions or when we pick certain steady-state values.
	\item Due to our assumptions , we will not have corner solutions and can neglect the non-negativity constraints. Due to the transversality condition and the concave optimization problem, we only need to focus on the first-order conditions. The Lagrangian for the household problem is
		\begin{align*}
			\pounds = E_t\sum_{j=0}^{\infty}\beta^j&\left\{\gamma \log(C_{t+j}) + \psi \log(1-L_{t+j}) \right\}\\
			+\beta^j \lambda_{t+j} &\left\{ \left(W_{t+j} L_{t+j} + R_{t+j} K_{t-1+j} - C_{t+j} - I_{t+j}\right) \right\}\\
			+\beta^j \mu_{t+j} &\left\{ \left((1-\delta)K_{t-1+j} + I_{t+j} - K_{t+j}\right)\right\}
		\end{align*}
		Note that the problem is not to choose $\{C_t,I_t,L_t,K_{t}\}_{t=0}^\infty$ all at once in an open-loop policy, but to choose these variables sequentially given the information at time $t$ in a closed-loop policy, i.e. at period $t$ decision rules for $\{C_t,I_t,L_t,K_{t}\}$ given the information set at period $t$; at period $t+1$ decision rules for $\{C_{t+1},I_{t+1},L_{t+1},K_{t+1}\}$ given the information set at period $t+1$.
		
		The first-order condition w.r.t. $C_t$ is given by
		\begin{align*}
			\frac{\partial \pounds}{\partial C_{t}} &= E_t \left(\gamma C_t^{-1}-\lambda_{t}\right) = 0\\
			\Leftrightarrow \lambda_{t} &= \gamma C_{t}^{-1} & (I)
		\end{align*}
		The first-order condition w.r.t. $L_t$ is given by
		\begin{align*}
			\frac{\partial \pounds}{\partial L_{t}} &= E_t \left(\frac{-\psi}{1-L_{t}}+\lambda_{t} W_{t}\right) = 0\\
			\Leftrightarrow \lambda_{t} W_{t} &= \frac{\psi}{1-L_{t}} &(II)
		\end{align*}
		The first-order condition w.r.t. $I_{t}$ is given by
		\begin{align*}
			\frac{\partial \pounds}{\partial I_{t}} &= E_t \left(-\lambda_{t} + \mu_{t}\right) = 0\\
			\Leftrightarrow \lambda_{t} &= \mu_{t} & (III)
		\end{align*}
		The first-order condition w.r.t. $K_{t}$ is given by
		\begin{align*}
			\frac{\partial \pounds}{\partial K_{t}} &= E_t (-\mu_{t}) + 
			E_t \beta \left(\lambda_{t+1}R_{t+1}+\mu_{t+1}(1-\delta)\right) = 0\\
			\Leftrightarrow \mu_{t} &= E_t \beta(\mu_{t+1}(1-\delta)+\lambda_{t+1}R_{t+1}) & (IV)
		\end{align*}

		(I) and (III) in (IV) yields
		\begin{align*}
			\underbrace{\gamma C_t^{-1}}_{U_t^c} &= \beta E_t \underbrace{\gamma C_{t+1}^{-1}}_{U_{t+1}^c}\left(1-\delta + R_{t+1}\right)
		\end{align*}
		This is the Euler equation of intertemporal optimality. It reflects the trade-off between consumption and savings. If the household saves a (marginal) unit of consumption, she can consume the gross rate of return on capital, i.e. $(1-\delta+R_{t+1})$ units, in the following period. The marginal utility of consuming today is equal to $U_t^c$, whereas consuming tomorrow has expected utility $E_t(U_{t+1}^c)$. Discounting expected marginal utility with $\beta$ the household must be indifferent between both choices in the optimum.

		(I) in (II) yields:
		\begin{align*}
		W_t = -\frac{\frac{-\psi}{1-L_t}}{\gamma C_t^{-1}} \equiv - \frac{U_t^l}{U_t^c}
		\end{align*}
		This equation reflects intratemporal optimality, particularly, the optimal choice for labor supply: the real wage must be equal to the marginal rate of substitution between labor and consumption.
	\item First, we note that even though firms maximize expected profits it is actually a static problem as there are no forward-looking terms. That is, the objective is to maximize profits
		\begin{align*}
			DIV_t = A_t K_{t-1}^\alpha L_t^{1-\alpha} - W_t L_t - R_t K_{t-1}
		\end{align*}
		The first-order condition w.r.t. $L_{t}$ is given by
		\begin{align*}
			\frac{\partial DIV_t}{\partial L_{t}} &= (1-\alpha) A_t K_{t-1}^\alpha L_t^{-\alpha} - W_t = 0\\
			\Leftrightarrow W_t &= (1-\alpha) A_t K_{t-1}^\alpha L_t^{-\alpha} = f_L = (1-\alpha) \frac{Y_t}{L_t}
		\end{align*}
		The real wage must be equal to the marginal product of labor. Due to the Cobb-Douglas production function it is a constant proportion $(1-\alpha)$ of the ratio of total output and labor. This is the labor demand function.
				
		The first-order condition w.r.t. $K_{t-1}$ is given by
		\begin{align*}
			\frac{\partial DIV_t}{\partial K_{t-1}} &= \alpha A_t K_{t-1}^{\alpha-1} L_t^{1-\alpha} - R_t = 0\\
			\Leftrightarrow R_t &= \alpha A_t K_{t-1}^{\alpha-1} L_t^{1-\alpha} = f_K = \alpha \frac{Y_t}{K_{t-1}}
		\end{align*}
		The real interest rate must be equal to the marginal product of capital. Due to the Cobb-Douglas production function it is a constant proportion $\alpha$ of the ratio of total output and capital. This is the capital demand function.
	\item First, consider the steady-state value of technology: 
		$$\log\bar{A}=\rho_A \log\bar{A} + 0 \Leftrightarrow \log\bar{A} = 0 \Leftrightarrow \bar{A} = 1$$ 
		The Euler equation in steady-state becomes:
		\begin{align*}
			\bar{U}^C &= \beta \bar{U}^C(1-\delta+\bar{R})\\
			\Leftrightarrow \bar{R} &= \frac{1}{\beta} + \delta - 1
		\end{align*}
		Now we will provide recursively closed-form expressions for all variables in relation to steady-state labor. That is the right-hand sides of the following equations are given in terms of parameters or previously computed expressions.
		\begin{itemize}
		\item The firms demand for capital in steady-state becomes
			\begin{align*}
				\bar{R} &= \alpha \bar{A} \bar{K}^{\alpha-1}\bar{L}^{1-\alpha}\\
				\Leftrightarrow \frac{\bar{K}}{\bar{L}} &= \left(\frac{\alpha \bar{A}}{\bar{R}}\right)^{\frac{1}{1-\alpha}}
			\end{align*}
		\item The firms demand for labor in steady-state becomes:
			\begin{align*}
				W =(1-\alpha) \bar{A}\bar{K}^\alpha \bar{L}^{-\alpha} = (1-\alpha)\bar{A} \left(\frac{\bar{K}}{\bar{L}}\right)^\alpha
			\end{align*}
		\item The law of motion for capital in steady-state implies
			\begin{align*}
				\frac{\bar{I}}{\bar{L}} &= \delta\frac{\bar{K}}{\bar{L}}
			\end{align*}
		\item The production function in steady-state becomes
			\begin{align*}
				\frac{\bar{Y}}{\bar{L}} = \bar{A} \left(\frac{\bar{K}}{\bar{L}}\right)^\alpha
			\end{align*}
		\item The clearing of the goods market in steady-state implies 
			\begin{align*}
				\frac{\bar{C}}{\bar{L}} = \frac{\bar{Y}}{\bar{L}} - \frac{\bar{I}}{\bar{L}}
			\end{align*}
		\end{itemize}
		Now, we have expressions for all variables as a ratio to steady-state labor. Hence, once we compute $L$, we can revisit the above expressions to compute all values in closed-form. Due to the log-utility function, we can actually derive a closed-form expression for $L$:
		\begin{align*}
			\psi \frac{1}{1-\bar{L}} &= \gamma \bar{C}^{-1} W\\
			\Leftrightarrow \psi \frac{\bar{L}}{1-\bar{L}} &= \gamma \left(\frac{\bar{C}}{\bar{L}}\right)^{-1} W\\
			\Leftrightarrow \bar{L} &= (1-\bar{L})\frac{\gamma}{\psi} \left(\frac{\bar{C}}{\bar{L}}\right)^{-1} W\\
			\Leftrightarrow \bar{L} &= \frac{\frac{\gamma}{\psi} \left(\frac{\bar{C}}{\bar{L}}\right)^{-1} W}{1+\frac{\gamma}{\psi} \left(\frac{\bar{C}}{\bar{L}}\right)^{-1} W}\\	
		\end{align*}
		Lastly, it is straigforward to compute the remaining steady-state values, i.e.
		\begin{align*}
			\bar{C} = \frac{\bar{C}}{\bar{L}}\bar{L},\qquad
			\bar{I} = \frac{\bar{I}}{\bar{L}}\bar{L},\qquad
			\bar{K} = \frac{\bar{K}}{\bar{L}}\bar{L},	\qquad	
			\bar{Y} = \frac{\bar{Y}}{\bar{L}}\bar{L}
		\end{align*}
	\item General hints: construct and parameterize the model such, that it corresponds to certain properties of the true economy. One often uses steady-state characteristics for choosing the parameters in accordance with observed data. For instance, long-run averages (wages, working-hours, interest rates, inflation, consumption-shares, government-spending-ratios, etc.) are used to fix steady-state values of the endogenous variables, which implies values for the parameters. You can also use micro-studies, however, one has to be careful about the aggregation!
			
	We will focus on OECD countries and discuss one \enquote{possible} way to calibrate the model parameters (there are many other ways):
	\begin{itemize}
		\item[$\boldsymbol{\alpha}$] productivity parameter of capital. Due to the Cobb Douglas production function thus should be equal to the proportion of capital income to total income of economy. So, one looks inside the national accounts for OECD countries and sets $\alpha$ to 1 minus the share of labor income over total income. For most OECD countries this implies a range of 0.25 to 0.35.
		\item[$\boldsymbol{\beta}$] subjective intertemporal preference rate of households: it is the value of future utility in relation to present utility. Usually takes a value slightly less than unity, indicating that agents discount the future. For quarterly data, we typically set it around 0.99. A better way: fix this parameter by making use of the Euler equation in steady-state: $\beta = \frac{1}{\bar{R}+1-\delta}$ where $\bar{R}=\alpha \frac{\bar{Y}}{\bar{K}}$. Looking at OECD data one usually finds that average capital productivity $\bar{K}/\bar{Y}$ is in the range of $9$ to $10$.
		\item[$\boldsymbol{\delta}$] depreciation rate of capital stock. For quarterly data the literature uses values in the range of 0.02 to 0.03. A better way: use steady-state implication that $\delta=\frac{\bar{I}}{\bar{K}}=\frac{\bar{I/Y}}{\bar{K/Y}}$. For OECD data one usually finds that average ratio of investment to output, $\bar{I}/\bar{Y}$, is around 0.25.
		\item[$\boldsymbol{\gamma}$ and $\boldsymbol{\psi}$] individual's preference regarding consumption and leisure. Often a certain interpretation in terms of elasticities of substitutions is possible. Here we can make use of the First-Order-Conditions in steady-state, i.e.
		$$\frac{\psi}{\gamma} = \bar{W}\frac{(1-\bar{L})}{\bar{C}}= (1-\alpha)\left(\frac{\bar{K}}{\bar{L}}\right)^\alpha\frac{(1-\bar{L})}{\bar{C}} = (1-\alpha)\left(\frac{\bar{K}}{\bar{L}}\right)^\alpha\frac{\frac{1}{\bar{L}}(1-\bar{L})}{\frac{\bar{C}}{\bar{L}}}$$
		and noting that $\bar{C}/\bar{L}$ as well as $\bar{K}/\bar{L}$ are given in terms of already calibrated parameters (see steady-state computations). Therefore, one possible way is to normalize one of the parameters to unity (e.g. $\gamma=1$) and calibrate the other one in terms of steady-state ratios for which we would only require to calibrate steady-state hours worked $\bar{L}$. Note that labor time is normalized and usually corresponds to 8 hours a day, i.e. $\bar{L}=1/3$.
		\item[$\boldsymbol{\rho_A}$ and $\boldsymbol{\sigma_A}$] parameters of process for total factor productivity. These can be estimated based on a regression of the Solow Residual, i.e. production function residuals. $\rho_A$ is mostly set above 0.9 to reflect persistence of the technological process and $\sigma_A$ around $0.6$ in the simple RBC model. Another way would be to try different values for $\sigma_A$ and then try to match the shape of impulse-response-functions of corresponding (S)VAR models.
	\end{itemize}
	\item The function might look like this:
	\lstinputlisting{../progs/rbc_logutil_ss.m}
	You can try it out with the following parametrization (same as in the Dynare mod file):
	\lstinputlisting{../progs/rbc_logutil_ss_test.m}
	\item The mod file might look like this:
		\lstinputlisting{../progs/Dynare/rbc_logutil.mod}
	Obviously, the results are the same.
	\item
	\begin{enumerate}
		\item  For the first-order conditions of the household we know use
		\begin{align*}
		U_t^C &= \gamma C_t^{-\eta_C}\\
		U_t^L &= - \psi (1-L_t)^{-\eta_L}
		\end{align*}
		The steady-state for labor changes to
		\begin{align*}
			W \gamma \left(\frac{C}{L}\right)^{-\eta_C} &= \psi(1-L)^{-\eta_L}L^{\eta_C}
		\end{align*}
		This cannot be solved for $L$ in closed-form. Rather, we need to condition on the values of the parameters and use an numerical optimizer to solve for $L$.	
		\item The function might look like this:
		\lstinputlisting{../progs/rbc_ss.m}
		You can try it out with the following parametrization (same as in the Dynare mod file):
		\lstinputlisting{../progs/rbc_ss_test.m}
		\item In Dynare we could use the following mod file:
		\lstinputlisting{../progs/Dynare/rbc_ces.mod}
		and the following helper function:
		\lstinputlisting{../progs/Dynare/rbc_ces_helper_function.m}		
		Obviously, the results are the same.
	\end{enumerate}		
\end{enumerate}
\fi
\newpage
\end{solution}