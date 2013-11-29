\documentclass[a4paper,${resume.configuration.fontSize}]{moderncv}
\moderncvstyle{casual}
\moderncvcolor{${resume.configuration.color}}
\usepackage[left=${resume.configuration.leftMargin},top=${resume.configuration.topMargin},right=${resume.configuration.rightMargin},bottom=${resume.configuration.bottomMargin}]{geometry}
<#-- spacing -->
\setlength{\hintscolumnwidth}{${resume.configuration.sectionIndent}}
\linespread{${resume.configuration.lineSpacing}}
<#-- font -->
<#assign fontTypeValue = helper.getFontTypeValue("${resume.configuration.fontType}")>
\renewcommand{\rmdefault}{${fontTypeValue}}
\renewcommand{\familydefault}{\rmdefault}

<#-- personal -->
\firstname{${resume.personal.firstName}}
\familyname{${resume.personal.lastName}}
<#if helper.isNotEmpty("${resume.contact.addressLine}")>
\address{${resume.contact.addressLine}}{${resume.contact.city}<#if helper.isNotEmpty("${resume.contact.state}")>, ${resume.contact.state} ${resume.contact.pincode}</#if>}{${resume.contact.country}}
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

<#-- objective -->
<#if sectionDetail.isObjectiveSection()>
  <#if resume.hasObjective()>
    \section{${sectionDetail.heading}}
    \cvitem{}{${resume.objective.text}}
  </#if>
</#if>

<#-- positions -->
<#if sectionDetail.isPositionSection()>
  <#if resume.hasPositions()>
    \section{${sectionDetail.heading}}
    <#list resume.positions as position>
    \cventry{${position.startDateAndEndDate}}{${position.title}}{${position.companyName}}{}{}{%
      <#if helper.isNotEmpty("${position.summary}")>${position.summary}</#if>}
    </#list>
  </#if>
</#if>

<#-- education -->
<#if sectionDetail.isEducationSection()>
  <#if resume.hasEducation()>
  \section{${sectionDetail.heading}}
  <#list resume.educations as education>
    <#assign degreeString = helper.getCommaSeperatedString("${education.degree}", "${education.fieldOfStudy}")>
    <#assign collegeString = helper.getCommaSeperatedString("${education.university}", "${education.schoolName}")>
    \cventry{${education.startDateAndEndDate}}{${education.degree}<#if helper.isNotEmpty("${education.fieldOfStudy}")> in ${education.fieldOfStudy}</#if>}{${collegeString}}{}{}{${education.summary}}
  </#list>
  </#if>
</#if>

<#-- projects (DO WE EVEN NEED THIS? SHOULDN'T THESE BE PART OF EXPERIENCES?) -->
<#if sectionDetail.isProjectSection()>
  <#if resume.hasProjects()>
  \section{${sectionDetail.heading}}
  <#list resume.projects as project>
  \cventry{${project.startDateAndEndDate}}{%
    <#if helper.isNotEmpty("${project.role}")>${project.role}<#if helper.isNotEmpty("${project.name}")> on ${project.name}%</#if>
    <#elseif helper.isNotEmpty("${project.name}")>${project.name}</#if>}
    {${project.companyName}}{${project.clientName}}{}{${project.summary}}
  </#list>
  </#if>
</#if>

<#-- skills -->
<#if sectionDetail.isSkillsSection()>
  <#if resume.hasSkills()>
  \section{${sectionDetail.heading}}
  <#list resume.skillGroups as skillGroup>
  \cvitem{${skillGroup.skillGroup}}{${skillGroup.skills}}
  </#list>
  </#if>
</#if>

<#-- achievements -->
<#if sectionDetail.isAchievementSection()>
  <#if resume.hasAchievements()>
  \section{${sectionDetail.heading}}
  <#list resume.achievements as achievement>
  \cvitem{${achievement.heading}}{${achievement.description}}
  </#list>
  </#if>
</#if>

<#-- personal -->
<#if sectionDetail.isPersonalSection()>
\section{${sectionDetail.heading}}
  <#if helper.isNotEmpty("${resume.personal.gender}")>\cvitem{Gender}{${resume.personal.gender}}</#if>
  <#if helper.isNotEmpty("${resume.personal.dateOfBirth}")>\cvitem{Date of Birth}{${resume.personal.dateOfBirth}}</#if>
  <#if helper.isNotEmpty("${resume.personal.maritalStatus}")>\cvitem{Marital Status}{${resume.personal.maritalStatus}}</#if>
  <#if helper.isNotEmpty("${resume.personal.nationality}")>\cvitem{Nationality}{${resume.personal.nationality}}</#if>
  <#if helper.isNotEmpty("${resume.personal.languages}")>\cvitem{Languages}{${resume.personal.languages}}</#if><#-- THIS SHOULD BE MORE THAN A LINE ITEM, I.E. A SECTION -->
  <#if helper.isNotEmpty("${resume.personal.hobbies}")>\cvitem{Hobbies}{${resume.personal.hobbies}}</#if><#-- THIS SHOULD BE MORE THAN A LINE ITEM, I.E. A SECTION -->
</#if>

<#-- custom -->
<#if sectionDetail.isCustomSection()>
  <#assign customSection = resume.getCustomSection("${sectionDetail.sectionId}")>
  <#if customSection.hasCustomSectionEntries()>
  \section{${sectionDetail.heading}}
  <#list customSection.entries as entry>
  \cvline{${entry.text}}
  </#list>
  </#if>
</#if>

<#-- associations -->
<#if sectionDetail.isAssociationSection()>
  <#if resume.hasAssociations()>
  \section{${sectionDetail.heading}}
  <#list resume.associations as association>
  \cvitem{${association.name}}{${association.description}}
  </#list>
  </#if>
</#if>

<#-- recommendations -->
<#if sectionDetail.isRecommendationSection()>
  <#if resume.hasRecommendations()>
  \section{${sectionDetail.heading}}
  <#list resume.recommendations as recommendation>
  \cvitem{\textbf{${recommendation.name}}<#if helper.isNotEmpty("${recommendation.type}")> (${recommendation.type})</#if>}{${recommendation.text}}
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


</#list>

\end{document}