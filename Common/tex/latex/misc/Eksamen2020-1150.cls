\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Eksamen2020-1150}[Klasse som formaterer etter kravene til eksamen våren 2020 ved IFI UiO.]
\LoadClass[norsk,11pt,a4paper]{article}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[norsk]{babel}

\usepackage{blindtext} % to quickly get a full document

\usepackage[hidelinks]{hyperref}
\usepackage[all]{hypcap}
\usepackage{lastpage}

\RequirePackage{titling}

\RequirePackage[dvipsnames]{xcolor}
\usepackage{tabularx}

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
\usepackage{listofitems}
\usepackage{mathtools}
\usepackage{ifthen}
\usepackage{lmodern}

\usepackage{attachfile}
\usepackage{pdfpages}
\usepackage{booktabs}
\usepackage{tikz}
\usepackage[small,euler-digits]{eulervm}
\usepackage{braket}
\usetikzlibrary{tikzmark}

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
\newcommand{\hsec}[2]{{\pagebreak\section{#1}\label{sec:#2}}}
\newcommand*{\refsec}[1]{\hyperref[{sec:#1}]{\ref*{sec:#1} \nameref*{sec:#1}}}
% Hyber-linkable sub_sections
\newcommand{\hsubsec}[2]{{\subsection{#1}\label{sssec:#2}}}
\newcommand*{\refsubsec}[1]{{\ref{sssec:#1}}}
% Header-safe math
\newcommand{\hsafem}[1]{{\texorpdfstring{#1}{[math]}}}

% Colored bitstrings
\newcommand{\bitstr}[1]{{\textcolor{RoyalBlue}{#1}}}

% 3*2 tabeller
\newcommand{\blockThreeTwo}[1]{{
    \mathrel{\readlist*\args{#1}
    \begin{tikzpicture}[align=center, baseline={([yshift=-.5ex]current bounding box.center)}]
        \node[minimum size=0.6cm, align=center] at (0.0, 0.0) {\small \args[5]};
        \node[minimum size=0.6cm, align=center] at (0.6, 0.0) {\args[6]};
        \node[minimum size=0.6cm, align=center] at (0.0, 0.6) {\args[3]};
        \node[minimum size=0.6cm, align=center] at (0.6, 0.6) {\args[4]};
        \node[minimum size=0.6cm, align=center] at (0.0, 1.2) {\args[1]};
        \node[minimum size=0.6cm, align=center] at (0.6, 1.2) {\args[2]};
        \draw (-0.3, -0.3) -- (0.9, -0.3);
        \draw (-0.3, 1.5) -- (0.9, 1.5);
        \draw (-0.3, -0.3) -- (-0.3, 1.5);
        \draw (0.9, -0.3) -- (0.9, 1.5);
        \draw (0.3, -0.3) -- (0.3, 1.5);
        \draw (-0.3, 0.3) -- (0.9, 0.3);
        \draw (-0.3, 0.9) -- (0.9, 0.9);
    \end{tikzpicture}}
}}
\newcommand{\blockThreeTwoCol}[1]{{
        \readlist*\args{#1}
        \begin{tikzpicture}[align=center, baseline={([yshift=-.5ex]current bounding box.center)}]
        
        \ifthenelse{\equal{\args[5]}{\string 1}}
          {\filldraw[fill=black, draw=black] (-0.3,-0.3) rectangle (0.3,0.3);}
          {\filldraw[fill=white, draw=black] (-0.3,-0.3) rectangle (0.3,0.3);}
       
        \ifthenelse{\equal{\args[6]}{\string 1}}
          {\filldraw[fill=black, draw=black] (0.3,-0.3) rectangle (0.9,0.3);}
          {\filldraw[fill=white, draw=black] (0.3,-0.3) rectangle (0.9,0.3);}
        
        \ifthenelse{\equal{\args[3]}{\string 1}}
          {\filldraw[fill=black, draw=black] (-0.3,0.3) rectangle (0.3,0.9);}
          {\filldraw[fill=white, draw=black] (-0.3,0.3) rectangle (0.3,0.9);}
          
        \ifthenelse{\equal{\args[4]}{\string 1}}
          {\filldraw[fill=black, draw=black] (0.3,0.3) rectangle (0.9,0.9);	}
          {\filldraw[fill=white, draw=black] (0.3,0.3) rectangle (0.9,0.9);}
          
        \ifthenelse{\equal{\args[1]}{\string 1}}
          {\filldraw[fill=black, draw=black] (-0.3,0.9) rectangle (0.3,1.5);}
          {\filldraw[fill=white, draw=black] (-0.3,0.9) rectangle (0.3,1.5);}
          
        \ifthenelse{\equal{\args[2]}{\string 1}}
          {\filldraw[fill=black, draw=black] (0.3,0.9) rectangle (0.9,1.5);}
          {\filldraw[fill=white, draw=black] (0.3,0.9) rectangle (0.9,1.5);}

        \end{tikzpicture}
}}

\tikzset{round node graph/.style={circle,fill=blue!20,minimum size=1cm}}
\tikzset{square node graph/.style={circle,fill=blue!20,font=\scriptsize}}
\tikzset{edge graph/.style={thick}}
\definecolor{rotnodecol}{RGB}{52, 103, 199}
\definecolor{lovnodecol}{RGB}{235, 63, 223}
\tikzset{rotnode tre/.style={circle, fill=rotnodecol, scale=0.7}}
\tikzset{lovnode tre/.style={circle, fill=lovnodecol, minimum size=4mm, scale=0.7}}
\tikzset{kant tre/.style={thick}}

\newcommand{\dcol}{\> \textcolor{Bittersweet}{::}\> }
\newcommand{\ddcol}{\> \textcolor{Bittersweet}{:::}\> }
\newcommand{\Emptyset}{\> \text{\o}\> }
