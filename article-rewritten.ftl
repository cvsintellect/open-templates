<#-- font-size: large, font: default -->
<#-- top: , bottom: , left: , right: , line-spacing: 1, has-section-indent?: true, section-indent: 90 -->
<#-- color: black, date-format: numeric, newline-character:  -->
\documentclass[${resume.configuration.fontSize}]{article}
\usepackage{array, xcolor, bibentry}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{longtable}
\usepackage{hyperref}
\usepackage{enumitem}
\usepackage[left=${resume.configuration.leftMargin},top=${resume.configuration.topMargin},right=${resume.configuration.rightMargin},bottom=${resume.configuration.bottomMargin}]{geometry}
<#-- font -->
<#assign fontTypeValue = helper.getFontTypeValue("${resume.configuration.fontType}")>
<#if helper.isRomanFont("${resume.configuration.fontType}")>
\renewcommand{\rmdefault}{${fontTypeValue}}
\renewcommand{\familydefault}{\rmdefault}
<#elseif helper.isSansSerifFont("${resume.configuration.fontType}")>
\renewcommand{\sfdefault}{${fontTypeValue}}
\renewcommand{\familydefault}{\sfdefault}
<#elseif helper.isTypeWriterFont("${resume.configuration.fontType}")>
\renewcommand{\ttdefault}{${fontTypeValue}}
\renewcommand{\familydefault}{\ttdefault}
</#if>
<#-- spacing -->
\linespread{${resume.configuration.lineSpacing}}
\setitemize{noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt}

\newcolumntype{L}{p{1.00\textwidth}}

<#-- name -->
\title{\bfseries\Huge\vspace{-50pt} ${resume.personal.firstName} ${resume.personal.lastName}\vspace{-40pt}}
\date{}

\begin{document}
\maketitle
<#-- show sections based on order -->
<#list resume.configuration.sectionDetails as sectionDetail>
<#if sectionDetail.isObjectiveSection()>
<#-- objective -->
<#if resume.hasObjective()>

\section*{${sectionDetail.heading}}
\begin{longtable}{L}
${resume.objective.text} \\
\end{longtable}
</#if>
</#if>
<#-- positions -->
<#if sectionDetail.isPositionSection()>
<#if resume.hasPositions()>

\section*{${sectionDetail.heading}}
<#list resume.positions as position>
\begin{longtable}{L}
\textbf{${position.title}}, ${position.companyName} \\
${position.startDateAndEndDate} \\
<#if helper.isNotEmpty("${position.summary}")>
${position.summary} \\
</#if>
\end{longtable}
</#list>
</#if>
</#if>
<#-- education -->
<#if sectionDetail.isEducationSection()>
<#if resume.hasEducation()>

\section*{${sectionDetail.heading}}
<#list resume.educations as education>
\begin{longtable}{L}
\textbf{${education.degree}}, ${education.fieldOfStudy} \\
${education.startDateAndEndDate} \\
<#assign collegeString = helper.getCommaSeperatedString("${education.university}", "${education.schoolName}")>
${collegeString} \\
<#if helper.isNotEmpty("${education.summary}")>
${education.summary} \\
</#if>
\end{longtable}
</#list>
</#if>
</#if>
<#-- projects -->
<#if sectionDetail.isProjectSection()>
<#if resume.hasProjects()>

\section*{${sectionDetail.heading}}
<#list resume.projects as project>
\begin{longtable}{L}
\textbf{${project.name}} \\
<#if helper.isNotEmpty("${project.companyName}")>
${project.companyName} \\
</#if>
<#if helper.isNotEmpty("${project.clientName}")>
${project.clientName} \\
</#if>
${project.startDateAndEndDate} \\
<#if helper.isNotEmpty("${project.role}")>
${project.role} \\
</#if>
<#if helper.isNotEmpty("${project.summary}")>
${project.summary} \\
</#if>
\end{longtable}
</#list>
</#if>
</#if>
<#-- recommendations -->
<#if sectionDetail.isRecommendationSection()>
<#if resume.hasRecommendations()>

\section*{${sectionDetail.heading}}
<#list resume.recommendations as recommendation>
\begin{longtable}{L}
<#assign recommendationString = helper.getCommaSeperatedString("\\textbf{${recommendation.name}}", "${recommendation.type}")>
${recommendationString} \\
${recommendation.text} \\
\end{longtable}
</#list>
</#if>
</#if>
<#-- talks -->
<#if sectionDetail.isTalkSection()>
<#if resume.hasTalks()>

\section*{${sectionDetail.heading}}
<#list resume.talks as talk>
\begin{longtable}{L}
\textit{${talk.title}} - ${talk.speakers} \\
${talk.event} , ${talk.date} \\
<#if helper.isNotEmpty("${talk.url}")>
${talk.url} \\
</#if>
<#if helper.isNotEmpty("${talk.summary}")>
${talk.summary} \\
</#if>
\end{longtable}
</#list>
</#if>
</#if>
<#-- publications -->
<#if sectionDetail.isPublicationSection()>
<#if resume.hasPublications()>

\section*{${sectionDetail.heading}}
<#list resume.publications as publication>
\begin{longtable}{L}
\textit{${publication.title}} - ${publication.authors} \\
<#if helper.isNotEmpty("${publication.publisherName}")>
${publication.publisherName} \\
</#if>
${publication.date} \\
<#if helper.isNotEmpty("${publication.url}")>
${publication.url} \\
</#if>
<#if helper.isNotEmpty("${publication.summary}")>
${publication.summary} \\
</#if>
\end{longtable}
</#list>
</#if>
</#if>
<#-- patents -->
<#if sectionDetail.isPatentSection()>
<#if resume.hasPatents()>

