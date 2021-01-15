\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{StdObligH2020}[Klasse som gir oppdatert formatering til obliger for høsten 2020.]
\LoadClass[norsk,11pt,a4paper]{article}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[norsk]{babel}

\usepackage{blindtext} % to quickly get a full document

\usepackage[hidelinks]{hyperref}
\usepackage[all]{hypcap}
\usepackage{lastpage}
%\usepackage[margin=1in]{geometry}

\RequirePackage{titling}

\RequirePackage[dvipsnames]{xcolor}
\usepackage{tabularx}

\RequirePackage{soul}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage{gensymb}
\usepackage{graphicx}
\usepackage{float}
\usepackage{multicol}
\usepackage{colortbl}
\usepackage{xcolor}
\usepackage{svg}
\usepackage{tabularx}
\usepackage{listofitems}
\usepackage{mathtools}
\usepackage{ifthen}
\usepackage{lmodern}
\usepackage{tkz-euclide}
\usetikzlibrary{plotmarks}
\usepackage{pgfplots}

\usepackage{attachfile}
\usepackage{pdfpages}
\usepackage{booktabs}
\usepackage{tikz}
\usepackage[small,euler-digits]{eulervm}
\usepackage{braket}
\usetikzlibrary{angles, quotes, tikzmark, backgrounds, calc, patterns, scopes}
\usetkzobj{all}


\usepackage{listings}


\usepackage{graphicx}
\usepackage{caption}
\usepackage{subcaption}

% Make new thing for draftonly
\usepackage{versions}
\excludeversion{draft}
\newcommand{\isdraft}[0]{
    \includeversion{draft}
	%\usepackage{draftwatermark}
	%\SetWatermarkText{Utkast}
	%\SetWatermarkColor[rgb]{1,0.95,0.95}
	%\SetWatermarkScale{2}
}

% Make styling of header and footer
\usepackage{fancyhdr} % to change header and footers
\pagestyle{fancy} % Turn on the style
\fancyhf{} % Start with clearing everything in the header and footer
\setlength{\headheight}{14pt}
\fancyfoot[R]{\thepage\ av \pageref{LastPage}}
\fancyhead[L]{\theauthor}
\fancyhead[C]{\thetitle}
\fancyhead[R]{\thedate}

% Redefine plain style, which is used for titlepage and chapter beginnings
% From https://tex.stackexchange.com/a/30230/828
\fancypagestyle{plain}{
    \renewcommand{\headrulewidth}{0pt}
    \fancyhf{}
    \fancyfoot[R]{\thepage\ av \pageref{LastPage}}
}

\usepackage{parskip} % Make paragraphs two line skips instead of indent

% Make quotes around some text
\newcommand{\quotes}[1]{"#1"}
\newcommand{\q}[1]{"#1"}

% Make a tuple-command
\newcommand{\tuple}[1]{\left\langle#1\right\rangle}

% Highlightcommand 
\DeclareRobustCommand{\hl}[1]{{\colorbox{yellow}{#1}}}
\DeclareRobustCommand{\hlc}[2]{{\colorbox{#1}{#2}}}

% Hyber-linkable sections
\newcommand{\hsec}[2]{{\pagebreak\section*{#1}\label{sec:#2}}}
\newcommand*{\refsec}[1]{\hyperref[{sec:#1}]{\ref*{sec:#1} \nameref*{sec:#1}}}
% Hyber-linkable sub_sections
\newcommand{\hsubsec}[2]{{\subsection*{#1}\label{sssec:#2}}}
\newcommand*{\refsubsec}[1]{{\ref{sssec:#1}}}
% Header-safe math
\newcommand{\hsafem}[1]{{\texorpdfstring{#1}{[math]}}}

% Code
\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}

\lstdefinestyle{mystyle}{
    backgroundcolor=\color{backcolour},   
    commentstyle=\color{codegreen},
    keywordstyle=\color{magenta},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\footnotesize,
    breakatwhitespace=false,         
    breaklines=true,                 
    captionpos=b,                    
    keepspaces=true,                 
    numbers=left,                    
    numbersep=5pt,                  
    showspaces=false,                
    showstringspaces=false,
    showtabs=false,                  
    tabsize=2
}

\lstset{style=mystyle}

\usepackage[ruled,vlined,linesnumbered]{algorithm2e}
\usepackage{algorithmic}
