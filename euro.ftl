\documentclass[helvetica,totpages,notitle,nologo]{europecv}
\usepackage{ifpdf}
\usepackage{bibentry}
\usepackage[english]{babel}
\usepackage{url}
\usepackage{hyperref}
\usepackage[inline]{enumitem}
\ifpdf
\usepackage[pdftex]{graphicx}
\else
\usepackage{graphicx}
\fi
\usepackage{xcolor}
\usepackage[a4paper,left=${resume.configuration.leftMargin},top=${resume.configuration.topMargin},right=${resume.configuration.rightMargin},bottom=${resume.configuration.bottomMargin}]{geometry}

<#-- color -->
<#if resume.configuration.isColorBlack()>
\colorlet{color00}{black!90}% for section title text
<#elseif resume.configuration.isColorBlue()>
\colorlet{color00}{blue!70}% for section title text
<#elseif resume.configuration.isColorGreen()>
\colorlet{color00}{green!60}% for section title text
<#elseif resume.configuration.isColorOrange()>
\colorlet{color00}{orange!40}% for section title text
<#elseif resume.configuration.isColorRed()>
\colorlet{color00}{red!70}% for section title text
<#elseif resume.configuration.isColorPurple()>
\colorlet{color00}{purple!60}% for section title text
<#elseif resume.configuration.isColorGrey()>
\colorlet{color00}{grey!90}% for section title text
</#if>

<#-- font -->
\usepackage[T1]{fontenc}
\usepackage{${helper.getFontTypeValue("${resume.configuration.fontType}")}}
<#if helper.isSansSerifFont("${resume.configuration.fontType}")>
\renewcommand*\familydefault{\sfdefault}
<#elseif helper.isTypeWriterFont("${resume.configuration.fontType}")>
\renewcommand*\familydefault{\ttdefault}
</#if>

<#-- spacing -->
\ecvLeftColumnWidth{${resume.configuration.sectionIndent}}
\linespread{${resume.configuration.lineSpacing}}
\setitemize{nolistsep,labelsep=1ex,leftmargin=*}

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
\ecvemail{${resume.contact.emailId}}
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

<#if resume.hasPhoto()>
\ecvpicture[width=60pt]{picture}
</#if>

<#if resume.isNotPremiumAccount()>
%% footer ad
\usepackage{eso-pic}
\usepackage{tikzpagenodes}
\AddToShipoutPictureBG{%
\begin{tikzpicture}[remember picture, overlay]
        \node [anchor=west, text=color3,  inner xsep=0pt] at (current page footer area.west) {\textit{powered by \href{www.cvsintellect.com}{CVsIntellect.com}}};
\end{tikzpicture}
}
%%
</#if>

\begin{document}
\fancyfoot{}
\selectlanguage{english}
\begin{europecv}
\ecvpersonalinfo[20pt]

<#if resume.links??>
<#list resume.links as link>
\ecvitem{${helper.capitalize("${link.name}")}}{\href{${link.getUrl()}}{${link.getLastPartOfURL()}}}
</#list>
\ecvitem{}{}
</#if>

<#if resume.hasHeadline()>
\ecvitem{}{\textit{${resume.summary.headline}}}
</#if>

<#-- show sections based on order -->
<#list resume.configuration.sectionDetails as sectionDetail>

<#-- certifications -->
<#if sectionDetail.isCertificationSection()><#if resume.hasCertifications()>
\ecvsection{\color{color00}${sectionDetail.heading}}
<#list resume.certifications as certification>
<#assign certificateString = helper.joinStringsWith(" by ", "\\textit{${certification.name}}", "\\textit{${certification.authorityName}}")>
\ecvitem{${certification.startDateAndEndDate}}{${certificateString}}
<#if helper.isNotEmpty("${certification.number}")>
\ecvitem{}{Number: ${certification.number}}
</#if>
</#list>
</#if></#if>

<#-- custom section -->
<#if sectionDetail.isCustomSection()>
<#assign customSection = resume.getCustomSection("${sectionDetail.sectionId}")>
<#if customSection.hasCustomSectionEntries()>
\ecvsection{\color{color00}${sectionDetail.heading}}
<#list customSection.entries as entry>
\ecvitem{${entry.heading}}{${entry.text}}
</#list>
</#if></#if>

