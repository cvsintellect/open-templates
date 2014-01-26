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

\definecolor{lightgray}{gray}{0.8}
\newcolumntype{L}{>{\raggedleft}p{0.20\textwidth}}
\newcolumntype{R}{p{0.75\textwidth}}
\newcommand\VRule{\color{lightgray}\vrule width 0.5pt}

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
\begin{longtable}{L!{\VRule}R}
 & ${resume.objective.text} \\
\end{longtable}
</#if>
</#if>
<#-- positions -->
<#if sectionDetail.isPositionSection()>
<#if resume.hasPositions()>

\section*{${sectionDetail.heading}}
<#list resume.positions as position>
\begin{longtable}{L!{\VRule}R}
${position.startDateAndEndDate} & \textbf{${position.title}}, ${position.companyName} \\
<#if helper.isNotEmpty("${position.summary}")>
 & ${position.summary} \\
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
\begin{longtable}{L!{\VRule}R}
${education.startDateAndEndDate} & \textbf{${education.degree}}, ${education.fieldOfStudy} \\
<#assign collegeString = helper.getCommaSeperatedString("${education.university}", "${education.schoolName}")>
 & ${collegeString} \\
<#if helper.isNotEmpty("${education.summary}")>
 & ${education.summary} \\
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
\begin{longtable}{L!{\VRule}R}
${project.startDateAndEndDate} & \textbf{${project.name}} \\
<#if helper.isNotEmpty("${project.companyName}")>
 & ${project.companyName} \\
</#if>
<#if helper.isNotEmpty("${project.clientName}")>
 & ${project.clientName} \\
</#if>
<#if helper.isNotEmpty("${project.role}")>
 & ${project.role} \\
</#if>
<#if helper.isNotEmpty("${project.summary}")>
 & ${project.summary} \\
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
\begin{longtable}{L!{\VRule}R}
<#assign recommendationString = helper.getCommaSeperatedString("\\textbf{${recommendation.name}}", "${recommendation.type}")>
& ${recommendationString} \\
& ${recommendation.text} \\
\end{longtable}
</#list>
</#if>
</#if>
<#-- talks -->
<#if sectionDetail.isTalkSection()>
<#if resume.hasTalks()>

\section*{${sectionDetail.heading}}
<#list resume.talks as talk>
\begin{longtable}{L!{\VRule}R}
${talk.date} & \textit{${talk.title}} - ${talk.speakers} \\
 & ${talk.event} \\
<#if helper.isNotEmpty("${talk.url}")>
 & ${talk.url} \\
</#if>
<#if helper.isNotEmpty("${talk.summary}")>
 & ${talk.summary} \\
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
\begin{longtable}{L!{\VRule}R}
${publication.date} & \textit{${publication.title}} - ${publication.authors} \\
<#if helper.isNotEmpty("${publication.publisherName}")>
 & ${publication.publisherName} \\
</#if>
<#if helper.isNotEmpty("${publication.url}")>
 & ${publication.url} \\
</#if>
<#if helper.isNotEmpty("${publication.summary}")>
 & ${publication.summary} \\
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
\begin{longtable}{L!{\VRule}R}
${patent.date} & \textit{${patent.title}} - ${patent.inventors} \\
<#assign patentString = helper.getCommaSeperatedString("${patent.officeName}", "${patent.number}", "${patent.status}")>
<#if helper.isNotEmpty("${patentString}")>
 & ${patentString} \\
</#if>
<#if helper.isNotEmpty("${patent.summary}")>
 & ${patent.summary} \\
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
\begin{longtable}{L!{\VRule}R}
${certification.startDateAndEndDate} & \textit{${certification.name}} - ${certification.authorityName} \\
<#if helper.isNotEmpty("${certification.number}")>
 & ${certification.number} \\
</#if>
\end{longtable}
</#list>
</#if>
</#if>
<#-- volunteers -->
<#if sectionDetail.isVolunteerSection()>
<#if resume.hasVolunteers()>

\section*{${sectionDetail.heading}}
<#list resume.volunteers as volunteer>
\begin{longtable}{L!{\VRule}R}
 & \textit{${volunteer.cause}}, ${volunteer.organizationName} \\
 & ${volunteer.role} \\
<#if helper.isNotEmpty("${volunteer.summary}")>
 & ${volunteer.summary} \\
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
\begin{longtable}{L!{\VRule}R}
\textbf{${skillGroup.skillGroup}} & ${skillGroup.skills} \\
\end{longtable}
</#list>
</#if>
</#if>
<#-- personal -->
<#if sectionDetail.isPersonalSection()>

\section*{${sectionDetail.heading}}
\begin{longtable}{L!{\VRule}R}
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
\begin{longtable}{L!{\VRule}R}
 & ${entry.text} \\
\end{longtable}
</#list>
</#if>
</#if>
</#list>

\end{document}