\section*{${sectionDetail.heading}}
<#list resume.patents as patent>
\begin{longtable}{L}
\textit{${patent.title}} - ${patent.inventors} \\
<#assign patentString = helper.getCommaSeperatedString("${patent.officeName}", "${patent.number}", "${patent.status}")>
<#if helper.isNotEmpty("${patentString}")>
${patentString} \\
${patent.date} \\
</#if>
<#if helper.isNotEmpty("${patent.summary}")>
${patent.summary} \\
</#if>
\end{longtable}
</#list>
</#if>
</#if>
<#-- certifications -->
<#if sectionDetail.isCertificationSection()>
<#if resume.hasCertifications()>

\section*{${sectionDetail.heading}}
<#list resume.certifications as certification>
\begin{longtable}{L}
\textit{${certification.name}} - ${certification.authorityName} \\
<#if helper.isNotEmpty("${certification.number}")>
${certification.number} \\
${certification.startDateAndEndDate} \\
</#if>
\end{longtable}
</#list>
</#if>
</#if>
<#-- test scores -->
<#if sectionDetail.isTestScoreSection()>
<#if resume.hasTestScores()>

\section*{${sectionDetail.heading}}
<#list resume.testScores as testScore>
\begin{longtable}{L}
${testScore.score} - \textit{${testScore.name}} \\
${testScore.date} \\
\end{longtable}
</#list>
</#if>
</#if>
<#-- volunteers -->
<#if sectionDetail.isVolunteerSection()>
<#if resume.hasVolunteers()>

\section*{${sectionDetail.heading}}
<#list resume.volunteers as volunteer>
\begin{longtable}{L}
\textit{${volunteer.cause}}, ${volunteer.organizationName} \\
${volunteer.role} \\
<#if helper.isNotEmpty("${volunteer.summary}")>
${volunteer.summary} \\
</#if>
\end{longtable}
</#list>
</#if>
</#if>
<#-- achievements -->
<#if sectionDetail.isAchievementSection()>
<#if resume.hasAchievements()>

\section*{${sectionDetail.heading}}
<#list resume.achievements as achievement>
\begin{longtable}{L}
\textit{${achievement.heading}} \\
<#if helper.isNotEmpty("${achievement.description}")>
${achievement.description} \\
</#if>
\end{longtable}
</#list>
</#if>
</#if>
<#-- associations -->
<#if sectionDetail.isAssociationSection()>
<#if resume.hasAssociations()>

\section*{${sectionDetail.heading}}
<#list resume.associations as association>
\begin{longtable}{L}
\textit{${association.name}} \\
<#if helper.isNotEmpty("${association.description}")>
${association.description} \\
</#if>
\end{longtable}
</#list>
</#if>
</#if>
<#-- skills -->
<#if sectionDetail.isSkillsSection()>
<#if resume.hasSkills()>

\section*{${sectionDetail.heading}}
<#list resume.skillGroups as skillGroup>
\begin{longtable}{L}
\textbf{${skillGroup.skillGroup}} \\
${skillGroup.skills} \\
\end{longtable}
</#list>
</#if>
</#if>
<#-- resources -->
<#if sectionDetail.isResourcesSection()>
<#if resume.hasResources()>

\section*{${sectionDetail.heading}}
<#list resume.resources as resource>
\begin{longtable}{L}
${resource.name} \\
\url{${resource.url}} \\
<#if helper.isNotEmpty("${resource.description}")>
${resource.description} \\
</#if>
\end{longtable}
</#list>
</#if>
</#if>
<#-- personal -->
<#if sectionDetail.isPersonalSection()>

\section*{${sectionDetail.heading}}
\begin{longtable}{>{\raggedleft}p{0.20\textwidth} p{0.80\textwidth}}
<#if helper.isNotEmpty("${resume.contact.addressLine}")>
ADDRESS & ${resume.contact.addressLine} \\
<#assign addressString = helper.getCommaSeperatedString("${resume.contact.city}", "${resume.contact.state}", "${resume.contact.country}")>
<#if helper.isNotEmpty("${addressString}")>
 & ${addressString} - ${resume.contact.pincode} \\
</#if>
</#if>
<#if helper.isNotEmpty("${resume.contact.phoneNumber}")>
PHONE & ${resume.contact.phoneNumber} \\
</#if>
<#if helper.isNotEmpty("${resume.contact.emailId}")>
EMAIL & ${resume.contact.emailId} \\
</#if>
<#if helper.isNotEmpty("${resume.personal.gender}")>
GENDER & ${resume.personal.gender} \\
</#if>
<#if helper.isNotEmpty("${resume.personal.dateOfBirth}")>
DATE OF BIRTH & ${resume.personal.dateOfBirth} \\
</#if>
<#if helper.isNotEmpty("${resume.personal.maritalStatus}")>
MARITAL STATUS & ${resume.personal.maritalStatus} \\
</#if>
<#if helper.isNotEmpty("${resume.personal.nationality}")>
NATIONALITY & ${resume.personal.nationality} \\
</#if>
<#if helper.isNotEmpty("${resume.personal.languages}")>
LANGUAGES & ${resume.personal.languages} \\
</#if>
<#if helper.isNotEmpty("${resume.personal.hobbies}")>
HOBBIES & ${resume.personal.hobbies} \\
</#if>
\end{longtable}
</#if>
<#-- custom section -->
<#if sectionDetail.isCustomSection()>
<#assign customSection = resume.getCustomSection("${sectionDetail.sectionId}")>
<#if customSection.hasCustomSectionEntries()>

\section*{${sectionDetail.heading}}
<#list customSection.entries as entry>
\begin{longtable}{L}
 & ${entry.text} \\
\end{longtable}
</#list>
</#if>
</#if>
</#list>

\end{document}