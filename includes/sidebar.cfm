
<!---Gets Course Information (name, code, due date) of courses that have textbooks due that day--->
<cfinvoke component="Queries"
          method="contractDueToday_Getter"
          returnvariable="contractDue_Course_Array">
    
<!---Gets Course Information (name, code, due date) of courses that have textbooks due that day--->
<cfinvoke component="Queries"
          method="UpcomingContractDueDates_Getter"
          returnvariable="UpcomingContractDue_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have textbooks due that day--->
<cfinvoke component="Queries"
          method="OverdueContractDueDates_Getter"
          returnvariable="OverdueContract_Course_Array">
    
<!---Gets Course Information (name, code, due date) of courses that have textbooks due that day--->
<cfinvoke component="Queries"
          method="UpcomingTextDueDates_Getter"
          returnvariable="UpcomingTextDue_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have textbooks due that day--->
<cfinvoke component="Queries"
          method="TextDueToday_Getter"
          returnvariable="TextDue_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have textbooks due that day--->
<cfinvoke component="Queries"
          method="OverdueTextDueDates_Getter"
          returnvariable="OverdueText_Course_Array">
    
<!---Gets Course Information (name, code, due date) of courses that have OWL Sites due that day--->
<cfinvoke component="Queries"
          method="OWLDueToday_Getter"
          returnvariable="OWLDue_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have OWL Sites due that day--->
<cfinvoke component="Queries"
          method="UpcomingOWLDueDates_Getter"
          returnvariable="UpcomingOWLDue_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have OWL Sites due that day--->
<cfinvoke component="Queries"
          method="OverdueOWLDueDates_Getter"
          returnvariable="OverdueOWL_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have OWL Sites due that day--->
<cfinvoke component="Queries"
          method="UpcomingCourseOutlineDueDates_Getter"
          returnvariable="UpcomingCourseOutlineDue_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have textbooks due that day--->
<cfinvoke component="Queries"
          method="CourseOutlineDueToday_Getter"
          returnvariable="CourseOutlineDue_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have OWL Sites due that day--->
<cfinvoke component="Queries"
          method="OverdueCourseOutlineDueDates_Getter"
          returnvariable="OverdueCourseOutline_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have survey reminders due that day--->
<cfinvoke component="Queries"
          method="ReminderDueToday_Getter"
          returnvariable="ReminderDue_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have survey reminders due that day--->
<cfinvoke component="Queries"
          method="UpcomingReminderDueDates_Getter"
          returnvariable="UpcomingReminderDue_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have survey reminders due that day--->
<cfinvoke component="Queries"
          method="OverdueReminderDueDates_Getter"
          returnvariable="OverdueReminder_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have survey evaluation due that day--->
<cfinvoke component="Queries"
          method="EvaluationDueToday_Getter"
          returnvariable="EvaluationDue_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have survey evaluation due that day--->
<cfinvoke component="Queries"
          method="UpcomingEvaluationDueDates_Getter"
          returnvariable="UpcomingEvaluationDue_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have survey evaluation due that day--->
<cfinvoke component="Queries"
          method="OverdueEvaluationDueDates_Getter"
          returnvariable="OverdueEvaluation_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have survey grades due that day--->
<cfinvoke component="Queries"
          method="GradesDueToday_Getter"
          returnvariable="GradesDue_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have survey grades due that day--->
<cfinvoke component="Queries"
          method="UpcomingGradesDueDates_Getter"
          returnvariable="UpcomingGradesDue_Course_Array">

<!---Gets Course Information (name, code, due date) of courses that have survey grades due that day--->
<cfinvoke component="Queries"
          method="OverdueGradesDueDates_Getter"
          returnvariable="OverdueGrades_Course_Array">



<html>

<head>
    <title>SideBar</title>
    <link rel="stylesheet" type="text/css" href="includes/sidebarStyle.css?v=1.1">
</head>

<body>

    <script type="text/javascript" src="includes/sidebarFunctions.js"></script>

    <cfoutput>

    <div id="mySidebar" class="sidebar">

        <span class="sidebar-MainTitle">
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
            <strong>NOTIFICATIONS</strong>
        </span>

        <details>
            <summary>
                <span class="sidebar-title">
                    TODAY
                    <span class="glyphicon glyphicon-chevron-down" style="font-size:14px" aria-hidden="true"></span>
                </span>
            </summary>
        <ul class="notification">

<!-----------------------------------------------------------------------------------CONTRACTS DUE------------------------------------------------------------------------------------>
            <cfloop array="#contractDue_Course_Array#" index="course">
                <li>
                    <span class="Notification-Header">
                        CONTRACT DUE:
                        <div class="floatRight"> #course.Contract_DueDate#</div>
                    </span>
                    <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(Course.Course_ID))#">Course: #Course.Course_Name#</a>
                </li>
            </cfloop>

