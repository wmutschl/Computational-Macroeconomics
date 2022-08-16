\section[An and Schorfheide (2007)]{An and Schorfheide (2007)\label{ex:AnScho2007_identif_bk}}
Consider the New Keynesian model of \textcite{An.Schorfheide_2007_BayesianAnalysisDSGE}.
The model equations are given by 
\begin{align}
	1 &= \beta \mathbb{E}_t\left[\left(\frac{c_{t+1}}{c_t}\right)^{-\tau} \frac{1}{\gamma z_{t+1}} \frac{R_t}{\pi_{t+1}}\right] \label{eq:AS_B1}
  \\
  1 &= \phi \left(\pi_t - \pi\right) \left[\left(1-\frac{1}{2\nu}\right)\pi_t + \frac{\pi}{2\nu}\right] - \phi \beta \mathbb{E}_t \left[\left(\frac{c_{t+1}}{c_t}\right)^{-\tau} \frac{y_{t+1}}{y_t} \left(\pi_{t+1} - \pi \right) \pi_{t+1}\right] + \frac{1}{\nu}\left[1-c_t^{\tau}\right]
  \\
  y_t &= c_t + \frac{g_t-1}{g_t} y_t + \frac{\phi}{2} \left({\pi_t - \pi}\right)^2 y_t
  \\
  R_t &= {R_t^{*}}^{1-\rho_R} R_{t-1}^{\rho_R} e^{\sigma_r\epsilon_{R,t}}
  \\
  \ln(z_t) &= \rho_z \ln(z_{t-1}) + \sigma_z\epsilon_{z,t}
  \\
  \ln(g_t) &= (1-\rho_g)\ln(\bar{g}) + \rho_g \ln(g_{t-1}) + \sigma_g\epsilon_{g,t}
  \\
  y_t^* &= (1-\nu)^{\frac{1}{\tau}} g_t
  \end{align}
where $\epsilon_{R,t}$, $\epsilon_{g,t}$ and $\epsilon_{z,t}$ are iid normally distributed with a standard error of 1.
Moreover, we have the following auxiliary parameter relationships:
\begin{align*}
	  \gamma = 1+\frac{\gamma^{Q}}{100}, \qquad
	  \beta = \frac{1}{1+r^{A}/400}, \qquad
	  \bar{\pi} = 1+\frac{\pi^{A}}{400}, \qquad
	  \phi = \tau \frac{1-\nu}{\nu \bar{\pi}^{2}\kappa}
\end{align*}
and one auxiliary variable $R_t^*$:
\begin{align*}
R_t^* &= R \left(\frac{\pi_t}{\bar{\pi}}\right)^{\psi_1} \left(\frac{y_t}{y_t^*}\right)^{\psi_2}
\end{align*}
Note that $y_t^*$ is an endogenous model variable, whereas $\bar{\pi}$ and $\bar{g}$ are parameters and $R$ denotes the steady-state of $R_t$.

\paragraph{Parametrization}
If not otherwise stated, use the following parameter values for the exercises:
\begin{align*}
	&\tau=2,\quad
	\kappa=0.33,\quad
	\nu=0.1,\quad
	\rho_g=0.95,\quad
	\rho_z=0.9,\quad	
	r^{A}=1,\quad
	\\
	&\pi^{A}=3.2,\quad
	\gamma^{Q}=0.5,\quad
	\bar{g}=1/0.85,\quad
	\sigma_z = \sqrt{0.9},\quad
	\sigma_g=\sqrt{0.36}
  \end{align*}
We will consider two different parametrizations of the monetary policy rule $(\psi_1,\psi_2,\rho_R,\sigma_r)$, one is called \textbf{hawkish}:
\begin{align*}
	&\psi_1=1.5,&& \psi_2=0.125,&& \rho_R = 0.75,&& \sigma_r = \sqrt{0.4}	\\
\end{align*}
and the other one \textbf{dovish}:
\begin{align*}
	&\psi_1=1.043195,&& \psi_2=0.918417,&& \rho_R = 0.792647,&& \sigma_r = \sqrt{0.446783}	
\end{align*}
\newpage
\subsection*{Exercises}

\begin{enumerate}
\item Provide intuition behind each equation of the model.
How are nominal price rigidities modelled?\\\emph{Hint: Have a look at the relevant parts of the underlying paper.}
\item Write a Dynare mod file for this model.
\item Derive the steady state of all model variables analytically and include these in a \texttt{steady\_state\_model} block.
	If you struggle to do that, use an \texttt{initval} block.
\item Calibrate the parameters such that the ratio of steady-state consumption to steady-state output is equal to 90\%.
	For the following exercises, though, revert to the original parametrization.		
\item Investigate the steady-state properties and theoretical moments of the two different parametrizations (dovish vs. hawkish) 
	by running the \texttt{steady} and \texttt{stoch\_simul(order=1)} commands.
	\\
	\emph{Hint: Look at Dynare's output in the command window for the Steady-State values and Theoretical Moments.}
\item Now compare the impulse-response functions of the two different parametrizations (dovish vs. hawkish) for output and inflation
	to a one standard deviation TFP shock and a one standard deviation monetary policy shock.
	Provide intuition for the impulse response functions.
\item The determinacy region is defined as the parameter space for which the Blanchard \& Khan (1980, Econometrica) order and rank conditions are full-filled.
	Dynare's sensitivity toolbox provides means to get a graphical representation of this region
	by drawing randomly from the parameter space and checking the order and rank conditions.
  	Add the following code snippet to your mod file:
\begin{verbatim}
%---------------
%specify parameters for which to map sensitivity
estimated_params;
PSI1, uniform_pdf,,, 0,6; %draw uniformly from 0 to 6
PSI2, uniform_pdf,,,-1,6; %draw uniformly from -1 to 6
RHOR, uniform_pdf,,,-1,1; %draw uniformly from -1 to 1
end;
varobs y pie;
dynare_sensitivity(prior_range=0,stab=1,nsam=2000);		
%---------------
\end{verbatim}	
	which randomly draws $\psi_1 \in [0,6]$, $\psi_2 \in [-1,6]$ and $\rho_R \in [-1,1]$,
	while keeping all other parameter values at their calibrated values.
	Focus on the the plots and explain these.
	What does this imply for the ability of monetary policy to anchor inflation expectations?
	\\
	\emph{Hint: The plots should look similar to Figure \ref{fig:determinacyplots}.}
\item In your opinion, is the monetary policy strategy conducted by the European Central bank hawkish or dovish?
	What about the Federal Reserve?
	Given the insights you gained in this exercise:
	Would it be desirable for policymakers to be rather hawkish or dovish?
\end{enumerate}

\paragraph{Readings}
\begin{itemize}
	\item \textcite{An.Schorfheide_2007_BayesianAnalysisDSGE}
\end{itemize}

\begin{solution}\textbf{Solution to \nameref{ex:AnScho2007_identif_bk}}
\ifDisplaySolutions

\fi
\newpage
\end{solution}