<#-- education -->
<#if sectionDetail.isEducationSection()><#if resume.hasEducation()>
\ecvsection{\color{color00}${sectionDetail.heading}}
<#list resume.educations as education>
<#assign degreeString = helper.joinStringsWith(" in ", "\\textbf{${education.degree}}", "\\textbf{${education.fieldOfStudy}}")>
<#assign collegeString = helper.getCommaSeperatedString("${education.university}", "${education.schoolName}")>
<#assign scoreString = helper.joinStringsWith(": ", "${education.scoreType}", "${education.totalScore}")>
\ecvitem{${education.startDateAndEndDate}}{${degreeString}, \textit{${collegeString}}}
<#if helper.isNotEmpty("${scoreString}")>
\ecvitem{}{${scoreString}}
</#if>
<#if helper.isNotEmpty("${education.summary}")>
\ecvitem{}{${education.summary}}
</#if>
</#list>
</#if></#if>

<#-- languages -->
<#if sectionDetail.isLanguageSection()><#if resume.hasLanguages()>
\ecvsection{\color{color00}${sectionDetail.heading}}
\ecvitem{}{%
 \makebox[0.23\columnwidth][l]{\phantom{$\circ$\,}\textit{Read}}
 \makebox[0.23\columnwidth][l]{\phantom{$\circ$\,}\textit{Write}}
 \makebox[0.23\columnwidth][l]{\phantom{$\circ$\,}\textit{Speak}}}
<#list resume.languages as language>
\ecvitem{${language.name}}{%
 \makebox[0.23\columnwidth][l]{$\circ$\,${language.read}}
 \makebox[0.23\columnwidth][l]{$\circ$\,${language.write}}
 \makebox[0.23\columnwidth][l]{$\circ$\,${language.speak}}}
</#list>
</#if></#if>

<#-- objective -->
<#if sectionDetail.isObjectiveSection()><#if resume.hasObjective()>
\ecvsection{\color{color00}${sectionDetail.heading}}
\ecvitem{}{${resume.objective.text}}
</#if></#if>

<#-- patents -->
<#if sectionDetail.isPatentSection()><#if resume.hasPatents()>
\ecvsection{\color{color00}${sectionDetail.heading}}
<#list resume.patents as patent>
\ecvitem{${resume.patents?size - patent_index}}{\textit{${patent.title}} - \textit{${patent.inventors}}}
<#assign patentString = helper.getCommaSeperatedString("${patent.officeName}", "${patent.number}", "${patent.date}", "${patent.status}", "${patent.url}")>
<#if helper.isNotEmpty("${patentString}")>
\ecvitem{}{${patentString}}
</#if>
<#if helper.isNotEmpty("${patent.summary}")>
\ecvitem{}{${patent.summary}}
</#if>
</#list>
</#if></#if>

