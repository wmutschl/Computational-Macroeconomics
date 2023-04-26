\begin{enumerate}

\item Declaration of variables and parameters:
    \begin{itemize}
    \item \textbf{Endogenous variables}:
    Output $Y_t$,
    consumption $C_t$,
    private investment $I_t$,
    basic government spending $G^B_t$,
    government investment $I_t^G$,
    private capital stock $K_t$, 
    public capital stock $K_t^G$,
    real rental rate of private capital $r_{K,t}$,
    real wage $w_t$, income tax rate $\tau_t$,
    fiscal transfers $TR_t$
    and labor $n_t$.
    Note that we have 12 equations, so we should also have 12 endogenous variables.
    \item \textbf{Exogenous variables}:
    Government spending shock $\varepsilon_t^{G^B}$,
    government investment shock $\varepsilon_t^{I^G}$,
    tax rate shock $\varepsilon_t^{\tau}$.
    \item \textbf{Parameters:}
    Discount factor $\beta$,
    public capital productivity $\theta_G$,
    private capital productivity $\theta_K$
    labor productivity $\theta_L$,
    utility leisure weight $\theta_L$,
    capital depreciation rate $\delta$,
    persistence parameter government spending rule $\rho_{G^B}$,
    persistence parameter government investment rule $\rho_{I^G}$,
    persistence parameter tax rule $\rho_{\tau}$,
    target value government spending $\bar{G^B}$,
    target value government investment $\bar{I^G}$,
    target value tax rate $\bar{\tau}$,
    \end{itemize}

\item We have 12 parameters to calibrate.
First, we fix the steady-state of six variables using the provided targets:
\begin{align*}
Y &= \bar{Y} = 1
\\
G^B &= \bar{G}^B = 0.2 \bar{Y} \tag*{(*)}
\\
I^G &= \bar{I}^G = 0.02 \bar{Y} \tag*{(*)}
\\
TR &= \bar{TR} = 0
\\
w &= \bar{w} = 2
\\
N &= \bar{N} = 1/3
\end{align*}
Second, from the labor demand equation in steady-state we have:
\begin{align*}
\theta_K = 1 - \frac{w N}{Y} = 1/3 \tag*{(*)}
\end{align*}
Constant returns to scale over privately provided inputs in the production function implies
\begin{align*}
\theta_N = 1-\theta_K = 2/3 \tag*{(*)}
\end{align*}
Third, public capital productivity $\theta_G$ should be lower than $\theta_K$, so for example:
\begin{align*}
\theta_G = 0.3 \cdot \theta_K = 0.1 \tag*{(*)}
\end{align*}
Fourth, capital depreciation rate is supposed to be 2.5\%:
\begin{align*}
\delta_K = 0.025 \tag*{(*)}
\end{align*}
Then evaluating the public capital accumulation equation, the production function, private capital accumulation equation, capital demand, market clearing and fiscal budget in steady-state imply:
\begin{align*}
K^G &= \frac{I^G}{\delta_K} = 0.8
\\
K &= \left(\frac{Y}{(K^G)^{\theta_G} N^{\theta_N}}\right)^{\frac{1}{\theta_K}} \approx 9.6231
\\
I &= \delta_K K \approx 0.2406
\\
C &= Y - I - G^B - I^G \approx 0.5394
\\
r_K &= \theta_K \frac{Y}{K} \approx 0.0364
\\
\tau &= \bar{\tau} = \frac{G^B + I^G + TR}{w N + r_K K} \approx 0.2164 \tag*{(*)}
\end{align*}
From the savings decision in steady-state we get
\begin{align*}
\beta = \frac{1}{1-\delta + (1-\tau)r_K} \approx 0.9965 \tag*{(*)}
\end{align*}
Now we can compute the labor utility weight parameter from the labor supply decision:
\begin{align*}
\theta_L = (1-\tau) w \frac{1-N}{C} \approx 1.9369 \tag*{(*)}
\end{align*}
Lastly, the persistence parameters are supposed to be equal to 0.75:
\begin{align*}
\rho_{G^B} &= 0.75 \tag*{(*)}
\\
\rho_{I^G} &= 0.75 \tag*{(*)}
\\
\rho_{\tau} &= 0.75 \tag*{(*)}
\end{align*}
Counting the $*$, we have calibrated the 12 model parameters using the steady-state relationships and the provided targets.

\item The mod file might look like this:
\lstinputlisting[style=Matlab-editor,basicstyle=\mlttfamily\scriptsize,title=\lstname]{progs/dynare/Baxter_King_steady.mod}


\end{enumerate}