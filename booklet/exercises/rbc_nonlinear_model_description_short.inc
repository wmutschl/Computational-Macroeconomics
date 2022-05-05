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
    ${{\gamma}}\, {{C}}_{t}^{-1}={{\gamma}}\, {{\beta}}\, {{C}}_{t+1}^{-1}\, \left(1-{{\delta}}+{{R}}_{t+1}\right)$ & intertemporal optimality (Euler)
    \\
    ${{W}}_{t}=-\frac{-{{\psi}}\, \left(1-{{L}}_{t}\right)^{-1}}{{{\gamma}}\, {{C}}_{t}^{-1}}$ & labor supply
    \\
    ${{K}}_{t}=\left(1-{{\delta}}\right)\, {{K}}_{t-1}+{{I}}_{t}$ & capital accumulation
    \\
    ${{Y}}_{t}={{C}}_{t}+{{I}}_{t}$ & market clearing
    \\
    ${{Y}}_{t}={{A}}_{t}\, {{K}}_{t-1}^{{{\alpha}}}\, {{L}}_{t}^{1-{{\alpha}}}$ & production function
    \\
    ${{W}}_{t}=\left(1-{{\alpha}}\right)\frac{{{Y}}_{t}}{{{L}}_{t}}$ & labor demand
    \\
    ${{R}}_{t}={{\alpha}}\frac{{{Y}}_{t}}{{{K}}_{t-1}}$ & capital demand
    \\
    $\log\left({{A}}_{t}\right)={{\rho^A}}\, \log\left({{A}}_{t-1}\right)+{{\varepsilon^A}}_{t}$ & total factor productivity
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
    ${Y}$ & output\\
    ${C}$ & consumption\\
    ${K}$ & capital\\
    ${L}$ & labor\\
    ${A}$ & productivity\\
    ${R}$ & interest Rate\\
    ${W}$ & wage\\
    ${I}$ & investment\\
    ${\varepsilon^A}$ & productivity Shock\\
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
    ${\rho^A}$ 	 & 	 0.900 	 & 	 persistence technology\\
    \bottomrule%
    \end{longtable}
    \end{center}
    \end{minipage} 