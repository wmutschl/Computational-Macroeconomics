\begin{enumerate}

\item Due to the transversality condition,
  we will not have corner solutions and can neglect the non-negativity constraints.
Moreover, due to the concave optimization problem, we only need to focus on the first-order conditions.

Making use of the normalized time budget, the Lagrangian for the household problem is
\begin{align*}
\pounds^H = E_t\sum_{j=0}^{\infty}\beta^j&\left\{\gamma \log(c_{t+j}) + \psi \log(1-n_{t+j}) \right\}
\\
+\beta^j \lambda_{t+j} &\left\{ \left(w_{t+j} n_{t+j} + r_{k,t+j} k_{t-1+j} - c_{t+j} - i_{t+j}\right) \right\}
\\
+\beta^j \mu_{t+j} &\left\{ \left((1-\delta)k_{t-1+j} + i_{t+j} - k_{t+j}\right)\right\}
\end{align*}
Note that the problem is not to choose $\{c_t,i_t,n_t,k_{t}\}_{t=0}^\infty$ all at once in an open-loop policy,
  but to choose these variables sequentially given the information at time $t$ in a closed-loop policy,
  i.e. at period $t$ decision rules for $\{c_t,i_t,n_t,k_{t}\}$ given the information set at period $t$;
  at period $t+1$ decision rules for $\{c_{t+1},i_{t+1},n_{t+1},k_{t+1}\}$ given the information set at period $t+1$,
  and so on.

The first-order condition w.r.t. $c_t$ is given by
\begin{align*}
\frac{\partial \pounds^H}{\partial c_{t}} &= E_t \left(\gamma c_t^{-1}-\lambda_{t}\right) = 0
\\
\Leftrightarrow \lambda_{t} &= \gamma c_{t}^{-1} & (I)
\end{align*}
The first-order condition w.r.t. $n_t$ is given by
\begin{align*}
\frac{\partial \pounds^H}{\partial n_{t}} &= E_t \left(\frac{-\psi}{1-n_{t}} + \lambda_{t} w_{t}\right) = 0
\\
\Leftrightarrow \lambda_{t} w_{t} &= \frac{\psi}{1-n_{t}} &(II)
\end{align*}
The first-order condition w.r.t. $i_{t}$ is given by
\begin{align*}
\frac{\partial \pounds^H}{\partial i_{t}} &= E_t \left(-\lambda_{t} + \mu_{t}\right) = 0
\\
\Leftrightarrow \lambda_{t} &= \mu_{t} & (III)
\end{align*}
The first-order condition w.r.t. $k_{t}$ is given by
\begin{align*}
\frac{\partial \pounds^H}{\partial k_{t}} &= E_t (-\mu_{t}) + 
	E_t \beta \left(\lambda_{t+1} r_{k,t+1} + \mu_{t+1}(1-\delta)\right) = 0
\\
\Leftrightarrow \mu_{t} &= E_t \beta(\mu_{t+1}(1-\delta) + \lambda_{t+1} r_{k,t+1}) & (IV)
\end{align*}

(I) and (III) in (IV) yields
\begin{align*}
\underbrace{\gamma c_t^{-1}}_{U_{c,t}} &= \beta E_t \underbrace{\gamma c_{t+1}^{-1}}_{U_{c,t+1}}\left(1 - \delta + r_{k,t+1}\right)
\end{align*}
This is the Euler equation of \textbf{intertemporal optimality}. It reflects the trade-off between consumption and savings.
If the household saves a (marginal) unit of consumption, i.e. invests this into the capital stock,
  she can consume $(1-\delta+r_{k,t+1})$ units in the following period.
The marginal utility of consuming a unit today is equal to $U_{c,t}$,
  whereas consuming tomorrow has expected utility equal to $E_t(U_{c,t+1})$.
Discounting expected marginal utility with $\beta$, an optimum is characterized by a situation
  in which the household must be indifferent between both choices.

