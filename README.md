# Teaching material for a course on *Computational Macroeconomics* on a graduate level (Master or PhD)

Please feel free to use this for teaching or learning purposes; however, taking into account the [GPL 3.0 license](https://choosealicense.com/licenses/gpl-3.0/).

If you spot mistakes, let me know by opening an issue or write me an email to [willi@mutschler.eu](mailto:willi@mutschler.eu).

## General
The course is aimed at advanced students of economics, especially master students and early PhD candidates who are interested in state-of-the-art numerical methods and current developments in computational macroeconomics.

We cover modern theoretical macroeconomics and combine it with state-of-the-art numerical methods to study abstract macroeconomic concepts such as optimal monetary, fiscal and environmental policy,  occasionally binding constraints (zero-lower-bound, irreversible investment), quantitative easing and rare disaster risk. To this end, we use the Dynamic Stochastic General Equilibrium (DSGE) model paradigm, particularly focusing on different variants of the New-Keynesian model, and develop the numerical procedures and algorithms required to solve and simulate such models. Using several examples from the literature the theoretical and methodological foundations of computational macroeconomics is taught.

## Prerequisites
Basic undergraduate knowledge of macroeconomics as well as econometrics are required. Programming skills in a scripting language are advantageous, but not necessary.

University of Tübingen:
- E433 Advanced Macroeconomics I (or similar advanced courses in your Bachelor studies)
- E434 Advanced Macroeconomics II (recommended but not required)
- S411 Advanced Time Series Analysis (recommended but not required)

## Course organization
As Computational Macroeconomics is highly computational, the course is interactive and "hands-on", so there is no formal separation between the lecture and the exercise class. In fact, the entire course is based on assignments and replication of papers, in which we work together to develop key theoretical concepts and then implement and illustrate them algorithmically.

We will first implement this using the user-friendly [Dynare](https://www.dynare.org) software toolkit, but then really dive into the code and program the required algorithms ourselves in [MATLAB](https://mathworks.com). I highly appreciate if you'd share codes in other computer languages (e.g. Julia, Python or R) to this course.

To this end, we roughly follow the flipped classroom teaching method, meaning that most exercises begin with a theoretical or conceptional question for which material (research papers, book chapters, videos, slides) will be made available. You are required to study this either on your own or, preferably, in a study group. Each week we meet on Wednesdays and Thursdays, alternating between either in person (following current Corona rules) or virtually on Zoom. In these sessions we clarify any questions you have while preparing the materials and then proceed to go through the exercises together. These are largely processed on the computer using Dynare and MATLAB (or any other language you prefer). The solutions to the assignments will be provided with a small time delay.

Please bring a computer with you to the sessions. If you do not have access to a portable computer, please contact the lecturer in advance so that we can organize a device for you.

The "in-person sessions" will also be streamed live, but not recorded.

## Credits and examination

To obtain credits for the course, students are required to actively participate in the class as well as hand in a midterm and endterm exam. Both exams are take-home and must be completed within 7 days. You will have to hand in both analytical derivations, answers to conceptional problems as well as computer code. You are required to work by yourself. Both exams count equally towards the final grade.

## MATLAB and Dynare Installation

Please install MATLAB on your computer (you will require 5-10GB of disk space), following the information provided by the university.
For video tutorials on how to install Dynare with MATLAB you might find [these video tutorials](https://www.youtube.com/playlist?list=PLiN_C6lGtCc_irD9Udf3W-XCJiUENLOpJ) useful.

Please also install the following toolboxes:
- Econometrics Toolbox
- Global Optimization Toolbox
- Optimization Toolbox
- Parallel Computing Toolbox
- Statistics and Machine Learning Toolbox
- Symbolic Math Toolbox

Alternatively, if the closed-source mentality of MATLAB is an irreconcilable issue for you, you can also use the free and open-source alternative [Octave](https://www.gnu.org/software/octave/index). Keep in mind though, that (given my experience) MATLAB is more beginner-friendly and much more performant than Octave.

## Schedule

### Week I: Introductions
**Goals**
- understand the organization of the course
- understand the scope and research topics of *Computational Macroeconomics*

**To Do**
- read the general information
- watch the introductory videos
	- introduction to the course
	- introduction to MATLAB
	- introduction to Dynare
- do exercise sheet 1
- write down all your questions
- participate in the Q&A session
- [schedule a meeting](https://schedule.mutschler.eu)
	- put *I am interested in this course* under *What is the meeting about?*
	- check your emails and cancel the meeting again using the link in the email
	- now you know how easy it is to schedule a meeting with me :-)


### Week II: DSGE models with Dynare, basic programming practice with MATLAB
**Goals**
- get familiar with the RBC model
- practice Dynare
- start programming with MATLAB

**To Do**
- watch the introductory videos
	- RBC Model: Derivation and Preprocessing
	- RBC Model: Steady-State
	- RBC Model: Calibration
- review the solutions from exercise sheet 1.
- TRY (!!!) to do exercise sheet 2
- bring all your questions and concerns to the Q&A sessions
- for immediate help: [schedule a meeting](https://schedule.mutschler.eu)


### Week III: Symbolic Math Toolbox, Algebra of New Keynesian Models

**Goals**
- get familiar with the Symbolic Math Toolbox of MATLAB
- get familiar with the math behind a basic New Keynesian model
- practice Dynare
- understand preprocessing and steady-state computations

**To Do**
- watch the videos
	- Algebra of New Keynesian Models with Calvo price rigidities
	- Steady-state of basic New Keynesian Model with Calvo price rigidities
	- slides and notes
- review the solutions from exercise sheet 2
- TRY (!!!) to do exercise sheet 3 (the solutions are already available)
- bring all your questions and concerns to the in-person meetings
- for immediate help: [schedule a meeting](https://schedule.mutschler.eu)


### Week IV: Preprocessing and steady-state in MATLAB, numerical optimization

**Goals**
- get familiar with the Symbolic Math Toolbox of MATLAB
- get familiar with the preprocessing and steady-state computations with MATLAB
- understand and start using numerical optimizers

**To Do**
- watch the (very short) videos:
	- Introduction to Optimization: What is Optimization
	- Introduction To Optimization: Objective Functions and Decision Variables
	- Introduction To Optimization: Gradients, Constraints, Continuous and Discrete Variables
	- Introduction To Optimization: Gradient Based Algorithms
	- Introduction To Optimization: Gradient Free Algorithms (1/2) - Genetic - Particle Swarm
	- Introduction To Optimization: Gradient Free Algorithms (2/2) Simulated Annealing, Nelder-Mead
	- Introduction to Optimization: Calculating Derivatives
	- Newton's Fractal (which Newton knew nothing about) (Time: 5:55 - 11:16)
Visually Explained: Newton's Method in Optimization
- review the solutions from exercise sheet 3
- do exercise sheet 4
- bring all your questions and concerns to the Q&A meetings
- for immediate help: [schedule a meeting](https://schedule.mutschler.eu)


### Week V: Stochastic and deterministic simulations in Dynare

**Goals**
- get familiar with the concepts of stochastic and deterministic simulations
- run stochastic simulations in Dynare using stoch_simul
- run deterministic simulations in Dynare using perfect_foresight_setup and perfect_foresight_solver
- create own plots for impulse response functions from Dynare outputs with MATLAB commands
- understand the concept of a impulse-response function with examples to technology, monetary and fiscal policy shocks

**To Do**
- watch the video:
	- RBC Baseline Model in Dynare: Deterministic vs Stochastic Simulations
- review the solutions from exercise sheet 4.
- do exercise 1 and 2 on sheet 5, we will do exercise 3 together
- bring all your questions and concerns to the Q&A meetings
- for immediate help: [schedule a meeting](https://schedule.mutschler.eu)


### Week VI: Perturbation Theory

**Goals**
- get the basic idea of the perturbation approach
- understand
	- Dynare's general model framework
	- different typology of variables
	- different orderings of variables
	- decision rules / policy function
	- Jacobian matrices
	- notation used for perturbation approximations

**To Do**
- follow the presentation
- review the solutions from exercise sheet 5
- for immediate help: [schedule a meeting](https://schedule.mutschler.eu)


### Week VII: Perturbation Implementation

**Goals**
- understand the implementation of the perturbation approach in Dynare and MATLAB

**To Do**
- follow the presentation
- for immediate help: [schedule a meeting](https://schedule.mutschler.eu)


### Week VIII: Midterm Exam

**Goals**
- get a good grade

**To Do**
- read the instructions on the exam
- hand in your solutions before DAY, MONTH DD TIME
- for immediate help: [schedule a meeting](https://schedule.mutschler.eu)


### Week IX: Discussion of Midterm Exam and Higher-order perturbation

**Goals**
- understand the solutions to the midterm exam
- get the basic idea of higher-order perturbation approach
- understand the notation and implementation

**To Do**
- try to follow the VERY LONG video presentation
- for immediate help: [schedule a meeting](https://schedule.mutschler.eu)


### Week X: Why higher-order approximation are important: Asset Pricing and Rare Disaster Risk

**Goals**
- understand the Jermann (1998) and the Isore and Szczerbowicz (2017) models
- understand the Dynare implementation (and some hints on where to get them from the web)
- understand the impact on the risk premium from a first, second, and third-order perturbation approximation
- understand the impact of a rare disaster risk shock on the economy from a first, second, and third-order perturbation approximation

**To Do**
- read the papers & get the replication files
- we will discuss the papers and codes in class
- for immediate help: [schedule a meeting](https://schedule.mutschler.eu)


### Week XI: Deterministic Simulations

**Goals**
- understand the objective, approach and algorithm of perfect foresight simulations
- appreciate the flexibility of deterministic simulations
- understand the implementation in Dynare
- include the zero-lower-bound in a New Keynesian model

**To Do**
- go through the deterministic simulation slides
- bring your questions to the Q&A session
- prepare the exercise
- for immediate help: [schedule a meeting](https://schedule.mutschler.eu)


### Week XII: Stochastic Simulations with Occassionaly Binding Constraints (occbin)

**Goals**
- understand the objective, approach and algorithm of occbin
- understand the limitations of occbin
- understand the implementation in Dynare
- include the zero-lower-bound in a stochastic New Keynesian model

**To Do**
- read Guerrieri, Iacoviello (2015) - OccBin: A toolkit for solving dynamic models with occasionally binding constraints easily
- read section 4.14. Occasionally binding constraints (OCCBIN) of Dynare's manual
- for immediate help: [schedule a meeting](https://schedule.mutschler.eu)


### Week XIII: Stochastic Simulations with Occassionaly Binding Constraints (occbin)

**Goals**
- understand the algorithm of occbin
- practice for the endterm

**To Do**
- run and understand the illustration files
- replicate figures 3 and 5 of the Guerrieri and Iacoviello (2015) paper with Dynare
- for immediate help: [schedule a meeting](https://schedule.mutschler.eu)


### Week XIV: Global Solution Methods Overview

**Goals**
- understand the difference between local and global solution methods
- understand the curse of dimensionality
- have a birds-eye-view on recent developments

**To Do**
- go through the projection codes that illustrate the approach for a simple RBC model
- for immediate help: [schedule a meeting](https://schedule.mutschler.eu)



### Week XV-XVI: Endterm Exam

**Goals**
- get a good grade

**To Do**
- download the files
- read the instructions on the exam
- hand in your solutions before MONTH DAY, TIMEpm
- each day check the version number of the exam and the changelog
- for immediate help: [schedule a meeting](https://schedule.mutschler.eu)

## References

Aguirre, A., Danielsson, J., 2020. Which programming language is best for economic research: Julia, Matlab, Python or R?. VOX.EU CEPR Research-based policy analysis and commentary from leading economists. URL [https://voxeu.org/article/which-programming-language-best-economic-research](https://voxeu.org/article/which-programming-language-best-economic-research)

An, S., Schorfheide, F., 2007. Bayesian Analysis of DSGE Models. Econometric Reviews 26, 113–172. [https://doi.org/10.1080/07474930701220071](https://doi.org/10.1080/07474930701220071)

Anderson, B.D.O., Moore, J.B., 2005. Optimal filtering, Dover ed., unabridged republ. ed, Dover books on engineering. Dover Publ, Mineola, NY.

Anderson, E.W., McGrattan, E.R., Hansen, L.P., Sargent, T.J., 1996. Chapter 4 Mechanics of forming and estimating dynamic linear economies, in: Handbook of Computational Economics. Elsevier, pp. 171–252. [https://doi.org/10.1016/S1574-0021(96)01006-4](https://doi.org/10.1016/S1574-0021(96)01006-4)

Andreasen, M.M., 2012. On the effects of rare disasters and uncertainty shocks for risk premia in non-linear DSGE models. Review of Economic Dynamics 15, 295–316. [https://doi.org/10.1016/j.red.2011.08.001](https://doi.org/10.1016/j.red.2011.08.001)

Arellano, C., Maliar, L., Maliar, S., Tsyrennikov, V., 2016. Envelope condition method with an application to default risk models. Journal of Economic Dynamics and Control 69, 436–459. [https://doi.org/10.1016/j.jedc.2016.05.016](https://doi.org/10.1016/j.jedc.2016.05.016)

Aruoba, S.B., Fernández-Villaverde, J., 2015. A comparison of programming languages in macroeconomics. Journal of Economic Dynamics and Control 58, 265–273. [https://doi.org/10.1016/j.jedc.2015.05.009](https://doi.org/10.1016/j.jedc.2015.05.009)

Baxter, M., King, R.G., 1993. Fiscal Policy in General Equilibrium. The American Economic Review 83, 315–334.

Brandimarte, P., 2006. Numerical methods in finance and economics: a MATLAB-based introduction, 2nd ed. ed, Statistics in practice. Wiley Interscience, Hoboken, N.J.

Brock, W.A., Mirman, L.J., 1972. Optimal economic growth and uncertainty: The discounted case. Journal of Economic Theory 4, 479–513. [https://doi.org/10.1016/0022-0531(72)90135-4](https://doi.org/10.1016/0022-0531(72)90135-4)

Calvo, G.A., 1983. Staggered prices in a utility-maximizing framework. Journal of Monetary Economics 12, 383–398. [https://doi.org/10.1016/0304-3932(83)90060-0](https://doi.org/10.1016/0304-3932(83)90060-0)

Coenen, G., McAdam, P., Straub, R., 2008. Tax reform and labour-market performance in the euro area: A simulation-based analysis using the New Area-Wide Model. Journal of Economic Dynamics and Control 32, 2543–2583. [https://doi.org/10.1016/j.jedc.2007.09.007](https://doi.org/10.1016/j.jedc.2007.09.007)

Dixit, A.K., Stiglitz, J.E., 1977. Monopolistic Competition and Optimum Product Diversity. The American Economic Review 67, 297–308.

Durlauf, S.N., Blume, L.E., 2010. Macroeconometrics and time series analysis.

Fernández-Villaverde, J., Rubio-Ramírez, J.F., Schorfheide, F., 2016. Solution and Estimation Methods for DSGE Models, in: Taylor, J.B., Uhlig, H. (Eds.), Handbook of Macroeconomics. Elsevier North-Holland, pp. 527–724.

Galí, J., 2015. Monetary policy, inflation, and the business cycle: an introduction to the new Keynesian framework and its applications, Second edition. ed. Princeton University Press, Princeton ; Oxford.

Gomes, S., Jacquinot, P., Pisani, M., 2012. The EAGLE. A model for policy analysis of macroeconomic interdependence in the euro area. Economic Modelling 29, 1686–1714. [https://doi.org/10.1016/j.econmod.2012.04.002](https://doi.org/10.1016/j.econmod.2012.04.002)

Guerrieri, L., Iacoviello, M., 2015. OccBin: A toolkit for solving dynamic models with occasionally binding constraints easily. Journal of Monetary Economics 70, 22–38. [https://doi.org/10.1016/j.jmoneco.2014.08.005](https://doi.org/10.1016/j.jmoneco.2014.08.005)

Gust, C., Herbst, E., López-Salido, D., Smith, M.E., 2017. The Empirical Implications of the Interest-Rate Lower Bound. American Economic Review 107, 1971–2006. [https://doi.org/10.1257/aer.20121437](https://doi.org/10.1257/aer.20121437)

Hansen, L.P., Sargent, T.J., 2013. Recursive Models of Dynamic Linear Economies. Princeton University Press. [https://doi.org/10.1515/9781400848188](https://doi.org/10.1515/9781400848188)

Heer, B., Maussner, A., 2009. Dynamic general equilibrium modeling: computational methods and applications, 2nd ed., corr. 2nd print. ed. Springer, Dordrecht New York.

Heijdra, B.J., 2017. Foundations of modern macroeconomics, Third edition. ed. Oxford university Press, Oxford.

Herbst, E., Schorfheide, F., 2016. Bayesian Estimation of DSGE Models, The Econometric and Tinbergen Institutes Lectures. Princeton University Press.

Isoré, M., Szczerbowicz, U., 2017. Disaster risk and preference shifts in a New Keynesian model. Journal of Economic Dynamics and Control 79, 97–125. [https://doi.org/10.1016/j.jedc.2017.04.001](https://doi.org/10.1016/j.jedc.2017.04.001)

Jacquinot, P., Pisani, M., Gomes, S., 2010. The EAGLE. A model for policy analysis of macroeconomic interdependence in the euro area. European Central Bank.

Jermann, U.J., 1998. Asset pricing in production economies. Journal of Monetary Economics 41, 257–275. [https://doi.org/10.1016/S0304-3932(97)00078-0](https://doi.org/10.1016/S0304-3932(97)00078-0)

Judd, K.L., 1998. Numerical Methods in Economics. The MIT Press.

Judd, K.L., Maliar, L., Maliar, S., 2017a. Lower Bounds on Approximation Errors to Numerical Solutions of Dynamic Economic Models. Econometrica 85, 991–1012. [https://doi.org/10.3982/ECTA12791](https://doi.org/10.3982/ECTA12791)

Judd, K.L., Maliar, L., Maliar, S., 2011. Numerically stable and accurate stochastic simulation approaches for solving dynamic economic models: Approaches for solving dynamic models. Quantitative Economics 2, 173–210. [https://doi.org/10.3982/QE14](https://doi.org/10.3982/QE14)

Judd, K.L., Maliar, L., Maliar, S., Tsener, I., 2017b. How to solve dynamic stochastic models computing expectations just once: How to solve dynamic stochastic models. Quantitative Economics 8, 851–893. [https://doi.org/10.3982/QE329](https://doi.org/10.3982/QE329)

Judd, K.L., Maliar, L., Maliar, S., Valero, R., 2014. Smolyak method for solving dynamic economic models: Lagrange interpolation, anisotropic grid and adaptive domain. Journal of Economic Dynamics and Control 44, 92–123. [https://doi.org/10.1016/j.jedc.2014.03.003](https://doi.org/10.1016/j.jedc.2014.03.003)

Juillard, M., 2022. Introduction to Dynare and local approximation (Slides).

Juillard, M., 2018. Dynamic Stochastic General Equilibrium Models: A Computational Perspective, in: Chen, S.-H., Kaboudan, M., Du, Y.-R. (Eds.), The Oxford Handbook of Computational Economics and Finance. Oxford University Press, p. 0. [https://doi.org/10.1093/oxfordhb/9780199844371.013.4](https://doi.org/10.1093/oxfordhb/9780199844371.013.4)

Kimball, M.S., 1995. The Quantitative Analytics of the Basic Neomonetarist Model. Journal of Money, Credit and Banking 27, 1241–1277. [https://doi.org/10.2307/2078048](https://doi.org/10.2307/2078048)

Lepetyuk, V., Maliar, L., Maliar, S., 2020. When the U.S. catches a cold, Canada sneezes: A lower-bound tale told by deep learning. Journal of Economic Dynamics and Control 117, 103926. [https://doi.org/10.1016/j.jedc.2020.103926](https://doi.org/10.1016/j.jedc.2020.103926)

Maliar, L., Maliar, S., 2015. Merging simulation and projection approaches to solve high-dimensional problems with an application to a new Keynesian model: Approaches to solve high-dimensional problems. Quantitative Economics 6, 1–47. [https://doi.org/10.3982/QE364](https://doi.org/10.3982/QE364)

Maliar, L., Maliar, S., 2014. Numerical Methods for Large-Scale Dynamic Economic Models, in: Schmedders, K., Judd, K.L. (Eds.), Handbook of Computational Economics Volume 3. Elsevier, pp. 325–477. [https://doi.org/10.1016/B978-0-444-52980-0.00007-4](https://doi.org/10.1016/B978-0-444-52980-0.00007-4)

Maliar, L., Maliar, S., 2013. Envelope condition method versus endogenous grid method for solving dynamic programming problems. Economics Letters 120, 262–266. [https://doi.org/10.1016/j.econlet.2013.04.031](https://doi.org/10.1016/j.econlet.2013.04.031)

McCandless, G.T., 2008. The ABCs of RBCs: an introduction to dynamic macroeconomic models. Harvard University Pres, Cambridge, MA.

Miranda, M.J., Fackler, P.L., 2002. Applied computational economics and finance. MIT, Cambridge, Mass. London.

Pfeifer, J., 2017. MATLAB Handout.

Ploberger, W., 2010. Law(s) of large numbers, in: Durlauf, S.N., Blume, L.E. (Eds.), Macroeconometrics and Time Series Analysis. Palgrave Macmillan UK, London, pp. 158–162. [https://doi.org/10.1057/9780230280830\_33](https://doi.org/10.1057/9780230280830_33)

Romer, D., 2019. Advanced macroeconomics, Fifth Edition. ed, The McGraw-Hill series in economics. McGraw-Hill Education, Dubuque.

Rupert, P., Šustek, R., 2019. On the mechanics of New-Keynesian models. Journal of Monetary Economics 102, 53–69. [https://doi.org/10.1016/j.jmoneco.2019.01.024](https://doi.org/10.1016/j.jmoneco.2019.01.024)

Schmedders, K., Judd, K.L., 2014. Introduction for Volume 3 of the Handbook of Computational Economics, in: Handbook of Computational Economics. Elsevier, pp. xv–xvii. [https://doi.org/10.1016/B978-0-444-52980-0.00020-7](https://doi.org/10.1016/B978-0-444-52980-0.00020-7)

Smets, F., Wouters, R., 2007. Shocks and Frictions in US Business Cycles: A Bayesian DSGE Approach. American Economic Review 97, 586–606. [https://doi.org/10.1257/aer.97.3.586](https://doi.org/10.1257/aer.97.3.586)

Torres, J.L., 2013. Introduction to dynamic macroeconomic general equilibrium models / José L. Torres, Department of Economics, University of Málaga. Vernon Press, Malaga, Spain.

Uribe, M., Schmitt-Grohe, S., 2017. Open economy macroeconomics. Princeton University Press, Princeton, NJ.

Walsh, C.E., 2017. Monetary theory and policy, Fourth edition. ed. MIT Press, London, England ; Cambridge, Massachusetts.

White, H., 2001. Asymptotic theory for econometricians, Rev. ed. ed. Academic Press, San Diego.

Woodford, M., 2003. Interest and prices: foundations of a theory of monetary policy. Princeton University Press, Princeton, N.J. ; Woodstock, Oxfordshire \[England\].

Yun, T., 1996. Nominal price rigidity, money supply endogeneity, and business cycles. Journal of Monetary Economics 37, 345–370. [https://doi.org/10.1016/S0304-3932(96)90040-9](https://doi.org/10.1016/S0304-3932(96)90040-9)