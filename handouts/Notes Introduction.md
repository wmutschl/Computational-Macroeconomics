# Introduction

## Script
Hello everyone!

My name is Willi Mutschler, I am an Assistant Professor in International Macroeconomics at the University of Tübingen, and would like to welcome you to this lecture series on Computational Macroeconomics in the summer term of 2022.

This is a graduate course aimed at our Master student's, but it is also a challenging course for early PhD students who want to get familiar with state-of-the art numerical methods that are commonly used in modern macroeconomics.

In particular, we will dive into the Dynamic Stochastic General Equilibrium paradigm, or DSGE models in short.
The DSGE approach
- refers to a very general family and broad class of structural models that are strongly rooted in economic theory.
- These models are micro-founded; that is, we explicitly formulate the dynamic optimization problems of the various agents and sectors: Households, firms, banks, the fiscal authority and the central bank, the international structure, etc
- We then mathematically solve these problems under uncertainty, because we add stochastic processes to the system of equations.
- Conditional on distributional assumptions for these structural and exogenous shocks, on the inclusion of certain model features, the DSGE model generates a joint probability distribution for the endogenous model variables such as output, consumption, investment, and inflation.
- In other words, we have a laboratory in which we can run experiments in.
- What about:
	- effects of quantitative easing or tightening when we are at the zero-lower bound
	- dynamics when the economy transitions from dirty industries to green industries
	- how large is the fiscal multiplier in times of a pandemic
	- what is the effect of a 5% VAT tax reduction on the income distribution of households
	- etc
- They have become the standard modeling framework in modern macroeconomic research. They often serve as a macroeconomic laboratory that allows to analyze how economic agents respond to changes in their environment as all variables are determined simultaneously and endogenously given a sound micro-founded theoretical setting.
- It is not surprising that DSGE models are intensively used in policy making e.g. by central banks they play a central role in providing an analytical foundation for the decision making. I am not saying they are the sole thing central bankers use, but it is a very important one.

Now this course is not an introduction into the modeling aspects of DSGE models; if you are interested in that I highly recommend you attend the Advanced Macro II course taught by Gernot Müller this semester who teaches you the bells and whistles of modern macroeconomic modeling and what questions require what kind of model. This is a very important point, let me really emphasize this.
It totally depends on what you want to study, what is your research question, that determines which kind of model you should use and which features this model needs to have. 

Typical textbook models can be usually handled with pen and paper at least to some extent to get the intuition and mechanics. Consider the very basic New Keynesian model with Calvo price frictions that under some simplified assumptions can be broken down into just three equations.
But, certain questions require you to use models that are much more complex, they are highly nonlinear, say you are concerned about occasionally binding constraints. How do we get out of the zero-lower-bound, maybe use forward guidance with threshold variables. Or you want to study the effect of introducing the possibility of a desaster. Say a financial crises, or a Gas and oil crisis or a pandemic might happen with a very tiny probability, but if it happens it'll have huge effects on the economy. How do people react if this probability now increases?

Now to answer such questions, you need models that quickly become large, complex and are highly nonlinear and of stochastic nature. You can't solve them with pen and paper anymore, you really need to use the computer and numerical methods for this.
And this is the goal of this course. This is our point of departure to have a detailed look into the computational implementation, into how we solve models, how we simulate models.

Granted this is often very cumbersome and challenging and it will require some investment that you will need to undergo. So this is not an easy course as there is a huge component of self-teaching involved because we do need to get familiar with several things from mathematics, numerics and statistics.

The only way to do this, is hands-on. So this is not a course where you get 90 minutes of lecture and then you are supposed to be familiar with a concept. This course is really about practicing and diving into the material, it is really hands-on. Of course, there will be several theoretical inputs and presentations and derivations of certain methods. But the real focus of this course is for you to practice this directly on your computer by means of exercises. Only by try and error, and doing it yourself you will really understand these concepts.

Now, we will most of the times cover a concept first in a user-friendly way and then in a more advanced way. For user-friendliness we will use Dynare, which is a widely used toolkit for solving, simulating and estimating DSGE models and doing all sorts of model evaluation and analysis. Dynare is used in all sorts of central banks, institutions like the IMF or the world bank, and in macro research departments. Now Dynare is open-source, you can have a look at all functions, and I am a member of the Dynare team, so obviously I want you to know it well. However, most users of Dynare use it as a black box to simulate a model, do an impulse response analysis, and some optimal policy exercise. Not us. So after we've seen what Dynare is capable to do, we will try to re-implement the underlying algorithms, in a simplified and more structured manner, in a programming language without getting lost in all the neat little things and tricks that we do in Dynare.
The goal is to get familiar with a variety of algorithms, examples and situations in which computational thinking is useful in approximating and evaluating abstract macroeconomic phenomena. 

