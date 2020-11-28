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
\geometry{left=2.5cm,right=2.5cm,top=2.5cm,bottom=1cm,columnsep=1.15cm}
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

%%%%%%%%%%%%%%%%%%%% Cover Letter %%%%%%%%%%%%%%%%%%%%
\NewDocumentEnvironment{letter}{ m +b }{
  \letterheader{#1}
  {\letterbodyfont\color{bodyfont}{#2}}\hfill
  {\letterbodyfont\color{bodyfont}\@city, den \today}
  \letterfootnote
}

\newcommand{\letterheader}[1]{%
  \begin{tikzpicture}[remember picture,overlay]%
  \fill[top color=white!10!header, bottom color=black!10!header] ([yshift=-0.5cm]current page.west |- {pic cs:here}) rectangle (current page.north east);
  \fill[accent] (current page.north west) rectangle ([yshift=-0.75cm]current page.north east);
  \end{tikzpicture}%
  {\\\letteraddressfont\color{headerfont}\@companyaddress\par}
  \vspace{1cm}
  \begin{adjustwidth}{0pt}{2\@photodim}
    {\lettertitlefont\color{headerfont}{#1}\tikzmark{here}}
  \end{adjustwidth}
  \begin{tikzpicture}[remember picture,overlay]
    \path[anchor={pic cs:here},xshift=\linewidth-\@photodim,
    yshift=1cm,
    fill overzoom image={\@photo}]circle[radius=\@photodim];
  \end{tikzpicture}
  \vspace{\@photodim-1cm}\\
}

\newcommand{\letterfootnote}{
  \vfill
  \mbox{\letterinfofont\color{header}\faHouseUser~\color{bodyfont}\@street}\hfill\vline\hfill
  \mbox{\letterinfofont\color{header}\faMapMarker*~\color{bodyfont}\@postalcode{, }\@city}\hfill\vline\hfill
  \mbox{\letterinfofont\color{header}\faAt~\color{bodyfont}\@email}\hfill\vline\hfill
  \mbox{\letterinfofont\color{header}\faPhone~\color{bodyfont}\@phone}
}

%%%%%%%%%%%%%%%%%%%% CV %%%%%%%%%%%%%%%%%%%%
\NewDocumentEnvironment{cv}{ m m +b }{
  \setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vspace{0.25\baselineskip}}
  \setlist[itemize]{label=\itemmarker}
  \begin{tikzpicture}[remember picture,overlay]%
    \fill[left color=white!10!header, right color=black!10!header] (current page.north west) rectangle ([xshift=(\columnwidth)+\oddsidemargin+1in+(\columnsep/2)]current page.south west);%
    \fill[accent] (current page.north west) rectangle ([yshift=-0.75cm]current page.north east);%
  \end{tikzpicture}%
  \switchcolumn
  \ifstrequal{#1}{}{}{\color{bodyfont}{\cvtitlefont{#1}\par}}
  \ifstrequal{#2}{}{}{\color{bodyfont}{\cvsubtitlefont{#2}\hspace{1em}\hrulefill\par\vspace{0.75cm}}}
  \switchcolumn
  {#3}
}

\newcommand{\divider}{
  \ifnumequal{\thecolumn}{0}{\color{headerfont}}{\color{bodyfont!30}}
    {\hdashrule{\linewidth}{0.6pt}{0.5ex}}\bigskip
}

\NewDocumentCommand{\cvsection}{ m }{
  \ifnumequal{\thecolumn}{0}{\color{headerfont}}{\color{bodyfont}}
  {\cvsectionfont{#1}\par\medskip}
}

\NewDocumentCommand{\cvinfo}{}{
  \ifnumequal{\thecolumn}{0}{\color{headerfont}}{\color{bodyfont}}
  \mbox{\cvitemfont\faHouseUser\hspace{1ex}\@street}\par\medskip
  \mbox{\cvitemfont\faMapMarker*\hspace{1ex}\@postalcode{, }\@city}\par\medskip
  \mbox{\cvitemfont\faAt\hspace{1ex}\@email}\par\medskip
  \mbox{\cvitemfont\faPhone\hspace{1ex}\@phone}\par\bigskip
}

\NewDocumentCommand{\cvevent}{ m m m m }{%
  \ifnumequal{\thecolumn}{0}{\cvitemfont\color{headerfont}
    {\cvitemtitlefont#1\par\smallskip}
    \ifstrequal{#2}{}{}{{\cvitemsubtitlefont #2\par\smallskip}}
    \cvitemfont
    \ifstrequal{#3}{}{}{\makebox[0.5\linewidth][l]{{\smaller\faCalendar}\hspace{1ex}#3}}
    \ifstrequal{#4}{}{}{\makebox[0.5\linewidth][l]{{\smaller\faMapMarker}\hspace{1ex}#4}}\par\medskip
  }{\cvitemfont\color{bodyfont}
    {\cvitemtitlefont\color{accent}#1\par\smallskip}
    \ifstrequal{#2}{}{}{{\cvitemsubtitlefont\color{header}#2\par\smallskip}}
    \ifstrequal{#3}{}{}{\makebox[0.5\linewidth][l]{{\smaller\faCalendar}\hspace{1ex}#3}}
    \ifstrequal{#4}{}{}{\makebox[0.5\linewidth][l]{{\smaller\faMapMarker}\hspace{1ex}#4}}\par\medskip  
  }
}

\NewDocumentCommand{\cvstrength}{ m m }{%
  \ifnumequal{\thecolumn}{0}{{\cvitemtitlefont\color{headerfont}{\smaller #1}\hspace{1ex}{#2}\par\smallskip}
  }{
    {\cvitemtitlefont{\smaller\color{header}#1}\hspace{1ex}{\color{accent}#2}\par\smallskip}
  }
}

\NewDocumentCommand{\cvtag}{ m }{%
  \begin{tikzpicture}
    \node[anchor=base,draw=accent,fill=background,rounded corners=3pt,
    inner xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex
    ] {\cvitemfont\color{bodyfont}#1};
  \end{tikzpicture}
  \hspace{1ex}\vspace{0.3ex}
}

\NewDocumentCommand{\cvskill}{ m m m }{%
  \ifnumequal{\thecolumn}{0}{\color{headerfont}
    {\cvitemtitlefont #1}\hfill
    \foreach \x in {1,...,5}{%
      \space{\ifnumgreater{\x}{#2}{\textcolor{accent}}{\textcolor{headerfont}}\ratingmarker}}\par
    \ifstrequal{#3}{}{{\cvitemfont~\\[\parskip]}}{{\cvitemfont#3\par\medskip}}
  }{
    {\cvitemtitlefont\color{accent}#1}\hfill
    \foreach \x in {1,...,5}{%
      \space{\ifnumgreater{\x}{#2}{\textcolor{bodyfont!30}}{\textcolor{header}}\ratingmarker}}\par
    \ifstrequal{#3}{}{{\cvitemfont~\\[\parskip]}}{{\cvitemfont\color{bodyfont}#3\par\medskip}}
}
}

\AtBeginDocument{%
\setlength{\parindent}{0pt}
\pagestyle{empty}
\pagecolor{background}
\raggedright
}