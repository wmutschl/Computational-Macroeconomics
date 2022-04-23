\subsection*{Model description}
Consider a version of the \textcite{Baxter.King_1993_FiscalPolicyGeneral} model.
\paragraph*{Households}
Let $C_t$ denote real consumption, $N_t$ real labor supply and $K_t$ private capital.
The representative household maximizes its expected life-time utility
\begin{align*}
  \max_{C_t,N_t,K_{t-1}} E_t \sum_{t=0}^\infty \beta^t \left[log(C_t)+\theta_l log(1-N_t) + \Gamma(G_t^B,I_t^B)\right]
\end{align*}
subject to
\begin{align*}
  C_t + I_t = (1-\tau_t)(w_t N_t+r_t K_{t-1}) + {TR}_t
\end{align*}
where $\beta$ denotes the discount rate, $\theta_l$ the Frisch elasticity of labor, 
  $w_t$ the real wage, $r_t$ the real interest rate and $TR_t$ real lump-sum transfers.
$\Gamma(G_t^B,I_t^B)$ is a general function of public consumption $G_t^B$
  and public investment $I_t^B$ such that it is non-decreasing in each of its arguments.
Optimality is given by the consumption-leisure choice
\begin{align}
  (1-\tau_t) w_t = \theta_l \frac{C_t}{1-N_t}
\end{align}
and the savings decision
\begin{align}
  \lambda_t = \beta E_t \left\{\lambda_{t+1}\left[(1-\delta) + (1-\tau_{t+1})r_{t+1}\right]\right\}
\end{align}
where
\begin{align}
  \lambda_t = \frac{1}{C_t}
\end{align}
denotes marginal utility of consumption.
The private and public capital stocks evolve according to
\begin{align}
  K_{t} &= (1-\delta)K_{t-1} + I_t\\
  K_{t}^B &= (1-\delta)K_{t-1}^B + I_t^B
\end{align}
with $\delta$ denoting the depreciation rate.
\paragraph*{Firms}
Firms maximize profits by choosing factor inputs according to
\begin{align*}
  \max_{N_t,K_{t-1}} Y_t - w_t N_t - r_t K_{t-1}
\end{align*}
subject to
\begin{align}
  Y_t = z_t (K_{t-1}^B)^\eta (K_{t-1})^\alpha (N_t)^{1-\alpha}
\end{align}
where $\eta$ denotes productivity of public capital and $\alpha$ the share of capital in production.
Taking factor prices as given, factor demand is determined by
\begin{align}
  w_t N_t &= (1-\alpha) Y_t\\
  r_t K_{t-1}&= \alpha Y_t
\end{align}
Productivity evolves according to
\begin{align}
  \log\left(\frac{z_t}{\bar{z}}\right) = \rho_z \log\left(\frac{z_{t-1}}{\bar{z}}\right) +   \varepsilon_t^z
\end{align}
where $\rho_z$ is a smoothing parameter and $\varepsilon_t^{z}\overset{iid}{\sim} N(0,\sigma_{z}^2)$.

\paragraph*{Fiscal authority}
The fiscal authority faces the budget constraint
\begin{align}
  G_t^B + I_t^B + TR_t = \tau_t(w_t N_t + r_t K_{t-1})
\end{align}
and its behavior is described by exogenous AR(1) processes
\begin{align}
  G^B_t-\bar{G^B} &= \rho_{G^B} \left({G^B}_{t-1} - \bar{G^B}\right) +  \varepsilon_t^{G^B}\\
  I^B_t-\bar{I^B} &= \rho_{I^B} \left({I^B}_{t-1} - \bar{I^B}\right) +  \varepsilon_t^{I^B}\\
  \log\left(\frac{\tau_t}{\bar{\tau}}\right) &= \rho_\tau \log\left(\frac{\tau_{t-1}}{\bar{\tau}}\right) +  \varepsilon_t^\tau
\end{align}
where $\rho_{G^B}, \rho_{I^B}, \rho_{\tau}$ are smoothing parameters and
\begin{align*}
\varepsilon_t^{G^B}\overset{iid}{\sim} N(0,\sigma_{G^B}^2), \qquad
\varepsilon_t^{I^B}\overset{iid}{\sim} N(0,\sigma_{I^B}^2), \qquad
\varepsilon_t^\tau\overset{iid}{\sim} N(0,\sigma_{\tau}^2)
\end{align*}
Notice that the inclusion of $TR_t$ implies a balanced budget rule,
  i.e. there is no debt in the model.
\paragraph*{Market clearing}
Market clearing implies that whatever is consumed by households must be produced
\begin{align}
  Y_t = C_t + I_t + G_t^B + I_t^B
\end{align}

\paragraph{Summary}
Overall, the Baxter and King (1993) model can be summarized through equations (1)-(23).
