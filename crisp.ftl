\documentclass[${resume.configuration.fontSize}]{scrartcl}
\usepackage[english]{babel}
\usepackage[a4paper,left=${resume.configuration.leftMargin},top=${resume.configuration.topMargin},right=${resume.configuration.rightMargin},bottom=${resume.configuration.bottomMargin},twocolumn,columnsep=1.25cm]{geometry}
\usepackage{bookman,etoolbox,hyperref,needspace,pifont,marvosym,tabularx,xcolor,microtype}

<#-- font -->
\usepackage[T1]{fontenc}
\usepackage{${helper.getFontTypeValue("${resume.configuration.fontType}")}}
<#if helper.isSansSerifFont("${resume.configuration.fontType}")>
\renewcommand*\familydefault{\sfdefault}
<#elseif helper.isTypeWriterFont("${resume.configuration.fontType}")>
\renewcommand*\familydefault{\ttdefault}
</#if>

<#-- spacing -->
\linespread{${resume.configuration.lineSpacing}}

<#-- color -->
\colorlet{color5}{black}% % Default foreground color. keep it black
\colorlet{color2}{black}%  url color. % Hyperlinks
<#if resume.configuration.isColorBlack()>
\colorlet{color0}{black!90}% for section title text
\colorlet{color4}{black!12}%  for personal box background
<#elseif resume.configuration.isColorBlue()>
\colorlet{color0}{blue!70}% for section title text
\colorlet{color4}{blue!8}%  for personal box background
<#elseif resume.configuration.isColorGreen()>
\colorlet{color0}{green!60}% for section title text
\colorlet{color4}{green!12}%  for personal box background
<#elseif resume.configuration.isColorOrange()>
\colorlet{color0}{orange!40}% for section title text
\colorlet{color4}{orange!18}%  for personal box background
<#elseif resume.configuration.isColorRed()>
\colorlet{color0}{red!70}% for section title text
\colorlet{color4}{red!10}%  for personal box background
<#elseif resume.configuration.isColorPurple()>
\colorlet{color0}{purple!60}% for section title text
\colorlet{color4}{purple!8}%  for personal box background
<#elseif resume.configuration.isColorGrey()>
\colorlet{color0}{grey!90}% for section title text
\colorlet{color4}{grey!8}%  for personal box background
</#if>

