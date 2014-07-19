\documentclass[a4paper,${resume.configuration.fontSize}]{moderncv}
\moderncvstyle{oldstyle}
\moderncvcolor{${resume.configuration.color}}
\usepackage[left=${resume.configuration.leftMargin},top=${resume.configuration.topMargin},right=${resume.configuration.rightMargin},bottom=${resume.configuration.bottomMargin}]{geometry}
\usepackage{multicol}

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

<#if resume.hasSummary()>
\quote{${resume.summary.headline}}
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
\cventry{${certification.startDateAndEndDate}}{${certificateString}}{}{<#if helper.isNotEmpty("${certification.number}")>Number: ${certification.number}</#if>}{}{}
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
 <#list resume.languages as language>
\cvitem{${language.name}}{${language.read} ${language.write} ${language.speak}}
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
<#assign patentString = helper.getCommaSeperatedString("${patent.officeName}", "${patent.number}", "${patent.date}", "${patent.status}")>
\cventry{${resume.patents?size - patent_index}}{${patent.title}}{${patent.inventors}}{}{}{<#if helper.isNotEmpty("${patentString}")>${patentString} \newline</#if>
${patent.summary}}
</#list>
</#if></#if>

<#-- personal -->
<#if sectionDetail.isPersonalSection()>
\section{${sectionDetail.heading}}
<#assign cityStateString = helper.getCommaSeperatedString("${resume.contact.city}", "${resume.contact.state}")>
<#assign countryCodeString = helper.joinStringsWith(" - ", "${resume.contact.country}", "${resume.contact.pincode}")>
\cvitem{Address}{${resume.contact.addressLine}\newline
${cityStateString}\newline
${countryCodeString}}
<#if helper.isNotEmpty("${resume.contact.phoneNumber}")>\cvitem{Phone}{${resume.contact.phoneNumber}}</#if>
<#if helper.isNotEmpty("${resume.contact.emailId}")>\cvitem{Email}{${resume.contact.emailId}}</#if>
<#if resume.links??><#list resume.links as link>
\cvitem{${link.name}}{${link.getLastPartOfURL()}}
</#list></#if>
<#if helper.isNotEmpty("${resume.personal.gender}")>\cvitem{Gender}{${resume.personal.gender}}</#if>
<#if helper.isNotEmpty("${resume.personal.dateOfBirth}")>\cvitem{Date of Birth}{${resume.personal.dateOfBirth}}</#if>
<#if helper.isNotEmpty("${resume.personal.fathersName}")>\cvitem{Fathers Name}{${resume.personal.fathersName}}</#if>
<#if helper.isNotEmpty("${resume.personal.mothersName}")>\cvitem{Mothers Name}{${resume.personal.mothersName}}</#if>
<#if helper.isNotEmpty("${resume.personal.maritalStatus}")>\cvitem{Marital Status}{${resume.personal.maritalStatus}}</#if>
<#if helper.isNotEmpty("${resume.personal.nationality}")>\cvitem{Nationality}{${resume.personal.nationality}}</#if>
<#if helper.isNotEmpty("${resume.personal.passportNumber}")>\cvitem{Passport Number}{${resume.personal.passportNumber}}</#if>
<#if helper.isNotEmpty("${resume.personal.languages}")>\cvitem{Languages}{${resume.personal.languages}}</#if>
<#if helper.isNotEmpty("${resume.personal.hobbies}")>\cvitem{Hobbies}{${resume.personal.hobbies}}</#if>
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
\cventry{${resume.publications?size - publication_index}}{${publication.title}}{${publication.authors}}{}{}{<#if helper.isNotEmpty("${publicationString}")>${publicationString} \newline</#if>
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
\cvitem{${skillGroup.skillGroup}}{<#if helper.isNotEmpty("${skillGroup.description}")>${skillGroup.description}</#if>
<#if skillGroup.skills??>
\begin{multicols}{3}
\begin{itemize}
<#list skillGroup.skills as skill>
\item ${skill}
</#list>
\end{itemize}
\end{multicols}
</#if>
}
</#list>
</#if></#if>

<#-- summary -->
<#if sectionDetail.isSummarySection()><#if resume.hasSummary()>
\section{${sectionDetail.heading}}
\cvitem{}{
<#if resume.summary.keywords??><#list resume.summary.keywords as keyword>\textbf{${keyword}}<#if keyword_has_next > | </#if></#list>\newline</#if>
${resume.summary.summary}}
</#if></#if>

<#-- talks -->
<#if sectionDetail.isTalkSection()><#if resume.hasTalks()>
\section{${sectionDetail.heading}}
<#list resume.talks as talk>
<#assign talkString = helper.getCommaSeperatedString("${talk.event}", "${talk.date}", "${talk.url}")>
\cventry{${resume.talks?size - talk_index}}{${talk.title}}{${talk.speakers}}{}{}{<#if helper.isNotEmpty("${talkString}")>${talkString} \newline</#if>
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