<#-- personal -->
<#if sectionDetail.isPersonalSection()><#if helper.atleastOneIsNotEmpty("${resume.personal.fathersName}", "${resume.personal.mothersName}", "${resume.personal.maritalStatus}", "${resume.personal.passportNumber}", "${resume.personal.languages}", "${resume.personal.hobbies}")>
\ecvsection{\color{color00}${sectionDetail.heading}}
<#if helper.isNotEmpty("${resume.personal.fathersName}")>
\ecvitem{Father's Name}{${resume.personal.fathersName}}
</#if>
<#if helper.isNotEmpty("${resume.personal.mothersName}")>
\ecvitem{Mother's Name}{${resume.personal.mothersName}}
</#if>
<#if helper.isNotEmpty("${resume.personal.maritalStatus}")>
\ecvitem{Marital Status}{${resume.personal.maritalStatus}}
</#if>
<#if helper.isNotEmpty("${resume.personal.passportNumber}")>
\ecvitem{Passport Number}{${resume.personal.passportNumber}}
</#if>
<#if helper.isNotEmpty("${resume.personal.languages}")>
\ecvitem{Languages}{${resume.personal.languages}}
</#if>
<#if helper.isNotEmpty("${resume.personal.hobbies}")>
\ecvitem{Hobbies}{${resume.personal.hobbies}}
</#if>
</#if></#if>

<#-- positions -->
<#if sectionDetail.isPositionSection()><#if resume.hasPositions()>
\ecvsection{\color{color00}${sectionDetail.heading}}
<#list resume.positions as position>
<#assign positionString = helper.joinStringsWith(" at ", "\\textbf{${position.title}}", "\\textbf{${position.companyName}}")>
\ecvitem{${position.startDateAndEndDate}}{${positionString}<#if helper.isNotEmpty("${position.companyURL}")>, ${position.companyURL}</#if><#if helper.isNotEmpty("${position.companyLocation}")>, \textit{${position.companyLocation}}</#if>}
<#if helper.isNotEmpty("${position.summary}")>
\ecvitem{}{${position.summary}}
</#if>
</#list>
</#if></#if>

<#-- projects -->
<#if sectionDetail.isProjectSection()><#if resume.hasProjects()>
\ecvsection{\color{color00}${sectionDetail.heading}}
<#list resume.projects as project>
<#assign projectString = helper.joinStringsWith(" on ", "\\textbf{${project.role}}", "\\textbf{${project.name}}")>
<#assign companyString = helper.joinStringsWith(" for ", "${project.companyName}", "${project.clientName}")>
\ecvitem{${project.startDateAndEndDate}}{${projectString}<#if helper.isNotEmpty("${companyString}")>, ${companyString}</#if>}
<#if helper.isNotEmpty("${project.summary}")>
\ecvitem{}{${project.summary}}
</#if>
</#list>
</#if></#if>

<#-- publications -->
<#if sectionDetail.isPublicationSection()><#if resume.hasPublications()>
\ecvsection{\color{color00}${sectionDetail.heading}}
<#list resume.publications as publication>
<#assign publicationString = helper.getCommaSeperatedString("${publication.publisherName}", "${publication.date}", "${publication.url}")>
\ecvitem{${resume.publications?size - publication_index}}{\textit{${publication.title}} - \textit{${publication.authors}}}
<#if helper.isNotEmpty("${publicationString}")>
\ecvitem{}{${publicationString}}
</#if>
<#if helper.isNotEmpty("${publication.summary}")>
\ecvitem{}{${publication.summary}}
</#if>
</#list>
</#if></#if>

<#-- recommendations -->
<#if sectionDetail.isRecommendationSection()><#if resume.hasRecommendations()>
\ecvsection{\color{color00}${sectionDetail.heading}}
<#list resume.recommendations as recommendation>
\ecvitem{\textbf{${recommendation.name}}}{\textit{${recommendation.type}}}
\ecvitem{}{${recommendation.text}}
</#list>
</#if></#if>

<#-- skills -->
<#if sectionDetail.isSkillsSection()><#if resume.hasSkills()>
\ecvsection{\color{color00}${sectionDetail.heading}}
<#list resume.skillGroups as skillGroup>
\ecvitem{${skillGroup.skillGroup}}{<#if helper.isNotEmpty("${skillGroup.description}")>${skillGroup.description}\newline</#if>
<#if skillGroup.skills??>
\begin{itemize*}[leftmargin=*, itemjoin={{\qquad}}]
<#list skillGroup.skills as skill>
\item \makebox[0.2\columnwidth][l]{${skill}}
</#list>
\end{itemize*}
</#if>
}
</#list>
</#if></#if>

<#-- summary -->
<#if sectionDetail.isSummarySection()><#if resume.hasSummary()>
\ecvsection{\color{color00}${sectionDetail.heading}}
\ecvitem{}{<#if resume.summary.keywords??><#list resume.summary.keywords as keyword>\textbf{${keyword}}<#if keyword_has_next> | </#if></#list>\newline</#if>
${resume.summary.summary}}
</#if></#if>

<#-- talks -->
<#if sectionDetail.isTalkSection()><#if resume.hasTalks()>
\ecvsection{\color{color00}${sectionDetail.heading}}
<#list resume.talks as talk>
<#assign talkString = helper.getCommaSeperatedString("${talk.event}", "${talk.date}", "${talk.url}")>
\ecvitem{${resume.talks?size - talk_index}}{\textit{${talk.title}} - \textit{${talk.speakers}}}
<#if helper.isNotEmpty("${talkString}")>
\ecvitem{}{${talkString}}
</#if>
<#if helper.isNotEmpty("${talk.summary}")>
\ecvitem{}{${talk.summary}}
</#if>
</#list>
</#if></#if>

<#-- volunteers -->
<#if sectionDetail.isVolunteerSection()><#if resume.hasVolunteers()>
\ecvsection{\color{color00}${sectionDetail.heading}}
<#list resume.volunteers as volunteer>
\ecvitem{\textit{${volunteer.role}}}{${volunteer.cause}, ${volunteer.organizationName}}
<#if helper.isNotEmpty("${volunteer.summary}")>
\ecvitem{}{${volunteer.summary}}
</#if>
</#list>
</#if></#if>

</#list>
\end{europecv}
\end{document}