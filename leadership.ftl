<#-- font-size: large, font: default -->
<#-- top: , bottom: , left: , right: , line-spacing: 1, has-section-indent?: true, section-indent: 100 -->
<#-- color: black, date-format: numeric, newline-character: \\ -->

\documentclass[a4paper,${resume.configuration.fontSize}]{res}
\usepackage{hyperref}
\usepackage{enumitem}
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
\topmargin -20pt
\oddsidemargin -5pt
\evensidemargin -5pt
\textheight 755pt
\resumewidth 470pt
\newsectionwidth{${resume.configuration.sectionIndent}}
\linespread{${resume.configuration.lineSpacing}}
\setitemize{noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt}

\begin{document}

<#-- personal -->
\name{\Large ${resume.personal.firstName} ${resume.personal.lastName}}
\address{\textbf{Address}\\
${resume.contact.addressLine}\\
${resume.contact.city}, ${resume.contact.state}\\
${resume.contact.country} - ${resume.contact.pincode}}
\address{\textbf{Contact}\\
${resume.contact.emailId}\\
${resume.contact.phoneNumber}}

\begin{resume}

<#-- show sections based on order -->
<#list resume.configuration.sectionDetails as sectionDetail>
<#if sectionDetail.isObjectiveSection()>
<#-- objective -->
<#if resume.hasObjective()>
\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
${resume.objective.text}
</#if>
</#if>
<#-- positions -->
<#if sectionDetail.isPositionSection()>
<#if resume.hasPositions()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
<#list resume.positions as position>
\textbf{${position.title}}\\
${position.companyName}\\
<#if helper.isNotEmpty("${position.startDateAndEndDate}")>
${position.startDateAndEndDate}\\
</#if>
<#if helper.isNotEmpty("${position.summary}")>
${position.summary}
</#if>
<#if position_has_next>
\\
</#if>
</#list>
</#if>
</#if>
<#-- education -->
<#if sectionDetail.isEducationSection()>
<#if resume.hasEducation()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
<#list resume.educations as education>
\textbf{${education.degree}}, ${education.fieldOfStudy}\\
<#assign collegeString = helper.getCommaSeperatedString("${education.university}", "${education.schoolName}")>
${collegeString}\\
<#if helper.isNotEmpty("${education.startDateAndEndDate}")>
${education.startDateAndEndDate}\\
</#if>
<#if helper.isNotEmpty("${education.summary}")>
${education.summary}
</#if>
<#if education_has_next>
\\
</#if>
</#list>
</#if>
</#if>
<#-- projects -->
<#if sectionDetail.isProjectSection()>
<#if resume.hasProjects()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
<#list resume.projects as project>
\textbf{${project.name}}\\
<#if helper.isNotEmpty("${project.companyName}")>
${project.companyName}\\
</#if>
<#if helper.isNotEmpty("${project.clientName}")>
${project.clientName}\\
</#if>
<#if helper.isNotEmpty("${project.role}")>
${project.role}\\
</#if>
<#if helper.isNotEmpty("${project.startDateAndEndDate}")>
${project.startDateAndEndDate}\\
</#if>
<#if helper.isNotEmpty("${project.summary}")>
${project.summary}
</#if>
<#if project_has_next>
\\
</#if>
</#list>
</#if>
</#if>
<#-- recommendations -->
<#if sectionDetail.isRecommendationSection()>
<#if resume.hasRecommendations()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
<#list resume.recommendations as recommendation>
\textbf{${recommendation.name}}, ${recommendation.type}\\
${recommendation.text}
<#if recommendation_has_next>
\\
</#if>
</#list>
</#if>
</#if>
<#-- talks -->
<#if sectionDetail.isTalkSection()>
<#if resume.hasTalks()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
<#list resume.talks as talk>
\textit{${talk.title}} - ${talk.speakers}\\
${talk.event}, ${talk.date}\\
<#if helper.isNotEmpty("${talk.url}")>
${talk.url}\\
</#if>
<#if helper.isNotEmpty("${talk.summary}")>
${talk.summary}
</#if>
<#if talk_has_next>
\\
</#if>
</#list>
</#if>
</#if>
<#-- publications -->
<#if sectionDetail.isPublicationSection()>
<#if resume.hasPublications()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
<#list resume.publications as publication>
\textit{${publication.title}} - ${publication.authors}\\
<#assign publisherString = helper.getCommaSeperatedString("${publication.publisherName}", "${publication.date}")>
<#if helper.isNotEmpty("${publisherString}")>
${publisherString}\\
</#if>
<#if helper.isNotEmpty("${publication.url}")>
${publication.url}\\
</#if>
<#if helper.isNotEmpty("${publication.summary}")>
${publication.summary}
</#if>
<#if publication_has_next>
\\
</#if>
</#list>
</#if>
</#if>
<#-- patents -->
<#if sectionDetail.isPatentSection()>
<#if resume.hasPatents()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
<#list resume.patents as patent>
\textit{${patent.title}} - ${patent.inventors}\\
<#assign patentString = helper.getCommaSeperatedString("${patent.officeName}", "${patent.date}")>
<#if helper.isNotEmpty("${patentString}")>
${patentString}\\
</#if>
<#assign patentString = helper.getCommaSeperatedString("${patent.number}", "${patent.status}")>
<#if helper.isNotEmpty("${patentString}")>
${patentString}\\
</#if>
<#if helper.isNotEmpty("${patent.summary}")>
${patent.summary}
</#if>
<#if patent_has_next>
\\
</#if>
</#list>
</#if>
</#if>
<#-- certifications -->
<#if sectionDetail.isCertificationSection()>
<#if resume.hasCertifications()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
<#list resume.certifications as certification>
\textit{${certification.name}} - ${certification.authorityName}\\
${certification.startDateAndEndDate}\\
<#if helper.isNotEmpty("${certification.number}")>
${certification.number}\\
</#if>
<#if certification_has_next>
\\
</#if>
</#list>
</#if>
</#if>
<#-- test scores -->
<#if sectionDetail.isTestScoreSection()>
<#if resume.hasTestScores()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
<#list resume.testScores as testScore>
${testScore.score} - \textit{${testScore.name}}, ${testScore.date}
<#if testScore_has_next>
\\
</#if>
</#list>
</#if>
</#if>
<#-- volunteers -->
<#if sectionDetail.isVolunteerSection()>
<#if resume.hasVolunteers()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
<#list resume.volunteers as volunteer>
\textit{${volunteer.cause}}, ${volunteer.organizationName}\\
${volunteer.role}\\
<#if helper.isNotEmpty("${volunteer.summary}")>
${volunteer.summary}
</#if>
<#if volunteer_has_next>
\\
</#if>
</#list>
</#if>
</#if>
<#-- achievements -->
<#if sectionDetail.isAchievementSection()>
<#if resume.hasAchievements()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
<#list resume.achievements as achievement>
\textit{${achievement.heading}}\\
<#if helper.isNotEmpty("${achievement.description}")>
${achievement.description}
</#if>
<#if achievement_has_next>
\\
</#if>
</#list>
</#if>
</#if>
<#-- associations -->
<#if sectionDetail.isAssociationSection()>
<#if resume.hasAssociations()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
<#list resume.associations as association>
\textit{${association.name}}\\
<#if helper.isNotEmpty("${association.description}")>
${association.description}
</#if>
<#if association_has_next>
\\
</#if>
</#list>
</#if>
</#if>
<#-- skills -->
<#if sectionDetail.isSkillsSection()>
<#if resume.hasSkills()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
<#list resume.skillGroups as skillGroup>
\textbf{${skillGroup.skillGroup}}\\
${skillGroup.skills}
<#if skillGroup_has_next>
\\
</#if>
</#list>
</#if>
</#if>
<#-- resources -->
<#if sectionDetail.isResourcesSection()>
<#if resume.hasResources()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
<#list resume.resources as resource>
${resource.name}\\
\url{${resource.url}}\\
<#if helper.isNotEmpty("${resource.description}")>
${resource.description}
</#if>
<#if resource_has_next>
\\
</#if>
</#list>
</#if>
</#if>
<#-- personal -->
<#if sectionDetail.isPersonalSection()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
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
</#if>
<#-- custom section -->
<#if sectionDetail.isCustomSection()>
<#assign customSection = resume.getCustomSection("${sectionDetail.sectionId}")>
<#if customSection.hasCustomSectionEntries()>

\section{\centerline{\color{${resume.configuration.color}}${sectionDetail.heading}}}
\vspace{4pt} \moveleft \hoffset \vbox{\color{${resume.configuration.color}} \hrule width\resumewidth height 1pt} \smallskip
<#list customSection.entries as entry>
${entry.text}
<#if entry_has_next>
\\
</#if>
</#list>
</#if>
</#if>
</#list>

\end{resume}
\end{document}