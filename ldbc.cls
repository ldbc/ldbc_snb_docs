\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ldbc}

\ProcessOptions
\LoadClass[11pt,oneside,openany,a4paper]{book}
\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\RequirePackage{epsfig}
\RequirePackage{color}
\RequirePackage{url}
\RequirePackage{ifthen}
\RequirePackage{amssymb}
\RequirePackage{longtable}
\RequirePackage{helvet}
\RequirePackage{tgtermes}
\RequirePackage{relsize}
\RequirePackage[T1]{fontenc}
\RequirePackage{lastpage}
\RequirePackage{multirow}
\RequirePackage{xspace}

\newif\if@contributor

% Utility commands for writing to .aux file
\newcommand{\auxwrite}[1]{\protected@write\@auxout{}{#1}}
\newcommand{\writelabel}[3]{\auxwrite{\string\newlabel{#1}{{#2}{#3}}}}

% Information about the deliverable

\newcommand{\wpIDText}{WPx}
\newcommand{\WP}[1]{\renewcommand{\wpIDText}{WP#1}}
\newcommand{\wpTitleText}{Set WP title using WPTitle}
\newcommand{\WPTitle}[1]{\renewcommand{\wpTitleText}{#1}}

\newcommand{\delIDText}{D<xxx>}
\newcommand{\delID}[1]{\renewcommand{\delIDText}{D#1}}
\newcommand{\delNameText}{Specify deliverable name using delName}
\newcommand{\delName}[1]{\renewcommand{\delNameText}{#1}}

\newcommand{\dueContractualText}{M12}
\newcommand{\dueDate}[1]{\renewcommand{\dueContractualText}{#1}}
\newcommand{\dueActualText}{M12}
\newcommand{\submissionDate}[1]{\renewcommand{\dueActualText}{#1}}
\newcommand{\keywordsText}{}
\newcommand{\keywords}[1]{\renewcommand{\keywordsText}{#1}}

\newcounter{dissemination-level}
\newcommand{\dissPU}{\setcounter{dissemination-level}{1}}
\newcommand{\dissRE}{\setcounter{dissemination-level}{2}}
\newcommand{\dissPP}{\setcounter{dissemination-level}{3}}
\newcommand{\dissCO}{\setcounter{dissemination-level}{4}}
\newcommand{\disseminationLevelText}[1][\value{dissemination-level}]{%
  \ifthenelse{#1=1}{Public (PU)}{%
  \ifthenelse{#1=2}{Restricted to group (RE)}{%
  \ifthenelse{#1=3}{Restricted to programme (PP)}{%
  \ifthenelse{#1=4}{Consortium (CO)}{}}}}%
}

\newcounter{nature-level}
\newcommand{\natR}{\setcounter{nature-level}{1}}
\newcommand{\natP}{\setcounter{nature-level}{2}}
\newcommand{\natD}{\setcounter{nature-level}{3}}
\newcommand{\natO}{\setcounter{nature-level}{4}}
\newcommand{\natureText}[1][\value{nature-level}]{%
  \ifthenelse{#1=1}{Report (R)}{%
  \ifthenelse{#1=2}{Prototype (P)}{%
  \ifthenelse{#1=3}{Demonstrator (D)}{%
  \ifthenelse{#1=4}{Other (O)}{}}}}%
}

\newcommand{\authorText}{[names of main authors]}
\renewcommand{\author}[1]{\renewcommand{\authorText}{#1}}

\newcommand{\authorPartnerText}{names of main authors (with partner names in parentheses)}
\newcommand{\authorPartner}[1]{\renewcommand{\authorPartnerText}{#1}}

\newcommand{\contributorText}{[names of contributors]}
\newcommand{\contributor}[1]{\renewcommand{\contributorText}{#1}\@contributortrue}

\newcommand{\reviewerOneText}{[name]}
\newcommand{\reviewerOne}[1]{\renewcommand{\reviewerOneText}{#1}}

\newcommand{\reviewerTwoText}{[name]}
\newcommand{\reviewerTwo}[1]{\renewcommand{\reviewerTwoText}{#1}}

\newcommand{\responsibleAuthorText}{name}
\newcommand{\responsibleAuthor}[1]{\renewcommand{\responsibleAuthorText}{#1}}

\newcommand{\responsiblePartnerText}{partner}
\newcommand{\responsiblePartner}[1]{\renewcommand{\responsiblePartnerText}{#1}}

\newcommand{\responsibleEmailText}{email address}
\newcommand{\responsibleEmail}[1]{\renewcommand{\responsibleEmailText}{#1}}

\newcommand{\responsiblePhoneText}{phone number}
\newcommand{\responsiblePhone}[1]{\renewcommand{\responsiblePhoneText}{#1}}


\newcommand{\documentUrlText}{}
\newcommand{\documentUrl}[1]{\renewcommand{\documentUrlText}{#1}}

\newcommand{\abstractText}{}
\newcommand{\abstract}[1]{\renewcommand{\abstractText}{#1}}

\newcommand{\execSummaryText}{}
\newcommand{\execSummary}[1]{\renewcommand{\execSummaryText}{#1}}

\newcommand{\versionLogText}{}
\newcommand{\lastVersionText}{}
\newcommand{\versionLog}[1]{\renewcommand{\versionLogText}{#1}}
\newcommand{\versionLogEntry}[4]{%
    #1 \T & \@spacer{}#2 & \@spacer{}\parbox[t]{4.6cm}{\raggedright #3 \B} & \@spacer{}\parbox[t]{6.6cm}{\raggedright #4 \B} \\%
    \hline%
}
\newcommand{\lastVersion}[1]{\renewcommand{\lastVersionText}{#1}}
\newcounter{isfinal}
\setcounter{isfinal}{0}
\newcommand{\final}{\setcounter{isfinal}{1}}

% Page sizes and general layout for the 'report' variant

\renewcommand\RSlargest{50pt}

\newcommand{\normalLayout}{%
    \setlength{\hoffset}{-.5cm}%
    \setlength{\textwidth}{17.0cm}%
    \setlength{\evensidemargin}{0cm}%
    \setlength{\oddsidemargin}{0cm}%
    %
    \setlength{\textheight}{24.5cm}%
%    \setlength{\voffset}{-.7cm}%
%    \setlength{\topmargin}{0cm}%
%    \setlength{\headheight}{1.5cm}%
%    \setlength{\headsep}{0.8cm}%
    \renewcommand{\headrulewidth}{0.2pt}%
    \renewcommand{\footrulewidth}{0.2pt}%
}
\normalLayout
\clubpenalty=9999
\widowpenalty=9999
\raggedbottom

% Header setup


\newcommand{\ldbcsnbdocversion}{0.3.0}
\newcommand{\ldbcsnbdoctitle}{LDBC Social Network Benchmark (SNB) -- \ldbcsnbdocversion}

\newcommand{\mainmatterheadingr}{\relscale{.92}}
\newcommand{\mainmatterheadingl}{\relscale{.92}\ldbcsnbdoctitle}
\pagestyle{fancy}
\fancyhead{}
\fancyhead[LO,RE]{\nouppercase{\leftmark}}
\fancyhead[RO,LE]{\nouppercase{\rightmark}}
\fancyfoot{}
\fancyfoot[LO,RE]{\mainmatterheadingl}
\fancyfoot[RO,LE]{Page \thepage{} of \pageref*{LastPage}}

% Customizations of the book style

% this command is overridden so that it does not kill the headers and footers
\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                \global\@topnum\z@
                \@afterindentfalse
                \secdef\@chapter\@schapter}
\renewcommand\mainmatter{%
    %\if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue
  %\pagenumbering{arabic}
}


% this command is overridden so that it formats the chapter as I want
\def\@makechapterhead#1{{\noindent \normalfont\Large\scshape \thechapter \space #1}\par \vskip 15\p@}
\def\@makeschapterhead#1{{\noindent \normalfont\Large\scshape #1}\par \vskip 15\p@}
\renewcommand\section{\@startsection {section}{1}{\z@}{-3.5ex \@plus -1ex \@minus -.2ex}{2.3ex \@plus.2ex}{\normalfont\Large}}
\renewcommand{\bibname}{References}
\renewcommand\contentsname{Table of Contents}
\renewcommand*\l@chapter[2]{%
\ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
    \parindent \z@ \rightskip \@pnumwidth
    \parfillskip -\@pnumwidth
    \leavevmode \scshape
    \advance\leftskip\@tempdima
    \hskip -\leftskip
    #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \penalty\@highpenalty
    \endgroup
\fi}

% The title page

% two arguments: counter and value
\newcommand{\boolTick}[2]{\ifthenelse{\value{#1}=#2}{$\boxtimes$}{$\Box$}}

\def\@spacer{\hspace*{2mm}}

\newcommand{\ldbcdatatitlepage}{%
    \normalLayout%
    \setlength{\voffset}{-2.15cm}%
    \thispagestyle{empty}%
    %\renewcommand{\headrulewidth}{0pt}%
    \noindent \setlength{\unitlength}{1mm}%
    \begin{center}%
        \hspace{.5mm}
        \includegraphics[height=7cm]{figures/ldbc-logo.pdf} \hfill
    \end{center}%
    {\vspace{1.8cm}%
%        \begin{center}%
%          {\Huge\bfseries LDBC} \\[4mm]%
%          {\Large\bfseries Cooperative Project}\\[3mm]%
%          {\Large\bfseries FP7 -- 317548}\\%
%        \end{center}%
        %
        \newcommand\T{\rule{0pt}{4.5mm}}%
        \newcommand\B{\rule[-2.5mm]{0pt}{0pt}}%
        \LARGE
        \begin{tabular}{c}\hspace*{16.6cm}\\[9mm]%
          \hline\Huge\relscale{1.15}%
          \parbox{16cm}{\vspace{3mm}\centering\bfseries \T \delIDText{} \delNameText \B} \\[3mm]%
        \hline%
%        \parbox[t]{16cm}{\centering\bfseries \vspace{0mm} Coordinator: \authorText \B} \\%
%        \if@contributor\parbox[t]{16cm}{\centering\bfseries \vspace{-3mm} With contributions from: \contributorText} \\\fi%
%        \normalsize%
%        \parbox{16cm}{\centering\bfseries 1\textsuperscript{st} Quality Reviewer: \reviewerOneText} \\[-3mm]%
%        \normalsize%
%        \parbox{16cm}{\centering\bfseries 2\textsuperscript{nd} Quality Reviewer: \reviewerTwoText} \\%
        \end{tabular}%

        \vspace{1cm}%
        \normalsize%
%        \noindent\begin{tabular}{|p{4.0cm};{1pt/1pt}p{12.2cm}|}%
%         & \\[-1.05em]% % this is here to avoid a gap caused by hdashlines
%        \hline%
%        Deliverable nature: \T \B & \natureText \\%
%        \hdashline[1pt/1pt]%
%        \T \parbox[t]{3.8cm}{Dissemination level:\\\footnotesize (Confidentiality)\B}  & \disseminationLevelText \\%
%        \hdashline[1pt/1pt]%
%        \T Contractual delivery date:\B & \dueContractualText \\%
%        \hdashline[1pt/1pt]%
%        \T Actual delivery date: \B & \dueActualText \\%
%        \hdashline[1pt/1pt]%
%        \T Version: \B & \lastVersionText \\%
%        \hdashline[1pt/1pt]%
%        \T Total number of pages: \B & \pageref{LastPage} \\%
%        \hdashline[1pt/1pt]%
%        \T Keywords: \B & \keywordsText \\%
%        \hline%
%        \end{tabular}%
%        \newpage%
%        \newpage%
%        \normalLayout%
%        \noindent\begin{tabular}{@{}c@{}}\\[-10mm]%
%        \hline%
%        \emph{\bfseries \T Abstract} \\[2mm]%
%        \parbox[t]{17.0cm}{\abstractText } \B \\%
%            \hline%
%        \end{tabular}%
        \newpage%
        \normalLayout%
%        \noindent\begin{tabular}{@{}c@{}}\\[-10mm]%
%        %\hline%
        \chapter*{Abstract}%
%        \emph{\bfseries \T Abstract} \\[2mm]%
%        \parbox[t]{17.0cm}{\abstractText } \B \\%
%            \hline%
%        \end{tabular}%
		\abstractText
        \newpage%
%        \addcontentsline{toc}{chapter}{Executive Summary}%
        \chapter*{Executive Summary}%
        \execSummaryText%
        \newpage%
%        \renewcommand\T{\rule{0pt}{3.5mm}}%
%        \renewcommand\B{\rule[-1.5mm]{0pt}{0pt}}%
%        \addcontentsline{toc}{chapter}{Document Information}%
%        \chapter*{Document Information}%
%        \noindent\begin{tabular}{|@{\@spacer}p{3.9cm}@{}|@{}p{4.3cm}@{}|@{}p{4.3cm}@{}|@{}p{4.3cm}@{}|}%
%        \hline%
%        \textbf{IST Project Number} \T\B  & \@spacer{}FP7 -- 317548 & \@spacer{}\textbf{Acronym} & \@spacer{}LDBC \\%
%        \hline%
%        \textbf{Full Title} \T\B          & \multicolumn{3}{p{10cm}@{\@spacer}|}{LDBC} \\%
%        \hline%
%        \textbf{Project URL} \T\B         & \multicolumn{3}{p{10cm}@{\@spacer}|}{http://www.ldbc.eu/} \\%
%        \hline%
%        \textbf{Document URL} \T\B        & \multicolumn{3}{p{10cm}@{\@spacer}|}{\documentUrlText }\\%
%        \hline%
%        \textbf{EU Project Officer} \T\B  & \multicolumn{3}{p{10cm}@{\@spacer}|}{Carola Carstens} \\%
%        \hline%
%        \end{tabular} \vspace{1em} \par%
%        \noindent\begin{tabular}{|@{\@spacer}p{3.9cm}@{}|@{}p{2.15cm}@{}|@{}p{2.15cm}@{}|@{}p{2.15cm}@{}|@{}p{6.45cm}@{}|}%
%        \hline%
%        \textbf{Deliverable} \T  & \@spacer{}\textbf{Number} & \@spacer{}\delIDText & \@spacer{}\textbf{Title} & \@spacer{}\parbox[t]{6.05cm}{\raggedright\delNameText\B} \\%
%        \hline%
%        \textbf{Work Package} \T  & \@spacer{}\textbf{Number} & \@spacer{}\wpIDText & \@spacer{}\textbf{Title} & \@spacer{}\parbox[t]{6.05cm}{\raggedright\wpTitleText\B} \\%
%        \hline%
%        \end{tabular} \vspace{1em} \par%
%        \noindent\begin{tabular}{|@{\@spacer}p{3.9cm}@{}|@{}p{3.225cm}@{}|@{}p{3.225cm}@{}|@{}p{3.225cm}@{}|@{}p{3.225cm}@{}|}%
%        \hline%
%        \textbf{Date of Delivery} \T\B & \@spacer{}\textbf{Contractual} & \@spacer{}\dueContractualText & \@spacer{}\textbf{Actual} & \@spacer{}\dueActualText \\%
%        \hline%
%        \textbf{Status} \T\B          & \multicolumn{2}{c|}{version \lastVersionText} & \multicolumn{2}{l|}{final \footnotesize\boolTick{isfinal}{1}} \\%
%        \hline%
%        \textbf{Nature} \T\B
%        & \multicolumn{4}{l|}{\footnotesize\natureText[1]~\boolTick{nature-level}{1}~~%
%                              \natureText[2]~\boolTick{nature-level}{2}~~%
%                              \natureText[3]~\boolTick{nature-level}{3}~~%
%                              \natureText[4]~\boolTick{nature-level}{4}} \\%
%        \hline%
%        \textbf{Dissemination Level} \T\B
%        & \multicolumn{4}{l|}{\footnotesize\disseminationLevelText[1]~\boolTick{dissemination-level}{1}~~%
%                              \disseminationLevelText[2]~\boolTick{dissemination-level}{2}~~%
%                              \disseminationLevelText[3]~\boolTick{dissemination-level}{3}~~%
%                              \disseminationLevelText[4]~\boolTick{dissemination-level}{4}} \\%
%        \hline%
%        \end{tabular} \vspace{1em} \par%
%        \noindent\begin{tabular}{|@{\@spacer}p{3.9cm}@{}|@{}p{2.15cm}@{}|@{}p{3.15cm}@{}|@{}p{2.15cm}@{}|@{}p{5.45cm}@{}|}%
%        \hline%
%        \textbf{Authors (Partner)} \T\B & \multicolumn{4}{p{12.5cm}|}{\raggedright \authorPartnerText} \\%
%        \hline%
%        \multirow{2}{*}{\textbf{Responsible Author}}
%                 & \@spacer{}\textbf{Name}    \T\B & \@spacer{}\parbox[t]{2.75cm}{\raggedright \responsibleAuthorText \B} & \@spacer{}\textbf{E-mail} & \@spacer{}\parbox[t]{5.05cm}{\raggedright \responsibleEmailText \B} \\%
%        \cline{2-5}%
%                 & \@spacer{}\textbf{Partner} \T\B & \@spacer{}\parbox[t]{2.75cm}{\raggedright \responsiblePartnerText \B} & \@spacer{}\textbf{Phone} & \@spacer{}\parbox[t]{5.05cm}{\raggedright \responsiblePhoneText \B} \\%
%        \hline%
%        \end{tabular} \vspace{1em} \par%
%        \noindent\begin{tabular}{|@{\@spacer}p{3.9cm}@{}|@{}p{12.9cm}@{}|}%
%        \hline%
%        \textbf{Abstract (for~disseminatio\-n)}\T\B & \@spacer{}\parbox[t]{12.5cm}{\raggedright\abstractText \B} \\%
%        \hline%
%        \textbf{Keywords} \T\B & \@spacer{}\keywordsText \\%
%        \hline%
%        \end{tabular} \vspace{1em} \par%
%        \noindent\begin{tabular}{|@{\@spacer}p{2.8cm}@{}|@{}p{2cm}@{}|@{}p{5cm}@{}|@{}p{7cm}@{}|}%
%        \hline%
%        \multicolumn{4}{|@{\@spacer}l@{}|}{\textbf{Version Log}\T\B} \\%
%        \hline%
%        \textbf{Issue Date\T\B} & \@spacer\textbf{Rev. No.} & \@spacer\textbf{Author} & \@spacer\textbf{Change} \\%
%        \hline%
%        \versionLogText%
%        \end{tabular}%
%        \newpage%
%todo table widths dont match - only fix I can think of is by hand adjust last width
%
%
%       Activity: & \multicolumn{2}{p{10.8cm}@{\@spacer}|}{\ActivityText{}: \ActivityNameText} \\
%       \hline%
%       Work Package: & \multicolumn{2}{l@{\@spacer}|}{\WPText{}: \WPNameText} \\
%       \hline%
%       \multicolumn{2}{|@{\@spacer}p{9.5cm}@{\@spacer}|@{\@spacer}}{Due Date:} & \dueContractualText \\
%       \hline%
%       \multicolumn{2}{|@{\@spacer}p{9.5cm}@{\@spacer}|@{\@spacer}}{Submission Date:} & \dueActualText \\
%       \hline%
%       \multicolumn{2}{|@{\@spacer}p{9.5cm}@{\@spacer}|@{\@spacer}}{Start Date of Project:} & 01/03/2008 \\
%       \hline%
%       \multicolumn{2}{|@{\@spacer}p{9.5cm}@{\@spacer}|@{\@spacer}}{Duration of Project:} & 36 Months \\
%       \hline%
%       \multicolumn{2}{|@{\@spacer}p{9.5cm}@{\@spacer}|@{\@spacer}}{Organisation Responsible for Deliverable:} & \responsibleText \\
%       \hline%
%       \multicolumn{2}{|@{\@spacer}p{9.5cm}@{\@spacer}|@{\@spacer}}{Revision:} & \lastVersionText \\
%       \hline%
%       Author(s): & \multicolumn{2}{l@{\@spacer}|}{\parbox[t]{10.8cm}{\authorText}} \\
%       \hline%
%       Reviewers: & \multicolumn{2}{l@{\@spacer}|}{\parbox[t]{10.8cm}{\reviewerPartnerText}} \\
%       \hline%
%        \textbf{Deliverable}        & \textbf{Number}   & \delIDText    & \textbf{Title}    & \delNameText \\
%        \hline%
%        \textbf{Work Package}       & \textbf{Number}   & \WPText       & \textbf{Title}    & \WPNameText \\
%
%       \setlength{\voffset}{-.7cm}%
%       \renewcommand{\headrulewidth}{0.2pt}%
%       %
%       \noindent\begin{tabular}{|@{\@spacer}p{1.0cm}@{\@spacer}|@{\@spacer}p{13cm}@{\@spacer}|@{\@spacer}c@{\@spacer}|}%
%       \hline%
%       \multicolumn{3}{|@{\@spacer}p{15.4cm}@{\@spacer}|}{\footnotesize Project co-funded by the European Commission within the Seventh Framework Programme (2007--2013)} \\
%       \hline%
%       \multicolumn{3}{|@{\@spacer}c@{\@spacer}|}{Dissemination Level} \\
%       \hline%
%       PU & {\small Public } & \boolTick{dissemination-level}{1} \\
%       \hline%
%       PP & {\small Restricted to other programme participants (including the Commission) } & \boolTick{dissemination-level}{2} \\
%       \hline%
%       RE & {\small Restricted to a group specified by the consortium (including the Commission) } & \boolTick{dissemination-level}{3} \\
%       \hline%
%       CO & {\small Confidential, only for members of the consortium (including the Commission) } & \boolTick{dissemination-level}{4} \\
%       \hline%
%       \end{tabular} \vspace{0.7cm} \par%
%       %
%       \newpage%
%       \noindent\begin{tabular}{|@{\@spacer}p{1.5cm}@{\@spacer}|@{\@spacer}p{2.5cm}@{\@spacer}|@{\@spacer}p{5.8cm}@{\@spacer}|@{\@spacer}p{5cm}@{\@spacer}|}%
%       \multicolumn{4}{c}{\Large\textbf{Version History}} \vspace{2mm}\\%
%       \hline%
%       \textbf{Version} & \textbf{Date}  & \textbf{Comments, Changes, Status}   & \textbf{Authors, Reviewers} \\%
%       \hline%
%       \versionLogText%
%       \end{tabular} \par%
%

    } %\newpage \normalLayout \fancyhead[OL,EL]{\mainmatterheadingl}\fancyhead[OR,ER]{\mainmatterheadingr}%
}

\renewcommand{\maketitle}{%
    \frontmatter%
    \pagenumbering{arabic}%
    \ldbcdatatitlepage%
    \tableofcontents%
%    \newcounter{pagesinfront}%
%    \setcounter{pagesinfront}{\value{page}}%
    \mainmatter%
%    \addtocounter{page}{\value{pagesinfront}}%
}

\newcommand{\ie}{i.e.\@\xspace}
\newcommand{\Ie}{I.e.\@\xspace}
\newcommand{\eg}{e.g.\@\xspace}
\newcommand{\Eg}{E.g.\@\xspace}
\newcommand{\etal}{et al.\@\xspace}
\newcommand{\etc}{etc.\@\xspace}
\newcommand{\vs}{vs.\@\xspace}
\newcommand{\viz}{viz.\@\xspace}
