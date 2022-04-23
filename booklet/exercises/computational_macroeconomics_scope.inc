\section[What is Computational Macroeconomics]{What is Computational Macroeconomics\label{ex:ComputationalMacroeconomics}}
Broadly define the scope and research topics of \enquote{Computational Macroeconomics}, 
	  sometimes referred to as \enquote{Numerical Methods in Economics}.
What are the challenges and approaches?

\paragraph{Readings}
\begin{itemize}
	\item \textcite[Part I]{Fernandez-Villaverde.Rubio-Ramirez.Schorfheide_2016_SolutionEstimationMethods}
	\item \textcite[Ch. 1]{Judd_1998_NumericalMethodsEconomics}
	\item \textcite{Maliar.Maliar_2014_NumericalMethodsLargeScale}
	\item \textcite[]{Schmedders.Judd_2014_IntroductionVolumeHandbook}
\end{itemize}

\begin{solution}\textbf{Solution to \nameref{ex:ComputationalMacroeconomics}}
\ifDisplaySolutions
Computational macroeconomics combines (i) modern theoretical macroeconomics 
  (the study of aggregated variables such as economic growth, unemployment and inflation 
  by means of structural macroeconomic models)
  with (ii) state-of-the-art numerical methods (the application of numerical methods by means of algorithms).
To this end, we will focus on the workhorse Dynamic Stochastic General Equilibrium (DSGE) model paradigm,
  and develop the numerical procedures and algorithms required to solve and simulate such models.
Very important: this course is NOT ABOUT HOW TO BUILT structural models,
  but it IS ABOUT HOW TO SOLVE AND SIMULATE such models on a computer.
This enables us to look at abstract macroeconomic concepts, for example:
\begin{itemize}
	\item transmission channels of macroeconomic shocks in linearly vs non-linearly solved models
	\item the short- and long-run effects of a higher inflation target
	\item models with occasionally binding constraints (zero-lower-bound, irreversible investment)
	\item the effects of quantitative easing/tightening (possibly at the zero-lower-bound)
	\item models with precautionary savings and heterogenous agents
	\item fiscal multipliers, is there a difference between linearly vs. non-linearly solved models
	\item models with an increasing probability of a rare disaster (financial crises, pandemic, war)
	\item models with an actual disaster
	\item dynamics of the transition from dirty to green energy
	\item optimal monetary, fiscal and environmental policy
\end{itemize}
	
To study such phenomena we typically cannot use simplified and linearized pen-and-paper models anymore,
  but need to rely on a computer to solve and simulate such models.
The computer basically becomes our lab in which we can conduct experiments
  by changing parameters or running counter-factual scenarios and policies.
This enables us to not only describe but also quantify transmission channels and effects of different economic policies
  in order to provide sound and exact policy analysis and advice.

The computational implementation, however, is often cumbersome and challenging.
Fortunately, modern programming languages make it easier for us to develop algorithms 
  and toolboxes for dealing with structural models in macroeconomics.
There is always a trade-off between model complexity and numerical method complexity.
Sometimes it is easier to simplify slightly your model instead of inventing new numerical methods.
Other times the specific question under study enforces you to develop new algorithms and approaches.
In practice, however, most of the times you don't have to reinvent the wheel; 
  but build on previous approaches, improve algorithms and adapt them in order to answer your research question.
The challenge is often that the codes developed so far are quite model-specific
  and require a high degree of fine-tuning and thus a deep understanding of the underlying algorithms.
Open-Source projects like Dynare aim to provide a model-independent and user-friendly approach;
  but it takes time for the development team of Dynare to catch up with the most recent developments in the literature.

Be warned: there is quite the investment one needs to undergo to study computational macroeconomics
  and there is a huge component of self-teaching involved,
  because most of us lack the required background in computational science, numerics and mathematics.
In fact, most macroeconomists doing research in this area are more or less self-taught (I can attest to this for myself),
  and we are always trying to look across the pond at what the current developments are in computer science and numerical mathematics
  and whether or not these are useful to solve and simulate our structural models.
\fi
\newpage
\end{solution}