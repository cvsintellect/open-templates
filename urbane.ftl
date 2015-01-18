\documentclass[a4paper,${resume.configuration.fontSize}]{moderncv}
\moderncvstyle{oldstyle}
\moderncvcolor{${resume.configuration.color}}
\usepackage[left=${resume.configuration.leftMargin},top=${resume.configuration.topMargin},right=${resume.configuration.rightMargin},bottom=${resume.configuration.bottomMargin}]{geometry}
\usepackage[inline]{enumitem}

<#-- font -->
\usepackage[T1]{fontenc}
\usepackage{${helper.getFontTypeValue("${resume.configuration.fontType}")}}
<#if helper.isSansSerifFont("${resume.configuration.fontType}")>
\renewcommand*\familydefault{\sfdefault}
<#elseif helper.isTypeWriterFont("${resume.configuration.fontType}")>
\renewcommand*\familydefault{\ttdefault}
</#if>

<#-- spacing -->
\setlength{\hintscolumnwidth}{${resume.configuration.sectionIndent}}
\linespread{${resume.configuration.lineSpacing}}

<#-- personal -->
\firstname{${resume.personal.firstName}}
\familyname{${resume.personal.lastName}}

<#if resume.hasPhoto()>
\photo[70pt][0.1pt]{picture}
</#if>

<#if resume.hasHeadline()>
\quote{${resume.summary.headline}}
</#if>

<#if resume.isNotPremiumAccount()>
%% footer ad
\usepackage{background}
\usepackage{tikzpagenodes}
  \backgroundsetup{%
    angle=0,
    scale=1,
    opacity=1,
    contents={%
      \begin{tikzpicture}[remember picture, overlay]
        \node [anchor=west, text=color2, font=\addressfont] at (current page footer area.west) {powered by \httplink{CVsIntellect.com}};
      \end{tikzpicture}},
  }%
%%
</#if>

\begin{document}
\maketitle

<#-- show sections based on order -->
<#list resume.configuration.sectionDetails as sectionDetail>

