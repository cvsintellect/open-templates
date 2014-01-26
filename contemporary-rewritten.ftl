\documentclass[a4paper,${resume.configuration.fontSize}]{moderncv}
\moderncvstyle{banking}
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
<#if helper.atleastOneIsNotEmpty("${resume.contact.addressLine}", "${resume.contact.city}", "${resume.contact.state}", "${resume.contact.country}", "${resume.contact.pincode}")>
  <#assign addressString = helper.getCommaSeperatedString("${resume.contact.city}", "${resume.contact.state}")>
  \address{${resume.contact.addressLine}}{${addressString} ${resume.contact.pincode}}{${resume.contact.country}}
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

<#-- certifications -->
<#if sectionDetail.isCertificationSection()><#if resume.hasCertifications()>
  \section{${sectionDetail.heading}}
  <#list resume.certifications as certification>
    \cventry{${certification.startDateAndEndDate}}{${certification.name}}{${certification.authorityName}}{${certification.number}}{}{}
  </#list>
</#if></#if>

<#-- custom -->
<#if sectionDetail.isCustomSection()><#assign customSection = resume.getCustomSection("${sectionDetail.sectionId}")><#if customSection.hasCustomSectionEntries()>
  \section{${sectionDetail.heading}}
  <#list customSection.entries as entry>
    \cvline{${entry.text}}
  </#list>
</#if></#if>

<#-- education -->
<#if sectionDetail.isEducationSection()><#if resume.hasEducation()>
  \section{${sectionDetail.heading}}
  <#list resume.educations as education>
    <#assign degreeString = helper. joinStringsWith(" in ", "${education.degree}", "${education.fieldOfStudy}")>
    <#assign collegeString = helper.getCommaSeperatedString("${education.university}", "${education.schoolName}")>
    \cventry{${education.startDateAndEndDate}}{${degreeString}}{${collegeString}}{}{}{${education.summary}}
  </#list>
</#if></#if>

<#-- objective -->
<#if sectionDetail.isObjectiveSection()><#if resume.hasObjective()>
  \section{${sectionDetail.heading}}
  \cvline{${resume.objective.text}}
</#if></#if>

<#-- patents -->
<#if sectionDetail.isPatentSection()><#if resume.hasPatents()>
  \section{${sectionDetail.heading}}
  <#list resume.patents as patent>
    \cventry{${patent.date}}{${patent.title}}{${patent.inventors}}{${patent.number}}{${patent.officeName} ${patent.status}}{${patent.summary}}
  </#list>
</#if></#if>

<#-- personal -->
<#if sectionDetail.isPersonalSection()><#if helper.atleastOneIsNotEmpty("${resume.personal.gender}", "${resume.personal.dateOfBirth}", "${resume.personal.maritalStatus}", "${resume.personal.nationality}", "${resume.personal.languages}", "${resume.personal.hobbies}")>
  \section{${sectionDetail.heading}}
  <#if helper.isNotEmpty("${resume.personal.gender}")>\cvitem{Gender}{${resume.personal.gender}}</#if>
  <#if helper.isNotEmpty("${resume.personal.dateOfBirth}")>\cvitem{Date of Birth}{${resume.personal.dateOfBirth}}</#if>
  <#if helper.isNotEmpty("${resume.personal.maritalStatus}")>\cvitem{Marital Status}{${resume.personal.maritalStatus}}</#if>
  <#if helper.isNotEmpty("${resume.personal.nationality}")>\cvitem{Nationality}{${resume.personal.nationality}}</#if>
  <#if helper.isNotEmpty("${resume.personal.languages}")>\cvitem{Languages}{${resume.personal.languages}}</#if>
  <#if helper.isNotEmpty("${resume.personal.hobbies}")>\cvitem{Hobbies}{${resume.personal.hobbies}}</#if>
</#if></#if>

<#-- positions -->
<#if sectionDetail.isPositionSection()><#if resume.hasPositions()>
  \section{${sectionDetail.heading}}
  <#list resume.positions as position>
    \cventry{${position.startDateAndEndDate}}{${position.title}}{${position.companyName}}{}{}{${position.summary}}
  </#list>
</#if></#if>

<#-- projects -->
<#if sectionDetail.isProjectSection()><#if resume.hasProjects()>
  \section{${sectionDetail.heading}}
  <#list resume.projects as project>
    <#assign projectString = helper. joinStringsWith(" on ", "${project.role}", "${project.name}")>
    <#assign companyString = helper. joinStringsWith(" for ", "${project.companyName}", "${project.clientName}")>
    \cventry{${project.startDateAndEndDate}}{${projectString}}{${companyString}}{}{}{${project.summary}}
  </#list>
</#if></#if>

<#-- publications -->
<#if sectionDetail.isPublicationSection()><#if resume.hasPublications()>
  \section{${sectionDetail.heading}}
  <#list resume.publications as publication>
    \cventry{${publication.date}}{${publication.title}}{${publication.authors}}{${publication.publisherName}}{${publication.url}}{${publication.summary}}
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
    \cvitem{${skillGroup.skillGroup}}{${skillGroup.skills}}
  </#list>
</#if></#if>

<#-- talks -->
<#if sectionDetail.isTalkSection()><#if resume.hasTalks()>
  \section{${sectionDetail.heading}}
  <#list resume.talks as talk>
    \cventry{${talk.date}}{${talk.title}}{${talk.speakers}}{${talk.event}}{${talk.url}}{${talk.summary}}
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