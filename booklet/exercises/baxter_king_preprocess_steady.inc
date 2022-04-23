\section[Fiscal Policy in General Equilibrium: preprocessing and steady-state]{Fiscal Policy in General Equilibrium: preprocessing and steady-state\label{ex:BaxterKingPreprocessSteady}}
\input{exercises/baxter_king_model_description.inc}
\subsection*{Exercises}
Willi, a fellow student, wants to assess how changes in fiscal policy (taxation \& spending) affect the real economy.

\begin{enumerate}
  \item From his class on introductory macroeconomics Willi remembers that 
    as a first step it is always important to distinguish between endogenous and exogenous variables 
	as well as model parameters. Can you help him with that?
  \item Willi is quite clever about calibrating the model parameters.
    In particular, he is interested in targeting steady-state values of the model:
      \begin{center}
       \begin{tabular}{lcc}
         Target & Symbol & Value \\\hline
         steady-state output level          & $\bar{Y}$ & 1 \\
         steady-state public consumption    & $\bar{G^B}$ & 0.2$\bar{Y}$ \\
         steady-state public investment     & $\bar{I^B}$ & 0.02$\bar{Y}$ \\
         steady-state transfers             & $\bar{TR}$ & 0 \\
         steady-state real wage             & $\bar{w}$ & 2\\
         steady-state labor supply          & $\bar{N}$ & 1/3\\
         \hline
       \end{tabular}
        \end{center}

       Furthermore, he thinks that public-capital productivity should be \textbf{lower}
	     than the capital share in production.
	   Regarding the exogenous processes he would like mild persistence ($\rho$'s equal to 0.75)
	   and small shock standard errors of 1\%.
	   Can you provide a calibration for all model parameters meeting his targets 
	   and economic intuition?\\
       \emph{Hint: First, set some reasonable values for $\beta,\delta$ and $\eta$.
	   Then begin with the target values and try to derive the steady-states 
	   of all other endogenous variables and the implied parameter values.}
  \item Willi has heard of the powerful toolbox DYNARE, 
    so he asks you to help him set up this model in DYNARE.
	Write a DYNARE mod-file for this model, commenting each step 
	such that Willi clearly understands each block.
\end{enumerate}

\paragraph{Readings}
\begin{itemize}
	\item \textcite{Baxter.King_1993_FiscalPolicyGeneral}
\end{itemize}

\begin{solution}\textbf{Solution to \nameref{ex:BaxterKingPreprocessSteady}}
\ifDisplaySolutions

\fi
\newpage
\end{solution}