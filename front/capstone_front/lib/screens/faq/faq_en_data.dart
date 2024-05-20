import 'package:easy_localization/easy_localization.dart';

final Map<String, List<Map<String, dynamic>>> faqsEn = {
  'major': majorFaq,
  'doubleMajor': doubleMajorFaq,
  'teachingCertification': teachingCertificationFaq,
  'engineeringCertification': engineeringCertificationFaq,
  'courseRegistrationGuide': courseRegistrationGuideFaq,
  'classSchedule': classScheduleFaq,
  'grades': gradesFaq,
  'semesterSystem': semesterSystemFaq,
  'fieldPractice': fieldPracticeFaq,
  'ictCreditLinkage': ictCreditLinkageFaq,
  'seoulCityInternship': seoulCityInternshipFaq,
  'eastsoftFieldPractice': eastsoftFieldPracticeFaq,
  'currentStudentJobExperience': currentStudentJobExperienceFaq,
  'employmentLinkedInternship': employmentLinkedInternshipFaq,
  'lincProjectFieldPractice': lincProjectFieldPracticeFaq,
  'tuitionPayment': tuitionPaymentFaq,
  'tuitionRefund': tuitionRefundFaq,
  'registrationDocumentIssuance': registrationDocumentIssuanceFaq,
  'criteriaForTuitionCalculationForExceedingCourseDuration':
      criteriaForTuitionCalculationForExceedingCourseDurationFaq,
  'academicRecords': academicRecordsFaq,
  'leaveOfAbsence': leaveOfAbsenceFaq,
  'returnFromLeaveOfAbsence': returnFromLeaveOfAbsenceFaq,
  'completionOfAcademicProgram': completionOfAcademicProgramFaq,
  'graduationThesis': graduationThesisFaq,
  'graduationCertificationSystem': graduationCertificationSystemFaq,
  'onCampusScholarships': onCampusScholarshipsFaq,
  'offCampusScholarships': offCampusScholarshipsFaq,
  'nationalScholarships': nationalScholarshipsFaq,
  'studentLoans': studentLoansFaq,
  'preventionOfOverlappingFinancialAid': preventionOfOverlappingFinancialAidFaq,
  'employment': employmentFaq,
  'entrepreneurship': entrepreneurshipFaq,
  'militaryServiceGuidance': militaryServiceGuidanceFaq,
  'reserveForcesGuidance': reserveForcesGuidanceFaq,
  'assignmentApplicationChange': assignmentApplicationChangeFaq,
  'supportFundSettlement': supportFundSettlementFaq,
  'supportFundExpenditure': supportFundExpenditureFaq,
  'exchangeStudentProgram': exchangeStudentProgramFaq,
  'visitingStudentProgram': visitingStudentProgramFaq,
  'doubleDegree': doubleDegreeFaq,
  'shortTermLanguageStudyAbroad': shortTermLanguageStudyAbroadFaq,
  'studentGlobalEngagement': studentGlobalEngagementFaq,
  'undergraduateStudent': undergraduateStudentFaq,
  'studentEvent': studentEventFaq,
  'undergraduateDepartmentOffice': undergraduateDepartmentOfficeFaq,
  'studentCounselingCenter': studentCounselingCenterFaq,
  'learningMethodSeminar': learningMethodSeminarFaq,
  'learningVolunteerPeerTutor': learningVolunteerPeerTutorFaq,
  'learningCounselingAndClinic': learningCounselingAndClinicFaq,
  'library': libraryFaq,
  'onCampusWelfareFacilities': onCampusWelfareFacilitiesFaq,
  'classroomUsage': classroomUsageFaq,
  'itemRental': itemRentalFaq,
  'website': websiteFaq,
  'educationalObjectives': educationalObjectivesFaq,
  'educationalPhilosophy': educationalPhilosophyFaq,
  'idealStudentProfile': idealStudentProfileFaq,
  'kmuVision2030Plus': kmuVision2030PlusFaq,
  'specializationPlan': specializationPlanFaq,
};

final List<Map<String, dynamic>> majorFaq = [
  {
    'title':
        'What are the scope and procedures for major transfer applications?',
    'content': """
1. Eligibility - Students who have completed at least one year of coursework and acquired the following credits by the end of the fourth semester:
- Global Humanities/Social Sciences/Business/Arts (excluding Business Administration and KIS): 33 credits or more
- Law (excluding Corporate Law)/Engineering/Science and Technology/Physical Education/Architecture/Automotive: 34 credits or more
- Business Administration (excluding KIS) and Corporate Law: 30 credits or more

2. Scope of Application
- Applications are open to all departments except the Department of Education
- Cross-applications between day and evening courses are not allowed, nor are transfers within the same department of the same major
- Only one department application is allowed

3. Application Submission
- Log in to the comprehensive information system, enter the required information under “Major Transfer Application,” and save
- Applicant's photo is not separately required; the photo registered in the academic record will be used
- A “Self-Introduction” is required only for departments conducting oral or interview tests

4. Additional Notes
a. Once approved, the decision is final and cannot be reversed.
b. Evaluations are based on the average GPA including grades from the summer term. (New students of the current year are eligible to apply)
c. Accepted students will have their academic records changed immediately, affecting their tuition notice.
※ Please refer to the annual major transfer guidelines before applying.
""",
  },
  {
    'title':
        'What are the eligibility criteria for major transfer applications?',
    'content': """
Eligibility
- Students who have completed at least one year of coursework and acquired the following credits by the end of the fourth semester (students on leave must return in the approval semester to be eligible):
  * Global Humanities/Social Sciences/Business/Arts (excluding Business Administration and KIS): 33 credits or more
  * Law (excluding Corporate Law)/Engineering/Science and Technology/Physical Education/Software Convergence/Architecture/Automotive: 34 credits or more
  * Corporate Law/Business Administration/KIS: 30 credits or more
""",
  },
];

final List<Map<String, dynamic>> doubleMajorFaq = [
  {
    'title': 'What is a minor?',
    'content': """
A minor is recognized when a student completes 21 credits or more in another major or department in addition to their first major (requirements vary by department/major).
LINK: https://www.kookmin.ac.kr/comm/menu/user/0dbbd0998b720f892d00562f7fa78428/content/index.do
""",
  },
  {
    'title': 'What are double majors and multiple majors?',
    'content': """
Definition of Multiple Majors - Students who complete another major (or department) or an interdisciplinary major in addition to their first major will receive recognition and a separate bachelor's degree for each.
An interdisciplinary major involves courses offered by two or more majors (departments) within the same academic category.
A convergence major involves courses offered by two or more majors (departments) from different academic categories (e.g., humanities, engineering, science, arts).
LINK: https://www.kookmin.ac.kr/comm/menu/user/0d6f69373dd19f5c29bf96eae7bc01e1/content/index.do
""",
  },
  {
    'title': 'What is an interdisciplinary major?',
    'content': """
An interdisciplinary major is one of the multiple majors where courses offered by two or more majors (departments) are combined. It can be applied as a second major or minor, and applications should be submitted to the coordinating department during the designated period.
LINK: https://hat.kookmin.ac.kr/
""",
  },
  {
    'title': 'Can I apply for two interdisciplinary majors?',
    'content': """
Students can have up to two additional majors besides their first major, one interdisciplinary major, and one minor (including the interdisciplinary major).
You cannot apply for two interdisciplinary majors.
""",
  },
  {
    'title': 'When and how can I apply for an interdisciplinary major?',
    'content': """
1. Interdisciplinary majors can be applied for during the multiple majors application period each semester through the comprehensive information system (notices are typically in April and October).
2. Approved self-designed interdisciplinary majors can also be applied for during this period through the comprehensive information system.
LINK: https://hat.kookmin.ac.kr/link/intro https://hat.kookmin.ac.kr/fusion/intro
""",
  },
  {
    'title':
        'When and how to apply for a self-designed interdisciplinary major?',
    'content': """
Applications for self-designed interdisciplinary majors are accepted in the first semester of each academic year. Applicants must have a GPA of 3.0 or higher and be enrolled in their 3rd to 6th semester. Applications undergo a review process, and results are notified after approval.
LINK: https://hat.kookmin.ac.kr/major/intro
""",
  },
  {
    'title': 'Questions about overlapping credits in interdisciplinary majors',
    'content': """
1. For interdisciplinary majors, up to 15 credits can overlap with the first major for double majors, but no overlap is allowed for minors.
2. For convergence majors, up to 12 credits can overlap with the first major for double majors, and up to 6 credits for minors.
LINK: https://hat.kookmin.ac.kr/link/intro https://hat.kookmin.ac.kr/fusion/intro
""",
  },
  {
    'title':
        'What is the minimum credit requirement for a self-designed interdisciplinary major?',
    'content': """
The minimum credit requirement for each participating department in a self-designed interdisciplinary major is 36 credits in total, with a minimum of 9 credits from each group (department). If there are three groups, 9 credits must be completed from each, with the remaining credits (9 credits) from any group of choice.
LINK: https://hat.kookmin.ac.kr/major/approval
""",
  },
  {
    'title': 'I want to know the curriculum for interdisciplinary majors.',
    'content': """
The curriculum for interdisciplinary majors is updated annually and can be found on the school website under School Introduction -> Regulations -> Catalog.
LINK: https://www.kookmin.ac.kr/user/unIntr/unSttu/pdfCmmn/cradle/index.do
""",
  },
  {
    'title':
        'Questions about changing the classification of interdisciplinary major credits',
    'content': """
The classification of credits for interdisciplinary majors is finalized during graduation assessment. For inquiries about your credits, please contact the Department of Humanities and Technology Convergence.
""",
  },
  {
    'title':
        'Can I change my interdisciplinary major to a minor after applying?',
    'content': """
Yes, you can change your interdisciplinary major to a minor during the major cancellation period after approval.
LINK: https://hat.kookmin.ac.kr/link/intro https://hat.kookmin.ac.kr/fusion/intro
""",
  },
];

final List<Map<String, dynamic>> teachingCertificationFaq = [
  {
    'title':
        'Application, qualifications, and selection for the teacher training course',
    'content': """
To complete the teacher training course, the course must be established in the student's department and major.
Applications must be submitted during the 3rd or 4th semester, with applications accepted once per academic year in October.
Candidates are selected based on their grades and interview scores at the end of the second year (finalized at the end of February each year).
For more details, please visit the teacher training course website at http://teaching.kookmin.ac.kr/.
LINK: teaching.kookmin.ac.kr
""",
  },
];

