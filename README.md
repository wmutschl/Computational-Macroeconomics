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


