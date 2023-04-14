\section[Quick Tour: MATLAB]{Quick Tour: MATLAB\label{ex:QuickTourMATLAB}}
Install the most recent version of MATLAB with the following Toolboxes:
	Econometrics Toolbox,
	Global Optimization Toolbox,
	Optimization Toolbox,
	Parallel Computing Toolbox,
	Statistics and Machine Learning Toolbox,
	Symbolic Math Toolbox. Open a new script and do the following:
\footnote{If you don't have any previous programming experience,
  I would highly recommend to go through
  \textcite[Appendix A]{Brandimarte_2006_NumericalMethodsFinance},
  \textcite[Appendix B]{Miranda.Fackler_2002_AppliedComputationalEconomics},
  and \textcite{Pfeifer_2017_MATLABHandout}.}

\begin{enumerate}
	\item Define the column vectors
	\begin{align*}
		x &=\left( -1,0,1,4,9,2,1,4.5,1.1,-0.9\right)' && y =\left( 1,1,2,2,3,3,4,4,5,\text{nan}\right)'
	\end{align*}
	\item Check if both vectors have the same length using either \texttt{length()} or \texttt{size()}. 
	\item Perform the following logical operations:
	\begin{align*}
		x &<y &&
		x <0 &&
		x+3 \geq 0 &&
		y <0
	\end{align*}
	\item Check if all elements in x satisfy both $x+3\geq 0$ and $y>0$.
	\item Check if all elements in x satisfy either $x+3\geq 0$ or $y>0$.
	\item Check if at least one element of $y$ is greater than $0$.
	\item Compute $x+y$, $xy$, $xy'$, $x'y$, $y/x$, and $x/y$.
	\item Compute the element-wise product and division of $x$ and $y$.
	\item Compute $\ln (x)$ and $e^x$.
	\item Use \texttt{any} to check if the vector $x$ contains elements	satisfying $\sqrt{x}\geq 2$.
	\item Compute
	$a =\sum_{i=1}^{10}x_{i}$ and $b =\sum_{i=1}^{10}y_{i}^{2}$.
	Omit the nan in $y$ when computing the sum.
	\item Compute $\sum_{i=1}^{10}x_{i}y_{i}^{2}$.
	Omit the nan in $y$ when computing the sum.
	\item Count the number of elements of $x>0$.
	\item Predict what the following commands will return:
	\begin{verbatim}x.^y  	x.^(1/y)  	log(exp(y))  	y*[-1,1]  	x+[-1,0,1]   sum(y*[-1,1],1,'omitnan') \end{verbatim} 	
	\item Define the matrix
 	$X=\begin{pmatrix}
 	1 & 4 & 7 \\ 
 	2 & 5 & 8 \\ 
 	3 & 6 & 9
 	\end{pmatrix}$.
	Print the transpose, dimensions and determinant of $X$.
	\item Compute the trace of $X$ (i.e. the sum of its diagonal elements).
	\item Change the diagonal elements of $X$ to [7,8,9].
	\item Compute the eigenvalues of (the new) $X$.
	Display a message if $X$ is positive or negative definite.
	\item Invert $X$ and compute the eigenvalues of $X^{-1}$.
	\item Define the column vector $a=(1,3,2)'$ and compute \texttt{a'*X}, \texttt{a'.*X}, and \texttt{X*a}.
	\item Compute the quadratic form $a^{\prime }Xa$.
	\item Define the matrices
 		$I=\left[ 
 		\begin{array}{lll}
 		1 & 0 & 0 \\ 
 		0 & 1 & 0 \\ 
 		0 & 0 & 1
 		\end{array}
 		\right]$,
 		$Y=\left[ 
 		\begin{array}{lll}
 		1 & 4 & 7 \\ 
 		2 & 5 & 8 \\ 
 		3 & 6 & 9
 		\end{array}
 		\begin{array}{lll}
 		1 & 0 & 0 \\ 
 		0 & 1 & 0 \\ 
 		0 & 0 & 1
 		\end{array}
 		\right]$ and $Z=\left[ 
 		\begin{array}{lll}
 		1 & 4 & 7 \\ 
 		2 & 5 & 8 \\ 
 		3 & 6 & 9 \\
 		1 & 0 & 0 \\ 
 		0 & 1 & 0 \\ 
 		0 & 0 & 1
 		\end{array}
 		\right]$.
	\item Generate the vectors
	\begin{align*}
 		x_{1} &=\left( 1,2,3,\ldots ,9\right) ,&&
 		x_{2} =\left( 0,1,0,1,0,1,0,1\right) ,&&
 		x_{3} =\left( 1,1,1,1,1,1,1,1\right) \\
 		x_{4} &=\left( -1,1,-1,1,-1,1\right) ,&&
 		x_{5} =\left( 1980,1985,1990,\ldots ,2010\right) ,&&
 		x_{6} =\left( 0,0.01,0.02,\ldots ,0.99,1\right)
	\end{align*}
	using sequence operator \texttt{:} or \texttt{repmat}.
	\item Generate a grid of $n=500$ equidistant points on the interval $[-\pi,\pi ]$ using \texttt{linspace}.
	\item Compare \texttt{1:10+1}, \texttt{(1:10)+1} and \texttt{1:(10+1)}.	
	\item Define the following column vectors
 		\begin{align*}
 		x&=
 		\begin{pmatrix}
 		1 &
 		1.1 & 
 		9 & 
 		8 & 
 		1 & 
 		4 & 
 		4 & 
 		1
 		\end{pmatrix} ,\quad y=
 		\begin{pmatrix}
 		1 & 
 		2 & 
 		3 & 
 		4 & 
 		4 & 
 		3 & 
 		2 & 
 		\text{NaN}
 		\end{pmatrix}'
		 \\ z&=
 		\begin{pmatrix}
 		true & 
 		true & 
 		false & 
 		false & 
 		true & 
 		false & 
 		false & 
 		false
 		\end{pmatrix}'
 		\end{align*}
 	\item Predict what the following commands will return (and then check if you are right):\\
 	\texttt{x(2:5)}, \texttt{x(4:end-2)}, \texttt{x([1 5 8])}, \texttt{x(repmat(1:3,1,4))},\\
	 \texttt{y(z)}, \texttt{y(\textasciitilde z)}, \texttt{y(x>2)}, \texttt{y(x==1)},\\
	 \texttt{x(\textasciitilde isnan(y))}, \texttt{y(\textasciitilde isnan(y))}
	\item Indexing is not only used to read certain elements of a vector but also to change them.
	Execute \texttt{x2 = x} to make a copy of \texttt{x}. Change all elements of \texttt{x2} that have the value $4$ to the value $-4$. Print \texttt{x2}.
	\item Change all elements of \texttt{x2} that have the value 1 to a missing value (\texttt{nan}). Print \texttt{x2}.
	\item Execute \texttt{x2(z) = []}. Print \texttt{x2}.
	\item Define the matrix $M = \begin{pmatrix}
		1&     5&     9&    12&     8&     4\\
		2&     6&    10&    11&     7&     3\\
		3&     7&    11&    10&     6&     2\\
		4&     8&    12&     9&     5&     1 \end{pmatrix}$
		using the $:$ operator and the \texttt{reshape} command.
	\item Predict what the following commands will return (and then check if you are right):\\
	\texttt{M(1,3)},
	\texttt{M(:,5)},
	\texttt{M(2,:)},
	\texttt{M(2:3,3:4)},
	\texttt{M(2:4,4)},
	\texttt{M(M>5)},
	\texttt{M(:,M(1,:)<=5)},
	\texttt{M(M(:,2)>6,:)},
	\texttt{M(M(:,2)>6,4:6)}
	\item Print all rows of $M$ where column 5 is at least three times larger than column 6.
	\item Count the number of elements of $M$ that are larger than 7.
	\item Count the number of elements of $M$ in row 2 that are smaller than their neighbors in row 1.
	\item Count the number of elements of $M$ that are larger than their left neighbor.
\end{enumerate}


\paragraph{Readings}
\begin{itemize}
	\item \textcite[Appendix A]{Brandimarte_2006_NumericalMethodsFinance}.
	\item \textcite[Appendix B]{Miranda.Fackler_2002_AppliedComputationalEconomics}.
	\item \textcite{Pfeifer_2017_MATLABHandout}
\end{itemize}

\begin{solution}\textbf{Solution to \nameref{ex:QuickTourMATLAB}}
\ifDisplaySolutions
\input{exercises/matlab_quick_tour_solution.inc}
\fi
\newpage
\end{solution}