final List<Map<String, dynamic>> engineeringCertificationFaq = [
  {
    'title': 'What are design courses?',
    'content': """
Design courses are specific courses within engineering certification that assign design credits, which may differ from course credits. Design courses must be completed in the sequence of [Introductory Design - Component Design - Capstone Design].
[Introductory Design] Entrepreneurship-Linked Engineering Design Introduction
[Component Design] Component design courses by program
[Capstone Design] **Capstone Design, **Capstone Design courses
For detailed design courses by program, please contact the department office.
""",
  },
  {
    'title': 'What should I do if I take a non-certified course?',
    'content': """
To complete engineering certification, you must take courses managed as certified courses within the department's program. Even if the course code is the same, if the course is not offered/managed by an engineering certification department, it will not count towards certification.
(EX: Thermodynamics in the Department of Automotive Engineering is not a certified course)
If it is a required certified course, you must retake it if you took a non-certified course with the same code.
In cases where retaking is not possible, graduation may not be possible.
LINK: https://cieek.kookmin.ac.kr/community/faq/8?sc=269
""",
  },
  {
    'title':
        'Are courses certified in other departments recognized as MSC courses?',
    'content': """
For basic liberal arts and MSC courses, if they are marked (engineering certification) or (ABEEK), they are recognized even if taken in other departments.
However, courses from universities without engineering certification will not count towards certification credits and may affect graduation eligibility.
LINK: https://cieek.kookmin.ac.kr/community/faq/8?sc=269
""",
  },
  {
    'title':
        'Can I take (engineering certification) courses without doing certification?',
    'content': """
You can take engineering certification (ABEEK) courses regardless of your certification status.
""",
  },
  {
    'title': 'What are the benefits of engineering certification?',
    'content': """
Benefits of completing engineering certification include:
1. International recognition as an engineer by ensuring equivalency of degrees across countries
2. Advantages when applying to companies with agreements with the Accreditation Board for Engineering Education of Korea (ABEEK)
3. Competitive edge in employment through demand-oriented education
4. Acquisition of creative problem-solving skills through program learning outcomes
For more details, visit the Center for Innovative Engineering Education's website (cieek.kookmin.ac.kr) or consult your department's engineering certification advisor.
LINK: http://www.abeek.or.kr/intro/benefit
""",
  },
  {
    'title':
        'Will courses taken before transfer/department change be recognized for certification?',
    'content': """
Regular courses are recognized for engineering certification as they are for the first major.
However, design courses may be recognized if the previous university operated engineering certification.
If the previous university did not operate engineering certification but the design courses were recognized in the first major, you may need to retake them to meet the design credit requirements for graduation.
""",
  },
  {
    'title': 'How can I check if I am doing engineering certification?',
    'content': """
Log in to the comprehensive information system > Student Profile Management > Personal Information Change > Basic Information Major. If you are doing engineering certification, it will be indicated as (OOO Engineering Department Intensive).
EX) Completing engineering certification: Materials Engineering Major (Materials Engineering Intensive) Not completing certification: Materials Engineering Major
LINK: https://cieek.kookmin.ac.kr/community/notice/56?sc=261
""",
  },
  {
    'title': 'Do I have to follow the order of design courses?',
    'content': """
Design courses must be completed in the sequence of [Introductory Design - Component Design - Capstone Design].
[Introductory Design] Entrepreneurship-Linked Engineering Design Introduction
[Component Design] Component design courses by program
[Capstone Design] **Capstone Design, **Capstone Design courses
For detailed design courses by program, please contact the department office.

* Note 1. You must complete a total of 12 design credits from introductory to capstone.
* Note 2. Design credits from other design courses taken in the same semester as Introductory Design are not recognized.
* Note 3. If you retake Introductory Design, previously earned design credits are not recognized.
* Note 4. After completing Capstone Design, design credits from subsequent courses are not recognized.
""",
  },
];

final List<Map<String, dynamic>> courseRegistrationGuideFaq = [
  {
    'title': 'What is the limit on the number of students for major courses?',
    'content': """
The number of students is limited based on the nature of the lecture (e.g., experiments, practical exercises, computer classes, discussion-based classes) and the capacity of the lecture or laboratory facilities.
""",
  },
  {
    'title': 'What are general electives?',
    'content': """
General electives refer to all courses outside the liberal arts and first major requirements. This includes multiple majors, minors, teaching certification, lifelong education specialist courses, military science, and other elective courses. Excess credits from required categories are counted as general electives. (Note: they are not reclassified as general electives.)
Be aware that there is a maximum credit limit for liberal arts courses (basic + elective + category liberal arts) per student number, and credits exceeding this limit will not count towards general electives.
Liberal Arts Credit Limit by Student Number:
* 2004, 2005: 70 credits / 2006 and later: 60 credits / 2013 and later: 50 credits
* Credits exceeding these limits will only be recognized up to the maximum.
""",
  },
  {
    'title': 'How do I register for courses?',
    'content': """
Course registration guide:
LINK: https://www.kookmin.ac.kr/comm/menu/user/9cc1a72c81e16567bc6a8cfbd57d625f/con
""",
  },
  {
    'title':
        'If I have completed all graduation credits by the first semester of my fourth year, do I need to register for courses in the second semester?',
    'content': """
There is no minimum credit requirement for the second semester of the fourth year (graduation semester), but you must verify that all graduation credits are completed. <Academic Regulations Chapter 8, Article 49>
""",
  },
  {
    'title': 'How do I fulfill general elective credits?',
    'content': """
After completing all required courses and minimum credits for graduation, any remaining courses will count towards general electives.
Example: If the graduation requirement is to complete 3 credits in Core Liberal Arts - Global, and you complete 6 credits, the remaining 3 credits will count as general electives.
""",
  },
];

final List<Map<String, dynamic>> classScheduleFaq = [
  // {
  //   'title': '',
  //   'content': """ """,
  // },{
  //   'title': '',
  //   'content': """ """,
  // },{
  //   'title': '',
  //   'content': """ """,
  // },{
  //   'title': '',
  //   'content': """ """,
  // },{
  //   'title': '',
  //   'content': """ """,
  // },{
  //   'title': '',
  //   'content': """ """,
  // },{
  //   'title': '',
  //   'content': """ """,
  // },
];

final List<Map<String, dynamic>> gradesFaq = [
  {
    'title': 'How are grades evaluated?',
    'content': """
Grades for courses are comprehensively evaluated by the instructor based on exam scores, assignment scores, attendance, and other assessments. However, grades for experiments, practicals, and similar special courses may be evaluated by other methods.
LINK: https://www.kookmin.ac.kr/comm/menu/user/896d2b98f59c00ba1d6160d1fd80c340/cor
""",
  },
  {
    'title': 'Can the grade correction period be extended?',
    'content': """
Grade corrections are only allowed if there is a clear error confirmed by the instructor. A specified period is set for corrections, and extensions are not possible as it would affect other academic schedules.
""",
  },
  {
    'title': 'What is the credit rollover system?',
    'content': """
Credit Rollover Guide:
1. Definition: Credits that can be rolled over are those not registered for within the maximum allowable credits per semester, and the criteria are as follows:
a. Rollover credits apply only when registering for credits exceeding the maximum in the next semester, limited to 3 credits.
b. Credits for exceptional performance take precedence over rollover credits and are not cumulative.
c. Rollover credits from one semester are valid for the next consecutive semester only and will expire if not used.
2. Rollover credit limit: 1~3 credits
3. Implementation: Applied from the second semester of 2014 based on the first semester’s registration
4. Eligibility: Students registered in consecutive regular semesters (e.g., students registered in the first semester of 2014 can roll over credits to the second semester of 2014)
5. Exclusions:
a. Students with academic warnings from the previous semester
b. Students without registration records from the previous semester (e.g., international internships, exchange programs)
c. Students with an average GPA of 3.75 or higher (3.5 for integrated bachelor’s and master’s programs) not using extra credits
d. Students not registering for rollover credits in the next semester
e. Students not registered in consecutive regular semesters (e.g., leave of absence, expulsion)
f. Students exceeding the standard study period (e.g., graduation extensions, failing students)
g. Other exclusions
1) Students eligible for extra credits due to exceptional performance can only apply for extra credits (not cumulative with rollover)
2) Courses like Social Service 1, 2, and Thursday Special Lecture are excluded from rollover
6. Example:
College with a maximum of 18 credits per semester:
a. If 16 out of 18 credits were registered in the first semester of 2014:
- 18 credits + 2 rollover credits = 20 credits in the second semester (rollover applies only when exceeding the maximum in the next regular semester; unused rollover credits expire)
b. If 14 out of 18 credits were registered in the first semester of 2014:
- 18 credits + 3 rollover credits = 21 credits in the second semester (rollover limited to 3 credits)
c. If 16 out of 18 credits were registered in the first semester of 2014, and the student became eligible for extra credits:
- 18 credits + 2 rollover credits + 3 extra credits = 21 credits in the second semester (extra credits take precedence over rollover)
d. If 2 out of 3 extra credits were registered in the first semester of 2014, and the student became eligible for extra credits again:
- 18 credits + 3 extra credits = 21 credits in the second semester (unused extra credits do not roll over)
e. If 16 out of 18 credits were registered in the first semester of 2014, and the student took a leave of absence in the second semester:
- 18 credits in the first semester of 2015 (rollover applies only to consecutive regular semesters)
f. Rollover does not apply to non-consecutive semesters (leave of absence, expulsion)
g. Rollover does not apply to students exceeding the standard study period (graduation extensions, failing students)
h. For other exclusions, refer to section "5. Exclusions"
""",
  },
];

final List<Map<String, dynamic>> semesterSystemFaq = [
  {
    'title': 'When and how are seasonal semesters operated?',
    'content': """
The operating period for seasonal semesters (summer and winter) is during vacation, with schedules announced on the 'Academic Notices' board (typically early May for summer and early November for winter).
LINK: https://www.kookmin.ac.kr/site/resource/guide/point/vacation.html
""",
  },
];

final List<Map<String, dynamic>> fieldPracticeFaq = [
  {
    'title':
        'Is it possible to take field practice courses and regular courses simultaneously upon final selection?',
    'content': """
It is not possible to take field practice courses and regular courses simultaneously.
""",
  },
  {
    'title':
        'Can field practice credits for major electives be recognized for a double degree major?',
    'content': """
No, field practice major elective credits are recognized only for the primary major.
""",
  },
  {
    'title':
        'What is the procedure for receiving the field practice support stipend?',
    'content': """
The field practice support stipend is provided jointly by Seoul City and the school on a 50:50 basis, based on the current year’s minimum wage (including weekly holiday allowance).
""",
  },
];

final List<Map<String, dynamic>> ictCreditLinkageFaq = [
  {
    'title':
        'Are graduates, completion students, and students on leave ineligible?',
    'content':
        """Yes, they are ineligible. According to the field practice regulations, only enrolled students can participate.""",
  },
  {
    'title':
        'Can field practice credits for major electives be recognized as double degree major credits?',
    'content':
        """No, field practice credits for major electives are recognized only as primary major credits.""",
  },
  {
    'title':
        'Is it possible to take field practice courses and regular courses simultaneously upon final selection?',
    'content':
        """No, it is not possible to take field practice courses and regular courses simultaneously.""",
  },
  {
    'title':
        'What is the procedure for receiving the field practice support stipend?',
    'content':
        """The field practice support stipend is provided by the ICT office (company support fund + ICT office).""",
  },
  {
    'title': 'How is course registration done?',
    'content':
        """Course registration is handled by the Career Development Support Center based on the students' application details. However, until the final selection results are announced, students can register for other regular courses. Once the final selection results are announced, regular course registration is automatically canceled, and field practice course registration is completed.""",
  },
  {
    'title': 'Are document screening and interviews conducted by the company?',
    'content':
        """Initially, the school reviews the qualifications of internship participants, and the ICT office directly selects interview candidates and finalizes successful applicants.""",
  },
  {
    'title':
        'Can I select major electives and general electives simultaneously during course registration?',
    'content':
        """Yes, it is possible. For example, you can select 9 credits of major electives and 3 credits of general electives. However, you must consider field practice credits recognized from previous semesters. For example, if a student participated in the ICT Credit Linkage in the first half of 2020 and was recognized for 6 credits of major electives, they can only be recognized for a total of 12 field practice credits (18 credits - 6 credits already recognized) in the second half of 2020, with a maximum of 3 credits in major electives (9 credits - 6 credits already recognized).""",
  },
  {
    'title':
        'Do the recognized credits for field practice change the duration of the field practice period?',
    'content':
        """No, the field practice period remains the same (4 months) regardless of the recognized credit period. Is it possible to apply for other field practice programs at the same time? No, only one program and one company can be applied for at a time. If duplicate applications are found, the application will be canceled. However, after receiving a rejection notice from one company, you can apply to another company.""",
  },
  {
    'title':
        'What is the maximum number of field practice credits that can be recognized during the field practice period?',
    'content':
        """According to the field practice regulations, the maximum number of field practice credits that can be recognized is 18 credits. However, for major credits, a maximum of 9 credits can be recognized, and pre-approval from the department head is required for major credit applications.""",
  },
  {
    'title': 'What are the eligibility criteria?',
    'content':
        """Only students enrolled in their 5th to 8th semester of the relevant semester are eligible to apply.""",
  },
];

