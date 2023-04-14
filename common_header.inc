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
\usepackage{hyperref}
\usepackage{enumitem}
\usepackage{graphicx}
\usepackage[usenames,dvipsnames]{xcolor}
\definecolor{mygreen}{rgb}{0,0.4,0}
\definecolor{mygray}{rgb}{0.5,0.5,0.5}
% \usepackage{listingsutf8}
% \lstset{language=Matlab,                    % Use MATLAB
%     backgroundcolor=\color{white},          % choose the background color; you must add \usepackage{color} or \usepackage{xcolor}
% 	frame=leftline,                         % Single frame around code
% 	basicstyle=\footnotesize,               % Use small true type font
% 	breaklines=true,                        % sets automatic line breaking
% 	breakatwhitespace=false,                % sets if automatic breaks should only happen at whitespace
% 	captionpos=t,                           % sets the caption-position to bottom
% 	keywordstyle=[1]\color{Blue}\bfseries,  % MATLAB functions bold and blue
% 	keywordstyle=[2]\color{Purple},         % MATLAB function arguments purple
% 	keywordstyle=[3]\color{Blue}\underbar,  % User functions underlined and blue
% 	morekeywords={matlab2tikz,varobs,model,var,end,estimation,parameters,estimated_params,varexo,shocks,steady_state_model,check,steady,stoch_simul,stderr,corr,steady_state,initval},
% 	deletekeywords={beta,log,LOG,PI,pi,Pi,what}, % if you want to delete keywords from the given language
% 	identifierstyle=,                       % Nothing special about identifiers
% 	commentstyle=\usefont{T1}{pcr}{m}{sl}\color{mygreen}\small, 	% Comments small dark green courier
% 	stringstyle=\color{Purple},             % Strings are purple
% 	showstringspaces=false,                 % Don't put marks in string spaces
% 	showspaces=false,                       % show spaces everywhere adding particular underscores; it overrides 'showstringspaces'
% 	showtabs=false,                         % show tabs within strings adding particular underscores
%   	tabsize=3,                              % 3 spaces per tab
% 	morecomment=[l][\color{Blue}]{...},     % Line continuation (...) like blue comment
% 	morecomment=[l]{//},
%     morecomment=[s]{/*}{*/},
% 	%numbers=left,                          % Line numbers on left
% 	numberblanklines=false,
%   	firstnumber=1,                          % Line numbers start with line 1
% 	numberstyle=\tiny\color{mygray},        % Line numbers are lightgray
% 	numbersep=5pt,                          % how far the line-numbers are from the code
% 	numberbychapter=false,
%   	stepnumber=5,                           % Line numbers go in steps of 5
% 	escapeinside={(*@}{@*)},                % if you want to add LaTeX within your code
% 	keepspaces=true,                        % keeps spaces in text, useful for keeping indentation of code (possibly needs columns=flexible)
% 	rulecolor=\color{black},                % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. comments (green here))
% 	title=\lstname,                         % show the filename of files included with \lstinputlisting; also try caption instead of title  
% }
\usepackage[numbered,framed]{matlab-prettifier}
\usepackage[backend=biber,style=authoryear]{biblatex}
\addbibresource{biblio.bib}
\usepackage[stable]{footmisc}
\usepackage{booktabs,longtable}
\usepackage{nameref}
\usepackage{float}
\usepackage{tikz}
\usetikzlibrary{positioning}
\usetikzlibrary{decorations.text}
%\makeatletter
%\newcommand*{\currentname}{\@currentlabelname}
%\makeatother
\renewcommand{\contentsname}{Overview}

\usepackage[
	%nosolutionfiles
	]{answers}
