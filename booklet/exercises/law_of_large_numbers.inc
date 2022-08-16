\section[Law Of Large Numbers]{Law Of Large Numbers\label{ex:LawOfLargeNumbers}}
Let $Y_{1},Y_{2},\ldots $ be an i.i.d. sequence of arbitrarily distributed random variables with finite variance $\sigma_Y ^{2}$ and expectation $\mu$. Define the sequence of random variables
\begin{equation*}
\overline{Y}_{T}=\frac{1}{T}\sum_{t=1}^{T}Y_{t}
\end{equation*}
\begin{enumerate}
	\item Briefly outline the intuition behind the \enquote{law of large numbers}.
 	\item Write a program to illustrate the law of large numbers for uniformly distributed random variables (you may also try different distributions such as normal, gamma, geometric, student's t with finite or infinite variance). To this end, do the following:
 	\begin{itemize}
 		\item Set $T=10000$ and initialize the $T \times 1$ output vector $u$.
 		\item Choose values for the parameters of the uniform distribution. Note that $E[u] = (a+b)/2$, where $a$ is the lower and $b$ the upper bound of the uniform distribution.
 		\item For $t=1,...,T$ do the following computations:
 		\begin{itemize}
 			\item Draw $t$ random variables from the uniform distribution with lower bound $a$ and upper bound $b$.
 			\item Compute and store the mean of the drawn values in your output vector at position $t$.
 		\end{itemize}
 		\item Plot your output vector and add a line to indicate the theoretical mean of the uniform distribution.
 	\end{itemize}
 	\item Now suppose that the sequence $Y_{1},Y_{2},\ldots $ is an $AR(1)$ process:
 	$$Y_{t} =\phi Y_{t-1} +\varepsilon _{t}$$
 	where $\varepsilon _{t}\sim iid(0,\sigma _{\varepsilon }^{2})$ is not necessarily normally distributed and $|\phi |<1$. Illustrate numerically that the law of large numbers still holds despite the intertemporal dependence.
\end{enumerate}

\paragraph{Readings}
\begin{itemize}
	\item \textcite{Ploberger_2010_LawLargeNumbers}
	\item \textcite[Ch. 3]{White_2001_AsymptoticTheoryEconometricians}
\end{itemize}

\begin{solution}\textbf{Solution to \nameref{ex:LawOfLargeNumbers}}
\ifDisplaySolutions
\begin{enumerate}
	\item In probability theory, the law of large numbers (LLN) is a theorem that describes the result of performing the same experiment a large number of times (repetitions, trials, experiments, or iterations). According to the LLN, the average of the results obtained from a large number of trials should be close to the expected value, and will tend to become closer as more trials are performed. The laws of large numbers are the cornerstones of asymptotic theory. In this exercise, the LLN is about determining what happens to $\overline{Y}_T$ as $T\rightarrow\infty$ (note that $\overline{Y}_T$ is a random variable). The LLN states that this series converges to the expected value $\mu$. More precisely, the strong LLN implies that at the limit, we can exactly determine $\mu$. The weak LLN implies that we can only approximately determine $\mu$, even though we can make the approximation very very very close to $\mu$. This implies: 
		\begin{itemize}
			\item Strong LLN means almost-sure convergence: At some point adding more observation does not matter at all for the average, it would be exactly equal to the expected value. That is, the sequence $\overline{Y}_{1},\overline{Y}_{2},\ldots $ of random variables converges \textbf{almost surely} to a variable $\mu$, if
			\begin{equation*}
			Pr\left( \left\{ \lim_{T\rightarrow \infty }\overline{Y}_{T}=\mu\right\} \right) =1
			\end{equation*}
			or simply:
			\begin{equation*}
			\overline{Y}_{T}\overset{a.s.}{\rightarrow }\mu
			\end{equation*}
			This definition of convergence is not very important in econometrics.
				
			\item Weak LLN means that the sample mean converges in probability to the population mean. That is, the sequence $\overline{Y}_{1},\overline{Y}_{2},\ldots $ of random variables converges \textbf{in probability} to a variable $\mu$, if
			\begin{equation*}
				\lim_{T\rightarrow \infty }Pr\left( |Y_{T}-\mu|<\delta \right) =1
			\end{equation*}
			As $T\rightarrow \infty$, the probability is approaching 1 very closely, but it is not actually 1. In other words, the probability that the average is \enquote{far} (more than an arbitrary small number $\delta$) from the expectation $\mu$ is zero. More compactly notation:
			\begin{eqnarray*}
				\overline{Y}_{T} &\overset{p}{\rightarrow }&\mu \\
				\textsl{plim}~\overline{Y}_{T} &=&\mu
			\end{eqnarray*}
			This definition of convergence is very important in econometrics. There exist different theorems that establish necessary and sufficient conditions depending on the process at study. In Quantitative Macroeconomics, we are mainly concerned with identically distributed process that are either independent of each other or homogenously dependent, i.e. autoregressive AR or VAR processes (aka homogeneous Markov processes).
		\end{itemize}
	\item Here is an extended illustration for several distributions: 
	\lstinputlisting{../progs/matlab/LawOfLargeNumbers.m}
	Note that for the $t$-distribution with infinite variance the weak LLN does not apply.
	\item Here is an extended illustration for different error term distributions: 
	\lstinputlisting{../progs/matlab/LawOfLargeNumbersAR1.m} 
	Note that we need to make sure that $E[\varepsilon_t]=0$ when we simulate data. We see that the weak law of large numbers holds under weaker conditions than iid. For instance, one can show that for the stationary AR(1), necessary and sufficient conditions are: $Var[y_t]<\infty$ and $|\gamma(k)| \rightarrow 0$ as $k \rightarrow \infty$. This does not hold for all distributions considered in the code. Particularly, the student's t distribution with 2 degrees of freedom does not have a finite variance.
\end{enumerate}
\fi
\newpage
\end{solution}