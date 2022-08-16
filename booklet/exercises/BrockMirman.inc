\section[Brock and Mirman (1972) Model]{Brock and Mirman (1972) Model\label{ex:BrockMirman}}
Consider a simple RBC model with log-utility and full depreciation.
The objective is to maximize
\begin{align*}
\max ~E_t \sum_{j=0}^{\infty} \beta^{j} \log(c_{t+j})
\end{align*}
subject to the law of motion for capital $k_t$ at the end of period $t$
\begin{align}
k_{t} = a_t k_{t-1}^\alpha - c_t \label{eq:BrockMirmanCapital}
\end{align}
with $\beta <1$ denoting the discount factor and $E_t$ is expectation given information at time $t$.
Productivity $a_t$ is the driving force of the economy and evolves according to
\begin{align}
\log{a_{t}} &= \rho_a \log{a_{t-1}}  + \varepsilon_{a,t} \label{eq:BrockMirmanTFP}
\end{align}
where $\rho_a$ denotes the persistence parameter
  and $\varepsilon_{a,t}$ is assumed to be normally distributed with mean zero and variance $\sigma_a$.
Finally, we assume that the transversality condition and 
  the following non-negativity constraints are fullfilled: $k_t \geq0$ and $c_t \geq 0$.

\begin{enumerate}
	\item Show that the first-order condition is given by
	\begin{align}
	1 = \alpha \beta E_t \frac{c_{t}}{c_{t+1}} a_{t+1} k_{t}^{\alpha-1} \label{eq:BrockMirmanEuler}
	\end{align}
	\item Compute the steady-state of the model with pen and paper,
		in the sense that there is a set of values for the endogenous variables that in equilibrium remain constant over time.
	\item Write MATLAB scripts that:
    \begin{enumerate}
        \item Pre-process the model and save both the static and dynamic model equations as well as Jacobians to script files
			that can be evaluated for any value of parameters, dynamic endogenous variables and exogenous variables.        
        \item Compute the steady-state for the following parametrization: $\alpha=0.3$, $\beta=0.96$, $\rho_a=0.5$, and $\sigma_a=0.2$.
        \item Compute the first-order approximated policy function (i.e. $g_x$ and $g_u$ in the notation used in the lecture) for the following parametrization: $\alpha=0.3$, $\beta=0.96$, $\rho_a=0.5$, and $\sigma_a=0.2$.
        \item Draw $T=100$ shocks from the standard normal distribution and simulate data for consumption $c_t$ for $t=1,...T$
	        by using the first-order approximated policy function.
    \end{enumerate}
\newpage
 	\item Professor Mutschler taught you the concept of a policy function,
   \begin{align*}
		\begin{pmatrix} c_{t}\\k_{t}\\a_{t} \end{pmatrix}
 		 &= g(a_{t-1},k_{t-1},\varepsilon_{a,t})
 	\end{align*}	 
	which maps the current state of the economy ($k_{t-1}$ and $a_{t-1}$) and current shocks $\varepsilon_{a,t}$ to current decisions of the agents.
	You remember him stating, that there is no way to derive the function in closed-form, so that's why we use perturbation approximation techniques.
	Willi, a fellow student, disagrees with this assessment and claims that he is able to compute the policy function in closed-form for this model.
	He claims that the policy function is linear in $ a_t k_{t-1}^\alpha$, i.e. it has the form
	\begin{align}
	c_{t} &= g^c a_t k_{t-1}^\alpha \label{eq:BrockMirman:gc}\\
	k_{t} & = g^k a_t k_{t-1}^\alpha \label{eq:BrockMirman:gk}
	\end{align}
	where $g^c$ and $g^k$ are some scalars which are a function of model parameters $\alpha$ and $\beta$ only.
	Professor Mutschler is surprised and therefore asks you on the exam to derive the scalar values $g^c$ and $g^k$.
	Do so by inserting the guessed policy functions \eqref{eq:BrockMirman:gc} and \eqref{eq:BrockMirman:gk}
	into the model equations \eqref{eq:BrockMirmanCapital} and \eqref{eq:BrockMirmanEuler}.
 	\item Compare simulated data for the endogenous variables as well as impulse response functions
	  of a one-standard-deviation technology shock based on the true solution with the first-order approximated one.
\end{enumerate} 


\paragraph{Readings}
\begin{itemize}
	\item \textcite{Brock.Mirman_1972_OptimalEconomicGrowth}
	\item \textcite[Ch.5]{Hansen.Sargent_2013_RecursiveModelsDynamic}
\end{itemize}