<!-----------------------------------------------------------------------------------TEXTBOOK DUE------------------------------------------------------------------------------------>
            <cfloop array="#TextDue_Course_Array#" index="course">
                <li>
                    <span class="Notification-Header">
                        TEXTBOOK DUE:
                        <div class="floatRight"> #course.Textbook_DueDate#</div>
                    </span>
                    <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(course.Course_ID))#">Course: #course.Course_Name#</a>
                    <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(course.Course_ID))#">Textbook: #course.Textbook_Title#</a>
                </li>
            </cfloop>

<!-----------------------------------------------------------------------------------OWL SITE DUE------------------------------------------------------------------------------------>
            <cfloop array="#OWLDue_Course_Array#" index="course">
                <li>
                    <span class="Notification-Header">
                        OWL DUE:
                        <div class="floatRight"> #course.OWL_DueDate#</div>
                    </span>
                    <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(Course.Course_ID))#">Course: #Course.Course_Name#</a>
                </li>
            </cfloop>

<!------------------------------------------------------------------------------------OUTLINE DUE------------------------------------------------------------------------------------>
            <cfloop array="#CourseOutlineDue_Course_Array#" index="course">
                <li>
                    <span class="Notification-Header">
                        COURSE OUTLINE DUE:
                        <div class="floatRight"> #course.CourseOutline_DueDate#</div>
                    </span>
                    <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(Course.Course_ID))#">Course: #Course.Course_Name#</a>
                </li>
            </cfloop>

<!------------------------------------------------------------------------------------EVALUATION REMINDER DUE------------------------------------------------------------------------------------>
            <cfloop array="#ReminderDue_Course_Array#" index="course">
                <li>
                    <span class="Notification-Header">
                        SURVEY REMINDER DUE:
                        <div class="floatRight"> #course.Reminder_DueDate#</div>
                    </span>
                    <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(course.Course_ID))#">Course: #course.Course_Name#</a>
                </li>
            </cfloop>

<!------------------------------------------------------------------------------------EVALUATION DUE--------------------------------------------------------------------------------->
            <cfloop array="#EvaluationDue_Course_Array#" index="course">
                <li>
                    <span class="Notification-Header">
                        SURVEY DUE:
                        <div class="floatRight"> #course.Evaluation_DueDate#</div>
                    </span>
                    <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(course.Course_ID))#">Course: #Course.Course_Name#</a>
                </li>
            </cfloop>

<!-------------------------------------------------------------------------------------GRADES DUE------------------------------------------------------------------------------------>
            <cfloop array="#GradesDue_Course_Array#" index="course">
                <li>
                    <span class="Notification-Header">
                        GRADES DUE:
                        <div class="floatRight"> #course.Grades_DueDate#</div>
                    </span>
                    <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(course.Course_ID))#">Course: #course.course_Name#</a>
                </li>
            </cfloop>
        </ul>
        </details>


<!---Due Dates for the Upcoming Week (Collapsable)--->
        <details>
            <summary>
                <span class="sidebar-title">
                    THIS WEEK
                    <span class="glyphicon glyphicon-chevron-down" style="font-size:14px" aria-hidden="true"></span>
                </span>
            </summary>
            <ul class="notification">

<!-----------------------------------------------------------------------------------TEXTBOOK DUE------------------------------------------------------------------------------------>
                <cfloop array="#UpcomingTextDue_Course_Array#" index="course">
                    <li>
                        <span class="Notification-Header">
                            TEXTBOOK DUE:
                            <div class="floatRight"> #course.Textbook_DueDate#</div>
                        </span>
                        <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(course.Course_ID))#">Course: #course.Course_Name#</a>
                    </li>
                </cfloop>
<!-----------------------------------------------------------------------------------CONTRACTS DUE------------------------------------------------------------------------------------>
                <cfloop array="#UpcomingContractDue_Course_Array#" index="course">
                    <li>
                        <span class="Notification-Header">
                            CONTRACT DUE:
                            <div class="floatRight"> #course.Contract_DueDate#</div>
                        </span>
                        <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(Course.Course_ID))#">Course: #Course.Course_Name#</a>
                    </li>
                </cfloop>

<!-----------------------------------------------------------------------------------OWL SITE DUE------------------------------------------------------------------------------------>
                <cfloop array="#UpcomingOWLDue_Course_Array#" index="course">
                    <li>
                        <span class="Notification-Header">
                            OWL DUE:
                            <div class="floatRight"> #course.OWL_DueDate#</div>
                        </span>
                        <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(Course.Course_ID))#">Course: #Course.Course_Name#</a>
                    </li>
                </cfloop>
    
 <!------------------------------------------------------------------------------------OUTLINE DUE------------------------------------------------------------------------------------>
                <cfloop array="#UpcomingCourseOutlineDue_Course_Array#" index="course">
                    <li>
                        <span class="Notification-Header">
                            COURSE OUTLINE DUE:
                            <div class="floatRight"> #course.CourseOutline_DueDate#</div>
                        </span>
                        <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(Course.Course_ID))#">Course: #Course.Course_Name#</a>
                    </li>
                </cfloop>
    