final List<Map<String, dynamic>> seoulCityInternshipFaq = [
  {
    'title': 'Are document screening and interviews conducted by the company?',
    'content':
        """Initially, the school reviews the qualifications of internship participants, and the Career Development Support Center and Liberal Arts professors directly select interview candidates and finalize successful applicants.""",
  },
  {
    'title':
        'Can I select major electives and general electives simultaneously during course registration?',
    'content':
        """Yes, it is possible. For example, you can select 3 credits of major electives and 3 credits of general electives. However, you must consider field practice credits recognized from previous semesters. For example, if a student participated in the Seoul City Internship in the summer of 2020 and was recognized for 6 credits of major electives, they can only be recognized for a total of 12 field practice credits (18 credits - 6 credits already recognized) in the second semester of 2020, with a maximum of 3 credits in major electives (9 credits - 6 credits already recognized).""",
  },
  {
    'title':
        'Is it possible to apply for other field practice programs at the same time?',
    'content':
        """No, only one program and one company can be applied for at a time. If duplicate applications are found, the application will be canceled. However, after receiving a rejection notice from one company, you can apply to another company.""",
  },
  {
    'title':
        'Do the recognized credits for field practice change the duration of the field practice period?',
    'content':
        """No, the field practice period remains the same (8 weeks) regardless of the recognized credit period.""",
  },
  {
    'title':
        'What is the maximum number of field practice credits that can be recognized during the seasonal semester?',
    'content':
        """According to the field practice regulations, the maximum number of field practice credits that can be recognized is 18 credits (6 credits for the seasonal semester). However, for major credits, a maximum of 9 credits can be recognized, and pre-approval from the department head is required for major credit applications.""",
  },
  {
    'title': 'What are the eligibility criteria?',
    'content':
        """Only students enrolled in their 5th to 7th semester of the relevant semester are eligible to apply. Graduates, completion students, and students on leave are ineligible. Yes, they are ineligible. According to the field practice regulations, only enrolled students can participate.""",
  },
  {
    'title': 'How is course registration done?',
    'content':
        """Course registration is handled by the Career Development Support Center based on the students' application details. However, until the final selection results are announced, students can register for other regular courses. Once the final selection results are announced, regular course registration is automatically canceled, and field practice course registration is completed.""",
  },
];

final List<Map<String, dynamic>> eastsoftFieldPracticeFaq = [
  {
    'title':
        'Are graduates, completion students, and students on leave ineligible?',
    'content':
        """Yes, they are ineligible. According to the field practice regulations, only enrolled students can participate.""",
  },
  {
    'title': 'Are document screening and interviews conducted by the company?',
    'content':
        """Initially, the school reviews the qualifications of internship participants, and Eastsoft directly selects interview candidates and finalizes successful applicants.""",
  },
  {
    'title': 'How is course registration done?',
    'content':
        """Course registration is handled by the Career Development Support Center based on the students' application details. However, until the final selection results are announced, students can register for other regular courses. Once the final selection results are announced, regular course registration is automatically canceled, and field practice course registration is completed.""",
  },
  {
    'title':
        'What is the procedure for receiving the field practice support stipend?',
    'content':
        """The field practice support stipend is provided by the school (company support fund + school support fund).""",
  },
  {
    'title':
        'Is it possible to take field practice courses and regular courses simultaneously upon final selection?',
    'content':
        """No, it is not possible to take field practice courses and regular courses simultaneously.""",
  },
  {
    'title':
        'Can field practice credits for major electives be recognized as double degree major credits?',
    'content':
        """No, field practice credits for major electives are recognized only as primary major credits.""",
  },
  {
    'title':
        'Can I select major electives and general electives simultaneously during course registration?',
    'content':
        """Yes, it is possible. For example, you can select 9 credits of major electives and 3 credits of general electives. However, you must consider field practice credits recognized from previous semesters. For example, if a student participated in the Eastsoft Field Practice in the first half of 2020 and was recognized for 6 credits of major electives, they can only be recognized for a total of 12 field practice credits (18 credits - 6 credits already recognized) in the second half of 2020, with a maximum of 3 credits in major electives (9 credits - 6 credits already recognized).""",
  },
  {
    'title':
        'Do the recognized credits for field practice change the duration of the field practice period?',
    'content':
        """No, the field practice period remains the same (6 months) regardless of the recognized credit period.""",
  },
  {
    'title':
        'Is it possible to apply for other field practice programs at the same time?',
    'content':
        """No, only one program and one company can be applied for at a time. If duplicate applications are found, the application will be canceled. However, after receiving a rejection notice from one company, you can apply to another company.""",
  },
  {
    'title':
        'What is the maximum number of field practice credits that can be recognized during the field practice period?',
    'content':
        """According to the field practice regulations, the maximum number of field practice credits that can be recognized is 18 credits. However, for major credits, a maximum of 9 credits can be recognized, and pre-approval from the department head is required for major credit applications.""",
  },
  {
    'title': 'What are the eligibility criteria?',
    'content':
        """Only students enrolled in their 5th to 8th semester of the relevant semester are eligible to apply.""",
  },
];

final List<Map<String, dynamic>> currentStudentJobExperienceFaq = [
  {
    'title':
        'Do the recognized credits for field practice change the duration of the field practice period?',
    'content':
        """No, the field practice period remains the same (8 weeks) regardless of the recognized credit period.""",
  },
  {
    'title':
        'Is it possible to apply for other field practice programs at the same time?',
    'content':
        """No, only one program and one company can be applied for at a time. If duplicate applications are found, the application will be canceled. However, after receiving a rejection notice from one company, you can apply to another company.""",
  },
  {
    'title':
        'What is the maximum number of field practice credits that can be recognized during the seasonal semester?',
    'content':
        """According to the field practice regulations, the maximum number of field practice credits that can be recognized is 18 credits (6 credits for the seasonal semester). However, for major credits, a maximum of 9 credits can be recognized, and pre-approval from the department head is required for major credit applications.""",
  },
  {
    'title': 'What are the eligibility criteria?',
    'content':
        """Only students enrolled in their 1st to 7th semester of the relevant semester are eligible to apply.""",
  },
  {
    'title': 'Are document screening and interviews conducted by the company?',
    'content':
        """Initially, the school reviews the qualifications of internship participants. Once the qualification review is completed, the company directly selects the document passers and interview candidates, finalizing successful applicants.""",
  },
  {
    'title':
        'Can I select major electives and general electives simultaneously during course registration?',
    'content':
        """Yes, it is possible. For example, you can select 3 credits of major electives and 3 credits of general electives. However, you must consider field practice credits recognized from previous semesters. For example, if a student participated in the summer job experience in 2020 and was recognized for 6 credits of major electives, they can only be recognized for a total of 12 field practice credits (18 credits - 6 credits already recognized) in the second semester of 2020, with a maximum of 3 credits in major electives (9 credits - 6 credits already recognized).""",
  },
  {
    'title':
        'Can field practice credits for major electives be recognized as double degree major credits?',
    'content':
        """No, field practice credits for major electives are recognized only as primary major credits.""",
  },
  {
    'title':
        'Is it possible to take field practice courses and regular courses simultaneously upon final selection?',
    'content':
        """No, it is not possible to take field practice courses and regular courses simultaneously.""",
  },
  {
    'title':
        'What is the procedure for receiving the field practice support stipend?',
    'content':
        """The field practice support stipend is provided by the school and the company.""",
  },
  {
    'title': 'How is course registration done?',
    'content':
        """Course registration is handled by the Career Development Support Center based on the students' application details. However, until the final selection results are announced, students can register for other regular courses. Once the final selection results are announced, regular course registration is automatically canceled, and field practice course registration is completed.""",
  },
  {
    'title':
        'Are graduates, completion students, and students on leave ineligible?',
    'content':
        """Yes, they are ineligible. According to the field practice regulations, only enrolled students can participate.""",
  },
];

final List<Map<String, dynamic>> employmentLinkedInternshipFaq = [
  {
    'title': 'What are the eligibility criteria?',
    'content':
        """Only students enrolled in their 8th semester of the relevant semester are eligible to apply.""",
  },
  {
    'title':
        'Are graduates, completion students, and students on leave ineligible?',
    'content':
        """Yes, they are ineligible. According to the Korea Scholarship Foundation regulations, scholarships can only be provided to enrolled students, so graduates, completion students, and students on leave are ineligible. Also, students enrolled in evening programs while working in the industry are ineligible.""",
  },
  {
    'title':
        'Can field practice credits for major electives be recognized as double degree major credits?',
    'content':
        """No, field practice credits for major electives are recognized only as primary major credits.""",
  },
  {
    'title':
        'Is it possible to take field practice courses and regular courses simultaneously upon final selection?',
    'content':
        """Field practice courses refer to the credits recognized after completing an internship program during a semester or seasonal semester, while regular courses are the ones taught by professors in class or online. As it is impossible to work during the hours of regular courses, simultaneous enrollment is not possible.""",
  },
  {
    'title': 'What is the procedure for receiving the scholarship?',
    'content':
        """After the selected student enters the attendance records from the 1st to the last day of the month, the institution applies for attendance confirmation at the end of the month. After processing by the university's National Work Study Department, the scholarship is paid (monthly payment, 10th-18th of the following month).""",
  },
  {
    'title': 'How is course registration done?',
    'content':
        """Course registration is handled by the Career Development Support Center based on the students' application details. However, until the final selection results are announced, students can register for other regular courses. Once the final selection results are announced, regular course registration is automatically canceled, and field practice course registration is completed.""",
  },
  {
    'title': 'Are document screening and interviews conducted by the company?',
    'content':
        """Initially, the school reviews the qualifications of internship participants. Once the qualification review is completed, the company directly selects the document passers and interview candidates, finalizing successful applicants.""",
  },
  {
    'title':
        'Can I select major electives and general electives simultaneously during course registration?',
    'content':
        """Yes, it is possible. For example, you can select 9 credits of major electives and 3 credits of general electives. However, you must consider field practice credits recognized from previous semesters. For example, if a student participated in the Employment-Linked Internship in the first semester of 2020 and was recognized for 6 credits of major electives, they can only be recognized for a total of 12 field practice credits (18 credits - 6 credits already recognized) in the second semester of 2020, with a maximum of 3 credits in major electives (9 credits - 6 credits already recognized).""",
  },
  {
    'title':
        'Do the recognized credits for the employment-linked internship change the duration of the internship period?',
    'content':
        """After the internship period ends, the participating company will evaluate the student's job performance and basic skills to determine whether to convert them to a full-time position or extend the internship. No, the duration of the field practice remains the same (semester: 15 weeks, seasonal semester: 8 weeks) regardless of the recognized credit period.""",
  },
  {
    'title':
        'Is it possible to apply for other field practice programs at the same time?',
    'content':
        """No, only one program and one company can be applied for at a time. If duplicate applications are found, the application will be canceled. However, after receiving a rejection notice from one company, you can apply to another company.""",
  },
  {
    'title':
        'What is the maximum number of field practice credits that can be recognized during the 8th semester?',
    'content':
        """According to the field practice regulations, the maximum number of field practice credits that can be recognized is 18 credits. However, for major credits, a maximum of 9 credits can be recognized, and pre-approval from the department head is required for major credit applications.""",
  },
];

