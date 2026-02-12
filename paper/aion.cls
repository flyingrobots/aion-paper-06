\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{aion}[2025/12/07 AIΩN Foundations Series Class]

\LoadClass[11pt]{article}

% ------------------------------------------------------------
% Packages
% ------------------------------------------------------------
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{amsmath, amssymb, amsfonts, amsthm}
\RequirePackage{microtype}
\RequirePackage{geometry}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{titlesec}
\RequirePackage{tocloft}
\RequirePackage{enumitem}
\RequirePackage{booktabs}
\RequirePackage{chngcntr}
\RequirePackage{hyperref}

% ------------------------------------------------------------
% Geometry
% ------------------------------------------------------------
\geometry{
    margin=1in,
}

% ------------------------------------------------------------
% Colors (brand)
% ------------------------------------------------------------
\definecolor{AIONBlue}{RGB}{20, 60, 120}
\definecolor{AIONAccent}{RGB}{120, 20, 120}

% ------------------------------------------------------------
% Hyperref
% ------------------------------------------------------------
\hypersetup{
    colorlinks=true,
    linkcolor=AIONBlue,
    citecolor=AIONBlue,
    urlcolor=AIONAccent,
    hypertexnames=false
}

% ------------------------------------------------------------
% Section Titles
% ------------------------------------------------------------
\titleformat{\section}
  {\large\bfseries\color{AIONBlue!85!black}}
  {\thesection}{0.5em}{}

\titleformat{\subsection}
  {\normalsize\bfseries\color{AIONBlue!85!black}}
  {\thesubsection}{0.5em}{}

% Reset figure numbering by section for cleaner hyperlinks
\counterwithin{figure}{section}
\renewcommand{\theHfigure}{\thesection.\arabic{figure}}

% ------------------------------------------------------------
% Theorem Environments
% ------------------------------------------------------------
\theoremstyle{definition}
\newtheorem{definition}{Definition}[section]
\newtheorem{assumption}[definition]{Assumption}

\theoremstyle{plain}
\newtheorem{proposition}[definition]{Proposition}
\newtheorem{theorem}[definition]{Theorem}
\newtheorem{lemma}[definition]{Lemma}
\newtheorem{corollary}[definition]{Corollary}

\theoremstyle{remark}
\newtheorem{remark}[definition]{Remark}
\newtheorem{example}[definition]{Example}

% ------------------------------------------------------------
% Metadata Commands
% ------------------------------------------------------------
\newcommand{\papertitle}{}
\newcommand{\papernumber}{}
\newcommand{\paperversion}{}
\newcommand{\paperdate}{}
\newcommand{\paperauthor}{}
\newcommand{\paperaffiliation}{}
\newcommand{\paperorcid}{}
\newcommand{\paperdoi}{}

\newcommand{\AION@require}[2]{%
  \ifx#1\empty
    \ClassError{aion}{#2 not set}{You must define #2 before \string\AIONTitlePage}
  \fi
}

\newcommand{\AIONTitlePage}{
    \AION@require{\papertitle}{\string\papertitle}
    \AION@require{\papernumber}{\string\papernumber}
    \AION@require{\paperauthor}{\string\paperauthor}
    \AION@require{\paperdate}{\string\paperdate}

    \thispagestyle{empty}
    \begin{center}

        % Nudge the block slightly downward for visual gravity
        \vspace*{1.5cm}

        % Title (primary anchor)
        {\Huge\bfseries \papertitle \par}
        \vspace{14pt}

        % Series / paper number (subtitle energy)
        {\normalsize\scshape\color{AIONBlue}
        AI$\Omega$N Foundations Series — \papernumber \par}

        \vspace{16pt}

        % Author block (confident, quiet)
        {\large
        \paperauthor \par}
        \vspace{4pt}

        {\normalsize
        \paperaffiliation \\
        ORCID: \paperorcid \par}

        \vspace{10pt}

        {\normalsize
        \paperdate \par}

        \ifx\paperdoi\empty\else
          \vspace{10pt}
          {\normalsize
          DOI: \href{https://doi.org/\paperdoi}{\paperdoi}\par}
        \fi

    \end{center}

    \vspace{2cm}
}

\newcommand{\AIONLegalPage}{
\cleardoublepage
\thispagestyle{empty}

\begin{center}
{\small
\vspace*{\fill}

\textcopyright~2025 James Ross\\[0.75em]

This work is licensed under the\\
\textbf{Creative Commons Attribution 4.0 International License (CC BY 4.0).}\\[1em]

You are free to:
\begin{itemize}[leftmargin=2em]
  \item \textbf{Share} — copy and redistribute the material in any medium or format
  \item \textbf{Adapt} — remix, transform, and build upon the material for any purpose
\end{itemize}

Under the following terms:
\begin{itemize}[leftmargin=2em]
  \item \textbf{Attribution} — You must give appropriate credit, provide a link to the license,\\
        and indicate if changes were made. You may not imply endorsement by the author.
\end{itemize}

For the full legal code of the license, see:\\[0.25em]
\url{https://creativecommons.org/licenses/by/4.0/}

\vspace*{\fill}
}
\end{center}

\cleardoublepage
}

\newcommand{\AIONFrontMatter}[1]{
    % 1. Title Page
    \AIONTitlePage

    % 2. Legal Page
    \AIONLegalPage

    % 3. Abstract (on its own page)
    \cleardoublepage
    \begin{abstract}
        #1
    \end{abstract}

    % 4. Table of Contents (on its own page)
    \cleardoublepage
    \tableofcontents
    \cleardoublepage
}

% ------------------------------------------------------------
% Table of Contents formatting
% ------------------------------------------------------------

\endinput