<!------------------------------------------------------------------------------------EVALUATION REMINDER DUE------------------------------------------------------------------------------------>
                <cfloop array="#UpcomingReminderDue_Course_Array#" index="course">
                    <li>
                        <span class="Notification-Header">
                            SURVEY REMINDER DUE:
                            <div class="floatRight"> #course.Reminder_DueDate#</div>
                        </span>
                        <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(course.Course_ID))#">Course: #course.Course_Name#</a>
                    </li>
                </cfloop>
<!------------------------------------------------------------------------------------EVALUATION DUE--------------------------------------------------------------------------------->
                <cfloop array="#UpcomingEvaluationDue_Course_Array#" index="course">
                    <li>
                        <span class="Notification-Header">
                            SURVEY DUE:
                            <div class="floatRight"> #course.Evaluation_DueDate#</div>
                        </span>
                        <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(course.Course_ID))#">Course: #Course.Course_Name#</a>
                    </li>
                </cfloop>
<!-------------------------------------------------------------------------------------GRADES DUE------------------------------------------------------------------------------------>
                <cfloop array="#UpcomingGradesDue_Course_Array#" index="course">
                    <li>
                        <span class="Notification-Header">
                            GRADES DUE:
                            <div class="floatRight"> #course.Grades_DueDate#</div>
                        </span>
                        <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(course.Course_ID))#">Course: #course.course_Name#</a>
                    </li>
                </cfloop>

            </ul>
        </details>


<!---Due Dates that are overdue (Collapsable)--->
        <details>
            <summary>
                <span class="sidebar-title">
                    OVERDUE
                    <span class="glyphicon glyphicon-chevron-down" style="font-size:14px" aria-hidden="true"></span>
                </span>
            </summary>
            <ul class="notification">
<!-----------------------------------------------------------------------------------TEXTBOOK DUE------------------------------------------------------------------------------------>
                <cfloop array="#OverdueText_Course_Array#" index="course">
                    <li>
                        <span class="Notification-Header">
                            TEXTBOOK DUE:
                            <div class="floatRight"> #course.Textbook_DueDate#</div>
                        </span>
                        <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(course.Course_ID))#">Course: #course.Course_Name#</a>
                    </li>
                </cfloop>
<!-----------------------------------------------------------------------------------CONTRACTS DUE------------------------------------------------------------------------------------>
                <cfloop array="#OverdueContract_Course_Array#" index="course">
                    <li>
                        <span class="Notification-Header">
                            CONTRACT DUE:
                            <div class="floatRight"> #course.Contract_DueDate#</div>
                        </span>
                        <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(Course.Course_ID))#">Course: #Course.Course_Name#</a>
                    </li>
                </cfloop>
<!-----------------------------------------------------------------------------------OWL SITE DUE------------------------------------------------------------------------------------>
                <cfloop array="#OverdueOWL_Course_Array#" index="course">
                    <li>
                        <span class="Notification-Header">
                            OWL DUE:
                            <div class="floatRight"> #course.OWL_DueDate#</div>
                        </span>
                        <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(Course.Course_ID))#">Course: #Course.Course_Name#</a>
                    </li>
                </cfloop>
 <!------------------------------------------------------------------------------------OUTLINE DUE------------------------------------------------------------------------------------>
                <cfloop array="#OverdueCourseOutline_Course_Array#" index="course">
                    <li>
                        <span class="Notification-Header">
                            COURSE OUTLINE DUE:
                            <div class="floatRight"> #course.CourseOutline_DueDate#</div>
                        </span>
                        <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(Course.Course_ID))#">Course: #Course.Course_Name#</a>
                    </li>
                </cfloop>
<!------------------------------------------------------------------------------------EVALUATION REMINDER DUE------------------------------------------------------------------------------------>
                <cfloop array="#OverdueReminder_Course_Array#" index="course">
                    <li>
                        <span class="Notification-Header">
                            SURVEY REMINDER DUE:
                            <div class="floatRight"> #course.Reminder_DueDate#</div>
                        </span>
                        <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(course.Course_ID))#">Course: #course.Course_Name#</a>
                    </li>
                </cfloop>
<!------------------------------------------------------------------------------------EVALUATION DUE--------------------------------------------------------------------------------->
                <cfloop array="#OverdueEvaluation_Course_Array#" index="course">
                    <li>
                        <span class="Notification-Header">
                            SURVEY DUE:
                            <div class="floatRight"> #course.Evaluation_DueDate#</div>
                        </span>
                        <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(course.Course_ID))#">Course: #Course.Course_Name#</a>
                    </li>
                </cfloop>
<!-------------------------------------------------------------------------------------GRADES DUE------------------------------------------------------------------------------------>
                <cfloop array="#OverdueGrades_Course_Array#" index="course">
                    <li>
                        <span class="Notification-Header">
                            GRADES DUE:
                            <div class="floatRight"> #course.Grades_DueDate#</div>
                        </span>
                        <a href="course_details.cfm?CourseID=#URLEncodedFormat(TRIM(course.Course_ID))#">Course: #course.course_Name#</a>
                    </li>
                </cfloop>

            </ul>
        </details>
    </div>

    </cfoutput>

    <div id="main">
        <button type=button class="openbtn" onclick="openNav(); return false;">&#9776;</button>
    </div>

</body>
</html>

