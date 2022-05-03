% !TeX encoding = UTF-8
% !TeX spellcheck = en_US
\documentclass[a4paper]{scrartcl}
\usepackage[T1]{fontenc}
%\usepackage[utf8]{inputenc}
\usepackage[english]{babel}
\usepackage[bottom=2.5cm,top=2.0cm,left=2.0cm,right=2.0cm]{geometry}
\usepackage{amssymb,amsmath,amsfonts}
\usepackage{lmodern}
\usepackage{csquotes}
\usepackage{url}
\usepackage{doi}
%\renewcommand{\labelenumi}{(\alph{enumi})}
%\renewcommand{\labelenumii}{(\roman{enumii})}
%\renewcommand{\Solutionlabel}[2]{\emph{Solution #1}}
%\renewenvironment{Solution}[1]{\begin{trivlist}\item
%		Solution to \emph{#1} }{\end{trivlist}}
%\renewcommand{\Solutionlabel}[1]{\emph{Solution to}}
%\renewcommand{\Solutionparams}{\Currentlabel \currentname (p.\thepage) }

%\parindent0mm
%\parskip1.5ex plus0.5ex minus0.5ex
%\renewcommand{\thesection}{{Aufgabe \arabic{section}:}}
%\renewcommand{\theenumi}{\alph{enumi}}
%\renewcommand\labelenumi{(\theenumi)}
\usepackage{enumitem}
\usepackage{graphicx}
\usepackage[usenames,dvipsnames]{color}
\definecolor{MyDarkGreen}{rgb}{0.0,0.4,0.0}
\usepackage{listingsutf8}
\lstset{language=Matlab,                        % Use MATLAB
	frame=leftline,                           % Single frame around code
	basicstyle=\footnotesize\ttfamily,             % Use small true type font
	breaklines=true,                        %
	keywordstyle=[1]\color{Blue}\bfseries,  % MATLAB functions bold and blue
	keywordstyle=[2]\color{Purple},         % MATLAB function arguments purple
	keywordstyle=[3]\color{Blue}\underbar,  % User functions underlined and blue
	morekeywords={matlab2tikz},
	identifierstyle=,                       % Nothing special about identifiers
	commentstyle=\usefont{T1}{pcr}{m}{sl}\color{MyDarkGreen}\small, 	% Comments small dark green courier
	stringstyle=\color{Purple},             % Strings are purple
	showstringspaces=false,                 % Don't put marks in string spaces
	tabsize=3,                             % 5 spaces per tab
	%
	%%% Put standard MATLAB functions not included in the default
	%%% language here
	%morekeywords={xlim,ylim,var,alpha,factorial,poissrnd,normpdf,normcdf},
	%
	%%% Put MATLAB function parameters here
	%morekeywords=[2]{on, off, interp},
	%
	%%% Put user defined functions here
	%morekeywords=[3]{FindESS, homework_example},
	%
	morecomment=[l][\color{Blue}]{...},     % Line continuation (...) like blue comment
	%numbers=left,                           % Line numbers on left
	firstnumber=1,                          % Line numbers start with line 1
	numberstyle=\tiny\color{Blue},          % Line numbers are blue
	stepnumber=5                            % Line numbers go in steps of 5
}
\usepackage[backend=biber,style=authoryear]{biblatex}
\addbibresource{bib_computational_macroeconomics.bib}
\usepackage[stable]{footmisc}
\usepackage{booktabs,longtable}
\usepackage{nameref}
%\makeatletter
%\newcommand*{\currentname}{\@currentlabelname}
%\makeatother
\renewcommand{\contentsname}{Overview}

\usepackage[
	%nosolutionfiles
	]{answers}
