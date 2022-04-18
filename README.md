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

| Week      | Topic |
| ----------- | ----------- |
| 1 | Introduction to course, Dynare and MATLAB |
| 2 | RBC Model Theory and Preprocessing in Dynare |
| 3 | Basic New Keynesian Model Theory and Preprocessing in MATLAB |
| 4 | Solution concepts, perfect foresight vs. policy functions in Dynare |
| 5 | Perfect foresight simulations in Dynare and MATLAB |
| 6 | Stochastic simulations - 1st order perturbation Theory |
| 7 | Stochastic simulations - 1st order perturbation Implementation in Dynare and MATLAB |
| 8 | MIDTERM EXAM |
| 9 | Stochastic Simulations: Higher-order perturbation Theory |
| 10 | Stochastic Simulations: Higher-order perturbation Implementation in Dynare and MATLAB |
| 11 | Projection Method Theory and Implementation in MATLAB |
| 12 | Occasionally-binding constraints under perfect foresight |
| 13 | Occasionally-binding constraints in stochastic setting |
| 14 | Applications and recent developments, Master thesis opportunities |
| 15 | ENDTERM EXAM |