%
%\ucwords[optional: miminum length]{text}
\newcommand\ucwords[2][3]{%
    % Fails gracefully if not in Lu  aLaTeX
    \providecommand\directlua[1]{#2}%
    \directlua{%
	local minlen = tonumber("#1")
	local src = "\luaescapestring{\unexpanded{#2}}"
	local dst = {}
	% Put a % inside \directlua is tricky as hell. Use char(37)
	% instead: still no plans for supporting non-ASCII platforms.
	for w in src:gmatch(string.char(37) .. "S+") do
	    if w:len() >= minlen then
		table.insert(dst, w:sub(1,1):upper() .. w:sub(2))
	    else
		table.insert(dst, w)
	    end
	end
	tex.print(dst)}}
%
\pagestyle{empty}
\setlength\parindent{0pt}
\color{color5} % Default foreground color. keep it black
\hypersetup{colorlinks,breaklinks,urlcolor=color2,linkcolor=color2}
\setkomafont{disposition}{\color{color0}}
\setkomafont{section}{\scshape\Large\mdseries}
%
\renewcommand\part[1]{%
    \twocolumn[%
    \begin{center}
	\vskip-\lastskip%
	{\usekomafont{part} #1} \medskip\\
	{\fontfamily{pzc}\selectfont\Large <#if resume.hasHeadline()>${resume.summary.headline}</#if>}
	\bigskip
    \end{center}]}
%
\makeatletter
\let\old@section\section
\renewcommand\section[2][]{%
    \old@section[#1]{\ucwords{#2}}%
    \newdimen\raising%
    \raising=\dimexpr-0.7\baselineskip\relax%
    \vskip\raising\hrule height 0.4pt\vskip-\raising}
\makeatother
%
% \ifjob{jobname}{content if matches}{content if does not match}
\newcommand\ifjob[3]{%
    \edef\JOBNAME{\jobname}%
    \edef\PIVOT{\detokenize{#1}}%
    \ifdefstrequal{\JOBNAME}{\PIVOT}{#2}{#3}%
}
%

%%% Symbols
\newcommand*{\marvosymbol}[1]{}
\renewcommand*{\marvosymbol}[1]{%
    {\fontfamily{mvs}\fontencoding{U}\fontseries{m}\fontshape{n}\selectfont\char#1}%
  }%
%% if needed in case
%\newcommand*{\mobilephonesymbol}   {\marvosymbol{72}~}
%\newcommand*{\fixedphonesymbol}    {\marvosymbol{84}~}
%\newcommand*{\faxphonesymbol}      {\marvosymbol{117}~}
%\newcommand*{\emailsymbol}         {\marvosymbol{66}~}
\newcommand*{\homepagesymbol}      {{\Large\marvosymbol{205}}}
%
\usepackage{tikz}
\newcommand*{\linkedinsymbol}{%
  \protect\raisebox{-0.0000165em}{%
    \protect\begin{tikzpicture}[x=0.08em, y=0.08em, xscale=0.25, yscale=-0.25, inner sep=0pt, outer
                                     sep=0pt]
      \protect\begin{scope}[cm={{0.60,0.0,0.0,0.60,(346.39,123.07)}}]
        \protect\path[fill=color2]
          (381,202) -- (434,202) .. controls (439,202) and (442,205) ..
          (442,210) -- (442,264) .. controls (442,268) and (439,272) ..
          (434,272) -- (381,272) .. controls (376,272) and (372,268) ..
          (372,264) -- (372,210) .. controls (372,205) and (376,202) ..
          (381,202) -- cycle;
        \protect\begin{scope}[xscale=0.98, yscale=1.02, fill=white]
          \protect\path[fill=white]
            (403,253) -- (403,224) -- (394,224) -- (394,253) --
            cycle(398,211) .. controls (397,211) and (395,212) ..
            (395,213) .. controls (394,213) and (393,215) ..
            (393,216) .. controls (393,217) and (394,218) ..
            (395,219) .. controls (395,220) and (397,220) ..
            (398,220) .. controls (400,220) and (401,220) ..
            (402,219) .. controls (402,218) and (403,217) ..
            (403,216) .. controls (403,215) and (402,213) ..
            (402,213) .. controls (401,212) and (400,211) ..
            (398,211) -- cycle;
          \protect\path[fill=white]
            (410,253) -- (419,253) --
            (419,236) .. controls (419,236) and (419,235) ..
            (419,235) .. controls (419,235) and (419,234) ..
            (419,234) .. controls (419,233) and (420,232) ..
            (421,232) .. controls (422,231) and (423,231) ..
            (424,231) .. controls (425,231) and (427,231) ..
            (427,232) .. controls (428,234) and (428,235) ..
            (428,237) -- (428,253) -- (437,253) --
            (437,236) .. controls (437,232) and (436,228) ..
            (434,226) .. controls (433,224) and (430,223) ..
            (427,223) .. controls (425,223) and (423,224) ..
            (421,225) .. controls (420,226) and (419,227) ..
            (418,228) -- (418,228) -- (417,224) --
            (410,224) .. controls (410,225) and (410,227) ..
            (410,228) .. controls (410,230) and (410,231) ..
            (410,233) -- cycle;
        \protect\end{scope}%
      \protect\end{scope}%
    \protect\end{tikzpicture}}%
  ~}
\newcommand*{\twittersymbol} {%
  \protect\raisebox{0em}{%
    \protect\begin{tikzpicture}[x=0.08em, y=0.08em, xscale=0.005, yscale=-0.005, inner sep=0pt, outer
                                 sep=0pt]
      \protect\path[fill=color2]
        (2000, 192) .. controls (1926, 225) and (1847, 247) ..
        (1764, 257) .. controls (1849, 206) and (1914, 126) ..
        (1945,  30) .. controls (1865,  77) and (1778, 111) ..
        (1684, 130) .. controls (1609,  50) and (1503,   0) ..
        (1385,   0) .. controls (1158,   0) and ( 974, 184) ..
        ( 974, 410) .. controls ( 974, 442) and ( 978, 474) ..
        ( 985, 504) .. controls ( 644, 487) and ( 342, 323) ..
        ( 139,  75) .. controls ( 104, 136) and (  84, 206) ..
        (  84, 281) .. controls (  84, 424) and ( 156, 549) ..
        ( 266, 623) .. controls ( 199, 621) and ( 136, 602) ..
        (  80, 572) .. controls (  80, 573) and (  80, 575) ..
        (  80, 577) .. controls (  80, 776) and ( 222, 941) ..
        ( 409, 979) .. controls ( 375, 988) and ( 339, 993) ..
        ( 301, 993) .. controls ( 275, 993) and ( 249, 991) ..
        ( 224, 986) .. controls ( 276,1149) and ( 428,1268) ..
        ( 607,1271) .. controls ( 467,1381) and ( 290,1447) ..
        (  98,1447) .. controls (  65,1447) and (  32,1445) ..
        (   0,1441) .. controls ( 182,1557) and ( 397,1625) ..
        ( 629,1625) .. controls (1384,1625) and (1796,1000) ..
        (1796, 458) .. controls (1796, 440) and (1796, 422) ..
        (1795, 405) .. controls (1875, 347) and (1945, 275) ..
        (2000, 192);
    \protect\end{tikzpicture}}%
  ~}
\newcommand*{\githubsymbol}  {%
  \protect\raisebox{-0.15em}{%
    \protect\begin{tikzpicture}[x=0.08em, y=0.08em, xscale=0.25, yscale=-0.25, inner sep=0pt, outer
                                 sep=0pt]
      \protect\begin{scope}[shift={(507,387)}]
        \protect\path[fill=color2]
          (117, 60) .. controls (117, 71) and (108, 81) ..
          ( 96, 81) .. controls ( 85, 81) and ( 75, 71) ..
          ( 75, 60) .. controls ( 75, 48) and ( 85, 39) ..
          ( 96, 39) .. controls (108, 39) and (117, 48) ..
          (117, 60) -- cycle;
        \protect\path[cm={{0.88,0.0,0.0,0.88,(11.10,6.89)}}, fill=white]
          (117, 60) .. controls (117, 71) and (108, 81) ..
          ( 96, 81) .. controls ( 85, 81) and ( 75, 71) ..
          ( 75, 60) .. controls ( 75, 48) and ( 85, 39) ..
          ( 96, 39) .. controls (108, 39) and (117, 48) ..
          (117, 60) -- cycle;
        \protect\path[fill=color2, nonzero rule]
          (103, 45) .. controls (103, 45) and (101, 46) ..
          (101, 47) -- (100, 47) --
          ( 99, 47) .. controls ( 99, 47) and ( 98, 47) ..
          ( 97, 47) .. controls ( 94, 47) and ( 93, 47) ..
          ( 92, 47) -- ( 92, 47) --
          ( 91, 47) .. controls ( 90, 46) and ( 88, 45) ..
          ( 88, 45) .. controls ( 88, 45) and ( 88, 45) ..
          ( 87, 45) .. controls ( 87, 45) and ( 87, 45) ..
          ( 87, 45) .. controls ( 86, 46) and ( 86, 48) ..
          ( 86, 49) -- ( 87, 50) --
          ( 86, 51) .. controls ( 85, 51) and ( 85, 52) ..
          ( 85, 53) .. controls ( 85, 54) and ( 85, 57) ..
          ( 85, 58) .. controls ( 85, 58) and ( 85, 58) ..
          ( 82, 59) .. controls ( 79, 59) and ( 77, 59) ..
          ( 77, 59) .. controls ( 77, 59) and ( 77, 59) ..
          ( 78, 59) .. controls ( 80, 59) and ( 83, 59) ..
          ( 85, 59) .. controls ( 85, 59) and ( 85, 59) ..
          ( 85, 59) .. controls ( 86, 59) and ( 86, 59) ..
          ( 86, 59) .. controls ( 86, 59) and ( 85, 59) ..
          ( 84, 59) .. controls ( 82, 60) and ( 80, 60) ..
          ( 79, 60) .. controls ( 78, 61) and ( 77, 61) ..
          ( 77, 61) .. controls ( 77, 61) and ( 78, 61) ..
          ( 79, 61) .. controls ( 81, 60) and ( 83, 60) ..
          ( 85, 60) .. controls ( 86, 60) and ( 86, 60) ..
          ( 86, 60) .. controls ( 86, 60) and ( 87, 61) ..
          ( 88, 62) .. controls ( 89, 63) and ( 90, 63) ..
          ( 92, 63) .. controls ( 92, 63) and ( 93, 64) ..
          ( 93, 64) .. controls ( 93, 64) and ( 93, 64) ..
          ( 93, 64) .. controls ( 92, 64) and ( 92, 65) ..
          ( 92, 65) .. controls ( 92, 66) and ( 90, 66) ..
          ( 89, 66) .. controls ( 88, 66) and ( 88, 66) ..
          ( 87, 65) .. controls ( 87, 64) and ( 86, 63) ..
          ( 86, 63) .. controls ( 85, 63) and ( 84, 63) ..
          ( 84, 63) .. controls ( 84, 63) and ( 84, 63) ..
          ( 84, 63) .. controls ( 85, 64) and ( 86, 65) ..
          ( 86, 66) .. controls ( 87, 67) and ( 87, 68) ..
          ( 88, 68) .. controls ( 89, 68) and ( 89, 68) ..
          ( 90, 68) -- ( 92, 68) -- ( 92, 70) -- ( 92, 72) --
          ( 91, 72) .. controls ( 91, 72) and ( 91, 73) ..
          ( 91, 73) .. controls ( 90, 73) and ( 90, 73) ..
          ( 91, 73) .. controls ( 92, 73) and ( 92, 73) ..
          ( 92, 73) .. controls ( 93, 73) and ( 93, 73) ..
          ( 93, 70) .. controls ( 93, 67) and ( 93, 67) ..
          ( 94, 66) -- ( 94, 66) --
          ( 94, 69) .. controls ( 94, 71) and ( 94, 73) ..
          ( 94, 73) .. controls ( 94, 73) and ( 94, 73) ..
          ( 93, 74) .. controls ( 93, 74) and ( 93, 74) ..
          ( 93, 74) .. controls ( 93, 74) and ( 93, 74) ..
          ( 94, 74) .. controls ( 94, 74) and ( 95, 74) ..
          ( 96, 73) .. controls ( 96, 72) and ( 96, 71) ..
          ( 96, 68) -- ( 96, 66) -- ( 96, 66) --
          ( 96, 69) .. controls ( 96, 72) and ( 96, 72) ..
          ( 97, 73) .. controls ( 97, 74) and ( 99, 74) ..
          ( 99, 74) .. controls ( 99, 74) and ( 99, 74) ..
          ( 99, 73) .. controls ( 99, 73) and ( 98, 73) ..
          ( 98, 72) .. controls ( 98, 72) and ( 98, 66) ..
          ( 98, 66) .. controls ( 98, 66) and ( 99, 66) ..
          ( 99, 66) .. controls ( 99, 67) and ( 99, 67) ..
          ( 99, 69) .. controls ( 99, 71) and ( 99, 72) ..
          ( 99, 72) .. controls ( 99, 73) and (100, 73) ..
          (100, 73) .. controls (101, 73) and (101, 73) ..
          (101, 73) .. controls (102, 73) and (102, 73) ..
          (102, 73) .. controls (101, 72) and (101, 72) ..
          (101, 69) .. controls (101, 66) and (101, 65) ..
          (100, 65) .. controls (100, 64) and (100, 64) ..
          (100, 64) -- ( 99, 64) --
          (100, 63) .. controls (101, 63) and (102, 63) ..
          (103, 63) .. controls (104, 62) and (106, 61) ..
          (106, 60) -- (106, 60) --
          (107, 60) .. controls (109, 60) and (113, 60) ..
          (115, 61) .. controls (115, 61) and (115, 61) ..
          (115, 61) .. controls (115, 60) and (111, 60) ..
          (108, 59) .. controls (107, 59) and (107, 59) ..
          (107, 59) .. controls (107, 59) and (107, 59) ..
          (107, 59) -- (107, 59) --
          (108, 59) .. controls (110, 59) and (112, 59) ..
          (114, 59) .. controls (115, 59) and (115, 59) ..
          (115, 59) .. controls (115, 59) and (112, 59) ..
          (109, 59) .. controls (108, 58) and (107, 58) ..
          (107, 58) .. controls (107, 58) and (107, 58) ..
          (107, 58) .. controls (107, 57) and (107, 56) ..
          (107, 55) .. controls (107, 53) and (107, 53) ..
          (107, 53) .. controls (107, 52) and (106, 51) ..
          (106, 50) -- (105, 50) --
          (105, 48) .. controls (105, 47) and (105, 46) ..
          (105, 46) -- (105, 45) --
          (104, 45) .. controls (104, 45) and (104, 45) ..
          (103, 45) -- cycle;
      \protect\end{scope}%
    \protect\end{tikzpicture}}%
  ~}
\newcommand*{\facebooksymbol} {%
  \protect\raisebox{0em}{%
    \protect\begin{tikzpicture}[x=0.08em, y=0.08em, xscale=0.022, yscale=-0.022, inner sep=0pt, outer
                                 sep=0pt]
    \protect\path[fill=color2,even odd rule] (31.9490,431.7110) .. controls
        (31.9490,451.7890) and (48.2130,468.0510) .. (68.2890,468.0510) --
        (431.7100,468.0510) .. controls (451.7880,468.0510) and (468.0500,451.7890) ..
        (468.0500,431.7110) -- (468.0500,68.2900) .. controls (468.0500,48.2130) and
        (451.7880,31.9500) .. (431.7100,31.9500) -- (68.2900,31.9500) .. controls
        (48.2130,31.9500) and (31.9500,48.2140) .. (31.9500,68.2900) --
        (31.9500,431.7110) -- cycle(259.0860,413.5380) -- (259.0860,268.1720) --
        (222.7440,268.1720) -- (222.7440,213.6580) -- (259.0860,213.6580) .. controls
        (259.0860,119.9870) and (263.0790,113.7190) .. (377.1980,113.7190) --
        (377.1980,168.2320) .. controls (317.0490,168.2320) and (322.6840,171.5940) ..
        (322.6840,213.6590) -- (377.1980,213.6590) -- (377.1980,268.1730) --
        (322.6840,268.1730) -- (322.6840,413.5390) -- (259.0860,413.5390) -- cycle;
    \protect\end{tikzpicture}}%
  ~}

\usepackage{xparse}
%
% Every \item can be followed by one or more paragraphs
% of description:
%
% \item{date range}{company}{role}
%
% Description of what achieved during this application.
\newenvironment{eventlist}{%
    \newcommand*\inskip{}
    \renewcommand\item[3]{%
	\inskip%
	{\raggedleft\scshape ##1\\[1pt]}
	\ifstrempty{##2}{}{##2\\[2pt]}
	{\Large\itshape ##3}
	\medskip
	\renewcommand\inskip{\bigskip}}}
    {\bigskip}
%
% Use only \item inside this environment: no other macros
% are allowed:
%
% \item[optional: what has been achieved]{years}{subject}{notes}
\newenvironment{yearlist}{%
    \renewcommand\item[4][]{%
	{\scshape ##2} & {\bfseries ##3} \\
	\ifstrempty{##1}{}{& {\scshape ##1} \\}
	& {\itshape ##4}\medskip\\}
    \tabularx{\linewidth}{rX}}
    {\endtabularx}


% Use only \item inside this environment: no other macros
% are allowed:
%
% \item{fact}{description}
\newenvironment{factlist}{%
    \newdimen\unbaseline
    \unbaseline=\dimexpr-\baselinestretch\baselineskip\relax
    \renewcommand\item[2]{%
	\textsc{##1} & {\raggedright ##2\medskip\\}\\[\unbaseline]}
    \tabularx{\linewidth}{rX}}
    {\endtabularx}
%%

%
\setcounter{secnumdepth}{-1}
%%%%%

\usepackage{eso-pic}
\newcommand\AtPageUpperMyleft[1]{\AtPageUpperLeft{%
 \put(\LenToUnit{\dimexpr\paperwidth-${helper.addToMargin("${resume.configuration.rightMargin}", 76)}\relax},\LenToUnit{-3.5cm}){#1}%
 }}%
\newcommand{\photo}[1]{%
\AddToShipoutPictureBG*{%
\AtPageUpperMyleft{\fboxsep1.5pt\fcolorbox{color0}{white}%
{\includegraphics[width=70pt,keepaspectratio]{#1}}}
}%
}

<#if resume.isNotPremiumAccount()>
%% footer ad
\usepackage{tikzpagenodes}
\AddToShipoutPictureBG{%
\begin{tikzpicture}[remember picture, overlay]
        \node [anchor=west, text=color2,  inner xsep=0pt] at ([yshift=0.6cm]current page footer area.west) {\textit{powered by \href{www.cvsintellect.com}{CVsIntellect.com}}};
\end{tikzpicture}
}
%%
</#if>

\begin{document}

<#if resume.hasPhoto()>
\photo{picture}
</#if>

\part{${resume.personal.firstName} ${resume.personal.lastName}}

<#assign cityStateString = helper.getCommaSeperatedString("${resume.contact.city}", "${resume.contact.state}")>
<#assign countyPincodeString = helper.joinStringsWith(" - ", "${resume.contact.country}", "${resume.contact.pincode}")>
{
\newcommand\SYMBOL[1]{\raisebox{-2pt}{\Large\ding{#1}}}%
    \needspace{0.5\textheight}%
    \newdimen\boxwidth%
    \boxwidth=\dimexpr\linewidth-2\fboxsep\relax%
    \colorbox{color4}{%
    \begin{tabularx}{\boxwidth}{c|X}
    \SYMBOL{45} & {<#if helper.isNotEmpty("${resume.contact.addressLine}")>${resume.contact.addressLine}\newline </#if><#if helper.isNotEmpty("${cityStateString}")>${cityStateString}\newline </#if><#if helper.isNotEmpty("${countyPincodeString}")>${countyPincodeString}</#if>}\smallskip\\
    \SYMBOL{37} & {${resume.contact.phoneNumber}}\smallskip\\
    \SYMBOL{41} & \href{mailto:${resume.contact.emailId}}{${resume.contact.emailId}}
<#if resume.links??>
<#list resume.links as link>
    \smallskip \\ \${link.name}symbol & \href{${link.getUrl()}}{${link.getLastPartOfURL()}}
</#list>
</#if>
    \end{tabularx}
}

<#-- show sections based on order -->
<#list resume.configuration.sectionDetails as sectionDetail>

<#-- certifications -->
<#if sectionDetail.isCertificationSection()><#if resume.hasCertifications()>
\section{${sectionDetail.heading}}
<#list resume.certifications as certification>
<#assign certificateString = helper.joinStringsWith(" by ", "\\textit{${certification.name}}", "\\textit{${certification.authorityName}}")>
${certificateString}<#if helper.isNotEmpty("${certification.startDateAndEndDate}")>, ${certification.startDateAndEndDate}</#if>\newline
<#if helper.isNotEmpty("${certification.number}")>
Number: ${certification.number}
</#if>
<#if certification_has_next>\par\vskip3pt</#if>
</#list>
</#if></#if>

<#-- custom -->
<#if sectionDetail.isCustomSection()><#assign customSection = resume.getCustomSection("${sectionDetail.sectionId}")><#if customSection.hasCustomSectionEntries()>
\section{${sectionDetail.heading}}
<#list customSection.entries as entry>
<#if helper.isNotEmpty("${entry.heading}")>
\textbf{${entry.heading}}\newline
</#if>
${entry.text}
<#if entry_has_next>\par\vskip3pt</#if>
</#list>
</#if></#if>

<#-- education -->
<#if sectionDetail.isEducationSection()><#if resume.hasEducation()>
\section{${sectionDetail.heading}}
<#list resume.educations as education>
<#assign degreeString = helper.joinStringsWith(" in ", "\\textbf{${education.degree}}", "\\textbf{${education.fieldOfStudy}}")>
<#assign collegeString = helper.getCommaSeperatedString("${education.schoolName}", "${education.university}")>
<#assign scoreString = helper.joinStringsWith(": ", "${education.scoreType}", "${education.totalScore}")>
<#if helper.isNotEmpty("${education.startDateAndEndDate}")>${education.startDateAndEndDate} - </#if>${degreeString}\newline
<#if helper.isNotEmpty("${collegeString}")>\textit{${collegeString}}\newline</#if>
<#if helper.isNotEmpty("${scoreString}")>
${scoreString}\newline
</#if>
<#if helper.isNotEmpty("${education.summary}")>
${education.summary}
</#if>
<#if education_has_next>\par\vskip3pt</#if>
</#list>
</#if></#if>

<#-- language -->
<#if sectionDetail.isLanguageSection()><#if resume.hasLanguages()>
\section{${sectionDetail.heading}}
\begin{factlist}
\item{}{%
 \makebox[0.23\columnwidth][l]{\phantom{$\circ$\,}\textit{Read}}
 \makebox[0.23\columnwidth][l]{\phantom{$\circ$\,}\textit{Write}}
 \makebox[0.23\columnwidth][l]{\phantom{$\circ$\,}\textit{Speak}}}
<#list resume.languages as language>
\item{\textbf{${language.name}}}{%
 \makebox[0.23\columnwidth][l]{$\circ$\,${language.read}}
 \makebox[0.23\columnwidth][l]{$\circ$\,${language.write}}
 \makebox[0.23\columnwidth][l]{$\circ$\,${language.speak}}}
</#list>
\end{factlist}
</#if></#if>

<#-- objective -->
<#if sectionDetail.isObjectiveSection()><#if resume.hasObjective()>
\section{${sectionDetail.heading}}
${resume.objective.text}
</#if></#if>

<#-- patents -->
<#if sectionDetail.isPatentSection()><#if resume.hasPatents()>
\section{${sectionDetail.heading}}
<#list resume.patents as patent>
<#assign patentString = helper.getCommaSeperatedString("${patent.officeName}", "${patent.number}", "${patent.date}", "${patent.status}", "${patent.url}")>
${resume.patents?size - patent_index}. \textit{${patent.title}} - \textit{${patent.inventors}}\newline
<#if helper.isNotEmpty("${patentString}")>
${patentString}\newline
</#if>
<#if helper.isNotEmpty("${patent.summary}")>
${patent.summary}
</#if>
<#if patent_has_next>\par\vskip3pt</#if>
</#list>
</#if></#if>

<#-- personal -->
<#if sectionDetail.isPersonalSection()><#if helper.atleastOneIsNotEmpty("${resume.personal.gender}", "${resume.personal.dateOfBirth}","${resume.personal.fathersName}","${resume.personal.mothersName}", "${resume.personal.maritalStatus}", "${resume.personal.nationality}","${resume.personal.passportNumber}", "${resume.personal.languages}", "${resume.personal.hobbies}")>
\section{${sectionDetail.heading}}
\begin{factlist}
<#if helper.isNotEmpty("${resume.personal.gender}")>
\item{\textit{Gender}}{${resume.personal.gender}}
</#if>
<#if helper.isNotEmpty("${resume.personal.dateOfBirth}")>
\item{\textit{Date of Birth}}{${resume.personal.dateOfBirth}}
</#if>
<#if helper.isNotEmpty("${resume.personal.fathersName}")>
\item{\textit{Father's Name}}{${resume.personal.fathersName}}
</#if>
<#if helper.isNotEmpty("${resume.personal.mothersName}")>
\item{\textit{Mother's Name}}{${resume.personal.mothersName}}
</#if>
<#if helper.isNotEmpty("${resume.personal.maritalStatus}")>
\item{\textit{Marital Status}}{${resume.personal.maritalStatus}}
</#if>
<#if helper.isNotEmpty("${resume.personal.nationality}")>
\item{\textit{Nationality}}{${resume.personal.nationality}}
</#if>
<#if helper.isNotEmpty("${resume.personal.passportNumber}")>
\item{\textit{Passport Number}}{${resume.personal.passportNumber}}
</#if>
<#if helper.isNotEmpty("${resume.personal.languages}")>
\item{\textit{Languages}}{${resume.personal.languages}}
</#if>
<#if helper.isNotEmpty("${resume.personal.hobbies}")>
\item{\textit{Hobbies}}{${resume.personal.hobbies}}
</#if>
\end{factlist}
</#if></#if>

<#-- positions -->
<#if sectionDetail.isPositionSection()><#if resume.hasPositions()>
\section{${sectionDetail.heading}}
<#list resume.positions as position>
<#assign positionString = helper.joinStringsWith(" at ", "\\textbf{${position.title}}", "\\textbf{${position.companyName}}")>
<#if helper.isNotEmpty("${position.startDateAndEndDate}")>${position.startDateAndEndDate} - </#if>${positionString}<#if helper.isNotEmpty("${position.companyURL}")>, ${position.companyURL}</#if><#if helper.isNotEmpty("${position.companyLocation}")>, \textit{${position.companyLocation}}</#if>\newline
<#if helper.isNotEmpty("${position.summary}")>
${position.summary}
</#if>
<#if position_has_next>\par\vskip3pt</#if>
</#list>
</#if></#if>

<#-- projects -->
<#if sectionDetail.isProjectSection()><#if resume.hasProjects()>
\section{${sectionDetail.heading}}
<#list resume.projects as project>
<#assign projectString = helper.joinStringsWith(" on ", "${project.role}", "\\textbf{${project.name}}")>
<#assign companyString = helper.joinStringsWith(" for ", "${project.companyName}", "${project.clientName}")>
<#if helper.isNotEmpty("${project.startDateAndEndDate}")>${project.startDateAndEndDate} - </#if>${projectString}\newline
<#if helper.isNotEmpty("${companyString}")>
${companyString}\newline
</#if>
<#if helper.isNotEmpty("${project.summary}")>
${project.summary}
</#if>
<#if project_has_next>\par\vskip3pt</#if>
</#list>
</#if></#if>

<#-- publications -->
<#if sectionDetail.isPublicationSection()><#if resume.hasPublications()>
\section{${sectionDetail.heading}}
<#list resume.publications as publication>
<#assign publicationString = helper.getCommaSeperatedString("${publication.publisherName}", "${publication.date}", "${publication.url}")>
${resume.publications?size - publication_index}. \textit{${publication.title}} - \textit{${publication.authors}}\newline
<#if helper.isNotEmpty("${publicationString}")>
${publicationString}\newline
</#if>
<#if helper.isNotEmpty("${publication.summary}")>
${publication.summary}
</#if>
<#if publication_has_next>\par\vskip3pt</#if>
</#list>
</#if></#if>

<#-- recommendations -->
<#if sectionDetail.isRecommendationSection()><#if resume.hasRecommendations()>
\section{${sectionDetail.heading}}
<#list resume.recommendations as recommendation>
\textbf{${recommendation.name}}<#if helper.isNotEmpty("${recommendation.type}")>, \textit{${recommendation.type}}\newline</#if>
${recommendation.text}
<#if recommendation_has_next>\par\vskip3pt</#if>
</#list>
</#if></#if>

<#-- skills -->
<#if sectionDetail.isSkillsSection()><#if resume.hasSkills()>
\section{${sectionDetail.heading}}
<#list resume.skillGroups as skillGroup>
\textbf{${skillGroup.skillGroup}}\newline
<#if helper.isNotEmpty("${skillGroup.description}")>
${skillGroup.description}\newline
</#if>
<#if skillGroup.skills??><#list skillGroup.skills as skill>\textit{${skill}}<#if skill_has_next>, </#if></#list></#if>
<#if skillGroup_has_next>\par\vskip3pt</#if>
</#list>
</#if></#if>

<#-- summary -->
<#if sectionDetail.isSummarySection()><#if resume.hasSummary()>
\section{${sectionDetail.heading}}
<#if resume.summary.keywords??>{\centering <#list resume.summary.keywords as keyword>\textbf{${keyword}}<#if keyword_has_next> | </#if></#list>\newline}</#if>
${resume.summary.summary}
</#if></#if>

<#-- talks -->
<#if sectionDetail.isTalkSection()><#if resume.hasTalks()>
\section{${sectionDetail.heading}}
<#list resume.talks as talk>
<#assign talkString = helper.getCommaSeperatedString("${talk.event}", "${talk.date}", "${talk.url}")>
${resume.talks?size - talk_index}. \textit{${talk.title}} - \textit{${talk.speakers}}\newline
<#if helper.isNotEmpty("${talkString}")>
${talkString}\newline
</#if>
<#if helper.isNotEmpty("${talk.summary}")>
${talk.summary}
</#if>
<#if talk_has_next>\par\vskip3pt</#if>
</#list>
</#if></#if>

<#-- volunteers -->
<#if sectionDetail.isVolunteerSection()><#if resume.hasVolunteers()>
\section{${sectionDetail.heading}}
<#list resume.volunteers as volunteer>
\textit{${volunteer.role}}, ${volunteer.cause}, ${volunteer.organizationName}\newline
<#if helper.isNotEmpty("${volunteer.summary}")>
${volunteer.summary}
</#if>
<#if volunteer_has_next>\par\vskip3pt</#if>
</#list>
</#if></#if>

</#list>
\end{document}