final List<Map<String, dynamic>> lincProjectFieldPracticeFaq = [
  {
    "title":
        "What documents need to be submitted after the field practice ends?",
    "content":
        "Submit the activity log, final report, internship review, and satisfaction survey through the online field practice system."
  },
  {
    "title": "What happens if I quit the field practice midway?",
    "content":
        "1. Quitting during the semester: If you quit or get a Non-pass during the semester, you will not receive support funds or credit recognition. 2. Quitting during vacation: If you quit or get a Non-pass during vacation, you will not receive support funds or credit recognition, and you must pay the pre-paid seasonal semester tuition."
  },
  {
    "title":
        "Do I have to register for courses myself through the comprehensive information system?",
    "content":
        "For field practice course registration, the LINC+ project team submits a registration document to the Academic Affairs team based on the courses selected by the students on the online field practice system. Therefore, students do not need to register themselves."
  },
  {
    "title":
        "What is the maximum number of credits that can be recognized for field practice courses?",
    "content":
        "The maximum number of credits that can be recognized for field practice during enrollment is 18 credits, with a maximum of 9 credits recognized as major credits."
  },
  {
    "title":
        "Can I register for other courses in addition to field practice courses?",
    "content":
        "No, you cannot register for other courses besides field practice courses."
  },
  {
    "title": "What are the eligibility criteria for field practice?",
    "content":
        "1. During the semester: Enrolled students (no grade level restriction) * Ineligible: (1) Students registered for other courses or those who have completed 18 credits of field practice courses (2) Evening program students (3) Students recruited for work or part-time jobs by the organization 2. During vacation: Enrolled students (no grade level restriction) * Ineligible: (1) Graduates (including those in extra semesters) (2) Students registered for other courses or those who have completed 18 credits of field practice courses (3) Evening program students (4) Students recruited for work or part-time jobs by the organization"
  },
  {
    "title": "How many days off are given during the field practice?",
    "content":
        "Excluding public holidays, 1 day off is provided for every 4 weeks of practice. Therefore, starting from the fifth week, 1 day off per month is given, which can be designated in consultation with the internship organization."
  },
  {
    "title":
        "What is the minimum recognized period for field practice programs?",
    "content":
        "1. During the semester: At least 12 weeks of practice 2. During vacation: At least 4 weeks of practice"
  },
  {
    "title": "When is the school's support stipend paid?",
    "content":
        "After the field practice ends, once all required documents are submitted by the student and the organization, and the supervising professor completes the grade evaluation, the stipend payment is processed."
  }
];

final List<Map<String, dynamic>> tuitionPaymentFaq = [
  {
    "title": "I missed the registration period, what should I do?",
    "content":
        "You can either pay in full during the additional registration period or apply for installment payments during the additional application period and pay the first installment. If you do not pay during this period, you will be considered unregistered, and you will not be able to complete the semester according to school regulations."
  },
  {
    "title": "How do I pay the tuition fees?",
    "content":
        "Check and print your tuition bill: Comprehensive Information System > Registration/Scholarship Information > Tuition Bill. Payment methods: Transfer to the virtual account specified on the bill or pay at the bank counter. Payment confirmation: Comprehensive Information System > Registration/Scholarship Information > Tuition Payment Certificate (available the day after payment)."
  },
  {
    "title": "What happens to my tuition if I take a leave of absence?",
    "content":
        "Since the 2017 academic year, students on leave cannot pay tuition. If you take a leave after the start of the semester, the tuition will be refunded according to the refund policy."
  },
  {
    "title": "Can I pay the tuition with a credit card?",
    "content":
        "Credit card payments are not accepted due to the high fees requested by card companies (1.5% of the payment amount). The equivalent amount is used for student support."
  },
  {
    "title":
        "Why does 'payment not accepted' appear when I try to deposit into the virtual account?",
    "content":
        "The amount must be exact for the virtual account deposit. Tuition payment hours are weekdays from 09:00 to 17:00 (weekend deposits not accepted). Check the 14-digit virtual account number and the amount again. If 'Kookmin University' appears as the sender, the payment is successful."
  },
  {
    "title":
        "Can I wait to pay my tuition until I decide whether to take a leave of absence?",
    "content":
        "Since the re-registration system (registration after leave and before returning) was abolished in 2017, students on leave cannot pay tuition. If you plan to take a leave this semester, do not register. However, if your leave application date is after the first installment period, you must pay the tuition and then apply for a refund to avoid being unregistered."
  },
  {
    "title":
        "I received a full scholarship, so my tuition is 0 won. Do I still need to visit the bank?",
    "content":
        "Visit any Woori Bank branch to request payment processing to be marked as 'registered.' If visiting the bank is difficult, you can transfer a small amount (e.g., student council fee) to the virtual account, which will process your registration. Failure to process registration will result in being marked as unregistered, and you will not be able to complete the semester."
  },
  {
    "title":
        "I applied for installment payments, but I want to take out a scholarship foundation loan.",
    "content":
        "Installment payment applicants cannot apply for loans. You need to cancel the installment payment application, then apply for and execute the loan."
  },
  {
    "title":
        "Do I need to pay the tuition if I applied for installment payments?",
    "content":
        "After applying for installment payments, pay the amount due during the first installment period."
  },
  {
    "title":
        "I am a new student and decided to withdraw. How much tuition will be refunded?",
    "content":
        "The admission fee is non-refundable, and the refund for tuition varies based on the withdrawal date: 1. Before the start of the semester: Full refund of tuition 2. After the start of the semester: The tuition, excluding the admission fee, will be refunded based on the following criteria: - Within 30 days from the start of the semester: 5/6 of the tuition - From 30 to 60 days from the start of the semester: 2/3 of the tuition - From 60 to 90 days from the start of the semester: 1/2 of the tuition - After 90 days from the start of the semester: No refund"
  },
  {
    "title":
        "How can I confirm that my tuition payment was processed correctly?",
    "content":
        "You can check through the Comprehensive Information System from 10 AM the day after payment. If you want immediate confirmation, you can provide your mobile number in the Profile Management section of the Comprehensive Information System to receive a text message."
  },
  {
    "title":
        "I registered and then applied for a military leave of absence. When will my tuition be refunded?",
    "content":
        "The refund will be processed within 3 weeks after applying for leave, and the full tuition will be refunded for military leave."
  }
];

final List<Map<String, dynamic>> tuitionRefundFaq = [
  {
    "title":
        "Can I get a tuition refund if I do not register for courses or receive all F grades?",
    "content":
        "No, tuition is non-refundable, and you will receive a grade warning. (However, if you do not register for courses because you have met all graduation credit requirements in your graduation semester, you will not receive a grade warning.)"
  },
  {
    "title": "How much tuition will be refunded?",
    "content":
        "1. Before the start of the semester: Full refund of tuition 2. After the start of the semester: The tuition, excluding the admission fee, will be refunded based on the following criteria: - Within 30 days from the start of the semester: 5/6 of the tuition - From 30 to 60 days from the start of the semester: 2/3 of the tuition - From 60 to 90 days from the start of the semester: 1/2 of the tuition - After 90 days from the start of the semester: No refund"
  }
];

final List<Map<String, dynamic>> registrationDocumentIssuanceFaq = [
  {
    "title": "I need a receipt for my tuition payment.",
    "content":
        "You can print the tuition payment receipt (education payment certificate) directly from 'Comprehensive Information System > Registration/Scholarship Information > Tuition Payment Certificate.'"
  }
];

final List<Map<String, dynamic>>
    criteriaForTuitionCalculationForExceedingCourseDurationFaq = [
  {
    "title":
        "I have exceeded the course duration. How much tuition do I have to pay?",
    "content":
        "1. Up to 3 credits: 1/6 of the tuition for the semester 2. 4 to 6 credits: 1/3 of the tuition for the semester 3. 7 to 9 credits: 1/2 of the tuition for the semester 4. 10 or more credits: Full tuition for the semester"
  }
];

final List<Map<String, dynamic>> academicRecordsFaq = [
  {
    "title":
        "It looks like my (expected) grade level is incorrect. What should I do?",
    "content":
        "At our school, the 1st and 2nd semesters are considered the 1st year, the 3rd and 4th semesters are considered the 2nd year, the 5th and 6th semesters are considered the 3rd year, and the 7th and 8th semesters are considered the 4th year. In the case of the Architecture Department's Architecture Design major, the 9th and 10th semesters are considered the 5th year. If there is still an error, please contact the Academic Affairs team."
  }
];

final List<Map<String, dynamic>> leaveOfAbsenceFaq = [
  {
    "title":
        "I get an enlistment date error when applying for military leave after enlisting.",
    "content":
        "Military leave is set based on applying before enlisting. If you have already enlisted, you must enter an enlistment date later than the application date. For example, if you have already enlisted and are applying for military leave on January 1, enter an enlistment date after January 2. Then, email your enlistment notice to the Academic Affairs team for final processing. It may take some time to complete the processing."
  },
  {
    "title": "Until when can I apply for a leave of absence?",
    "content":
        "You can apply for a leave of absence from the regular leave application period until 90 days after the start of the semester. After 30 days from the start of the semester, only offline applications are accepted. The refund amount of the paid tuition depends on the leave application timing. For more details, please refer to the related link."
  },
  {
    "title":
        "Can I get a tuition refund if I take a leave of absence during the semester?",
    "content":
        "Since the 2017 academic year, students on leave cannot pay tuition. If you take a leave after the start of the semester, the tuition will be refunded according to the refund policy."
  },
  {
    "title": "How do I cancel an already submitted leave of absence?",
    "content":
        "Leave of absence and return are one-time applications for academic status changes. If you wish to cancel, please contact the Academic Affairs team for processing."
  },
  {
    "title": "Until when can I apply for reinstatement?",
    "content":
        "You can apply for reinstatement before the start of the semester."
  },
  {
    "title":
        "Can I return after taking only one semester off if I applied for a one-year leave of absence?",
    "content":
        "You can apply for reinstatement in the middle of the period. All leaves of absence, including military leave, do not require you to take the entire duration you applied for. Apply for reinstatement when you wish to return."
  },
  {
    "title":
        "What should I do if I receive an enlistment notice during a general leave of absence?",
    "content":
        "Select military leave in the Comprehensive Information System's academic information - leave of absence application menu. Military leave can be applied for one month before the enlistment date."
  },
  {
    "title":
        "If I receive a scholarship, do I have to pay the tuition in advance and then take a leave of absence?",
    "content":
        "Since the 2017 academic year, students on leave cannot pay tuition. If you take a leave after the start of the semester, the tuition will be refunded according to the refund policy. Scholarships are forfeited for students on leave (except for merit scholarships, which are deferred to the returning semester). If a scholarship recipient registers and then takes a leave, the full scholarship amount will be reclaimed regardless of the leave application period (National and external scholarships follow the respective institution's guidelines)."
  },
  {
    "title": "I have questions about taking a leave of absence.",
    "content": "View leave of absence guidelines."
  },
  {
    "title": "What is the maximum duration for taking a leave of absence?",
    "content":
        "The maximum duration for taking a leave of absence is 4 years (8 semesters) during enrollment, and you can apply for 1-2 semesters at a time (excluding military/medical/maternity/childcare leave)."
  }
];

