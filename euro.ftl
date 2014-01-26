<#-- font-size: large, font: avant garde -->
<#-- top: 40, bottom: 40, left: 30, right: 30, line-spacing: 1, has-section-indent?: true, section-indent: 125 -->
<#-- color: black, date-format: numeric, newline-character:  -->

\documentclass[helvetica,notitle,logo]{europecv}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[a4paper,left=${resume.configuration.leftMargin},top=${resume.configuration.topMargin},right=${resume.configuration.rightMargin},bottom=${resume.configuration.bottomMargin}]{geometry}
\usepackage{ifpdf}
\usepackage{bibentry}
\usepackage[english]{babel}
\usepackage{url}
\usepackage{hyperref}
\usepackage{enumitem}
\ifpdf
\usepackage[pdftex]{graphicx}
\else
\usepackage{graphicx}
\fi
\usepackage{color}
<#-- color -->
\definecolor{black}{rgb}{0,0,0}
\definecolor{blue}{rgb}{0.22,0.45,0.70}
\definecolor{green}{rgb}{0.35,0.70,0.30}
\definecolor{orange}{rgb}{0.95,0.55,0.15}
\definecolor{purple}{rgb}{0.50,0.33,0.80}
\definecolor{red}{rgb}{0.95,0.20,0.20}
\definecolor{grey}{rgb}{0.45,0.45,0.45}
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
\ecvLeftColumnWidth{${resume.configuration.sectionIndent}}
\linespread{${resume.configuration.lineSpacing}}
\setitemize{noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt}

<#-- personal -->
\ecvlastname{${resume.personal.lastName}}
\ecvfirstname{${resume.personal.firstName}}
<#assign addressString = helper.getCommaSeperatedString("${resume.contact.addressLine}", "${resume.contact.city}", "${resume.contact.state}", "${resume.contact.country}", "${resume.contact.pincode}")>
<#if helper.isNotEmpty("${addressString}")>
\ecvaddress{${addressString}}
</#if>
<#if helper.isNotEmpty("${resume.contact.phoneNumber}")>
\ecvtelephone{${resume.contact.phoneNumber}}
</#if>
<#if helper.isNotEmpty("${resume.contact.emailId}")>
\ecvemail{${resume.contact.emailId}}}}
</#if>
<#if helper.isNotEmpty("${resume.personal.nationality}")>
\ecvnationality{${resume.personal.nationality}}
</#if>
<#if helper.isNotEmpty("${resume.personal.gender}")>
\ecvgender{${resume.personal.gender}}
</#if>
<#if helper.isNotEmpty("${resume.personal.dateOfBirth}")>
\ecvdateofbirth{${resume.personal.dateOfBirth}}
</#if>

\begin{document}
\fancyfoot{}
\selectlanguage{english}
\begin{europecv}
\ecvpersonalinfo[20pt]

<#-- show sections based on order -->
<#list resume.configuration.sectionDetails as sectionDetail>
<#if sectionDetail.isObjectiveSection()>
<#-- objective -->
<#if resume.hasObjective()>
\ecvsection{\color{${resume.configuration.color}}${sectionDetail.heading}}
\ecvitem{}{${resume.objective.text}}
</#if>
</#if>
<#-- positions -->
<#if sectionDetail.isPositionSection()>
<#if resume.hasPositions()>

\ecvsection{\color{${resume.configuration.color}}${sectionDetail.heading}}
<#list resume.positions as position>
\ecvitem{${position.startDateAndEndDate}}{\textbf{${position.title}}, ${position.companyName}}
<#if helper.isNotEmpty("${position.summary}")>
\ecvitem{}{${position.summary}}
</#if>
<#if position_has_next>
\ecvitem{}{}
</#if>
</#list>
</#if>
</#if>
<#-- education -->
<#if sectionDetail.isEducationSection()>
<#if resume.hasEducation()>

\ecvsection{\color{${resume.configuration.color}}${sectionDetail.heading}}
<#list resume.educations as education>
\ecvitem{${education.startDateAndEndDate}}{\textbf{${education.degree}}, ${education.fieldOfStudy}}
<#assign collegeString = helper.getCommaSeperatedString("${education.university}", "${education.schoolName}")>
\ecvitem{}{${collegeString}}
<#if helper.isNotEmpty("${education.summary}")>
\ecvitem{}{${education.summary}}
</#if>
<#if education_has_next>
\ecvitem{}{}
</#if>
</#list>
</#if>
</#if>
<#-- projects -->
<#if sectionDetail.isProjectSection()>
<#if resume.hasProjects()>

\ecvsection{\color{${resume.configuration.color}}${sectionDetail.heading}}
<#list resume.projects as project>
\ecvitem{${project.startDateAndEndDate}}{\textbf{${project.name}}}
<#if helper.isNotEmpty("${project.companyName}")>
\ecvitem{}{${project.companyName}}
</#if>
<#if helper.isNotEmpty("${project.clientName}")>
\ecvitem{}{${project.clientName}}
</#if>
<#if helper.isNotEmpty("${project.role}")>
\ecvitem{}{${project.role}}
</#if>
<#if helper.isNotEmpty("${project.summary}")>
\ecvitem{}{${project.summary}}
</#if>
<#if project_has_next>
\ecvitem{}{}
</#if>
</#list>
</#if>
</#if>
<#-- recommendations -->
<#if sectionDetail.isRecommendationSection()>
<#if resume.hasRecommendations()>