\begin{solution}\textbf{Solution to \nameref{ex:BrockMirman}}
\ifDisplaySolutions
\begin{enumerate}
	\item Due to our assumptions , we will not have corner solutions and can neglect the non-negativity constraints. Due to the transversality condition and the concave optimization problem, we only need to focus on the first-order conditions. 
	The Lagrangian for the household problem is
	\begin{align*}
	L = E_t\sum_{j=0}^{\infty}\beta^j\left\{\log(C_{t+j}) + \lambda_{t+j} \left(A_{t+j}K_{t+j-1}^\alpha -C_t - K_{t+j}\right)\right\}
	\end{align*}
	Note that the problem is not to choose $\{C_t,K_{t}\}_{t=0}^\infty$ all at once in an open-loop policy, but to choose these variables sequentially given the information at time $t$ in a closed-loop policy.
			
	The first-order condition w.r.t. $C_t$ is given by
	\begin{align*}
	\frac{\partial L}{\partial C_{t}} &= E_t \left(C_t^{-1}-\lambda_{t}\right) = 0\\
	\Leftrightarrow \lambda_{t} &= C_{t}^{-1} & (I)
	\end{align*}
	The first-order condition w.r.t. $K_{t}$ is given by
	\begin{align*}
	\frac{\partial L}{\partial K_{t}} &= E_t (-\lambda_{t}) + 
	E_t \beta \left(\lambda_{t+1}\alpha A_{t+1} K_{t}^{\alpha-1}\right) = 0\\
	\Leftrightarrow \lambda_{t} &= \alpha\beta E_t \lambda_{t+1}A_{t+1} K_{t}^{\alpha-1} & (II)
	\end{align*}
			
	(I) and (II) yields
	\begin{align*}
	C_t^{-1} = \alpha\beta E_t C_{t+1}^{-1} A_{t+1} K_{t}^{\alpha-1}
	\end{align*}
	
	\item First, consider the steady value of technology: 
	$$\log\bar{A}=\rho_A \log\bar{A} + 0 \Leftrightarrow \log\bar{A} = 0 \Leftrightarrow \bar{A} = 1$$ 
	The Euler equation in steady-state becomes:
	\begin{align*}
	\bar{K} = (\alpha \beta \bar{A})^{\frac{1}{1-\alpha}}
	\end{align*}
	
	\item Inserting the guessed policy function for $C_t$ inside the the capital accumulation equation yields:
		\begin{align*}
		K_{t} = A_{t}K_{t-1}^\alpha - g_C A_t K_{t-1}^\alpha = (1-g_C) A_t K_{t-1}^\alpha
		\end{align*}
		Therefore, $g^K=(1-g^C)$. Once we derive $g^C$, we get $g^K$.
			
		Inserting the guessed policy function for $C_t$ inside the Euler equation yields
		\begin{align*}
		\frac{1}{C_t} = \alpha \beta E_t \frac{1}{C_{t+1}}A_{t+1} K_{t}^{\alpha-1}\\
		\frac{1}{g_C A_t K_{t-1}^\alpha} = \alpha \beta E_t \frac{1}{g_C A_{t+1} K_{t}^\alpha}A_{t+1} K_{t}^{\alpha-1}\\
		A_t K_{t-1}^\alpha = \frac{1}{\alpha \beta} E_t K_{t}
		\end{align*}
		Inserting the decision rule for capital:
		\begin{align*}
			A_t K_{t-1}^\alpha = \frac{1}{\alpha \beta} (1-g^C)A_t K_{t-1}^\alpha\\
			\Leftrightarrow g^C = (1-\alpha \beta)
		\end{align*}
		Thus the policy function for $C_t$ is
		$$ C_t = (1-\alpha\beta) A_t K_{t-1}^\alpha$$
		and for $K_{t}$:
		$$ K_{t} = \alpha \beta A_t K_{t-1}^\alpha$$
		Now inserting $A_t = A_{t-1}^{\rho} e^{\varepsilon_t}$ yields:
		\begin{align*}
			A_t &= A_{t-1}^{\rho} e^{\varepsilon_t}
			\\
			C_t &= (1-\alpha\beta) A_{t-1}^\rho K_{t-1}^\alpha e^{\varepsilon_t}
			\\
			K_t &= \alpha\beta A_{t-1}^\rho K_{t-1}^\alpha e^{\varepsilon_t}
		\end{align*}
		In summary we have found analytically the policy functions. This will not be possible for other DSGE models and we have to rely on numerical methods to approximate the highly nonlinear functions $g$ and $h$.
	\item Here is the main function:
	%\lstinputlisting{../progs/BrockMirman_f.m}

	And this function computes the steady-state:
	%\lstinputlisting{../progs/BrockMirman_ss.m}

	If you know Dynare, here is a Dynare mod file:
	%\lstinputlisting{../progs/BrockMirman.mod}
	\item Here is a script that compares the true policy function with the approximated one:
	%\lstinputlisting{../progs/BrockMirman_compare.m}

	Note that as long as we stay close to the steady-state the approximated solution is very accurate.

\end{enumerate}

\fi
\newpage
\end{solution}