final List<Map<String, dynamic>> returnFromLeaveOfAbsenceFaq = [
  {
    "title": "How do I cancel an already submitted reinstatement?",
    "content":
        "Leave of absence and return are one-time applications for academic status changes. If you wish to cancel, please contact the Academic Affairs team for processing. If you want to extend the leave, you must apply for an additional leave during the leave application period. Leave is not automatically extended by canceling reinstatement."
  },
  {
    "title": "I have questions about reinstatement.",
    "content": "View reinstatement guidelines."
  },
  {
    "title": "Can I return before being discharged?",
    "content":
        "You can return if the remaining leave days after the discharge date allow you to attend school and the total leave period after the start of the semester does not exceed 1/4 of the entire course. Required documents include 1. Pledge of reinstatement before discharge, 2. Confirmation of remaining leave days, 3. Proof of discharge schedule. The confirmation of remaining leave days should include the student's identifying information, remaining leave days as of a certain date, and the unit commander's confirmation (seal, signature). No specific form is required. Apply for reinstatement before the start of the semester."
  }
];

final List<Map<String, dynamic>> completionOfAcademicProgramFaq = [
  {
    "title": "Q1. What is 'Completion of Academic Program'?",
    "content":
        "A new academic status called 'completion' has been added to the existing four statuses (enrollment, leave of absence, dismissal, and graduation) for students who are not enrolled but wish to postpone graduation. Previously, students who failed to graduate due to not meeting certain requirements had to register for extra semesters. Now, they can graduate in the relevant semester without paying tuition if they fulfill graduation requirements within two years from the completion date. If it exceeds two years, they will be dismissed and must re-enroll to graduate."
  },
  {
    "title":
        "Q2. What is the difference between a student who has completed their program and an enrolled student?",
    "content":
        "Students who have completed their program do not need to pay tuition for two years from the completion date and can receive a certificate of expected graduation. Enrolled students are those who have completed registration and are in an enrolled status, receiving a certificate of enrollment and, if applicable, a certificate of expected graduation. Students who have completed their program can use this certificate for employment or further studies and have access to on-campus facilities and programs organized by the Career Development Center."
  },
  {
    "title":
        "Q3. Can I become a student who has completed their program if I meet all graduation requirements?",
    "content":
        "If you meet all graduation requirements, such as required credits, graduation thesis, and certification, you will be processed for graduation. If you substitute the English proficiency requirement of graduation certification through coursework, you cannot become a student who has completed their program."
  },
  {
    "title":
        "Q4. Can students from all departments receive the benefits of completion status?",
    "content":
        "Students belonging to departments that operate graduation theses, graduation certifications, and engineering certifications can become students with completion status if they meet the requirements. Students in departments that do not have these criteria cannot become students with completion status."
  },
  {
    "title":
        "Q5. I am on a leave of absence beyond the regular semesters. Can I graduate or complete my program while on leave?",
    "content":
        "Students must be enrolled or have completed their program to undergo graduation evaluation and graduate or complete their program. Therefore, students on a leave of absence beyond the regular semesters must return to school and be in enrolled status to graduate or complete their program."
  },
  {
    "title":
        "Q6. How can I remain an enrolled student instead of becoming a student with completion status?",
    "content":
        "If you lack the required graduation credits or have not completed mandatory courses, you will automatically be disqualified from graduation and can register and enroll for extra semesters. Among students who have met graduation or completion requirements, those who are pursuing a double major, minor, or teaching license but have not fulfilled the requirements can apply for graduation deferral to continue enrolling and taking courses. Therefore, students who do not wish to have completion status should prepare in advance for graduation disqualification and deferral to maintain their enrolled status."
  },
  {
    "title":
        "Q7. Is there no way to return to enrolled status once I become a student with completion status?",
    "content":
        "Once you are in 'completion' status, you cannot change back to enrolled status. Students with completion status do not need to pay tuition and cannot register for courses, so they must fulfill graduation requirements such as English proficiency and departmental certification through test scores and certificates only."
  },
  {
    "title": "Q8. Why was the 'Completion System' created?",
    "content":
        "Due to the severe job market in the past five years, the number of students postponing graduation has increased by about 150-200 annually. This has led to social issues regarding tuition fees for students who have earned the required credits but do not take classes. Consequently, many universities have implemented a new academic status called 'completion' to adapt to these societal changes. Our university also adopted the completion system to reduce the tuition burden for extra semesters and help students resolve graduation issues more flexibly."
  },
  {
    "title":
        "Q9. When should I submit the graduation requirements (thesis, English proficiency, portfolio, etc.) for my department during the semester?",
    "content":
        "The submission schedule for graduation theses, certifications, etc., varies by department. Please contact your department for detailed information."
  },
  {
    "title": "Q10. What is graduation deferral?",
    "content":
        "Graduation deferral refers to postponing graduation. There is no specific system called 'graduation deferral', but students can prepare for graduation at their desired time by utilizing disqualification from graduation, deferral, and the completion system."
  }
];

final List<Map<String, dynamic>> graduationThesisFaq = [
  {
    "title": "How do I apply for a national scholarship?",
    "content":
        "You can apply online through the Korea Scholarship Foundation website and the 'Korea Scholarship Foundation' mobile app. You need to log in with your own public authentication certificate (student's name)."
  }
];

final List<Map<String, dynamic>> graduationCertificationSystemFaq = [
  {
    "title": "What is an engineering certification portfolio?",
    "content":
        "An engineering certification portfolio is a record of the educational achievements and personal activities throughout the university course, submitted in the final semester to graduate with engineering certification. It includes resumes, cover letters, key activity records, essays, and design course projects, uploaded to the engineering program support system (KEPSS) by the specified deadline."
  },
  {
    "title": "Is engineering certification mandatory?",
    "content":
        "Kookmin University requires graduation certification. Students enrolled from the 2017 academic year onwards must complete the graduation certification to graduate. Detailed information can be found on the school website. In departments with engineering certification, this fulfills the graduation certification requirement. For students with double majors, minors, or who are teacher candidates, check if you can opt-out of engineering certification."
  },
  {
    "title": "Can I opt-out of engineering certification?",
    "content":
        "Students eligible to change their certification include those who transferred, changed majors, or have specific conditions such as multiple majors, international students, foreign students, those in exchange programs, early graduates, and those enrolled before the 2016 academic year who have not applied for certification changes before. Please refer to the departmental notice for detailed instructions and deadlines."
  },
  {
    "title": "When can I opt-out of engineering certification?",
    "content":
        "Applications to opt-out of engineering certification are accepted during the course add/drop period (1-2 weeks after the semester starts). Please check the departmental notice board for detailed information during this period."
  },
  {
    "title":
        "Are transfer or major change students automatically registered for engineering certification?",
    "content":
        "Transfer and major change students must apply during the first 1-2 weeks of their entry semester. The application period varies by department, so please check your department’s notice board and K-Push for the exact schedule."
  },
  {
    "title":
        "Do I need to submit a portfolio for engineering certification upon graduation?",
    "content":
        "Yes, you must submit an engineering certification portfolio to graduate with engineering certification. The required items for the portfolio vary by department and should be uploaded to the Comprehensive Information System > Engineering Program Support System > Portfolio Management."
  },
  {
    "title": "How can I check the items required for the portfolio?",
    "content":
        "Portfolio requirements vary by department. Detailed information is available on each department’s notice board. Common requirements and upload methods can be found on the Center for Innovation in Engineering Education website."
  },
  {
    "title": "Do I need to keep reports to get engineering certification?",
    "content":
        "To graduate with engineering certification, you must submit your graduation portfolio for evaluation. All programs require final reports for design courses. Keep the final report or equivalent documents for courses with design credits. If you cannot prepare the report due to certain circumstances, you can submit a reason for non-submission form during graduation evaluation."
  },
  {
    "title": "How do I apply for engineering certification?",
    "content":
        "Applications for engineering certification are processed during the course add/drop period (1-2 weeks after the semester starts) along with opt-out applications. Check your department’s notice board for the exact schedule and application process."
  }
];

final List<Map<String, dynamic>> onCampusScholarshipsFaq = [
  {
    "title":
        "Do I need to submit an application form to receive a merit scholarship?",
    "content":
        "To ease the process for students, the submission of application forms for merit scholarships (Sungkok, top student, types 1-3) has been abolished. Students are selected based on academic performance without needing to submit an application."
  },
  {
    "title": "What scholarships are available beyond tuition?",
    "content":
        "There are scholarships for work-study and living expenses, among others. Check the scholarship notices on the university website for details on scholarships that exceed tuition coverage."
  },
  {
    "title": "What are the conditions for receiving a merit scholarship?",
    "content":
        "To receive a merit scholarship (Sungkok, top student, types 1-3), students must earn at least 17 credits (12 credits for seniors) in the previous semester, have no grades of F, and maintain a GPA of 3.0 or higher. Additional requirements may vary by department, so check with your department."
  },
  {
    "title":
        "If I drop a course, will it affect my merit scholarship eligibility?",
    "content":
        "Merit scholarship eligibility is determined based on grades recorded immediately after the grade correction period. Even if you drop a course later, the grades recorded before the drop will be used for scholarship selection."
  },
  {
    "title":
        "How many students or what percentage of each department receives scholarships?",
    "content":
        "For Sungkok and top student scholarships, the Student Support Team allocates the number of recipients based on the number of students in each major/department. For types 1-3, allocation is made to each college, which then re-allocates to departments based on student numbers and budget. Scholarship amounts and recipients may vary each semester and department based on these factors."
  },
  {
    "title": "How can I check if I have been selected for a scholarship?",
    "content":
        "You can check your scholarship status on the Comprehensive Information System under the 'Scholarship History' section."
  },
  {
    "title":
        "What scholarships are available for general students, and how much are they?",
    "content":
        "General students can receive merit scholarships based on academic performance and need-based scholarships for financial difficulties or contributions to the department. Merit scholarships include Sungkok (full tuition), top student (70% tuition), type 1 (50% tuition), type 2 (30% tuition), and type 3 (20% tuition). Need-based scholarships include type 1 (70% tuition), type 2 (50% tuition), and type 3 (30% tuition)."
  },
  {
    "title":
        "Do I need to register before taking a leave of absence to receive my scholarship?",
    "content":
        "Since 2017, registration before taking a leave of absence is no longer required. Merit scholarships are carried over, but other scholarships are refunded upon taking a leave. Consult your department before taking a leave."
  }
];