<#-- certifications -->
<#if sectionDetail.isCertificationSection()><#if resume.hasCertifications()>
\section{${sectionDetail.heading}}
<#list resume.certifications as certification>
<#assign certificateString = helper.joinStringsWith(" by ", "${certification.name}", "${certification.authorityName}")>
\cvitem{${certification.startDateAndEndDate}}{\textbf{${certificateString}}<#if helper.isNotEmpty("${certification.number}")>, Number: ${certification.number}</#if>}
</#list>
</#if></#if>

<#-- custom -->
<#if sectionDetail.isCustomSection()>
<#assign customSection = resume.getCustomSection("${sectionDetail.sectionId}")>
<#if customSection.hasCustomSectionEntries()>
\section{${sectionDetail.heading}}
<#list customSection.entries as entry>
\cvitem{${entry.heading}}{${entry.text}}
</#list>
</#if></#if>

<#-- education -->
<#if sectionDetail.isEducationSection()><#if resume.hasEducation()>
\section{${sectionDetail.heading}}
<#list resume.educations as education>
<#assign degreeString = helper.joinStringsWith(" in ", "${education.degree}", "${education.fieldOfStudy}")>
<#assign collegeString = helper.getCommaSeperatedString("${education.schoolName}", "${education.university}")>
<#assign scoreString = helper.joinStringsWith(": ", "${education.scoreType}", "${education.totalScore}")>
\cventry{${education.startDateAndEndDate}}{${degreeString}}{${collegeString}}{${scoreString}}{}{${education.summary}}
</#list>
</#if></#if>

<#-- languages -->
<#if sectionDetail.isLanguageSection()><#if resume.hasLanguages()>
\section{${sectionDetail.heading}}
\begin{description}[nosep,labelwidth=1in,labelsep=\separatorcolumnwidth,leftmargin=!]
 \item[\phantom{\hspace{1in}}]
 \begin{itemize*}[leftmargin=*, itemjoin={{\hfil}}]
  \item[\phantom{\large$\circ$}] \makebox[1in][l]{\textit{Read}}
  \item[\phantom{\large$\circ$}] \makebox[1in][l]{\textit{Write}}
  \item[\phantom{\large$\circ$}] \makebox[1in][l]{\textit{Speak}}
 \end{itemize*}
\end{description}
<#list resume.languages as language>
\begin{description}[nosep,labelwidth=1in,labelsep=\separatorcolumnwidth,leftmargin=!,align=right]
 \item[${language.name}]
 \begin{itemize*}[leftmargin=*, itemjoin={{\hfil}}]
  \item \makebox[1in][l]{${language.read}}
  \item \makebox[1in][l]{${language.write}}
  \item \makebox[1in][l]{${language.speak}}
 \end{itemize*}
\end{description}
</#list>
</#if></#if>

<#-- objective -->
<#if sectionDetail.isObjectiveSection()><#if resume.hasObjective()>
\section{${sectionDetail.heading}}
\cvitem{}{${resume.objective.text}}
</#if></#if>

<#-- patents -->
<#if sectionDetail.isPatentSection()><#if resume.hasPatents()>
\section{${sectionDetail.heading}}
<#list resume.patents as patent>
<#assign patentString = helper.getCommaSeperatedString("${patent.officeName}", "${patent.number}", "${patent.date}", "${patent.status}", "${patent.url}")>
\cventry{${resume.patents?size - patent_index}}{${patent.title}}{${patent.inventors}}{}{}{<#if helper.isNotEmpty("${patentString}")>${patentString}\newline</#if>
${patent.summary}}
</#list>
</#if></#if>

<#-- personal -->
<#if sectionDetail.isPersonalSection()>
\section{${sectionDetail.heading}}
\begin{description}[nosep,labelwidth=1.25in,labelsep=3ex,leftmargin=!,align=right]
<#if helper.atleastOneIsNotEmpty("${resume.contact.addressLine}", "${resume.contact.city}", "${resume.contact.state}", "${resume.contact.country}", "${resume.contact.pincode}")>
<#assign cityStateString = helper.getCommaSeperatedString("${resume.contact.city}", "${resume.contact.state}")>
<#assign countryCodeString = helper.joinStringsWith(" - ", "${resume.contact.country}", "${resume.contact.pincode}")>
\item[Address] ${resume.contact.addressLine}, ${cityStateString}, ${countryCodeString}
</#if>
<#if helper.isNotEmpty("${resume.contact.phoneNumber}")>\item[Phone] ${resume.contact.phoneNumber}</#if>
<#if helper.isNotEmpty("${resume.contact.emailId}")>\item[Email] ${resume.contact.emailId}</#if>
<#if resume.links??><#list resume.links as link>
\item[${helper.capitalize("${link.name}")}] \href{${link.getUrl()}}{${link.getLastPartOfURL()}}
</#list></#if>
<#if helper.isNotEmpty("${resume.personal.gender}")>\item[Gender] ${resume.personal.gender}</#if>
<#if helper.isNotEmpty("${resume.personal.dateOfBirth}")>\item[Date of Birth] ${resume.personal.dateOfBirth}</#if>
<#if helper.isNotEmpty("${resume.personal.fathersName}")>\item[Fathers Name] ${resume.personal.fathersName}</#if>
<#if helper.isNotEmpty("${resume.personal.mothersName}")>\item[Mothers Name] ${resume.personal.mothersName}</#if>
<#if helper.isNotEmpty("${resume.personal.maritalStatus}")>\item[Marital Status] ${resume.personal.maritalStatus}</#if>
<#if helper.isNotEmpty("${resume.personal.nationality}")>\item[Nationality] ${resume.personal.nationality}</#if>
<#if helper.isNotEmpty("${resume.personal.passportNumber}")>\item[Passport Number] ${resume.personal.passportNumber}</#if>
<#if helper.isNotEmpty("${resume.personal.languages}")>\item[Languages] ${resume.personal.languages}</#if>
<#if helper.isNotEmpty("${resume.personal.hobbies}")>\item[Hobbies] ${resume.personal.hobbies}</#if>
 \end{description}
</#if>

<#-- positions -->
<#if sectionDetail.isPositionSection()><#if resume.hasPositions()>
\section{${sectionDetail.heading}}
<#list resume.positions as position>
<#assign positionString = helper.joinStringsWith(" at ", "${position.title}", "${position.companyName}")>
\cventry{${position.startDateAndEndDate}}{${positionString}}{${position.companyLocation}}{${position.companyURL}}{}{${position.summary}}
</#list>
</#if></#if>

<#-- projects -->
<#if sectionDetail.isProjectSection()><#if resume.hasProjects()>
\section{${sectionDetail.heading}}
<#list resume.projects as project>
<#assign projectString = helper.joinStringsWith(" on ", "${project.role}", "${project.name}")>
<#assign companyString = helper.joinStringsWith(" for ", "${project.companyName}", "${project.clientName}")>
\cventry{${project.startDateAndEndDate}}{${projectString}}{${companyString}}{}{}{${project.summary}}
</#list>
</#if></#if>

<#-- publications -->
<#if sectionDetail.isPublicationSection()><#if resume.hasPublications()>
\section{${sectionDetail.heading}}
<#list resume.publications as publication>
<#assign publicationString = helper.getCommaSeperatedString("${publication.publisherName}", "${publication.date}", "${publication.url}")>
\cventry{${resume.publications?size - publication_index}}{${publication.title}}{${publication.authors}}{}{}{<#if helper.isNotEmpty("${publicationString}")>${publicationString}\newline</#if>
${publication.summary}}
</#list>
</#if></#if>

<#-- recommendations -->
<#if sectionDetail.isRecommendationSection()><#if resume.hasRecommendations()>
\section{${sectionDetail.heading}}
<#list resume.recommendations as recommendation>
\cventry{}{${recommendation.name}}{${recommendation.type}}{}{}{${recommendation.text}}
</#list>
</#if></#if>

<#-- skills -->
<#if sectionDetail.isSkillsSection()><#if resume.hasSkills()>
\section{${sectionDetail.heading}}
<#list resume.skillGroups as skillGroup>
\cvitem{${skillGroup.skillGroup}}{<#if helper.isNotEmpty("${skillGroup.description}")>${skillGroup.description}</#if>\newline
<#if skillGroup.skills??>
\begin{itemize*}[leftmargin=*, itemjoin={{\qquad}}]
<#list skillGroup.skills as skill>
\item \makebox[0.2\maincolumnwidth][l]{${skill}}
</#list>
\end{itemize*}
</#if>
}
</#list>
</#if></#if>

<#-- summary -->
<#if sectionDetail.isSummarySection()><#if resume.hasSummary()>
\section{${sectionDetail.heading}}
\cventry{}{<#if resume.summary.keywords??><#list resume.summary.keywords as keyword>\textbf{${keyword}}<#if keyword_has_next> | </#if></#list></#if>}{}{}{}{${resume.summary.summary}}
</#if></#if>

<#-- talks -->
<#if sectionDetail.isTalkSection()><#if resume.hasTalks()>
\section{${sectionDetail.heading}}
<#list resume.talks as talk>
<#assign talkString = helper.getCommaSeperatedString("${talk.event}", "${talk.date}", "${talk.url}")>
\cventry{${resume.talks?size - talk_index}}{${talk.title}}{${talk.speakers}}{}{}{<#if helper.isNotEmpty("${talkString}")>${talkString}\newline</#if>
${talk.summary}}
</#list>
</#if></#if>

<#-- volunteers -->
<#if sectionDetail.isVolunteerSection()><#if resume.hasVolunteers()>
\section{${sectionDetail.heading}}
<#list resume.volunteers as volunteer>
\cventry{}{${volunteer.role}}{${volunteer.cause}}{${volunteer.organizationName}}{}{${volunteer.summary}}
</#list>
</#if></#if>

</#list>
\end{document}