\ecvsection{\color{${resume.configuration.color}}${sectionDetail.heading}}
<#list resume.recommendations as recommendation>
<#assign recommendationString = helper.getCommaSeperatedString("\\textbf{${recommendation.name}}", "${recommendation.type}")>
\ecvitem{}{${recommendationString}}
\ecvitem{}{${recommendation.text}}
<#if recommendation_has_next>
\ecvitem{}{}
</#if>
</#list>
</#if>
</#if>
<#-- talks -->
<#if sectionDetail.isTalkSection()>
<#if resume.hasTalks()>

\ecvsection{\color{${resume.configuration.color}}${sectionDetail.heading}}
<#list resume.talks as talk>
\ecvitem{${talk.date}}{\textit{${talk.title}} - ${talk.speakers}}
\ecvitem{}{${talk.event}}
<#if helper.isNotEmpty("${talk.url}")>
\ecvitem{}{${talk.url}}
</#if>
<#if helper.isNotEmpty("${talk.summary}")>
\ecvitem{}{${talk.summary}}
</#if>
<#if talk_has_next>
\ecvitem{}{}
</#if>
</#list>
</#if>
</#if>
<#-- publications -->
<#if sectionDetail.isPublicationSection()>
<#if resume.hasPublications()>

\ecvsection{\color{${resume.configuration.color}}${sectionDetail.heading}}
<#list resume.publications as publication>
\ecvitem{${publication.date}}{\textit{${publication.title}} - ${publication.authors}}
<#if helper.isNotEmpty("${publication.publisherName}")>
\ecvitem{}{${publication.publisherName}}
</#if>
<#if helper.isNotEmpty("${publication.url}")>
\ecvitem{}{${publication.url}}
</#if>
<#if helper.isNotEmpty("${publication.summary}")>
\ecvitem{}{${publication.summary}}
</#if>
<#if publication_has_next>
\ecvitem{}{}
</#if>
</#list>
</#if>
</#if>
<#-- patents -->
<#if sectionDetail.isPatentSection()>
<#if resume.hasPatents()>

\ecvsection{\color{${resume.configuration.color}}${sectionDetail.heading}}
<#list resume.patents as patent>
\ecvitem{${patent.date}}{\textit{${patent.title}} - ${patent.inventors}}
<#assign patentString = helper.getCommaSeperatedString("${patent.officeName}", "${patent.number}", "${patent.status}")>
<#if helper.isNotEmpty("${patentString}")>
\ecvitem{}{${patentString}}
</#if>
<#if helper.isNotEmpty("${patent.summary}")>
\ecvitem{}{${patent.summary}}
</#if>
<#if patent_has_next>
\ecvitem{}{}
</#if>
</#list>
</#if>
</#if>
<#-- certifications -->
<#if sectionDetail.isCertificationSection()>
<#if resume.hasCertifications()>

\ecvsection{\color{${resume.configuration.color}}${sectionDetail.heading}}
<#list resume.certifications as certification>
\ecvitem{${certification.startDateAndEndDate}}{\textit{${certification.name}} - ${certification.authorityName}}
<#if helper.isNotEmpty("${certification.number}")>
\ecvitem{}{${certification.number}}
</#if>
<#if certification_has_next>
\ecvitem{}{}
</#if>
</#list>
</#if>
</#if>
<#-- volunteers -->
<#if sectionDetail.isVolunteerSection()>
<#if resume.hasVolunteers()>

\ecvsection{\color{${resume.configuration.color}}${sectionDetail.heading}}
<#list resume.volunteers as volunteer>
\ecvitem{}{\textit{${volunteer.cause}}, ${volunteer.organizationName}}
\ecvitem{}{${volunteer.role}}
<#if helper.isNotEmpty("${volunteer.summary}")>
\ecvitem{}{${volunteer.summary}}
</#if>
<#if volunteer_has_next>
\ecvitem{}{}
</#if>
</#list>
</#if>
</#if>
<#-- skills -->
<#if sectionDetail.isSkillsSection()>
<#if resume.hasSkills()>

\ecvsection{\color{${resume.configuration.color}}${sectionDetail.heading}}
<#list resume.skillGroups as skillGroup>
\ecvitem{${skillGroup.skillGroup}}{${skillGroup.skills}}
<#if skillGroup_has_next>
\ecvitem{}{}
</#if>
</#list>
</#if>
</#if>
<#-- personal -->
<#if sectionDetail.isPersonalSection()>
<#if helper.atleastOneIsNotEmpty("${resume.personal.maritalStatus}", "${resume.personal.languages}", "${resume.personal.hobbies}")>

\ecvsection{\color{${resume.configuration.color}}${sectionDetail.heading}}
<#if helper.isNotEmpty("${resume.personal.maritalStatus}")>
\ecvitem{Marital Status}{${resume.personal.maritalStatus}}
</#if>
<#if helper.isNotEmpty("${resume.personal.languages}")>
\ecvitem{Languages}{${resume.personal.languages}}
</#if>
<#if helper.isNotEmpty("${resume.personal.hobbies}")>
\ecvitem{Hobbies}{${resume.personal.hobbies}}
</#if>
</#if>
</#if>
<#-- custom section -->
<#if sectionDetail.isCustomSection()>
<#assign customSection = resume.getCustomSection("${sectionDetail.sectionId}")>
<#if customSection.hasCustomSectionEntries()>

\ecvsection{\color{${resume.configuration.color}}${sectionDetail.heading}}
<#list customSection.entries as entry>
\ecvitem{}{${entry.text}}
<#if entry_has_next>
\ecvitem{}{}
</#if>
</#list>
</#if>
</#if>
</#list>

\end{europecv}
\end{document}