final List<Map<String, dynamic>> offCampusScholarshipsFaq = [
  {
    "title":
        "How can I get the university president's seal on an external scholarship recommendation letter?",
    "content":
        "Fill in your personal details on the recommendation letter and get approval from the Student Support Team. Then, you can get the seal from the Comprehensive Service Center in the main building."
  },
  {
    "title": "How to write an external scholarship recommendation letter?",
    "content":
        "Generally, the recommendation reason should be written and signed by your advisor or a professor from your college. Follow these steps:\n1. For the president's seal: contact the Student Support Team (Baek Min-jung: 02-910-4058)\n2. For the dean's seal: contact your college's administrative team."
  }
];

final List<Map<String, dynamic>> nationalScholarshipsFaq = [
  {
    "title":
        "Do I need to apply separately for types 1 and 2 national scholarships?",
    "content":
        "When applying for national scholarships, types 1 and 2 are applied for together."
  },
  {
    "title":
        "Do enrolled students need to apply for national scholarships in the first application period?",
    "content":
        "Enrolled students are generally required to apply in the first period. However, they can apply twice in the second period during their enrollment by submitting a request for reconsideration for that semester."
  },
  {
    "title":
        "How are grades reflected for students who failed the previous semester?",
    "content": "The grades from the failed semester are reflected as they are."
  }
];

final List<Map<String, dynamic>> studentLoansFaq = [
  {
    "title": "How do I apply for a student loan?",
    "content":
        "Check the scholarship notices on the university website each semester for the application period and eligibility. Detailed information can be found on the Korea Scholarship Foundation website."
  }
];

final List<Map<String, dynamic>> preventionOfOverlappingFinancialAidFaq = [
  {
    "title": "Can I receive scholarships that exceed my tuition fees?",
    "content":
        "For scholarships within the scope of tuition fees, such as merit and need-based scholarships, the law prohibits receiving more than the tuition amount. Check the scholarship notices on the website for information on scholarships within and beyond tuition coverage."
  }
];

final List<Map<String, dynamic>> employmentFaq = [
  {
    "title":
        "What education programs are available at the Career Development Center?",
    "content":
        "Visit the Career Development Center website (career.kookmin.ac.kr) and log in > e-Portfolio > Career Development Center Roadmap to see the available programs. The roadmap includes various non-curricular programs and employment-related courses. Click on each program for details, schedules, and reviews."
  },
  {
    "title": "Where can I find employment information?",
    "content":
        "Employment information is uploaded every Sunday on the Physical Education College employment bulletin board."
  },
  {
    "title": "What is C-point?",
    "content":
        "C-points are points earned by attending specific education programs conducted by the Career Development Center. They can be used like cash on the Career Development Center website. Items applied for with points are processed on the Friday morning following the application date and sent to the registered phone number in your academic records."
  },
  {
    "title":
        "What types of counseling are available at the University Job Center?",
    "content":
        "The University Job Center offers comprehensive counseling services, from specific job and role information to help with resumes and interview preparation. Various psychological/personality tests, such as MBTI, Enneagram, and CPI, are also available."
  },
  {
    "title": "How do I apply for an employment club?",
    "content":
        "You can apply by receiving an application form from the University Job Center."
  },
  {
    "title":
        "Can graduates and students on leave receive employment counseling?",
    "content":
        "Employment counseling at the Career Development Center is available to graduates, prospective graduates, and students on leave."
  },
  {
    "title": "How can I receive employment counseling?",
    "content":
        "Employment counseling is available in-person and online.\n1. In-person counseling: Check the available counseling slots (in green) on the counseling menu and apply. (You can have counseling twice a month, up to four times per semester)\n2. Online counseling: Post your query on the online counseling board and receive a response from a Career Development Center advisor."
  },
  {
    "title": "I applied for a recommended job. How can I check the results?",
    "content":
        "You can check the status and results of your recommended job applications in the e-Portfolio under 'Recommended Job Status.'\n- Application complete: Your application has been successfully submitted.\n- Selected: You have been selected as a recommended candidate and forwarded to the company. The company will proceed with the selection process.\n- Not selected: You were not selected as a recommended candidate."
  },
  {
    "title": "Where can I find programs I can participate in?",
    "content":
        "Log in to the Career Development Center website (career.kookmin.ac.kr) and check the recommended programs on your dashboard."
  },
  {
    "title": "How does the recommended job placement process work?",
    "content":
        "Recommended job placements offer a great opportunity to secure employment under favorable conditions. Types of recommended placements:\n1) Recruitment processes that only include students recommended by the university\n2) Open to all applicants but with benefits (e.g., extra points in the document screening) for recommended candidates.\nProcess:\n1) Companies request student recommendations from the Career Development Center\n2) Advertisement of recommended job placement\n3) Students apply for the recommended job placement\n4) The Career Development Center selects recommended candidates\n5) The recommended candidates list is forwarded to the company\n6) The company proceeds with its own selection process"
  }
];

final List<Map<String, dynamic>> entrepreneurshipFaq = [
  {
    "title": "How do entrepreneurship clubs operate?",
    "content":
        "The LINC+ project team recruits entrepreneurship clubs once a year in May. Support of up to 3 million KRW per team is provided from June to December, and a final presentation is held in December. The number of recruits varies each year, and selection is through document review and presentations."
  }
];

final List<Map<String, dynamic>> militaryServiceGuidanceFaq = [
  {
    "title":
        "How can I check the final acceptance results for enlisted soldiers?",
    "content":
        "1. Final acceptance results for enlisted soldiers are notified via SMS (alert message) at 10:00 on the announcement date.\n2. If you do not receive the SMS, you can check the results on the Military Manpower Administration website (Military Service Inquiry -> Military Support -> Inquiry and Issuance -> Acceptance Status/Enlistment Notice)."
  },
  {
    "title":
        "How long do I have to change the priority order of branches after applying to multiple branches?",
    "content":
        "1. Multiple applications to branches are allowed only in the same session (same application period, announcement date, enlistment month, etc.).\n    a. Only possible between Army Technical Administrative Soldiers, Navy, Air Force, Marine Corps General Technical/Professional Technical Soldiers.\n    b. Not possible between Navy and Marine Corps, and for specialized soldiers, buddy enlistment, hometown service, family service.\n2. You can change the priority order of branches until 7 days before the final acceptance announcement date on the Military Manpower Administration website (Military Service Inquiry -> Military Support -> Modify Application (Change Priority Order))."
  },
  {
    "title": "Can I cancel my application for enlisted soldiers?",
    "content":
        "You can cancel your application on the Military Manpower Administration website until 7 days before the final acceptance announcement date.\n(Military Manpower Administration website > Military Service Inquiry -> Military Support -> Cancel Application)\nHowever, you cannot cancel your application after the application deadline and until the first acceptance announcement."
  }
];

final List<Map<String, dynamic>> reserveForcesGuidanceFaq = [
  {
    "title":
        "I had surgery for a herniated disc while on active duty and received a 5th grade classification. Am I exempt from reserve training?",
    "content":
        "If a reserve force member cannot fulfill reserve duty due to illness, they can apply for a change in military service classification to the local Military Manpower Administration chief according to Article 65 of the Military Service Act and Article 135 of the Enforcement Decree. Depending on the results of the physical examination conducted at a designated institution or military hospital, they may be reclassified to wartime labor force or exempt from military service. Thus, those classified as 5th to 6th grade can be exempt from reserve training by applying for a change in military service classification to the Military Manpower Administration."
  },
  {
    "title":
        "My registered address is in Gyeonggi-do, but I live in Seoul. Can I receive training in Seoul?",
    "content":
        "You can apply for nationwide training. This can be done at the nearest reserve force unit or through the reserve force website (mobile app) under 'Nationwide Training'."
  },
  {
    "title":
        "My health has deteriorated, and I am unable to participate in training. Is there a way to defer or postpone training until I can participate?",
    "content":
        "1. If you submit a medical certificate stating you are unable to participate in training due to illness, you can defer or postpone reserve training.\n- For medical certificates under 180 days, training is deferred\n- For medical certificates over 180 days, training is postponed until the end of the treatment period specified in the certificate\n2. If the same illness requires extended treatment, a second medical certificate extending the treatment period can be submitted. The total treatment period will be calculated by adding the first and second treatment periods.\nTraining deferral can be applied through the reserve force website or at the Kookmin University reserve force unit."
  },
  {
    "title": "Will I be immediately reported if I miss reserve training?",
    "content":
        "For mobilization training, unauthorized absence results in immediate reporting according to the Military Service Act. However, for supplementary training, there is no penalty for missing the basic training and the first supplementary training except for increased training hours. Missing the second supplementary training results in reporting according to the Reserve Forces Act."
  },
  {
    "title":
        "How can I request a transfer in and out of student reserve force units?",
    "content":
        "Reserve Force Transfer Application\n1. Eligibility: New admission, readmission, transfer, graduate school admission, new appointment\n2. Transfer\n- Undergraduate freshmen, transfer students, graduate students: The reserve force battalion will verify academic enrollment and request transfer to student reserve force units.\n- Returning undergraduate students: Verified at the beginning of the semester (March 1 for the first semester, September 1 for the second semester) for transfer.\nStudents do not need to report for transfer; it is processed based on academic enrollment.\nReserve Force Transfer Out\n1. Eligibility: Leave of absence, withdrawal, dismissal, graduation, employment at civilian reserve force units\n2. Processed automatically with academic changes, no separate application required.\nNo need for regional transfer reporting."
  },
  {
    "title": "Who is eligible for university workplace reserve force units?",
    "content":
        "1) Employed faculty and staff\n2) Enrolled undergraduate students (except cyber university students)\n3) Enrolled graduate students (except for professional, special, research, management courses, and online programs)\n* Students exceeding the study period are excluded and are assigned to local reserve force units."
  },
  {
    "title":
        "What are the reasons for deferring or postponing student reserve force training?",
    "content":
        "1) Training Deferral Reasons: Illness, critical illness or death of direct relatives, departure abroad, various exams, marriage, significant duties, etc.\n- Submission deadline: At least 3 days before the training date\n- Deferral period: Varies by reason\n- Required documents: Deferral application (available at the reserve force unit) and related documents\n2) Training Postponement Reasons: Illness or mental disability (certified for over 180 days), long-term stay abroad (over 365 days), etc.\n- Training Postponement: Applies to the relevant year's training."
  },
  {
    "title":
        "I was discharged this year. What reserve force training will I receive as a student reserve force member?",
    "content":
        "* Students: 1-6 years: Basic training 8 hours, 7-8 years: Emergency network check\n* If only attending the second semester: Regional reserve force supplementary training absentees must complete the missed training (up to 32 hours) during the university's training schedule after returning.\n- For mobilization designees, if you miss the first semester mobilization training without approval, you will be reported by the Military Manpower Administration (attend or defer before returning).\n- Local reserve forces: 1-4 years: Mobilization designees: 2 nights 3 days mobilization training, non-mobilization designees: 4 days supplementary training (32 hours) or 2 nights 3 days. 5-6 years: Basic training (8 hours), front/rear plan training (12 hours)."
  }
];

