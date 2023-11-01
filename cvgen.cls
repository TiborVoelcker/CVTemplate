%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is cvgen.cls, which is a Template for an application letter
% and cv, written by Tibor Völcker (tiborvoelcker@hotmail.de)
% 
% It is partly based on altacv.cls written by LianTze Lim
% (https://github.com/liantze/AltaCV).

\ProvidesClass{cvgen}[CV and Cover Letter generator.]

\LoadClass{article}

%%%%%%%%%%%%%%%%%%%% Packages %%%%%%%%%%%%%%%%%%%%
\RequirePackage[fixed]{fontawesome5}
\RequirePackage[margin=2cm]{geometry}
%\geometry{left=2.5cm,right=2.5cm,top=2.5cm,bottom=1cm,columnsep=1.15cm}
\RequirePackage{tikz}
\RequirePackage[skins]{tcolorbox}
\usetikzlibrary{tikzmark}
\RequirePackage[skins]{tcolorbox}
\RequirePackage[ddmmyyyy]{datetime}
\renewcommand{\dateseparator}{.}
\RequirePackage{xparse}
\RequirePackage[inline]{enumitem}
\RequirePackage{relsize}
\RequirePackage{dashrule}
\RequirePackage{calc}
\RequirePackage{changepage}

%%%%%%%%%%%%%%%%%%%% Standard Colors and Styles %%%%%%%%%%%%%%%%%%%%
\colorlet{background}{white}
\colorlet{header}{black!20!white}
\colorlet{accent}{black!40!white}
\colorlet{headerfont}{background}
\colorlet{bodyfont}{black!70!white}
\colorlet{symbols}{header}

\newcommand{\itemmarker}{{\textbullet}}
\newcommand{\ratingmarker}{\faCircle}

\newcommand{\titlefont}{\Huge\bfseries}
\newcommand{\sectionfont}{\Large\bfseries}
\newcommand{\subsectionfont}{\large}
\newcommand{\bodyfont}{\normalsize}

\newcommand{\letterbodyfont}{\bodyfont}
\newcommand{\letteraddressfont}{\letterbodyfont}
\newcommand{\lettertitlefont}{\titlefont}
\newcommand{\letterinfofont}{\letterbodyfont}
\newcommand{\cvtitlefont}{\titlefont}
\newcommand{\cvsubtitlefont}{\sectionfont}
\newcommand{\cvsectionfont}{\sectionfont}
\newcommand{\cvitemtitlefont}{\subsectionfont\bfseries}
\newcommand{\cvitemsubtitlefont}{\subsectionfont}
\newcommand{\cvitemfont}{\bodyfont}

%%%%%%%%%%%%%%%%%%%% Variables %%%%%%%%%%%%%%%%%%%%
\newlength{\@photodim}
\newcommand{\companyaddress}[1]{\def\@companyaddress{#1}}
\renewcommand{\title}[1]{\def\@title{#1}}
\newcommand{\photo}[2]{\def\@photo{#1}
  \setlength{\@photodim}{#2}}
\newcommand{\city}[1]{\def\@city{#1}}
\newcommand{\postalcode}[1]{\def\@postalcode{#1}}
\newcommand{\street}[1]{\def\@street{#1}}
\newcommand{\phone}[1]{\def\@phone{#1}}
\newcommand{\email}[1]{\def\@email{#1}}
\newcommand{\birthday}[1]{\def\@birthday{#1}}

%%%%%%%%%%%%%%%%%%%% Cover Letter %%%%%%%%%%%%%%%%%%%%
\NewDocumentEnvironment{letter}{ m s +b }{
  \letterheader{#1}{#2} {\letterbodyfont\color{bodyfont}{#3}}\hfill {\letterbodyfont\color{bodyfont}\@city, \today}
  \letterfootnote }

\newcommand{\letterheader}[2]{%
\begin{tikzpicture}[remember picture,overlay]%
  \fill[top color=white!10!header, bottom color=black!10!header]
  ([yshift=-0.5cm]current page.west |- {pic cs:here}) rectangle (current
  page.north east);
\end{tikzpicture}{%
\\\letteraddressfont\color{headerfont}\@companyaddress\par}
\vspace{1cm}
\IfBooleanTF{#2}{{\lettertitlefont\color{headerfont}{#1}\tikzmark{here}}}{
  \begin{adjustwidth}{0pt}{2\@photodim+1cm}
    {\lettertitlefont\color{headerfont}{#1}\tikzmark{here}}
  \end{adjustwidth}
  \begin{tikzpicture}[remember picture,overlay]
    \path[anchor={pic cs:here},xshift=\linewidth-\@photodim,
      yshift=1cm,
      fill overzoom image={\@photo}]circle[radius=\@photodim];
  \end{tikzpicture}}
\vspace{1.5cm}\\
}

\newcommand{\letterfootnote}{
  \vfill
  \mbox{\letterinfofont\color{symbols}\faHouseUser~\color{bodyfont}\@street}\hfill\vline\hfill
  \mbox{\letterinfofont\color{symbols}\faMapMarker*~\color{bodyfont}\@postalcode~\@city}\hfill\vline\hfill
  \mbox{\letterinfofont\color{symbols}\faAt~\color{bodyfont}\@email}\hfill\vline\hfill
  \mbox{\letterinfofont\color{symbols}\faPhone~\color{bodyfont}\@phone}
}

%%%%%%%%%%%%%%%%%%%% CV %%%%%%%%%%%%%%%%%%%%
\NewDocumentEnvironment{cv}{ m m s +b }{
  \setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vspace{0.25\baselineskip}}
  \setlist[itemize]{label=\itemmarker}
  \begin{tikzpicture}[remember picture,overlay]%
    \fill[left color=white!10!header, right color=black!10!header] (current
    page.north west) rectangle ([xshift=(\columnwidth)+\oddsidemargin+1in+(\columnsep/2)]current page.south west);%
    \IfBooleanT{#3}{\fill[accent] (current page.north west) rectangle ([yshift=-0.75cm]current
      page.north east);}
  \end{tikzpicture}%
  \switchcolumn
  \ifstrequal{#1}{}{}{\color{bodyfont}{\cvtitlefont{#1}\par\smallskip}}
  \ifstrequal{#2}{}{}{\color{bodyfont}{\cvsubtitlefont{#2}}\par\vspace{0.75cm}}
  \switchcolumn {#4} }

\newcommand{\divider}{
  \ifnumequal{\thecolumn}{0}{\color{headerfont}}{\color{bodyfont!30}} {\hdashrule{\linewidth}{0.6pt}{0.5ex}}\bigskip }

\NewDocumentCommand{\cvsection}{ m }{
  \ifnumequal{\thecolumn}{0}{\color{headerfont}}{\color{bodyfont}} {\cvsectionfont{#1}\par\medskip} }

\NewDocumentCommand{\cvinfo}{}{
  \ifnumequal{\thecolumn}{0}{\color{headerfont}}{\color{bodyfont}}
  \mbox{\cvitemfont\faHouseUser\hspace{1ex}\@street}\par\medskip
  \mbox{\cvitemfont\faMapMarker*\hspace{1ex}\@postalcode~\@city}\par\medskip
  \mbox{\cvitemfont\faAt\hspace{1ex}\@email}\par\medskip
  \mbox{\cvitemfont\faPhone\hspace{1ex}\@phone}\par\medskip
  \@ifundefined{@birthday}{}{
    \mbox{\cvitemfont\faCalendar*[regular]\hspace{1ex}\@birthday}\par\medskip } }

\NewDocumentCommand{\cvevent}{ m m m m }{%
  \ifnumequal{\thecolumn}{0}{\cvitemfont\color{headerfont} {\cvitemtitlefont#1\par\smallskip}
    \ifstrequal{#2}{}{}{{\cvitemsubtitlefont #2\par\smallskip}}
    \cvitemfont
    \ifstrequal{#3}{}{}{\makebox[\widthof{{\smaller\faCalendar}\hspace{1ex}#3}][l]{{\smaller\faCalendar}\hspace{1ex}#3}}
    \ifstrequal{#4}{}{}{\makebox[0.5\linewidth][l]{{\smaller\faMapMarker}\hspace{1ex}#4}\par\smallskip\bodyfont} }{\cvitemfont\color{bodyfont} {\cvitemtitlefont\color{accent}#1\par\smallskip}
    \ifstrequal{#2}{}{}{{\cvitemsubtitlefont\color{header}#2\par\smallskip}}
    \ifstrequal{#3}{}{}{\makebox[\widthof{{\smaller\faCalendar}\hspace{1ex}#3}][l]{{\smaller\faCalendar}\hspace{1ex}#3}\hfill}
    \ifstrequal{#4}{}{}{\makebox[0.5\linewidth][l]{{\smaller\faMapMarker}\hspace{1ex}#4}\par\smallskip\bodyfont} } }

\NewDocumentCommand{\cvstrength}{ m m }{%
  \ifnumequal{\thecolumn}{0}{{\cvitemtitlefont\color{headerfont}{\smaller #1}\hspace{1ex}{#2}\par\smallskip} }{ {\cvitemtitlefont{\smaller\color{header}#1}\hspace{1ex}{\color{accent}#2}\par\smallskip} } }

\NewDocumentCommand{\cvtag}{ m }{%
  \begin{tikzpicture}
    \node[anchor=base,draw=accent,fill=background,rounded corners=3pt, inner
      xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex ] {\cvitemfont\color{bodyfont}#1};
  \end{tikzpicture}
  \hspace{1ex}\vspace{0.3ex} }

\NewDocumentCommand{\cvskill}{ m m O{5} m o o }{%
  \ifnumequal{\thecolumn}{0}{\color{headerfont} {\cvitemtitlefont #1}\hfill
    \foreach \x in {1,...,#3}{%
        \space{\ifnumgreater{\x}{#2}{
            \IfValueTF{#6} {\textcolor{#6}} {\textcolor{accent}} }{
            \IfValueTF{#5} {\textcolor{#5}} {\textcolor{headerfont}} }\ratingmarker}}\par
    \ifstrequal{#4}{}{{\cvitemfont~\\[\parskip]}}{{\cvitemfont#4\par\medskip}} }{ {\cvitemtitlefont\color{accent}#1}\hfill
    \foreach \x in {1,...,#3}{%
        \space{\ifnumgreater{\x}{#2}{
            \IfValueTF{#6} {\textcolor{#6}} {\textcolor{bodyfont!30}} }{
            \IfValueTF{#5} {\textcolor{#5}} {\textcolor{header}} }\ratingmarker}}\par
    \ifstrequal{#4}{}{{\cvitemfont~\\[\parskip]}}{{\cvitemfont\color{bodyfont}#4\par\medskip}} } }

\AtBeginDocument{%
  \emergencystretch 3em
  \setlength{\parindent}{0pt}
  \pagestyle{empty}
  \pagecolor{background}
  % \raggedright
}