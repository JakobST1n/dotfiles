\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{StdOblig}[Standar Oblig Class]

\LoadClass[norsk,11pt,a4paper]{article}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[norsk]{babel}

\usepackage{lastpage}
\usepackage{fancyhdr}
\pagestyle{fancy} 

\usepackage{hyperref}
\usepackage[all]{hypcap}

\usepackage[normalem]{ulem}

\RequirePackage{xcolor}
\RequirePackage{soul}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage{graphicx}
\usepackage{float}
\usepackage{multicol}
\usepackage{colortbl}
\usepackage{xcolor}
\usepackage{svg}
\usepackage{tabularx}

\usepackage{attachfile}
\usepackage{pdfpages}
\usepackage{booktabs}
\usepackage{tikz}
\usepackage[small,euler-digits]{eulervm}
\usepackage{braket}

\usepackage{graphicx}
\usepackage{caption}
\usepackage{subcaption}

\newcommand{\headlinecolor}{\normalcolor}

% Page X of Y
\cfoot{\thepage\ of \pageref{LastPage}}

% Simple indent for subitems
\newcommand{\SubItem}[1]{
    {\setlength\itemindent{15pt} \item[-] #1}
}

% Make quotes around some text
\newcommand{\quotes}[1]{"#1"}
\newcommand{\q}[1]{"#1"}

% Hyber-linkable sections
\newcommand{\hsec}[2]{{\pagebreak\section{#1}\label{sec:#2}}}
\newcommand*{\refsec}[1]{\hyperref[{sec:#1}]{\ref*{sec:#1} \nameref*{sec:#1}}}
% Hyber-linkable sub_sections
\newcommand{\hsubsec}[2]{{\subsection{#1}\label{sssec:#2}}}
\newcommand*{\refsubsec}[1]{{\ref{sssec:#1}}}

% Make a tuple-command
\newcommand{\tuple}[1]{\langle #1 \rangle}

% Highlightcommand 
\DeclareRobustCommand{\hl}[1]{{\colorbox{yellow}{#1}}}
\DeclareRobustCommand{\hlc}[2]{{\colorbox{#1}{#2}}}

% Make new thing for draftonly
\newif\ifdraft
\draftfalse

