[![Build LaTeX exercises as PDF](https://github.com/wmutschl/Computational-Macroeconomics/actions/workflows/latex-exercises.yml/badge.svg)](https://github.com/wmutschl/Computational-Macroeconomics/actions/workflows/latex-exercises.yml)
[![Build LaTeX exams as PDF](https://github.com/wmutschl/Computational-Macroeconomics/actions/workflows/latex-exams.yml/badge.svg)](https://github.com/wmutschl/Computational-Macroeconomics/actions/workflows/latex-exams.yml)

# Computational Macroeconomics

These are my course materials for a graduate course on Computational Macroeconomics taught at the University of Tübingen.
The compiled materials (such as PDFs) are available under [Releases](https://github.com/wmutschl/Computational-Macroeconomics/releases).

Please feel free to use this for teaching or learning purposes; however, taking into account the [GPL 3.0 license](https://choosealicense.com/licenses/gpl-3.0/).

## Schedule with To-Do Lists

<details>
  <summary>Week 1: Introductions</summary>

### Goals

* understand the scope and topics of *Computational Macroeconomics*
* decide whether you want to take the course
* prepare your computer for the course with MATLAB/Octave and Dynare
* do your first steps in MATLAB/Octave and Dynare

### To Do

* [ ] read the general course information on [Ilias](https://ovidius.uni-tuebingen.de/ilias3/goto.php?target=crs_4166405&client_id=pr02)
* [ ] watch the introductory videos (on YouTube)
  * [ ] [Introduction to Computational Macroeconomics](https://youtu.be/vZfX5U5xyws)
  * [ ] [Introduction to MATLAB](https://youtu.be/_CbLr11aeQ4)
  * [ ] [Quick Tour Dynare (focus on solution methods and simulations)](https://youtu.be/NDFSUx46FvM)
* [ ] prepare your computer: MATLAB/Octave and Dynare
  * [ ] install MATLAB R2023a following [this guide](https://uni-tuebingen.de/einrichtungen/zentrum-fuer-datenverarbeitung/dienstleistungen/clientdienste/software/matlab-einzelplatzlizenz/) if you are a student of the University of Tübingen. Please also install the following toolboxes: Econometrics Toolbox, Global Optimization Toolbox, Optimization Toolbox, Parallel Computing Toolbox, Statistics and Machine Learning Toolbox, Symbolic Math Toolbox. As an alternative to MATLAB you can also install Octave following [this guide](https://octave.org/download).
  * [ ] install Dynare 5.4 following [this guide](https://www.dynare.org/resources/quick_start/)
* [ ] do [exercises for week 1](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/week_1.pdf)
* [ ] write down all your questions
* [ ] [schedule an online meeting](https://schedule.mutschler.eu) with me
  * [ ] put *"I am interested in this course"* under *"What is the meeting about?"*
  * [ ] check your emails and cancel the meeting again using the link in the email
  * [ ] now you know how easy it is to schedule a meeting with me :-)
* [ ] participate in the Q&A sessions

</details>


<details>
  <summary>Week 2: RBC Model, Calibration and Steady-State</summary>

### Goals

* understand and get comfortable with the algebra of RBC models
* understand the concept of a steady-state
* understand the concept of calibration
* practice Dynare
* start programming with MATLAB

### To Do

* [ ] watch the following videos (on YouTube)
  * [ ] [RBC Baseline Model Equations and Introduction to preprocessing with Dynare](https://youtu.be/ZfsKGzR84hQ)
  * [ ] [RBC Baseline Model: steady-state derivations and implementation in Dynare (with preprocessing tips)
](https://youtu.be/4xeoLh3edpo)
  * [ ] [RBC Baseline Model in Dynare: Simple vs Advanced Calibration using Modularization and Changing Types
](https://youtu.be/HRpynlbZBzM)
* [ ] do exercises 1 and 2 of [week 2's exercise sheet](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/week_2.pdf), we will do the case study together
* [ ] bring all your questions and concerns to the Q&A sessions

</details>


<details>
  <summary>Week 3: Practicing MATLAB, New Keynesian Model</summary>

### Goals

* practice MATLAB: symbolic toolbox, matrix algebra, loops, Kronecker products, functions
* understand and get comfortable with the algebra of New Keynesian models
* practice Dynare with the New Keynesian model

### To Do

* [ ] watch [Algebra of New Keynesian Models with Calvo price rigidities](https://youtu.be/oEf9bc9_qxw) on YouTube
* [ ] do the MATLAB exercises 1 and 2 of [week 3's exercise sheet](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/week_3.pdf)
* [ ] work carefully and thoroughly through the very long exercise 3 of [week 3's exercise sheet](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/week_3.pdf)
* [ ] we will do exercise 4 of [week 3's exercise sheet](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/week_3.pdf) together in class
* [ ] bring all your questions and concerns to the Q&A sessions

</details>


<details>
  <summary>Week 4: Preprocessing and steady-state in MATLAB, numerical optimization</summary>

### Goals

* understand and replicate preprocessing and steady-state computations in MATLAB
* understand and start using numerical optimizers

### To Do

* [ ] watch the (very short) videos:
  * [Introduction to Optimization: What is Optimization](https://youtu.be/Q2dewZweAtU)
  * [Introduction To Optimization: Objective Functions and Decision Variables](https://youtu.be/AoJQS10Ewn4)
  * [Introduction To Optimization: Gradients, Constraints, Continuous and Discrete Variables](https://youtu.be/URkmNZuFzKg)
  * [Introduction To Optimization: Gradient Based Algorithms](https://youtu.be/n-Y0SDSOfUI)
  * [Introduction To Optimization: Gradient Free Algorithms (1/2) - Genetic - Particle Swarm](https://youtu.be/3QJjfeVrut8)
  * [Introduction To Optimization: Gradient Free Algorithms (2/2) Simulated Annealing, Nelder-Mead](https://youtu.be/NI3WllrvWoc)
  * [Introduction to Optimization: Calculating Derivatives](https://youtu.be/QGo31GQjEvE)  
* [ ] do exercises 1-3 of [week 4's exercise sheet](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/week_4.pdf)
* [ ] bring all your questions and concerns to the Q&A sessions

</details>


<details>
  <summary>Week 5: Deterministic simulations and perfect-foresight algorithm</summary>

### Goals

* understand Dynare's commands to do deterministic simulations
* understand the Newton algorithm used by Dynare to solve perfect foresight problems
* re-implement deterministic simulations in MATLAB

### To Do
* [ ] watch the videos
  * [Understanding Deterministic (Perfect Foresight) Simulations in Dynare](https://youtu.be/I6CgzoOfoS0)
  * [RBC Baseline Model in Dynare: Deterministic vs Stochastic Simulations](https://youtu.be/KHTEZiw9ukU)
  * [Newton's Fractal (which Newton knew nothing about) (Time: 5:55 - 11:16)](https://youtu.be/-RdOwhmqP5s?t=355)
  * [Visually Explained: Newton's Method in Optimization](https://youtu.be/W7S94pq5Xuo)
* [ ] do exercise 1 of [week 5's exercise sheet](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/week_5.pdf)
* [ ] we will do a case study together in class
* [ ] bring all your questions and concerns to the Q&A sessions

</details>


<details>
  <summary>Week 6: Practicing preprocessing and deterministic simulations, Deal with numerical issues, Homotopy, New-Keynesian SIR</summary>

### Goals

* understand the SIR (Susceptible, Infected, Recovered) epidemiology model
* understand and get used to Dynare's macro preprocessing directives
* understand timing conventions of predetermined variables
* understand the difference between sticky-price and flex-price New Keynesian economies
* deal with common numerical issues in the perfect foresight solution algorithm
* understand homotopy in the context of perfect foresight simulations
* simulate a New-Keynesian SIR model

### To Do
* prepare exercise 1 of [week 6's exercise sheet](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/week_6.pdf)
  * [ ] read the case-study paper carefully
  * [ ] download all files
  * [ ] read all the exercises
  * [ ] try to prepare the exercises (this will be hard, so we will go through this together in class)
* [ ] bring all your questions and concerns to the Q&A sessions

</details>


## Content

We cover modern theoretical macroeconomics (the study of aggregated variables such as economic growth, unemployment and inflation by means of structural macroeconomic models) and combine it with numerical methods to study abstract macroeconomic concepts such as optimal monetary, fiscal and environmental policy,  occasionally binding constraints (zero-lower-bound, irreversible investment), quantitative easing and rare disasters. To this end, we use the Dynamic Stochastic General Equilibrium (DSGE) model paradigm, particularly focusing on different variants of the New-Keynesian model, and develop the numerical procedures and algorithms required to solve and simulate such models. Using several case studies from the literature the theoretical and methodological foundations of computational macroeconomics are taught.

## Topics
- Algebra of RBC and New-Keynesian models
- Steady-state
- Preprocessing of DSGE models
- Simulation and solution methods
  - perfect foresight
  - 1st-order perturbation (log-linearization)
  - k-order perturbation
  - projection
- Impulse response analysis
- Sensitivity analysis
- Large shocks
- Rare events
- Occasionally binding constraints
- Optimal policy



## Case Studies and Replications (Preliminary)
- [x] Fiscal policy (Baxter and King, 1993, American Economic Review)
- [x] Epidemics (Eichenbaum, Rebelo and Trabandt, 2022, Journal of Economic Dynamics and Control)
- [ ] Trend inflation (Ascari and Sbordone, 2014, Journal of Economic Literature)
- [ ] Technology shocks and business cycles (King, Plosser and Rebelo, 1988, Journal of Monetary Economics)
- [ ] International spillovers under different environmental policy regimes (Annicchiarico and Diluiso, 2019, Resource and Energy Economics)
- [ ] Nonlinearities and large shocks (Harding, Linde and Trabandt, 2022)
- [ ] Fiscal multipliers (Linde and Trabandt, 2017, Journal of Applied Econometrics)
- [ ] Optimal environmental policy (Heutel, 2012, Review of Economic Dynamics; Annicchiarico and Di Dio, 2015, Journal of Environmental Economics and Management)
- [ ] Equity premium puzzle (Jermann, 1998, Journal of Monetary Economics)
- [ ] Zero-lower bound on nominal interest rates (Guerrieri and Iacoviello, 2015, Journal of Monetary Economics)
- [ ] Rare disasters (Fernandez-Villaverde and Levintal, 2018, Quantitative Economics; Isore and Szczerbowicz, 2017, Journal of Economic Dynamics and Control)
- [ ] Endogenous Banking Crises (Boissay, Collard, and Smets, 2016, Journal of Political Economy)

## Learning target

Students acquire knowledge of advanced numerical methods in the field of computational macroeconomics. This knowledge is relevant for the realization of a wide variety of macroeconomic research projects and is applied in central banks, ministries, research institutes (e.g. DIW, ifo, IfW, IWH, RWI) and research departments of international organizations (e.g. IMF, World Bank). Upon successful  completion of this module, students are prepared to work in these areas. At the same time, the module  prepares students for the requirements of a methodologically oriented macroeconomic dissertation.

Students get familiar with a variety of algorithms, examples and situations in which computational thinking is useful in approximating and evaluating abstract macroeconomic phenomena. They recognize and appreciate the connections between theory and computational methods and use their training to find possible avenues of research. While constructing abstract algorithms, they identify appropriate computational tools and evaluate their strengths and weaknesses in the context of problem solving. They utilize computers and software effectively as tools for solving and simulating macroeconomic models. In addition, because students work on the problem sets as a team, students' coordination, organization, and communication skills are enhanced.


## Requirements
Basic undergraduate knowledge of macroeconomics as well as econometrics are required, programming skills in a scripting language are advantageous, but not necessary.

## Software used

* [MATLAB](https://mathworks.com) or [Octave](https://octave.org)
* [Dynare](https://www.dynare.org)


## Getting Involved
If you spot mistakes, let me know by opening an issue or write me an email to [willi@mutschler.eu](mailto:willi@mutschler.eu).
Moreover, solutions to the exercises in other computer languages (e.g. Julia, Python or R) are highly appreciated.