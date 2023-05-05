\begin{center}
\begin{longtable}{lc}
\caption{Dynamic Model Equations}
\label{tbl:RBC.Model}\\%
\hline%
\multicolumn{1}{c}{\textbf{Equation}} &
\multicolumn{1}{c}{\textbf{Description}}\\%
\hline\hline%
\endfirsthead
\multicolumn{2}{c}{{\tablename} \thetable{} -- Continued}\\%
\hline%
\multicolumn{1}{c}{\textbf{Variable}} &
\multicolumn{1}{c}{\textbf{Description}}\\%
\hline\hline%
\endhead
${{\gamma}}\, {{c}}_{t}^{-1}={{\gamma}}\, {{\beta}}\, {{c}}_{t+1}^{-1}\, \left(1-{{\delta}}+{{r}}_{t+1}\right)$ & intertemporal optimality (Euler)
\\
${{w}}_{t}=-\frac{-{{\psi}}\, \left(1-{{n}}_{t}\right)^{-1}}{{{\gamma}}\, {{c}}_{t}^{-1}}$ & labor supply
\\
${{k}}_{t}=\left(1-{{\delta}}\right)\, {{k}}_{t-1}+{{i}}_{t}$ & capital accumulation
\\
${{y}}_{t}={{c}}_{t}+{{i}}_{t}$ & market clearing
\\
${{y}}_{t}={{a}}_{t}\, {{k}}_{t-1}^{{{\alpha}}}\, {{n}}_{t}^{1-{{\alpha}}}$ & production function
\\
${{w}}_{t}=\left(1-{{\alpha}}\right)\frac{{{y}}_{t}}{{{n}}_{t}}$ & labor demand
\\
${{r}}_{t}={{\alpha}}\frac{{{y}}_{t}}{{{k}}_{t-1}}$ & capital demand
\\
$\log\left({{a}}_{t}\right)= (1-\rho) log(a) + {{\rho}}\, \log\left({{a}}_{t-1}\right)+{{\varepsilon}}_{t}$ & total factor productivity
\\
\bottomrule%
\end{longtable}
\end{center}
    
\begin{minipage}{.5\linewidth}
\begin{center}
\begin{longtable}{cc}
\caption{Variables}
\label{tbl:RBC.Variables}\\%
\hline%
\multicolumn{1}{c}{\textbf{Variable}} &
\multicolumn{1}{c}{\textbf{Description}}\\%
\hline\hline%
\endfirsthead
\multicolumn{2}{c}{{\tablename} \thetable{} -- Continued}\\%
\hline%
\multicolumn{1}{c}{\textbf{Variable}} &
\multicolumn{1}{c}{\textbf{Description}}\\%
\hline\hline%
\endhead
${y}$ & output\\
${c}$ & consumption\\
${k}$ & capital\\
${n}$ & labor\\
${a}$ & productivity\\
${r}$ & interest Rate\\
${w}$ & wage\\
${i}$ & investment\\
${\varepsilon}$ & productivity Shock\\
\bottomrule%
\end{longtable}
\end{center}
\end{minipage}%
\begin{minipage}{.5\linewidth}
\begin{center}
\begin{longtable}{ccc}
\caption{Parameter Values}
\label{tbl:RBC.Parameters}\\%
\toprule%
\multicolumn{1}{c}{\textbf{Parameter}} &
\multicolumn{1}{c}{\textbf{Value}} &
\multicolumn{1}{c}{\textbf{Description}}\\%
\midrule%
\endfirsthead
\multicolumn{3}{c}{{\tablename} \thetable{} -- Continued}\\%
\midrule%
\multicolumn{1}{c}{\textbf{Parameter}} &
\multicolumn{1}{c}{\textbf{Value}} &
    \multicolumn{1}{c}{\textbf{Description}}\\%
\midrule%
\endhead
${\beta}$ 	 & 	 0.990 	 & 	 discount factor\\
${\delta}$ 	 & 	 0.025 	 & 	 depreciation rate\\
${\gamma}$ 	 & 	 1.000 	 & 	 consumption utility weight\\
${\psi}$ 	 & 	 1.600 	 & 	 labor disutility weight\\
${\alpha}$ 	 & 	 0.350 	 & 	 output elasticity of capital\\
${\rho}$ 	 & 	 0.900 	 & 	 persistence technology\\
$A$          &   10      &   normalization for steady-state $a$\\
\bottomrule%
\end{longtable}
\end{center}
\end{minipage} 