(I) in (II) yields:
\begin{align*}
w_t = -\frac{\frac{-\psi}{1-n_t}}{\gamma c_t^{-1}} \equiv - \frac{U_{n,t}}{U_{c,t}}
\end{align*}
This equation reflects \textbf{intratemporal optimality}; in other words, the labor supply function.
According to the equation, the real wage must be equal to the marginal rate of substitution between consumption and leisure.

\item First, note that even though firms maximize expected profits it is actually a static problem as there are no forward-looking terms.
That is, the objective is to maximize profits
\begin{align*}
{div}_t = a_t k_{d,t}^\alpha n_{d,t}^{1-\alpha} - w_t n_{d,t} - r_{k,t} k_{d,t}
\end{align*}
The first-order condition w.r.t. $n_{d,t}$ is given by
\begin{align*}
\frac{\partial {div}_t}{\partial n_{d,t}} &= (1-\alpha) a_t k_{d,t}^\alpha n_{d,t}^{-\alpha} - w_t = 0
\\
\Leftrightarrow w_t &= (1-\alpha) a_t k_{d,t}^\alpha n_{d,t}^{-\alpha} = f_n = (1-\alpha) \frac{y_t}{n_{d,t}}
\end{align*}
The real wage must be equal to the marginal product of labor.
Due to the Cobb-Douglas production function it is a constant proportion $(1-\alpha)$ of the ratio of total output to labor.
Simply put, this is the labor demand function.
				
The first-order condition w.r.t. $k_{d,t}$ is given by
\begin{align*}
\frac{\partial {div}_t}{\partial k_{d,t}} &= \alpha a_t k_{d,t}^{\alpha-1} n_{d,t}^{1-\alpha} - r_{k,t} = 0
\\
\Leftrightarrow r_{k,t} &= \alpha a_t k_{d,t}^{\alpha-1} n_{d,t}^{1-\alpha} = f_k = \alpha \frac{y_t}{k_{d,t}}
\end{align*}
The real rental rate for capital must be equal to the marginal product of capital.
Due to the Cobb-Douglas production function it is a constant proportion $\alpha$ of the ratio of total output to capital.
Simply put, this is the capital demand function.

\item Making use of clearing of labor and capital markets implies that the firm's profits in the optimum are given by:
\begin{align*}
{div}_t &= y_t - w_t n_{t} - r_{k,t} k_{t-1} = y_t - (1-\alpha)y_t - \alpha y_t = 0
\\
\Leftrightarrow y_t &= w_t n_{t} + r_{k,t} k_{t-1}
\end{align*}
Insert into the budget restriction of the households yields:
\begin{align*}
c_t + i_t = w_t n_{t} + r_{k,t} k_{t-1} + {div}_t = y_t
\end{align*}
This is a manifestation of Walras law: if 2 out of 3 markets are cleared, the last market must clear as well.

\item First, consider the steady-state value of technology:
\begin{align*}
\log{a}&=\rho_a \log{a} + 0 \Leftrightarrow \log{a} = 0
\\
\Leftrightarrow a &= 1 
\end{align*}
The Euler equation in steady-state becomes:
\begin{align*}
U_c &= \beta U_c (1-\delta+r_k)
\\
\Leftrightarrow r_k &= \frac{1}{\beta} + \delta - 1
\end{align*}
Next we will provide recursively closed-form expressions for all variables in terms of steady-state labor.
That is the right-hand sides of the following equations are given in terms of parameters or previously computed expressions.
\begin{itemize}
	\item The firms demand for capital in steady-state becomes
	\begin{align*}
	r_k &= \alpha a k^{\alpha-1} n^{1-\alpha}
	\\
	\Leftrightarrow \frac{k}{n} &= \left(\frac{\alpha a}{r_k}\right)^{\frac{1}{1-\alpha}}
	\end{align*}
	\item The firms demand for labor in steady-state becomes:
	\begin{align*}
	w = (1-\alpha) a k^\alpha n^{-\alpha} = (1-\alpha)a \left(\frac{k}{n}\right)^\alpha
	\end{align*}
	\item The law of motion for capital in steady-state implies
	\begin{align*}
	\frac{i}{n} &= \delta\frac{k}{n}
	\end{align*}
	\item The production function in steady-state becomes
	\begin{align*}
	\frac{y}{n} = a \left(\frac{k}{n}\right)^\alpha
	\end{align*}
	\item The clearing of the goods market in steady-state implies 
	\begin{align*}
	\frac{c}{n} = \frac{y}{n} - \frac{i}{n}
	\end{align*}
