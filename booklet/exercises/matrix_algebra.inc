\section[Matrix Algebra]{Matrix Algebra\label{ex:MatrixAlgebra}}
Let
	\begin{align*}
	A = \begin{pmatrix}0.5 &0 &0 \\0.1&0.1&0.3\\0&0.2&0.3 \end{pmatrix} && \Sigma_u = \begin{pmatrix}2.25 & 0 & 0\\ 0 & 1 & 0.5\\ 0 & 0.5 & 0.74 \end{pmatrix} && R = \begin{bmatrix} \cos(\phi) & -\sin(\phi)\\ \sin(\phi) & \cos(\phi) \end{bmatrix}
	\end{align*}
\begin{enumerate}
	\item Compute the eigenvalues of A. What would this imply for the system $y_t = c + A y_{t-1} + u_t$ with $u_t$ being white noise?
 	\item Consider the matrices D: $m\times n$, E: $n\times p$ and F: $p\times k$. Show that $$vec(DEF)=\left(F'\otimes D\right) vec(E),$$ where $\otimes$ is the Kronecker product and $vec$ the vectorization operator.
 	\item Show that R is an orthogonal matrix. Why is this matrix called a rotation matrix?	
 	\item Compute a regular lower triangular matrix $W \in \mathbb{R}^{3 \times 3}$ and a diagonal matrix $\Sigma_\varepsilon \in \mathbb{R}^{3 \times 3}$ such that $\Sigma_u=W \Sigma_\varepsilon W'$.\\Hint: Use the Cholesky factorization $\Sigma_u = P P' = W \Sigma_\varepsilon^{\frac{1}{2}}(W \Sigma_\varepsilon^{\frac{1}{2}})'$.
 	\item Solve the discrete Lyapunov matrix equation $\Sigma_{y} = A\Sigma_{y}A' + \Sigma_{u}$ using
 	\begin{enumerate}
 		\item the Kronecker product and vectorization
 		\item the following iterative algorithm:
 			\begin{align*}
 			\Sigma_{y,0} &= I, A_0 = A, \Sigma_{u,0} = \Sigma_{u}\\
 			\Sigma_{y,i+1} &= A_i \Sigma_{y,i} A_i' + \Sigma_{u,i}\\
 			\Sigma_{u,i+1} &= A_i \Sigma_{u,i} A_i' + \Sigma_{u,i}\\
 			A_{i+1} &= A_i A_i
 			\end{align*}
 			Write a loop until either a maximal number of iterations (say 500) is reached or each element of $\Sigma_{y,i+1}-\Sigma_{y,i}$ is less than $10^{-25}$ in absolute terms.
 	\item Compare both approaches for A and $\Sigma_u$ given above.
 	\end{enumerate}
\end{enumerate}

\paragraph{Readings:}
\begin{itemize}
	\item \textcite[Ch.~4.2]{Anderson.McGrattan.Hansen.EtAl_1996_ChapterMechanicsForming}
	\item \textcite[Ch.~6.7]{Anderson.Moore_2005_OptimalFiltering}
	\item \textcite[Ch.~4.10]{Uribe.Schmitt-Grohe_2017_OpenEconomyMacroeconomics}
\end{itemize}

\begin{solution}\textbf{Solution to \nameref{ex:MatrixAlgebra}}  
\ifDisplaySolutions
\begin{enumerate}
	\item \lstinputlisting{../progs/matlab/MatrixAlgebra_Eigenvalues.m}
	In the univariate AR(1) model we would check whether the autocorrelation coefficient is between -1 and 1, 
	i.e. $|A|<1$, such that $\sum_{j=0}^\infty (AL)^j=1/(1-AL)$ where $L$ is the lag operator.
	In the multivariate case, we want the same thing, i.e. $\sum_{j=0}^\infty (AL)^j=(1-AL)^{-1}$.
	Note that $A$ is a square matrix and taking the power of a matrix is not a trivial task. One convenient way to do so, however, is to consider an eigenvalue decomposition (if it exists): $A= Q \Lambda Q^{-1}$, where $Q$ is the square matrix whose columns contain the eigenvectors $q_i$ corresponding to the eigenvalues $\lambda_i$ found on the diagonal of $\Lambda = [\lambda_i]_{ii}$. Moreover, note that $\Lambda$ is a diagonal matrix and $Q$ is an orthogonal matrix $Q^{-1}=Q'$. Using this decomposition one can show that it is very easy to compute for instance a
	\begin{itemize}
		\item matrix inverse $A^{-1} = Q \Lambda^{-1} Q^{-1}$ where the inverse of $[\Lambda^{-1}]_{ii} = 1/\lambda_i$ is very easy to calculate as it is a diagonal matrix
		\item matrix powers: $A^2=(Q\Lambda Q^{-1})(Q\Lambda Q^{-1})=Q\Lambda (Q^{-1}Q) \Lambda Q^{-1} = Q \Lambda^2 Q^{-1}$ or more generally: $A^j = Q \Lambda^j Q^{-1}$.
	\end{itemize}
	So, for $\sum_{j=0}^\infty (AL)^j=(1-AL)^{-1}$ we need that $\lim_{j\rightarrow \infty}\Lambda^j=0$. As this is a diagonal matrix, this simplifies to looking at each eigenvalue, whether it is between -1 and 1: $|\lambda_i|<1$. In other words, for VAR(1) systems $y_t = c + A y_{t-1} + u_t$ we need to check whether the eigenvalues are inside the unit circle, then the VAR(1) model is said both stable and covariance-stationary.
	\item Example for vectorization and Kronecker product:
		\begin{align*}
			\underbrace{vec\begin{pmatrix} 1&3&2\\1&0&0\\1&2&2 \end{pmatrix}}_{3\times3} = \underbrace{\begin{pmatrix} 1 \\1 \\1 \\3 \\0 \\2 \\2 \\ 0 \\2\end{pmatrix}}_{9\times1}, \qquad 
			\underbrace{\begin{pmatrix} 1&3&2\\1&0&0\\1&2&2 \end{pmatrix}}_{3\times3} \otimes \underbrace{\begin{pmatrix}0&5\\5&0\\1&1 \end{pmatrix}}_{3\times2} =
 			\underbrace{\begin{pmatrix} 1\cdot\begin{pmatrix}0&5\\5&0\\1&1 \end{pmatrix}&3\cdot\begin{pmatrix}0&5\\5&0\\1&1 \end{pmatrix}&2\cdot\begin{pmatrix}0&5\\5&0\\1&1 \end{pmatrix}\\1\cdot\begin{pmatrix}0&5\\5&0\\1&1 \end{pmatrix}&0\cdot\begin{pmatrix}0&5\\5&0\\1&1 \end{pmatrix}&0\cdot\begin{pmatrix}0&5\\5&0\\1&1 \end{pmatrix}\\1\cdot\begin{pmatrix}0&5\\5&0\\1&1 \end{pmatrix}&2\cdot\begin{pmatrix}0&5\\5&0\\1&1 \end{pmatrix}&2\cdot\begin{pmatrix}0&5\\5&0\\1&1 \end{pmatrix}  \end{pmatrix}}_{9\times6}
 		\end{align*}
		 Using this definition, we can show that $vec(DEF) = (F' \otimes D) vec(E)$ using e.g. a symbolic toolbox:
		 \lstinputlisting{../progs/matlab/MatrixAlgebra_KroneckerFormula.m}
		 Of course you can do this on paper as well:		 
 		\begin{align*}
 		DEF &= D \begin{pmatrix} e_1 & e_2 & \dots & e_p \end{pmatrix}
 		\begin{pmatrix}
 		f_{11} &f_{12} &\dots &f_{1k} \\
 		f_{21} &f_{22} &\dots &f_{2k} \\
 		\vdots &\vdots &\vdots &\vdots\\
 		f_{p1} &f_{p2} &\dots &f_{pk}
 		\end{pmatrix}\\
 		&= D \underbrace{\begin{pmatrix} e_1f_{11}+e_2f_{21}+\dots+e_p f_{p1},& e_1f_{12}+e_2f_{22}+\dots+e_p f_{p2}, & \dots ,& e_1f_{1k}+e_2f_{2k}+\dots+e_p f_{pk}\end{pmatrix}}_{n\times k}
 		\end{align*}
		
 		\begin{align*}
 		vec(DEF) &= \begin{pmatrix} f_{11}D e_1 +f_{21}D e_2+\dots+ f_{p1}D e_p\\ f_{12}D e_1+f_{22} D e_2 + \dots +  f_{p2} D e_p \\ \vdots \\ f_{1k} D e_1+ f_{2k} D e_2 +\dots+ f_{pk} D e_p  \end{pmatrix}
 		= \begin{pmatrix} f_{11}D &  f_{21}D  & \dots & f_{p1}D \\ f_{12}D  & f_{22} D & \dots & f_{p2} D\\ \vdots & \vdots &\vdots&\vdots \\ f_{1k}D & f_{2k} D &\dots& f_{pk} D  \end{pmatrix} \begin{pmatrix} e_1\\e_2\\ \vdots\\e_p\end{pmatrix}\\
 		&= \left(F'\otimes D\right) vec(E)
 		\end{align*}
	\item An orthogonal matrix is characterized by $R'=R^{-1}$ and therefore $R'R=R R' = I$. Here:
		 \begin{align*}
			  R'R = \begin{pmatrix}
			  (\cos(\phi))^2 + (\sin(\phi))^2 & -\cos(\phi)\sin(\phi) + \sin(\phi)\cos(\phi)\\-\sin(\phi)\cos(\phi) + \cos(\phi)\sin(\phi) & (\sin(\phi))^2 + (\cos(\phi))^2
			  \end{pmatrix}
			  \end{align*}
		 with $(\cos(\phi))^2 + (\sin(\phi))^2 = 1$ (so-called trigonometric Pythagoras).
		 
		 \lstinputlisting{../progs/matlab/MatrixAlgebra_Rotation.m}
		 
		 Why rotation matrix? A rotation matrix rotates vectors or objects in the Euclidian space without stretching or shrinking it.
		 \begin{center}  \includegraphics[width=.5\textwidth]{graphs/Rotation.png} \end{center}
		 In this example the matrix R rotates the vector counter-clockwise given angle $\phi$. An active rotation means that the vector is multiplied by the rotation matrix and this rotates the vector counterclockwise $x' = Rx$. A passive rotation means that the coordinate system is rotated and therefore the vector is also rotated: $x' = R^{-1} x$. Later on we will need rotation matrices for identification of structural shocks!
	\item \lstinputlisting{../progs/matlab/MatrixAlgebra_Cholesky.m}
		\begin{align*}
	 		\underbrace{\begin{pmatrix}1&0&0\\0&1&0\\0&0.5&1\end{pmatrix}}_W \underbrace{\begin{pmatrix}2.25&0&0\\0&1&0\\0&0&0.49\end{pmatrix}}_{\Sigma_\varepsilon} \underbrace{\begin{pmatrix}1&0&0\\0&1&0.5\\0&0&1\end{pmatrix}}_{W'} = \underbrace{\begin{pmatrix}2.25&0&0\\0&1&0.5\\0&0.5&0.74\end{pmatrix}}_{\Sigma}
		\end{align*}
	\item Solving this equation can be done either analytically or using an algorithm:
	\begin{enumerate}
		\item Analytically:
			\begin{align*}
				vec(\Sigma_y) &= vec(A \Sigma_y A') + vec(\Sigma_u) = (A \otimes A)vec(\Sigma_y) + vec(\Sigma_u)\\
				(I-A\otimes A)vec(\Sigma_y) &= vec(\Sigma_u)\\
				vec(\Sigma_y) &= (I-A\otimes A)^{-1}vec(\Sigma_u)
			\end{align*}
		\item Doubling algorithm:
		\lstinputlisting{../progs/matlab/dlyapdoubling.m}
		The basic idea of the doubling algorithm is to start at some $\Sigma_{y,0}$ and find new values for $\Sigma_{y,i+1}$ using the equation $A \Sigma_{y,i} A' + \Sigma_u$ until the difference $\Sigma_{y,i+1} - \Sigma_{y,i}$ becomes very small or a certain number of iterations is reached. The doubling algorithm, however, allows one to pass in one iteration from $\Sigma_{y,i}$ to $\Sigma_{y,2i}$ rather than $\Sigma_{y,i+1}$, provided that one updates three other matrices. There are also other (generalized) algorithms to solve such matrix Lyapunov (or Sylvester) equations.
		\item Comparison:
		\lstinputlisting{../progs/matlab/MatrixAlgebra_Lyapunov.m}
	\end{enumerate}
		
\end{enumerate}
\fi
\newpage
\end{solution}