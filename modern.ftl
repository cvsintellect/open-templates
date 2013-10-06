<#-- font-size: large, font: default -->
<#-- top: 60, bottom: 60, left: 60, right: 60, line-spacing: 1, has-section-indent?: true, section-indent: 70 -->
<#-- color: blue, date-format: numeric, newline-character:  -->

\documentclass[a4paper,${resume.configuration.fontSize}]{moderncv}
\moderncvstyle{casual}
\moderncvcolor{${resume.configuration.color}}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
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
\setlength{\hintscolumnwidth}{${resume.configuration.sectionIndent}}
\linespread{${resume.configuration.lineSpacing}}
\setitemize{noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt}
\AtBeginDocument{\recomputelengths}

<#-- personal -->
\firstname{${resume.personal.firstName}}
\familyname{${resume.personal.lastName}}
<#assign addressString = helper.getCommaSeperatedString("${resume.contact.addressLine}", "${resume.contact.city}", "${resume.contact.state}", "${resume.contact.country}")>
<#if helper.isNotEmpty("${addressString}")>
\address{${addressString}}{${resume.contact.pincode}}
</#if>
<#if helper.isNotEmpty("${resume.contact.phoneNumber}")>
\phone{${resume.contact.phoneNumber}}
</#if>
<#if helper.isNotEmpty("${resume.contact.emailId}")>
\email{${resume.contact.emailId}}
</#if>

\begin{document}
\maketitle
<#-- show sections based on order -->
<#list resume.configuration.sectionDetails as sectionDetail>
<#if sectionDetail.isObjectiveSection()>
<#-- objective -->
<#if resume.hasObjective()>

\section{${sectionDetail.heading}}
\cvitem{}{${resume.objective.text}}
\cvitem{}{}
</#if>
</#if>
<#-- positions -->
<#if sectionDetail.isPositionSection()>
<#if resume.hasPositions()>

\section{${sectionDetail.heading}}
<#list resume.positions as position>
\cvitem{}{\textbf{${position.title}}, ${position.companyName}}
<#if helper.isNotEmpty("${position.startDateAndEndDate}")>
\cvitem{}{${position.startDateAndEndDate}}
</#if>
<#if helper.isNotEmpty("${position.summary}")>
\cvitem{}{${position.summary}}
</#if>
\cvitem{}{}
</#list>
</#if>
</#if>
<#-- education -->
<#if sectionDetail.isEducationSection()>
<#if resume.hasEducation()>

\section{${sectionDetail.heading}}
<#list resume.educations as education>
\cvitem{}{\textbf{${education.degree}}, ${education.fieldOfStudy}}
<#assign collegeString = helper.getCommaSeperatedString("${education.university}", "${education.schoolName}")>
\cvitem{}{${collegeString}}
<#if helper.isNotEmpty("${education.startDateAndEndDate}")>
\cvitem{}{${education.startDateAndEndDate}}
</#if>
<#if helper.isNotEmpty("${education.summary}")>
\cvitem{}{${education.summary}}
</#if>
\cvitem{}{}
</#list>
</#if>
</#if>
<#-- projects -->
<#if sectionDetail.isProjectSection()>
<#if resume.hasProjects()>

\section{${sectionDetail.heading}}
<#list resume.projects as project>
\cvitem{}{\textbf{${project.name}}}}
<#if helper.isNotEmpty("${project.companyName}")>
\cvitem{}{${project.companyName}}
</#if>
<#if helper.isNotEmpty("${project.clientName}")>
\cvitem{}{${project.clientName}}
</#if>
<#if helper.isNotEmpty("${project.role}")>
\cvitem{}{${project.role}}
</#if>
<#if helper.isNotEmpty("${project.startDateAndEndDate}")>
\cvitem{}{${project.startDateAndEndDate}}
</#if>
<#if helper.isNotEmpty("${project.summary}")>
\cvitem{}{${project.summary}}
</#if>
\cvitem{}{}
</#list>
</#if>
</#if>
<#-- recommendations -->
<#if sectionDetail.isRecommendationSection()>
<#if resume.hasRecommendations()>

\section{${sectionDetail.heading}}
<#list resume.recommendations as recommendation>
<#assign recommendationString = helper.getCommaSeperatedString("\\textbf{${recommendation.name}}", "${recommendation.type}")>
\cvitem{}{${recommendationString}}
\cvitem{}{${recommendation.text}}
\cvitem{}{}
</#list>
</#if>
</#if>
<#-- talks -->
<#if sectionDetail.isTalkSection()>
<#if resume.hasTalks()>

\section{${sectionDetail.heading}}
<#list resume.talks as talk>
\cvitem{}{\textit{${talk.title}} - ${talk.speakers}}
<#assign talkString = helper.getCommaSeperatedString("${talk.event}", "${talk.date}")>
\cvitem{}{${talkString}}
<#if helper.isNotEmpty("${talk.url}")>
\cvitem{}{${talk.url}}
</#if>
<#if helper.isNotEmpty("${talk.summary}")>
\cvitem{}{${talk.summary}}
</#if>
\cvitem{}{}
</#list>
</#if>
</#if>
<#-- publications -->
<#if sectionDetail.isPublicationSection()>
<#if resume.hasPublications()>

\section{${sectionDetail.heading}}
<#list resume.publications as publication>
\cvitem{}{\textit{${publication.title}} - ${publication.authors}}
<#assign publisherString = helper.getCommaSeperatedString("${publication.publisherName}", "${publication.date}")>
<#if helper.isNotEmpty("${publisherString}")>
\cvitem{}{${publisherString}}
</#if>
<#if helper.isNotEmpty("${publication.url}")>
\cvitem{}{${publication.url}}
</#if>
<#if helper.isNotEmpty("${publication.summary}")>
\cvitem{}{${publication.summary}}
</#if>
\cvitem{}{}
</#list>
</#if>
</#if>
<#-- patents -->
<#if sectionDetail.isPatentSection()>
<#if resume.hasPatents()>