final List<Map<String, dynamic>> assignmentApplicationChangeFaq = [
  {
    "title": "I want to change my project plan. Is it possible?",
    "content":
        "You can change some parts of your project plan. However, you must submit a project change approval request to the LINC+ project team and get approval at least three weeks before the deadline for submitting expense reports."
  },
  {
    "title":
        "What are the conditions to become the team leader for a Capstone Design project?",
    "content":
        "The team leader must be a third-year or higher student from a department participating in the LINC+ project. (The list of participating departments is available in the LINC+ introduction booklet.)"
  }
];

final List<Map<String, dynamic>> supportFundSettlementFaq = [
  {
    "title": "What are the main reasons for the refund of support funds?",
    "content":
        "The main reasons for refunding support funds are:\na) Withdrawal without a valid reason\nb) Failure to submit activity results, violation of reporting obligations, failure to submit expense reports, non-compliance with reporting requirements\nc) Misuse of operating funds for purposes other than intended\nd) Engaging in activities that damage the reputation of the LINC+ project team"
  },
  {
    "title": "Are all project support funds transferred in cash?",
    "content":
        "No. After project approval, you must submit expense reports for each expenditure. The project team will review the documents and transfer the approved amount within the budget to the team leader's account."
  },
  {
    "title": "What are the common reasons for rejection of expense reports?",
    "content":
        "Common reasons for rejection include missing signatures from the representative student or attendees on the meeting minutes. Ensure that supporting documents are not overlapping and are easily identifiable (avoid using staples or tape). Attach documents in the order listed in the expense report, and ensure that each document is in the correct order (e.g., receipt, transaction statement, quotation, photos, etc.)."
  },
  {
    "title":
        "What receipts are accepted for project support fund expenditures?",
    "content":
        "Only receipts from personal credit cards, debit cards, and electronic tax invoices issued to the Industry-Academic Cooperation Foundation of Kookmin University are accepted. Receipts must include the amount, date, merchant name, partial card number, and approval number. Corporate card receipts, cash receipts, simplified receipts, and cash payment receipts are not accepted."
  },
  {
    "title":
        "Do I submit the expense report after spending all the project support funds?",
    "content":
        "Expense reports and supporting documents must be submitted within four weeks from the date of expenditure."
  }
];

final List<Map<String, dynamic>> supportFundExpenditureFaq = [
  {
    "title": "Can I purchase software programs?",
    "content":
        "General-purpose software cannot be purchased. You need to discuss with the LINC+ project team to determine if the software is general-purpose. Even if approved, only software with a license period of less than one year and a price under 1 million KRW (including VAT) can be purchased."
  },
  {
    "title":
        "Can I purchase computer-related equipment and parts (external hard drive, USB, SD card, power strip, LAN cable, etc.)?",
    "content":
        "General-purpose equipment cannot be purchased. If you need to purchase equipment related to the project, consult the project team in advance."
  },
  {
    "title":
        "Where can I find the guidelines for the Capstone Design project support fund expenditures and documents?",
    "content":
        "The guidelines are available on the LINC+ project team website. Please check the following link:\n[Capstone Design Project Support Fund Guidelines](https://linc.kookmin.ac.kr/archives/9903?syb=4)"
  },
  {
    "title":
        "Can I use the support fund for equipment fees at on-campus facilities like the 3D Printing Design Innovation Center?",
    "content":
        "No. The support fund cannot be used for transactions with facilities that share the same business registration number as Kookmin University or the Industry-Academic Cooperation Foundation (e.g., UIT Design Solution Center-3D Printing Design Innovation Center)."
  },
  {
    "title": "Can I make multiple payments to the same vendor?",
    "content":
        "Splitting payments into multiple transactions to avoid submitting a comparative quotation is not allowed. Additionally, meeting expenses can only be claimed once per day, so multiple payments in one day are not supported."
  }
];

final List<Map<String, dynamic>> exchangeStudentProgramFaq = [
  {
    "title": "How many overseas partner universities does our university have?",
    "content":
        "As of August 2020, our university has exchange agreements with over 400 universities and institutions in 60 countries. The Exchange Partners and program details can be found on the Kookmin University English website or the International Exchange Team website."
  },
  {
    "title": "What is the exchange student program?",
    "content":
        "The exchange student program allows students to study at an overseas partner university for one semester (up to one year) and transfer the credits earned back to Kookmin University. Exchange students pay tuition to Kookmin University but are exempt from tuition at the partner university. They can take language or regular courses and participate in extracurricular activities to enhance cultural understanding."
  },
  {
    "title":
        "What types of international exchange programs does our university offer?",
    "content":
        "The International Exchange Team offers various regular programs (exchange students, visiting students, etc.) and short-term programs (language courses, SGE, etc.). Additionally, the Global Peers (GPS) program supports international exchange students in adapting to campus life and facilitates language and cultural exchange. Other international exchange programs may be offered by individual colleges or departments."
  },
  {
    "title": "What are the credit recognition limits when studying abroad?",
    "content":
        "The maximum number of credits recognized per semester varies by college and student. Generally, it follows the credit limits specified in the university regulations. Students with a GPA of 3.75 or higher in the semester before departure can have an additional 3 credits recognized. For language courses or SGE programs, 1-2 credits may be recognized depending on the program."
  },
  {
    "title":
        "What are the eligibility requirements for international exchange programs?",
    "content":
        "Eligibility requirements vary by program and host university. Check the International Exchange Team website for detailed requirements and notices. For programs offered by individual colleges, contact the respective college's administrative office."
  }
];

final List<Map<String, dynamic>> visitingStudentProgramFaq = [
  {
    "title": "What is the visiting student program?",
    "content":
        "The visiting student program allows students to study at an overseas partner university for 1-2 semesters and transfer the credits earned back to Kookmin University. Unlike exchange students, visiting students pay tuition to both Kookmin University and the partner university. To alleviate financial burden, visiting students receive tuition and living expense scholarships. They can choose the duration of their stay (up to two semesters)."
  }
];

final List<Map<String, dynamic>> doubleDegreeFaq = [
  {
    "title": "What is the double degree program?",
    "content":
        "Students who have studied at Kookmin University for at least four semesters and earned at least half of the required graduation credits can study at an overseas partner university to complete the remaining credits. Upon meeting the graduation requirements of both universities, they receive degrees from both institutions. Double degree students pay tuition to both Kookmin University and the partner university and receive tuition support scholarships for up to four semesters."
  }
];

final List<Map<String, dynamic>> shortTermLanguageStudyAbroadFaq = [
  {
    "title": "What is the short-term language study abroad program?",
    "content":
        "This program allows students to study a foreign language (English, Chinese, Spanish, etc.) at an overseas partner university for 3-4 weeks during the summer or winter break and earn Kookmin University credits. Students pay Kookmin University’s summer/winter session tuition and the partner university's program fee and receive a scholarship upon completion."
  }
];

final List<Map<String, dynamic>> studentGlobalEngagementFaq = [
  {
    "title": "What is the Sungkok Global Exposure (SGE) program?",
    "content":
        "The SGE program allows students to participate in international exchange programs (lectures, student exchanges, etc.) at overseas partner universities for 1-2 weeks during the summer or winter break and earn Kookmin University credits. The program is led by individual colleges and provides scholarships."
  }
];

final List<Map<String, dynamic>> undergraduateStudentFaq = [
  {
    "title": "How can I get an engineering certification certificate?",
    "content":
        "Engineering certification can be confirmed by the degree title. Students needing certification documents can download them from the Center for Innovation in Engineering Education website (cieek.kookmin.ac.kr) under Community > FAQ > Engineering Certification Documents."
  }
];

final List<Map<String, dynamic>> studentEventFaq = [
  {
    "title": "What is the procedure for student events?",
    "content":
        "Student event permits are generally granted for events that do not interfere with classes. Submit the student event permit application to the Student Support Team, then get approval from the relevant departments for final event approval."
  },
  {
    "title": "Management departments for event venues",
    "content":
        "Main stadium and gymnasium: Weekdays (College of Physical Education Administrative Team), weekends, and holidays (General Affairs Team)\nLecture rooms: Administrative teams of each college\nComprehensive Welfare Center performance hall: Performance hall management office"
  }
];

final List<Map<String, dynamic>> undergraduateDepartmentOfficeFaq = [
  {
    "title": "What are the operating hours of the department office?",
    "content":
        "During the semester, it is open from 09:00 to 17:00. During vacations, it is open from 09:30 to 16:00. Lunch break is from 12:00 to 13:00."
  }
];

final List<Map<String, dynamic>> studentCounselingCenterFaq = [
  {
    "title": "Can I receive personal counseling again?",
    "content":
        "Students who have previously received personal counseling can apply again six months after the conclusion of their previous counseling."
  },
  {
    "title": "I want to stop personal counseling.",
    "content":
        "Clients have the right to choose to end counseling. During counseling sessions, counselors will discuss with clients about the end of counseling and whether the goals have been achieved. Even if clients decide to end counseling without discussing it with the counselor, it is important to have a final session to conclude. Please feel free to discuss with your counselor if you wish to end counseling."
  },
  {
    "title": "What are the operating hours?",
    "content": "The Student Counseling Center operates from 9:30 AM to 5:00 PM."
  },
  {
    "title": "Will records be kept if I receive counseling at the center?",
    "content":
        "Personal information is kept for five years but will not be disclosed externally except in exceptional situations (e.g., crisis situations). Confidentiality is maintained."
  },
  {
    "title": "Where can I apply?",
    "content":
        "You can apply for counseling and psychological tests by visiting the Student Counseling Center, calling, or applying online through the center's website or K-Startup.\nPhone application: 02-910-4232\nWebsite application: https://sangdam.kookmin.ac.kr/sub03_02_01.php"
  },
  {
    "title": "What tests are available to understand my personality?",
    "content":
        "The Student Counseling Center offers personality type tests such as MBTI and TCI."
  },
  {
    "title":
        "Will receiving personal counseling be a disadvantage for employment?",
    "content":
        "The Student Counseling Center guarantees the confidentiality of your personal information and counseling content. Therefore, there will be no disadvantage related to employment."
  },
  {
    "title": "I might not be able to attend my counseling session.",
    "content":
        "If you cannot attend your counseling session, please notify the counselor or the center at least 24 hours in advance to reschedule. You can cancel up to three sessions during the counseling period."
  },
  {
    "title": "What is personal counseling?",
    "content":
        "Personal counseling involves regular one-on-one sessions with a professional counselor to enhance self-understanding and adaptation. It typically consists of 8-15 sessions, held once a week for 50 minutes each."
  },
  {
    "title": "Who conducts the counseling?",
    "content":
        "Counseling is conducted by professional counselors with graduate-level training or higher in related fields."
  },
  {
    "title": "What issues can I discuss in counseling?",
    "content":
        "You can discuss a wide range of issues, including adjustment problems, academic and career issues, relationship issues, sexual and gender issues, family problems, personality issues, emotional problems, existential issues, behavioral and habit issues, economic or practical problems. No issue is too small for counseling."
  },
  {
    "title": "Will my professors know if I receive personal counseling?",
    "content":
        "The center guarantees the confidentiality of your personal information and counseling content. Your counseling details will not be disclosed to your professors or anyone else without your consent. However, in cases where there is a threat to the client's or others' safety, counselors are obligated to inform relevant parties according to ethical guidelines. The center retains personal information and counseling records for five years and destroys them immediately after this period."
  },
  {
    "title": "Who can receive personal counseling?",
    "content":
        "All enrolled students, including those on leave, are eligible for personal counseling."
  },
  {
    "title": "What does the Student Counseling Center do?",
    "content":
        "The Student Counseling Center provides counseling and psychological testing for students experiencing psychological or emotional difficulties. It also offers various psychological training programs."
  },
  {
    "title": "What is the procedure for personal counseling?",
    "content":
        "The personal counseling procedure is as follows: 'Application -> Registration -> Appointment for intake interview -> Intake interview -> Psychological testing -> Counselor assignment -> Counseling sessions'. The process from registration to assignment may take 2-4 weeks."
  },
  {
    "title": "Where is the Student Counseling Center located?",
    "content":
        "The Student Counseling Center is located in room 402 of the Comprehensive Welfare Center."
  },
  {
    "title": "Can graduates use the center?",
    "content":
        "The center is available only to enrolled students, including those on leave."
  },
  {
    "title": "Can students on leave use the center?",
    "content": "Yes, students on leave can use the center."
  },
  {
    "title": "Can graduate students receive counseling at the center?",
    "content": "Yes, graduate students can receive counseling."
  },
  {
    "title": "What is MBTI?",
    "content":
        "MBTI is a personality assessment that helps you understand your personality, relationships, and career exploration. More details can be found on the center's website (https://sangdam.kookmin.ac.kr/sub03_01_01.php)."
  }
];