\end{itemize}
Now, we have expressions for all variables as a ratio to steady-state labor.
Hence, once we compute $n$, we can revisit the above expressions to compute all values in closed-form.
Due to the log-utility function, we can actually derive a closed-form expression for $n$.
To this end, set labor demand equal to labor supply and express the right hand side in terms of previously computed expressions.
\begin{align*}
\psi \frac{1}{1-n} &= \gamma c^{-1} w
\\
\Leftrightarrow \psi \frac{n}{1-n} &= \gamma \left(\frac{c}{n}\right)^{-1} w
\\
\Leftrightarrow n &= (1-n)\frac{\gamma}{\psi} \left(\frac{c}{n}\right)^{-1} w
\\
\Leftrightarrow n &= \frac{\frac{\gamma}{\psi} \left(\frac{c}{n}\right)^{-1} w}{1+\frac{\gamma}{\psi} \left(\frac{c}{n}\right)^{-1} w}
\end{align*}
Now we have $n$, so it is straightforward to compute the missing steady-state values, i.e.
\begin{align*}
c = \frac{c}{n} n,\qquad
i = \frac{i}{n} n,\qquad
k = \frac{k}{n} n,\qquad	
y = \frac{y}{n} n
\end{align*}

\item The transversality condition for an infinite horizon dynamic optimization problem is the boundary condition
  determining a solution to the problem's first-order conditions together with the initial condition.
The transversality condition requires the present value of the state variables (here $k_t$ and $a_t$) to converge to zero as the planning horizon recedes towards infinity.
The first-order and transversality conditions are sufficient to identify an optimum in a concave optimization problem.
Given an optimal path, the necessity of the transversality condition reflects the impossibility of finding an alternative feasible path
  for which each state variable deviates from the optimum at each time and increases discounted utility.
These conditions are implicit only, we don't enter them in a computer program.
But implicitly we do consider them when we focus on unique and stable solutions or when we pick certain steady-state values.
	
\item General hints: construct and parameterize the model such, that it corresponds to certain properties of the true economy.
One often uses steady-state characteristics for choosing the parameters in accordance with observed data.
For instance, long-run averages (wages, hours worked, interest rates, inflation, consumption-shares, government-spending-ratios, etc.) are used 
  to target certain steady-state values of the endogenous variables, which implies certain values for some parameters.\footnote{
These are often referred to as \emph{great ratios}; however, the econometric literature is not in agreement as to whether these average values are indeed stable.
Nevertheless, this is often assumed.
  }
You can also use micro-studies, however, one has to be careful about the aggregation.
			
We will focus on OECD countries and discuss one \enquote{possible} way to calibrate the model parameters (there are many other ways):
\begin{itemize}
\item[$\boldsymbol{\alpha}$] productivity parameter of capital.
Due to the Cobb Douglas production function thus should be equal to the proportion of capital income to total income of economy.
So, one looks inside the national accounts for OECD countries and sets $\alpha$ to 1 minus the share of labor income over total income.
For most OECD countries this implies a range of 0.25 to 0.40.
\item[$\boldsymbol{\beta}$] subjective intertemporal preference rate of households:
  it is the value of future utility in relation to present utility.
