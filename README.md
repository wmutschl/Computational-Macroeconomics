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



## Case Studies
- Technology shocks and business cycles (King, Plosser and Rebelo, 1988, Journal of Monetary Economics)
- Welfare and fiscal policy (Baxter and King, 1993, American Economic Review)
- Epidemics (Eichenbaum, Rebelo and Trabandt, 2022, Journal of Economic Dynamics and Control)
- Trend inflation (Ascari and Sbordone, 2014, Journal of Economic Literature)
- International spillovers under different environmental policy regimes (Annicchiarico and Diluiso, 2019, Resource and Energy Economics)
- Nonlinearities and large shocks (Harding, Linde and Trabandt, 2022)
- Fiscal multipliers (Linde and Trabandt, 2017, Journal of Applied Econometrics)
- Optimal environmental policy (Heutel, 2012, Review of Economic Dynamics; Annicchiarico and Di Dio, 2015, Journal of Environmental Economics and Management)
- Equity premium puzzle (Jermann, 1998, Journal of Monetary Economics)
- Zero-lower bound on nominal interest rates (Guerrieri and Iacoviello, 2015, Journal of Monetary Economics)
- Rare disasters (Fernandez-Villaverde and Levintal, 2018, Quantitative Economics; Isore and Szczerbowicz, 2017, Journal of Economic Dynamics and Control)
- Endogenous Banking Crises (Boissay, Collard, and Smets, 2016, Journal of Political Economy)

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