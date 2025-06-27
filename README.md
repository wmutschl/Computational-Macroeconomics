![Build LaTeX](../../actions/workflows/latex.yml/badge.svg)![Dynare 6.0 MATLAB R2024a Windows](../../actions/workflows/dynare-6.0-matlab-r2024a-windows.yml/badge.svg)![Dynare 6.0 MATLAB R2024a MacOS](../../actions/workflows/dynare-6.0-matlab-r2024a-macos.yml/badge.svg)![Dynare 6.0 MATLAB R2024a Ubuntu](../../actions/workflows/dynare-6.0-matlab-r2024a-ubuntu.yml/badge.svg)

# Computational Macroeconomics

These are my course materials for a graduate course on Computational Macroeconomics taught at the University of Tübingen.
The compiled PDF materials are available under [Releases](https://github.com/wmutschl/Computational-Macroeconomics/releases) (make sure to click *Show all assets*).

Please feel free to use this for teaching or learning purposes; however, taking into account the [GPL 3.0 license](https://choosealicense.com/licenses/gpl-3.0/).

## Schedule with To-Do Lists

<details>
<summary>Week 1: Introductions</summary>

### Goals

* understand the scope and topics of *Computational Macroeconomics*
* decide whether you want to take the course
* prepare your computer for the course with MATLAB/Octave and Dynare
* do your first steps in MATLAB/Octave and Dynare
* (optionally) install GitKraken and do your first steps with git

### To Do

* [x] find course information and the schedule on [https://macroeconomics.chat](https://macroeconomics.chat/cm2025), but you need to sign up first by following the link provided in [Ilias](https://ovidius.uni-tuebingen.de/ilias3/ilias.php?baseClass=ilrepositorygui&ref_id=5076472) (for University of Tübingen students only)
* [x] read the general course information, the schedule and tips on using Mattermost in the Town Square channel of [https://macroeconomics.chat](https://macroeconomics.chat/cm2025)
* [x] join the [literature](https://macroeconomics.chat/cm2025/channels/literature) channel, which will contain the readings (papers and books) as pdfs
* [x] join the [recordings](https://macroeconomics.chat/cm2025/channels/recordings) channel, which will contain the recordings of all our classes
* [x] briefly introduce yourself (what are you studying, which semester, where did you do your undergraduate studies) in the [town square](https://macroeconomics.chat/cm2025/channels/town-square) channel and whether you have previous experience with programming and are already somewhat familiar with the RBC or New Keynesian models (this is not mandatory for the course, but it is useful to know)
* [x] watch the introductory videos (on YouTube)
  * [x] [Introduction to Computational Macroeconomics](https://youtu.be/zIcEVggOwTI)
  * [x] [Introduction to MATLAB](https://youtu.be/_CbLr11aeQ4)
  * [x] [Quick Tour Dynare (focus on solution methods and simulations)](https://youtu.be/NDFSUx46FvM)
* [x] prepare your computer: MATLAB/Octave and Dynare
  * [x] install MATLAB R2024b following [this guide](https://uni-tuebingen.de/einrichtungen/zentrum-fuer-datenverarbeitung/dienstleistungen/clients/software/matlab-einzelplatzlizenz/) if you are a student of the University of Tübingen. Please also install the following toolboxes: Econometrics Toolbox, Global Optimization Toolbox, Optimization Toolbox, Parallel Computing Toolbox, Statistics and Machine Learning Toolbox, Symbolic Math Toolbox. As an alternative to MATLAB you can also install Octave following [this guide](https://octave.org/download).
  * [x] install Dynare 6.3 following [this guide](https://www.dynare.org/resources/quick_start/)
  * [x] (optionally) create an account on [GitHub.com](https://github.com/signup)
  * [x] (optionally) sign up for the [GitHub Students Developer Pack](https://education.github.com/pack) to get a free Pro license for GitKraken (among other things)
  * [x] (optionally) install the [GitKraken Client](https://gitkraken.com/download)
* [x] do [exercise sheet 1](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/exercises_1.pdf)
* [x] write down all your questions
* [x] check out how to [schedule an online meeting](https://schedule.mutschler.eu) with me
  * put *"I am interested in this course"* under *"What is the meeting about?"*
  * check your emails and cancel the meeting again using the link in the email
  * now you know how easy it is to schedule a meeting with me :-)

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

* [x] watch the following videos (on YouTube)
  * [x] [RBC Baseline Model Equations and Introduction to preprocessing with Dynare](https://youtu.be/ZfsKGzR84hQ)
  * [x] [RBC Baseline Model: steady-state derivations and implementation in Dynare (with preprocessing tips)](https://youtu.be/4xeoLh3edpo)
  * [x] [RBC Baseline Model in Dynare: Simple vs Advanced Calibration using Modularization and Changing Types](https://youtu.be/HRpynlbZBzM)
* [x] do exercise 1 of [exercise sheet 2](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/exercises_2.pdf), we will do exercise 2 and 3 (the case study) together
* [x] bring all your questions and concerns to the Q&A sessions

</details>

<details>
<summary>Week 3: Practicing DYNARE, Symbolic Preprocessing in MATLAB</summary>

### Goals

* practice DYNARE: permanent changes in fiscal policy
* practice MATLAB: symbolic toolbox, matrix algebra, loops, Kronecker products, functions

### To Do

* [x] do exercise 2 and 3 of [exercise sheet 3](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/exercises_3.pdf)
* [x] we will do exercise 1 of [exercise sheet 3](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/exercises_3.pdf) together in class, but you should already have a look at the exercise sheet
* [x] bring all your questions and concerns to the Q&A sessions

</details>

<details>
<summary>Week 4-5: Catch-up with exercises, Preprocessing and Steady-State in MATLAB</summary>

### Goals

* catch-up with exercises
* understand preprocessing and steady-state computations in MATLAB

### To Do

* [x] finish and re-visit last week's exercises
* [x] understand how to add deterministic growth to the RBC model
* [x] we will do exercise 4 of [exercise sheet 4](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/exercises_4.pdf) together in class, but you should already have a look at the exercise sheet
* [x] bring all your questions and concerns to the Q&A sessions

</details>

<details>
<summary>Week 5: New Keynesian Model</summary>

### Goals

* understand and get comfortable with the algebra of New Keynesian models
* practice Dynare with the New Keynesian model

### To Do

* [x] watch [Algebra of New Keynesian Models with Calvo price rigidities](https://youtu.be/oEf9bc9_qxw) on YouTube
* [x] work carefully and thoroughly through the very long exercise 1 of [exercise sheet 4](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/exercises_4.pdf)
* [x] we will practice Dynare with the New Keynesian model by doing exercise 2 of [exercise sheet 4](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/exercises_4.pdf) together in class
* [x] schedule a meeting for all your questions and concerns (or write me an email)

</details>

<details>
<summary>Week 6: Numerical optimization, deterministic simulations and perfect-foresight algorithm</summary>

### Goals

* understand and start using numerical optimizers
* understand numerical steady-state computations
* understand Dynare's commands to do deterministic simulations
* understand the Newton algorithm used by Dynare to solve perfect foresight problems
* re-implement deterministic simulations in MATLAB

### To Do

* [x] watch the (very short) videos:
  * [Introduction to Optimization: What is Optimization](https://youtu.be/Q2dewZweAtU)
  * [Introduction To Optimization: Objective Functions and Decision Variables](https://youtu.be/AoJQS10Ewn4)
  * [Introduction To Optimization: Gradients, Constraints, Continuous and Discrete Variables](https://youtu.be/URkmNZuFzKg)
  * [Introduction To Optimization: Gradient Based Algorithms](https://youtu.be/n-Y0SDSOfUI)
  * [Introduction To Optimization: Gradient Free Algorithms (1/2) - Genetic - Particle Swarm](https://youtu.be/3QJjfeVrut8)
  * [Introduction To Optimization: Gradient Free Algorithms (2/2) Simulated Annealing, Nelder-Mead](https://youtu.be/NI3WllrvWoc)
  * [Introduction to Optimization: Calculating Derivatives](https://youtu.be/QGo31GQjEvE)
* [x] do exercises 1-2 of [exercise sheet 5](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/exercises_5.pdf)
* [x] watch the videos
  * [Visually Explained: Newton's Method in Optimization](https://youtu.be/W7S94pq5Xuo)
  * [Understanding Deterministic (Perfect Foresight) Simulations in Dynare](https://youtu.be/I6CgzoOfoS0)
  * [Optional: Newton's Fractal (which Newton knew nothing about) (Time: 5:55 - 11:16)](https://youtu.be/-RdOwhmqP5s?t=355)
* [x] bring all your questions and concerns to the Q&A sessions

</details>

<details>

<summary>Week 7: Midterm Exam: Rotemberg Adjustment Costs, Monopolistic Competition, Irreversible Investment, War Shock</summary>

### Goals

* understand quadratic price adjustment costs
* understand monopolistic competition and the Dixit Stiglitz elasticity parameter
* understand irreversible investments as an occasionally binding constraint
* understand the modeling of a war in a New Keynesian model
* get a good grade

### To Do

* [x] read the instructions and do all exercises from the [summer 2025 midterm exam](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/midterm_exam_ss2025.pdf)
* [x] read the papers carefully
* [x] hand in your solutions via email
* [x] for immediate help: contact me [via email](mailto:willi@mutschler.eu) or [schedule a meeting](https://schedule.mutschler.eu)

</details>

<details>

<summary>Week 8: Practicing deterministic simulations using a New-Keynesian SIR model: Deal with numerical issues and use homotopy</summary>

### Goals

* understand the SIR (Susceptible, Infected, Recovered) epidemiology model
* understand and get used to Dynare's macro preprocessing directives
* understand timing conventions of predetermined variables
* understand the difference between sticky-price and flex-price New Keynesian economies
* deal with common numerical issues in the perfect foresight solution algorithm
* understand homotopy in the context of perfect foresight simulations
* simulate a New-Keynesian SIR model

### To Do

* [x] read the case-study paper carefully
* [x] prepare [exercise sheet 6](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/exercises_6.pdf): exercise 1 and 2 for the first meeting and exercises 3 and 4 for the second meeting
  * [x] download all files
  * [x] read all the exercises
  * [x] we will go through this together in class
* [x] bring all your questions and concerns to the Q&A sessions

</details>

<details>
<summary>Week 9 and 10: First-order perturbation, Shock transmission channels, Log-Linearization</summary>

### Goals

* understand the concept of a policy function
* understand the general idea of first-order perturbation approximation
* understand certainty equivalence
* understand the algorithm to compute the perturbation matrices using the Linear Rational Expectation model framework
* [optional] understand Dynare's first-order perturbation solver

### To Do

* [x] watch
  * [x] [RBC Baseline Model in Dynare: Deterministic vs Stochastic Simulations](https://youtu.be/KHTEZiw9ukU)
  * [x] [Solving rational expectation models with first order perturbation: what Dynare does (Part 1 of 2)](https://youtu.be/hmVxasBgbqM) on YouTube
* [x] do [exercise sheet 7](https://github.com/wmutschl/Computational-Macroeconomics/releases/latest/download/exercises_7.pdf) on your own
* [x] read Rupert and Šustek (2019)

</details>

<details>
<summary>Week 11: Trend Inflation and Environmental Policy in the New Keynesian model.</summary>

### Goals

* understand and get used to Dynare's *stoch_simul* command
* understand Dynare's sensitivity toolbox
* study the macroeconomics of trend inflation in a New Keynesian model
* study the macroeconomics of different environmental policies in a New Keynesian model

### To Do

* [x] read the case-study paper on trend inflation carefully (Ascari and Sbordone, 2014)
* [x] read the case-study paper on environmental policy carefully (Annicchiarico and Di Dio, 2015)
* [x] download all files
* [x] try to prepare the replications

</details>

<!---

<details>
<summary>Week 11: ; Practicing Stochastic Simulations, Impulse Response Functions, Perturbation. Environmental Policy,OccBin, Introduction to Higher-Order Approximation Recursive Preferences and Equity Risk Premium and Stochastic Volatility</summary>

### Goals

* study the modeling approach and effects of different environmental policies in a New Keynesian model

### To Do

* [ ]
  * [x] read the case-study paper on environmental policy

</details>

<details>
<summary>Week 12: Optimal Policy and Welfare assessment</summary>

### Goals

* 

### To Do

* [ ]

</details>

<details>
<summary>Week 13: Projection</summary>

### Goals

* 

### To Do

* [ ]

</details>

<details>
<summary>Week 14: Projection</summary>

### Goals

* 

### To Do

* [ ]

</details>

\-->

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
- [x] Wars (Auray and Eyquem, 2019, Journal of Economic Dynamics and Control)
- [ ] Trend inflation (Ascari and Sbordone, 2014, Journal of Economic Literature)
- [ ] Technology shocks and business cycles (King, Plosser and Rebelo, 1988, Journal of Monetary Economics)
- [ ] International spillovers under different environmental policy regimes (Annicchiarico and Diluiso, 2019, Resource and Energy Economics)
- [ ] Nonlinearities and large shocks (Harding, Linde and Trabandt, 2022)
- [ ] Fiscal multipliers (Linde and Trabandt, 2017, Journal of Applied Econometrics)
- [ ] Optimal environmental policy (Heutel, 2012, Review of Economic Dynamics; Annicchiarico and Di Dio, 2015, Journal of Environmental Economics and Management)
- [ ] Equity premium puzzle (Jermann, 1998, Journal of Monetary Economics)
- [ ] Zero-lower bound on nominal interest rates, irreversible investment (Guerrieri and Iacoviello, 2015, Journal of Monetary Economics)
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
Please sent me those either [via email](mailto:willi@mutschler.eu) or (better) open a pull request.