final List<Map<String, dynamic>> learningMethodSeminarFaq = [
  {
    "title":
        "Are there any seminars on study methods or self-directed learning enhancement?",
    "content":
        "Yes, the Center for Teaching and Learning offers seminars and workshops such as 'Changing Time for Tomorrow' (NaeBashi) based on the KMU Learning Competency Test results. Topics include organization, time management, and learning environment management. There are also TipTalk concerts where you can learn from peers. For more details, visit the Center for Teaching and Learning website (http://ctl.kookmin.ac.kr)."
  }
];

final List<Map<String, dynamic>> learningVolunteerPeerTutorFaq = [
  {
    "title":
        "I want to help younger students adapt to their major and study. How can I do that?",
    "content":
        "You can participate as a peer tutor or mentor through the Center for Teaching and Learning. Peer tutors receive a stipend and must have a GPA of 3.8 or higher with an A grade in the subject they tutor. Apply during recruitment periods or participate in the peer tutor training program. For more details, visit the Center for Teaching and Learning website (http://ctl.kookmin.ac.kr)."
  }
];

final List<Map<String, dynamic>> learningCounselingAndClinicFaq = [
  {
    "title":
        "I am not achieving the learning outcomes I expected despite my efforts. Is there a place to get my study methods checked?",
    "content":
        "You can apply for the LOAS Learning Clinic at the Center for Teaching and Learning. While it primarily supports students on academic probation, any interested student can participate. The clinic assesses learning issues and provides personalized sessions based on individual needs. For more details, visit the Center for Teaching and Learning website (http://ctl.kookmin.ac.kr)."
  }
];

final List<Map<String, dynamic>> libraryFaq = [
  {
    "title": "What are the criteria for selecting books for purchase?",
    "content":
        "Not all requested books are purchased. Due to the library's limited budget and institutional guidelines, some requests may be denied. Reasons for denial include:\n1. Duplicate copies: The library already owns the requested book.\n2. Inaccurate bibliographic information: Essential details are missing or incorrect, making verification difficult.\n3. Books already ordered: The book is already on order by another user.\n4. Comics: Only academically essential comics are considered.\n5. Children's books: Books for young children or adolescents without academic purpose.\n6. Exam preparation books: Materials for entrance exams, transfer, or study abroad.\n7. Unsuitable format: Books that are too large, pocket-sized, or in an unsuitable binding.\n8. Inappropriate subject matter: Non-academic content such as romance novels, light novels, or self-help books.\n9. Expensive books: Books costing over 100,000 KRW.\n10. Other: Any books deemed unsuitable by the library director."
  },
  {
    "title": "Can I request CDs, DVDs, or Blu-ray materials?",
    "content":
        "Yes, you can request non-book materials like CDs, DVDs, and Blu-rays. Submit a 'Non-Book Request Form' at the Multimedia Information Room on the first floor of the Seongkok Library or online via My Library > Book Purchase Request. Approval depends on whether the material can be used with existing facilities. Note that high-cost or highly specialized materials may be restricted."
  },
  {
    "title": "What is the Priority Processing Request service?",
    "content":
        "This service allows users to prioritize the processing of requested materials, enabling faster borrowing. If a book's status is 'Processing,' click the 'Priority' button next to its status. Each user can request priority processing for up to three books at a time. You will be notified via SMS when the book is ready for borrowing, usually within two business days. Failure to borrow within this period may result in penalties."
  },
  {
    "title": "How do I request the purchase of e-books (including audiobooks)?",
    "content":
        "Request e-books through the Seongkok Library website (login required) under E-book Library > Book Purchase Request. You can request up to five e-books per month, separate from physical book requests. Note that only e-books available for library licensing can be purchased."
  },
  {
    "title": "How can I check the status of my book purchase request?",
    "content":
        "To check the status of your book request, click on the title in the Book Purchase Request/Inquiry section. Status descriptions include:\n- Selected: Purchase confirmed, awaiting processing.\n- Ordered: Ordered from the vendor.\n- Quoted: Awaiting delivery after receiving the quote.\n- Registered: Book received, awaiting cataloging.\n- Processing: Undergoing data entry and cataloging.\n- Available: Ready for borrowing."
  },
  {
    "title": "Why was my book purchase request canceled?",
    "content":
        "Book purchase requests may be canceled for reasons such as:\n1. Duplicate copies: Already owned by the library.\n2. Inaccurate bibliographic information: Essential details are missing or incorrect.\n3. Books already ordered: Already on order by another user.\n4. Comics: Only academically essential comics are considered.\n5. Children's books: Books for young children or adolescents without academic purpose.\n6. Exam preparation books: Materials for entrance exams, transfer, or study abroad.\n7. Unsuitable format: Books that are too large, pocket-sized, or in an unsuitable binding.\n8. Inappropriate subject matter: Non-academic content such as romance novels, light novels, or self-help books.\n9. Expensive books: Books costing over 100,000 KRW.\n10. Other: Any books deemed unsuitable by the library director."
  },
  {
    "title":
        "Do I get borrowing priority for the books I requested for purchase?",
    "content":
        "The Seongkok Library does not grant borrowing priority to users who request book purchases. However, requesters will be notified first via SMS and email once the book arrives, giving them a chance to use the Priority Processing service for quicker access. If another user requests priority processing first, they may borrow the book earlier."
  }
];

final List<Map<String, dynamic>> onCampusWelfareFacilitiesFaq = [
  {
    "title": "Is there a place to study in the Welfare Building?",
    "content":
        "Yes, you can study at the Job Café operated by the Career Development Center on the B1 floor of the Welfare Building. The hours are 09:00 to 20:00 during the semester and vacation."
  },
  {
    "title": "I want to reserve a study room.",
    "content":
        "Study rooms are available for reservation for study groups affiliated with the Career Development Center. You can reserve rooms B129, B130, and B131 on the B1 floor of the Welfare Building through the Career Development Center website (https://career.kookmin.ac.kr/)."
  },
  {
    "title":
        "What are the location and operating hours of the Career Development Center?",
    "content":
        "The Career Development Center is located in room B102 on the B1 floor of the Welfare Building (opposite Cafe Namu). The center is open from 09:00 to 17:00 during the semester and from 09:30 to 16:00 during vacations (closed 12:00-13:00 for lunch)."
  }
];

final List<Map<String, dynamic>> classroomUsageFaq = [
  {
    "title":
        "I am a student in the College of Automotive Engineering and want to rent a classroom in the Engineering Building.",
    "content":
        "If you want to rent a classroom, please visit the College of Automotive Engineering Administrative Office (Engineering Building, room 227)."
  }
];

final List<Map<String, dynamic>> itemRentalFaq = [
  {
    "title":
        "I want to borrow class materials (not available for other departments).",
    "content":
        "You can borrow class materials by visiting room 104 in the Mirae Building during weekdays (09:00-17:00, excluding lunch break 12:00-13:00)."
  }
];

final List<Map<String, dynamic>> websiteFaq = [
  {
    "title":
        "The personal information on the Career Development Center website is incorrect. How can I fix it?",
    "content":
        "Personal information on the Career Development Center website is linked with the Integrated Information System. Please update your information through the Integrated Information System. The updated information will be reflected on the Career Development Center website the next day (updated daily at 6 AM)."
  }
];

final List<Map<String, dynamic>> educationalObjectivesFaq = [
  {
    "title": "What are the educational goals of our university?",
    "content":
        "Our university aims to cultivate well-rounded individuals through four educational goals: Character Education, Cooperative Education, Initiative Education, and Creative Education. These goals aim to develop cultured individuals, communicative collaborators, forward-thinking leaders, and creative professionals."
  }
];

final List<Map<String, dynamic>> educationalPhilosophyFaq = [
  {
    "title": "What is the educational philosophy of our university?",
    "content":
        "Our university's educational philosophy is rooted in the 'Patriotism' of Haegong Shin Ik-hee and the 'Entrepreneurial Spirit' of Sungkok Kim Sung-gon. Established after Korea's liberation to train national talent, our founding philosophy emphasizes that academic activities should ultimately serve the nation and its people. Since 1959, the entrepreneurial spirit of Sungkok, the founder of SsangYong Group, has been embedded as the cultural DNA of our institution."
  }
];

final List<Map<String, dynamic>> idealStudentProfileFaq = [
  {
    "title": "What is the ideal student profile of our university?",
    "content":
        "The ideal student of our university is described as 'The Challenging KMU* Student,' specifically defined as a 'practical and interdisciplinary talent who changes the world as a community-oriented individual.'"
  }
];

final List<Map<String, dynamic>> kmuVision2030PlusFaq = [
  {
    "title":
        "Is there a development plan outlining our university's future vision and plans?",
    "content":
        "Yes, our university established a long-term development plan, KMU Vision 2030+, in 2018. The vision aims to become a representative university setting new standards for higher education in Korea by 2030."
  },
  {
    "title": "How has the development plan of our university evolved?",
    "content":
        "The evolution of our university's development plan is as follows: Leap 2010 (2000-2009) -> KMU1010 (2009-2014) -> Challenge 1010 (2014-2017) -> KMU Vision 2030 (2017-2018) -> KMU Vision 2030+ (2018-present)."
  },
  {
    "title":
        "What distinguishes our university's development plan from others?",
    "content":
        "Unlike other plans that set quantitative goals for development, our university's long-term development plan focuses on optimizing and innovating goals and strategies in education, industry-academic cooperation, and research."
  },
  {
    "title": "What are the core aspects of our university's development plan?",
    "content":
        "Our university's long-term development plan, KMU Vision 2030+, includes 12 innovation tasks aimed at establishing and expanding the foundation for nurturing 'TEAM-type talent who changes the world.' These tasks are individually set and promoted in the areas of education, industry-academic cooperation, and research."
  }
];

final List<Map<String, dynamic>> specializationPlanFaq = [
  {
    "title": "Does our university have a specialization plan?",
    "content":
        "Yes, our university has a specialization strategy as part of its long-term development plan. The specialization system has been consistently promoted since the 'Challenge 1010' plan was established in 2014."
  }
];