Now our main programming language will be MATLAB, for several reasons that we will discuss in an exercise later on. The main is that most code written in the last 30 years of research done in Macroeconomics was done in MATLAB. So it is important for you to learn to understand the legacy code.
Now, if you don't have any programming experience that's fine, just be aware that you need some extra time to practice this and get into MATLAB. It is, however, very easy to learn. Learning a programming language is a huge investment; however, once you have knowledge of one, learning another one tends to be easier as they are based on the same principles. If you do have programming experience in a scripting language like Python, R, MATLAB or Julia you will be able to follow along just fine and feel free to re-implement this in your language of choice. In this way you will learn it even better.

Let's talk about course organization:
- We roughly follow the flipped classroom teaching method, meaning that most exercises begin with a theoretical or conceptional question for which material (research papers, book chapters, videos, slides) will be made available to you both on Ilias, but also in a GitHub repository.
- Please become a member of the Ilias group so that I can get in touch with you.
- You are required to study this material either on your own or, preferably, in a study group.
- Each week we meet on Wednesdays (16:15-17:45) and Thursdays (10:15-11:45) alternating between either in person (following current Corona rules) or virtually on Zoom. The "in-person sessions" will also be streamed live, but not recorded via Zoom.
- In these sessions we clarify any questions you have while preparing the materials and then proceed to go through the exercises together.
- These are largely processed on the computer using Dynare and MATLAB (or any other language you prefer).
- The solutions to the assignments will be provided with a small time delay.
- Please bring a computer with you to the sessions. If you do not have access to a portable computer, please contact me in advance so that we can organize a device for you.

Lastly, let's have a look at the topics I plan to cover in this semester.

Week I: Introduction to the course, Dynare and MATLAB
Week II and III: we will review the RBC and New Keynesian model so everyone is on the same page and particularly we will have a look how to preprocess a DSGE model on a computer, meaning how do we transform a very specific model into a general model framework
Week IV: Solution concepts, perfect foresight vs. policy functions. Once we have a solution concept, we are able to do things like impulse-response function, variance decomposition, historical decomposition, optimal policy etc.
Week V: Dive into perfect foresight simulations in Dynare and MATLAB
Week VI and VII: Stochastic simulations: 1st order perturbation Theory also known as solution to rational expectations model and how to implement this in Dynare and MATLAB for any DSGE model
Week VIII: MIDTERM EXAM
Week IX and X: Stochastic Simulations: Higher-order perturbation Theory as an example of local solution methods
Week XI: Projection Method Theory and Implementation in MATLAB as an example of global solution methods
Week XII: Occasionally-binding constraints under perfect foresight and also in stochastic settings
Week XIII: Rare disaster models
Week XIV: Applications and recent developments, Master thesis opportunities
Week XV: ENDTERM EXAM

Lastly, to get credits for this course, there will be a midterm and an endterm exam, both counting equally towards your overall grade.
As our course is exercise based, so will be the exam, you will get a bunch of exercises; in fact, I am going to ask you to replicate results from the literature. Because this will require you to try and error, you will get some time as the exam is take-home and you are required to hand in the exam within a week.

Alright, on Ilias I have put a To Do List for this week. Please go through the material and I am looking forward to meeting you in this weeks Q&A session then.

As always, if something is not clear or you are struggling, feel free to schedule a meeting with me using my online booking tool.

Lastly, this is a new course which I am still preparing, so please give me a little slack if I change things in the short term or if mistakes creep in. I am always open to feedback and will correct errors as soon as possible.

Okay, see you soon.

## Video
### Title
Introduction to Computational Macroeconomics
### Description
Course on Computational Macroeconomics (Master and PhD level)
Week 1: Introduction
Taught at University of Tübingen, Summer 2022

GitHub repo: https://github.com/wmutschl/Computational-Macroeconomics


**Timestamps**
00:22 - Target audience
00:37 - What are DSGE models
01:55 - DSGE models as a laboratory
03:32 - Limits of pen and paper models
05:04 - This course is NOT about modeling DSGE models, but about numerical methods to simulate and solve DSGE models
06:51 - Two step approach: first we use Dynare, then we implement it ourselves in MATLAB
08:50 - Programming language will be MATLAB
09:46 - Course organization
11:53 - Schedule and topics
14:48 - Exam is take-home
15:21 - To Do list on Ilias

### tags
Computational Macroeconomics, Macroeconometrics, DSGE, Solution, Simulation, Numerical Methods

### playlists
- Computational Macroeconomics (University Tübingen, Summer 2022)
