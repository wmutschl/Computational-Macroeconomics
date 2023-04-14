\begin{enumerate}
\item General purpose: C/C++, Fortran, Python, Excel.
	Domain-specific: MATLAB, Julia, R, Mathematica, EViews.
\item Every program is a set of instructions, say to add two numbers. 
	Compilers and interpreters take human-readable code and convert it to computer-readable machine code.
	In a compiled language, the target machine directly translates the program.
	In an interpreted language, the source code is not directly translated by the target machine.
	Instead, a different program, aka the interpreter, reads and executes the code.
	Some modern languages like Python can have both compiled and interpreted implementations,
	  but for simplicity's sake it is useful to keep in mind the distinction.
		
	Compiled languages like Fortran, C or C++ are usually fastest, more efficient and more powerful,
	  but they are harder to learn and harder to code in.
	They also require a build step, i.e. they need to be compiled.
	Interpreted languages like Python, Mathematica, MATLAB, R or Julia are slower,
	  but easier to learn and faster to code in.
	Interpreters run through a program line by line and execute each command.
	Interpreted languages tend to be very similar in the syntax,
	  but differ in best practices and concepts.
	
	Interpreted languages were once significantly slower than compiled languages.
	But, with the development of just-in-time (JiT) compilation, that gap is shrinking.
	MATLAB and Julia are two very prominent examples that make use of JiT compilation,
	  that is they combine both worlds.

	You can also make use of e.g. Fortran or C++ code in MATLAB, R, Python or Julia;
	  that is, write very CPU-intensive tasks in a compiled language
	  and use them in an interpreted language.
	
\item Learning a programming language is a huge investment;
	however, once one has knowledge of one, learning another one tends to be easier
	  as they are based on similar principles.
	Try to stick with popular choices as the choice of learning resources and communities
	  that help you learn this language are wider spread,
	  i.e. googling for help is much easier for C++ than for Fortran.
	Often the project you are working on dictates which programming language you should use.
	The general purpose languages can be used in many non-scientific applications,
	  so your investment might payoff in very different fields in the end. 
		
	In scientific computing, particularly in Macroeconomics,
	  we are often faced with CPU intensive problems 
	  and need to prototype models and methods quickly.
	An interpreted language like MATLAB or Julia that does just-in-time compilation
	  is therefore best suited for such tasks.
	Moreover, having some basic knowledge in C++ is advisable
	  to write computational intensive tasks in a compiled language 
	  and reuse this as e.g. so-called MEX files in MATLAB.
	Moreover, looking at legacy code in the last 20-30 years of research done
	  in quantitative and computational Macroeconomics,
	  we see that most was and still is conducted in MATLAB,
	  whereas highly intensive tasks were programmed in Fortran.
	So keep in mind, that you need to understand this legacy codebase.
	Nevertheless, in the last couple of years, researchers in Macroeconomics are really pushing Julia.
	Moreover, new developments like Machine Learning require you to invest in Python.
	For writing scientific reports and papers you should get familiar with Latex and Markdown.
	
	Another issue to consider is the license, cost and support of the language maintainers.
	Most programming languages are free and open-source,
	  others like MATLAB are proprietary and are quite expensive
	  (luckily there are free and open-source clones like Octave available).
	Regardless of the license, having a good governance structure,
	  i.e. a board, cooperation or company driving the development of the language,
	  is very important for the sustainability of the language
	  and for your investment in a computer language.
			
	Lastly, and very importantly, have a look at the toolset available for the languages.
	Which Integrated Development Environment (IDE) do you like best?
	Which text editor do you prefer?
	How good are the debugging capabilities of your chosen environment.
	Things like syntax highlighting, smart indentation, code linting, comparison tools,
	  handling of workspace, etc. are very important.
	Some languages like MATLAB bring their own IDE in one big package and it works very well.
	Others like Julia, Python or C++ can be neatly integrated in a variety of environments;
	  in fact Visual Studio Code has become the leading editor and environment for many languages,
	  but of course there are many other great choices depending on your needs and preferences.
	
	So which computer languages should you devote your time into,
	  if you are interested in computational or quantitative macroeconomics?
	\\
	\textbf{Here is my opinionated advice:}
	\begin{itemize}
		\item Default languages (excellent knowledge): Julia and MATLAB
		\item Data analysis and Machine Learning (advanced knowledge): R and Python
		\item Heavy tasks (basic knowledge): C++ and Fortran
		\item Scientific writing (advanced knowledge): Markdown and Latex
	\end{itemize}
\end{enumerate}