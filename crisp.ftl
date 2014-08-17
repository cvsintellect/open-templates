\documentclass[${resume.configuration.fontSize}]{scrartcl}
\usepackage[english]{babel}
\usepackage[a4paper,left=${resume.configuration.leftMargin},top=${resume.configuration.topMargin},right=${resume.configuration.rightMargin},bottom=${resume.configuration.bottomMargin},twocolumn,columnsep=1.25cm]{geometry}
\usepackage{bookman,etoolbox,hyperref,needspace,pifont,tabularx,xcolor,microtype}

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
\color[HTML]{303030} % Default foreground color
\definecolor{link}{HTML}{505090} % Hyperlinks
\definecolor{color0}{HTML}{F5BD9D} % personal box color
\hypersetup{colorlinks,breaklinks,urlcolor=link,linkcolor=link}
\setkomafont{disposition}{\color[HTML]{804010}}
\setkomafont{section}{\scshape\Large\mdseries}
%
\renewcommand\part[1]{%
    \twocolumn[%
    \begin{center}
	\vskip-\lastskip%
	{\usekomafont{part} #1} \medskip\\
	{\fontfamily{pzc}\selectfont\Large <#if resume.hasSummary()>${resume.summary.headline}</#if>}
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
% \personal[optional: web site without scheme (no http:// prefix)]
%          {address}{phone number}{email}
\newcommand\personal[4][]{%
    \newcommand\SYMBOL[1]{\raisebox{-2pt}{\Large\ding{##1}}}%
    \needspace{0.5\textheight}%
    \newdimen\boxwidth%
    \boxwidth=\dimexpr\linewidth-2\fboxsep\relax%
    \colorbox{color0}{%
    \begin{tabularx}{\boxwidth}{c|X}
    \SYMBOL{45} & {#2}\smallskip\\
    \SYMBOL{37} & {#3}\smallskip\\
    \SYMBOL{41} & \href{mailto:#4}{#4}
    \ifstrempty{#1}{}{\smallskip\\ \SYMBOL{218} & \href{http://#1}{#1}}
    \end{tabularx}}}
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
\begin{document}

\part{${resume.personal.firstName} ${resume.personal.lastName}}

<#assign cityStateString = helper.getCommaSeperatedString("${resume.contact.city}", "${resume.contact.state}")>
<#assign countyPincodeString = helper.joinStringsWith(" - ", "${resume.contact.country}", "${resume.contact.pincode}")>

\personal
    []
    {<#if helper.isNotEmpty("${resume.contact.addressLine}")>${resume.contact.addressLine}\newline </#if><#if helper.isNotEmpty("${cityStateString}")>${cityStateString}\newline </#if><#if helper.isNotEmpty("${countyPincodeString}")>${countyPincodeString}</#if>}
    {${resume.contact.phoneNumber}}
    {${resume.contact.emailId}}

<#-- show sections based on order -->
<#list resume.configuration.sectionDetails as sectionDetail>

<#-- certifications -->
<#if sectionDetail.isCertificationSection()><#if resume.hasCertifications()>
\section{${sectionDetail.heading}}
<#list resume.certifications as certification>
<#assign certificateString = helper.joinStringsWith(" by ", "\\textit{${certification.name}}", "\\textit{${certification.authorityName}}")>
${certification.startDateAndEndDate} - ${certificateString}\par
<#if helper.isNotEmpty("${certification.number}")>Number: ${certification.number}</#if>
<#if certification_has_next >\newline</#if>
</#list>
</#if></#if>

<#-- custom -->
<#if sectionDetail.isCustomSection()><#assign customSection = resume.getCustomSection("${sectionDetail.sectionId}")><#if customSection.hasCustomSectionEntries()>
\section{${sectionDetail.heading}}
<#list customSection.entries as entry>
\textbf{${entry.heading}}\par
${entry.text}
<#if entry_has_next >\newline</#if>
</#list>
</#if></#if>

<#-- education -->
<#if sectionDetail.isEducationSection()><#if resume.hasEducation()>
\section{${sectionDetail.heading}}

<#list resume.educations as education>
<#assign degreeString = helper.joinStringsWith(" in ", "\\textbf{${education.degree}}", "\\textbf{${education.fieldOfStudy}}")>
<#assign collegeString = helper.getCommaSeperatedString("${education.schoolName}", "${education.university}")>
<#assign scoreString = helper.joinStringsWith(": ", "${education.scoreType}", "${education.totalScore}")>
${education.startDateAndEndDate} - ${degreeString}\par
<#if helper.isNotEmpty("${collegeString}")>\textit{${collegeString}}\par</#if>
<#if helper.isNotEmpty("${scoreString}")>${scoreString}\par</#if>
<#if helper.isNotEmpty("${education.summary}")>
${education.summary}
</#if>
<#if education_has_next >\newline</#if>
</#list>
</#if></#if>

<#-- language -->
<#if sectionDetail.isLanguageSection()><#if resume.hasLanguages()>
\section{${sectionDetail.heading}}
\begin{factlist}
\item{}{\textit{Read} \textit{Write} \textit{Speak}}
<#list resume.languages as language>
\item{\textbf{${language.name}}}{${language.read} ${language.write} ${language.speak}}
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
${resume.patents?size - patent_index}. \textit{${patent.title}} - \textit{${patent.inventors}}\par
<#if helper.isNotEmpty("${patentString}")>${patentString}\par</#if>
<#if helper.isNotEmpty("${patent.summary}")>
${patent.summary}
</#if>
<#if patent_has_next >\newline</#if>
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
${position.startDateAndEndDate} - ${positionString}<#if helper.isNotEmpty("${position.companyURL}")>, ${position.companyURL}</#if><#if helper.isNotEmpty("${position.companyLocation}")>, \textit{${position.companyLocation}}</#if>\par
<#if helper.isNotEmpty("${position.summary}")>
${position.summary}
</#if>
<#if position_has_next >\newline</#if>
</#list>
</#if></#if>

<#-- projects -->
<#if sectionDetail.isProjectSection()><#if resume.hasProjects()>
\section{${sectionDetail.heading}}
<#list resume.projects as project>
<#assign projectString = helper.joinStringsWith(" on ", "\\textbf{${project.role}}", "\\textbf{${project.name}}")>
<#assign companyString = helper.joinStringsWith(" for ", "${project.companyName}", "${project.clientName}")>
${project.startDateAndEndDate} - ${projectString}\par
${companyString}\par
<#if helper.isNotEmpty("${project.summary}")>
${project.summary}
</#if>
<#if project_has_next >\newline</#if>
</#list>
</#if></#if>

<#-- publications -->
<#if sectionDetail.isPublicationSection()><#if resume.hasPublications()>
\section{${sectionDetail.heading}}
<#list resume.publications as publication>
<#assign publicationString = helper.getCommaSeperatedString("${publication.publisherName}", "${publication.date}", "${publication.url}")>
${resume.publications?size - publication_index}. \textit{${publication.title}} - \textit{${publication.authors}}\par
<#if helper.isNotEmpty("${publicationString}")>${publicationString}\par</#if>
<#if helper.isNotEmpty("${publication.summary}")>
${publication.summary}
</#if>
<#if publication_has_next >\newline</#if>
</#list>
</#if></#if>

<#-- recommendations -->
<#if sectionDetail.isRecommendationSection()><#if resume.hasRecommendations()>
\section{${sectionDetail.heading}}
<#list resume.recommendations as recommendation>
\textbf{${recommendation.name}}, \textit{${recommendation.type}}\par
${recommendation.text}
<#if recommendation_has_next >\newline</#if>
</#list>
</#if></#if>

<#-- skills -->
<#if sectionDetail.isSkillsSection()><#if resume.hasSkills()>
\section{${sectionDetail.heading}}
<#list resume.skillGroups as skillGroup>
\textbf{${skillGroup.skillGroup}}\par
<#if helper.isNotEmpty("${skillGroup.description}")>
${skillGroup.description}
</#if>
<#if skillGroup.skills??><#list skillGroup.skills as skill>\textit{${skill}}<#if skill_has_next >, </#if></#list>\par</#if>
<#if skillGroup_has_next >\newline</#if>
</#list>
</#if></#if>

<#-- summary -->
<#if sectionDetail.isSummarySection()><#if resume.hasSummary()>
\section{${sectionDetail.heading}}
<#if resume.summary.keywords??>{\centering <#list resume.summary.keywords as keyword>\textbf{${keyword}}<#if keyword_has_next > | </#if></#list>\par}</#if>
${resume.summary.summary}
</#if></#if>

<#-- talks -->
<#if sectionDetail.isTalkSection()><#if resume.hasTalks()>
\section{${sectionDetail.heading}}
<#list resume.talks as talk>
<#assign talkString = helper.getCommaSeperatedString("${talk.event}", "${talk.date}", "${talk.url}")>
${resume.talks?size - talk_index}. \textit{${talk.title}} - \textit{${talk.speakers}}\par
<#if helper.isNotEmpty("${talkString}")>${talkString}\par</#if>
<#if helper.isNotEmpty("${talk.summary}")>
${talk.summary}
</#if>
<#if talk_has_next >\newline</#if>
</#list>
</#if></#if>

<#-- volunteers -->
<#if sectionDetail.isVolunteerSection()><#if resume.hasVolunteers()>
\section{${sectionDetail.heading}}
<#list resume.volunteers as volunteer>
\textit{${volunteer.role}}, ${volunteer.cause}, ${volunteer.organizationName}\par
<#if helper.isNotEmpty("${volunteer.summary}")>
${volunteer.summary}
</#if>
<#if volunteer_has_next >\newline</#if>
</#list>
</#if></#if>

</#list>

\end{document}