\section{${sectionDetail.heading}}
<#list resume.patents as patent>
\cvitem{}{\textit{${patent.title}} - ${patent.inventors}}
<#assign patentString = helper.getCommaSeperatedString("${patent.officeName}", "${patent.number}", "${patent.status}", "${patent.date}")>
<#if helper.isNotEmpty("${patentString}")>
\cvitem{}{${patentString}}
</#if>
<#if helper.isNotEmpty("${patent.summary}")>
\cvitem{}{${patent.summary}}
</#if>
\cvitem{}{}
</#list>
</#if>
</#if>
<#-- certifications -->
<#if sectionDetail.isCertificationSection()>
<#if resume.hasCertifications()>

\section{${sectionDetail.heading}}
<#list resume.certifications as certification>
\cvitem{}{\textit{${certification.name}} - ${certification.authorityName}}
<#assign certificationString = helper.getCommaSeperatedString("${certification.number}", "${certification.startDateAndEndDate}")>
<#if helper.isNotEmpty("${certificationString}")>
\cvitem{}{${certificationString}}
</#if>
\cvitem{}{}
</#list>
</#if>
</#if>
<#-- test scores -->
<#if sectionDetail.isTestScoreSection()>
<#if resume.hasTestScores()>

\section{${sectionDetail.heading}}
<#list resume.testScores as testScore>
\cvitem{}{${testScore.score} - \textit{${testScore.name}}, ${testScore.date}}
\cvitem{}{}
</#list>
</#if>
</#if>
<#-- volunteers -->
<#if sectionDetail.isVolunteerSection()>
<#if resume.hasVolunteers()>

\section{${sectionDetail.heading}}
<#list resume.volunteers as volunteer>
\cvitem{}{\textit{${volunteer.cause}}, ${volunteer.organizationName}}
\cvitem{}{${volunteer.role}}
<#if helper.isNotEmpty("${volunteer.summary}")>
\cvitem{}{${volunteer.summary}}
</#if>
\cvitem{}{}
</#list>
</#if>
</#if>
<#-- achievements -->
<#if sectionDetail.isAchievementSection()>
<#if resume.hasAchievements()>

\section{${sectionDetail.heading}}
<#list resume.achievements as achievement>
\cvitem{}{\textit{${achievement.heading}}}
<#if helper.isNotEmpty("${achievement.description}")>
\cvitem{}{${achievement.description}}
</#if>
\cvitem{}{}
</#list>
</#if>
</#if>
<#-- associations -->
<#if sectionDetail.isAssociationSection()>
<#if resume.hasAssociations()>

\section{${sectionDetail.heading}}
<#list resume.associations as association>
\cvitem{}{\textit{${association.name}}}
<#if helper.isNotEmpty("${association.description}")>
\cvitem{}{${association.description}}
</#if>
\cvitem{}{}
</#list>
</#if>
</#if>
<#-- skills -->
<#if sectionDetail.isSkillsSection()>
<#if resume.hasSkills()>

\section{${sectionDetail.heading}}
<#list resume.skillGroups as skillGroup>
\cvitem{}{\textbf{${skillGroup.skillGroup}}}
\cvitem{}{${skillGroup.skills}}
\cvitem{}{}
</#list>
</#if>
</#if>
<#-- resources -->
<#if sectionDetail.isResourcesSection()>
<#if resume.hasResources()>

\section{${sectionDetail.heading}}
<#list resume.resources as resource>
\cvitem{${resource.name}}{\url{${resource.url}}}
<#if helper.isNotEmpty("${resource.description}")>
\cvitem{}{${resource.description}}
</#if>
\cvitem{}{}
</#list>
</#if>
</#if>
<#-- personal -->
<#if sectionDetail.isPersonalSection()>
<#if helper.atleastOneIsNotEmpty("${resume.personal.gender}", "${resume.personal.dateOfBirth}", "${resume.personal.maritalStatus}", "${resume.personal.nationality}", "${resume.personal.languages}", "${resume.personal.hobbies}")>

\section{${sectionDetail.heading}}
\cvitem{}{
\begin{tabular}{ l l }
<#if helper.isNotEmpty("${resume.personal.gender}")>
\textbf{Gender } & ${resume.personal.gender} \\
</#if>
<#if helper.isNotEmpty("${resume.personal.dateOfBirth}")>
\textbf{Date of Birth } & ${resume.personal.dateOfBirth} \\
</#if>
<#if helper.isNotEmpty("${resume.personal.maritalStatus}")>
\textbf{Marital Status } & ${resume.personal.maritalStatus} \\
</#if>
<#if helper.isNotEmpty("${resume.personal.nationality}")>
\textbf{Nationality } & ${resume.personal.nationality} \\
</#if>
<#if helper.isNotEmpty("${resume.personal.languages}")>
\textbf{Languages } & ${resume.personal.languages} \\
</#if>
<#if helper.isNotEmpty("${resume.personal.hobbies}")>
\textbf{Hobbies } & ${resume.personal.hobbies} \\
</#if>
\end{tabular}
}
\cvitem{}{}
</#if>
</#if>
<#-- custom section -->
<#if sectionDetail.isCustomSection()>
<#assign customSection = resume.getCustomSection("${sectionDetail.sectionId}")>
<#if customSection.hasCustomSectionEntries()>

\section{${sectionDetail.heading}}
<#list customSection.entries as entry>
\cvitem{}{${entry.text}}
\cvitem{}{}
</#list>
</#if>
</#if>
</#list>

\end{document}