Usually this parameter takes a value slightly less than unity, indicating that agents discount the future.
For quarterly data, we typically set it around 0.99 and for yearly data 0.96.
These values imply a certain steady-state real rental rate.
To see this, re-consider the Euler equation in steady-state: $\beta = \frac{1}{r_k+1-\delta}$ where $r_k= \alpha \frac{y}{k}$.
Looking at OECD data one usually finds that the average capital productivity $k/y$ is in the range of $9$ to $11$.
\item[$\boldsymbol{\delta}$] depreciation rate of capital stock.
For quarterly data the literature uses values in the range of 0.02 to 0.03, for yearly data you often find 0.10.
Again let's use a steady-state relationship to get a reasonable value.
That is, $\delta=\frac{i}{k}=\frac{i/y}{k/y}$.
For OECD data one usually finds an average ratio of investment to output, $i/y$, around 0.25.
\item[$\boldsymbol{\gamma}$ and $\boldsymbol{\psi}$] households's preference regarding consumption and leisure.
Often a certain interpretation in terms of elasticities of substitutions is possible.
In the RBC model, we can make use of the FOCs in steady-state, i.e.
\begin{align*}
\frac{\psi}{\gamma} = w\frac{(1-n)}{c}= (1-\alpha)\left(\frac{k}{n}\right)^\alpha\frac{(1-n)}{c} = (1-\alpha)\left(\frac{k}{n}\right)^\alpha\frac{\frac{1}{n}(1-n)}{\frac{c}{n}}
\end{align*}
Note that $c/n$ as well as $k/n$ are given in terms of already calibrated parameters (see steady-state computations).
Therefore, one possible way is to normalize one of the parameters to unity (e.g. $\gamma=1$)
  and calibrate the other one $\psi$ in terms of steady-state ratios.
We would, however, need to fix a value for time devoted to work in steady-state $n$.
In the specification of the utility function, we see that labor is normalized to be between 0 and 1,
  so targeting 8 hours a day implies $n=8/24=1/3$.
\item[$\boldsymbol{\rho_A}$ and $\boldsymbol{\sigma_A}$] parameters of process for total factor productivity.
These do not influence the steady-state values, but the dynamics of the model.
Often you can calibrate these by e.g. estimating the Cobb-Douglas production function with OLS and then compute the Solow residuals.
Then look at the persistence and standard error of the residuals.
Typically we find that $\rho_A$ is mostly set around 0.9 to reflect persistence of the technological process
  and $\sigma_A$ around $0.6$ in the simple RBC model.
\end{itemize}
\item The function might look like this:
\lstinputlisting[style=Matlab-editor,basicstyle=\mlttfamily\scriptsize,title=\lstname]{progs/matlab/rbc_logutil_ss.m}
You can try it out with the following parametrization:
\lstinputlisting[style=Matlab-editor,basicstyle=\mlttfamily\scriptsize,title=\lstname]{progs/matlab/rbc_logutil_ss_test.m}
\item The mod file might look like this:
\lstinputlisting[style=Matlab-editor,basicstyle=\mlttfamily\scriptsize,title=\lstname]{progs/dynare/rbc_logutil.mod}
Obviously, the results are the same.
\item
\begin{enumerate}
	\item  For the first-order conditions of the household we now use
	\begin{align*}
	U_{c,t} &= \gamma c_t^{-\eta_c}
	\\
	U_{n,t} &= - \psi (1-n_t)^{-\eta_l}
	\end{align*}
	The steady-state for labor changes to
	\begin{align*}
	w \gamma \left(\frac{c}{n}\right)^{-\eta_c} &= \psi(1-n)^{-\eta_l}n^{\eta_c}
	\end{align*}
	This cannot be solved for $n$ in closed-form.
	Rather, we need to condition on the values of the parameters and use a numerical optimizer to solve for $n$.
	\item The function might look like this:
	\lstinputlisting[style=Matlab-editor,basicstyle=\mlttfamily\scriptsize,title=\lstname]{progs/matlab/rbc_ss.m}
	You can try it out with the following parametrization (same as in the Dynare mod file):
	\lstinputlisting[style=Matlab-editor,basicstyle=\mlttfamily\scriptsize,title=\lstname]{progs/matlab/rbc_ss_test.m}
	\item In Dynare we could use the following mod file:
	\lstinputlisting[style=Matlab-editor,basicstyle=\mlttfamily\scriptsize,title=\lstname]{progs/dynare/rbc_ces.mod}
	and the following helper function:
	\lstinputlisting[style=Matlab-editor,basicstyle=\mlttfamily\scriptsize,title=\lstname]{progs/dynare/rbc_ces_helper_function.m}
	Obviously, the results are the same.
\end{enumerate}

\end{enumerate}