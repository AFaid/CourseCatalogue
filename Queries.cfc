
<cfcomponent>

 <!---Pulls all DISTINCT course names from course table--->
    <cffunction name="CourseName_Getter" hint="Distinct Course Names">
    
        <cfquery datasource="WCSTracking" name="CourseName_Query">
            SELECT DISTINCT Course_Name
            FROM Course
        </cfquery>

        <cfset CourseName_Array=ArrayNew(1)>

        <cfloop query="CourseName_Query">
            <cfset ArrayAppend(CourseName_Array, CourseName_Query.Course_Name)>
        </cfloop>

        <cfreturn CourseName_Array>

    </cffunction>

    <cffunction name="InstructorName_Getter" hint="returns instructor's name associated with a given instructor ID">
        
        <cfargument name="InstructorID"
                type="integer"
                required="yes">

        <cfquery datasource="WCSTracking" name="InstructorName_Query">
            SELECT Instructor_Name 
            FROM Instructors
            WHERE ID = #InstructorID#
        </cfquery>
        
        <cfoutput>
            #InstructorName_Query.Instructor_Name#
        </cfoutput>

    </cffunction>


 <!---Pulls all DISTINCT course codes from course table--->
    <cffunction name="CourseCode_Getter" hint="Distinct Course Codes">
    
        <cfquery datasource="WCSTracking" name="CourseCode_Query">
            SELECT DISTINCT Course_Code
            FROM Course
        </cfquery>

        <cfset CourseCode_Array=ArrayNew(1)>

        <cfloop query="CourseCode_Query">
            <cfset ArrayAppend(CourseCode_Array, CourseCode_Query.Course_Code)>
        </cfloop>

        <cfreturn CourseCode_Array>

    </cffunction>

 <!---Pulls all courses that have textbooks due today in course table--->
    <cffunction name="TextDueToday_Getter" hint="Returns list of courses with text due today">

        <cfquery datasource="WCSTracking" name="TextbookDeadlines_Query">
            SELECT course.ID, Text_Due, Course_Name, Title
            FROM Course INNER JOIN Textbooks
            ON Textbook_ISBN = ISBN
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.Text_Recieved = 0 AND convert(DateTime2, Text_Due) = convert(date, getDate())
                AND Text_Required = 'yes'
        </cfquery>

        <cfset TextDue_Course_Array=ArrayNew(1)>

        <cfloop query="TextbookDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#TextbookDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#TextbookDeadlines_Query.Course_Name#>
            <cfset courseStruct['Textbook_DueDate']=#TextbookDeadlines_Query.Text_Due#>
            <cfset courseStruct['Textbook_Title']=#TextbookDeadlines_Query.Title#>
            <cfset ArrayAppend(TextDue_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn TextDue_Course_Array>

    </cffunction>
    
<!---Pulls all courses that have Contracts due today in course table--->
    <cffunction name="ContractDueToday_Getter" hint="Returns list of courses with contracts due today">

        <cfquery datasource="WCSTracking" name="contractDeadlines_Query">
            SELECT course.ID, contract_Due, Course_Name
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE (CourseChecklist.contract_Recieved = 0 OR CourseChecklist.contract_Sent = 0) AND convert(DateTime2, contract_Due) = convert(date, getDate())
        </cfquery>

        <cfset contractDue_Course_Array=ArrayNew(1)>

        <cfloop query="contractDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#contractDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#contractDeadlines_Query.Course_Name#>
            <cfset courseStruct['Contract_DueDate']=#contractDeadlines_Query.contract_Due#>
            <cfset ArrayAppend(contractDue_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn contractDue_Course_Array>

    </cffunction>

<!---Pulls all courses that have Owl Sites due today in course table--->
    <cffunction name="OWLDueToday_Getter" hint="Returns list of courses with OWL Sites due today">

        <cfquery datasource="WCSTracking" name="OWLDeadlines_Query">
            SELECT course.ID, owl_Due, Course_Name
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.owl_siteCreated = 0 AND convert(DateTime2, owl_Due) = convert(date, getDate())
                AND (OWL_Required = 'Blanksite' OR OWL_Required = 'copysite');
        </cfquery>

        <cfset OWLDue_Course_Array=ArrayNew(1)>

        <cfloop query="OWLDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#OWLDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#OWLDeadlines_Query.Course_Name#>
            <cfset courseStruct['OWL_DueDate']=#OWLDeadlines_Query.OWL_Due#>
            <cfset ArrayAppend(OWLDue_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn OWLDue_Course_Array>

    </cffunction>

 <!---Pulls all courses that have course outline due today in course table--->
    <cffunction name="CourseOutlineDueToday_Getter" hint="Returns list of courses with outline due today">

        <cfquery datasource="WCSTracking" name="CourseOutlineDeadlines_Query">
            SELECT course.ID, CourseOutline_Due, Course_Name, Course_Code
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.Outline_Recieved = 0 AND convert(DateTime2, CourseOutline_Due) = convert(date, getDate())
        </cfquery>

        <cfset Outline_Course_Array=ArrayNew(1)>

        <cfloop query="CourseOutlineDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#CourseOutlineDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#CourseOutlineDeadlines_Query.Course_Name#>
            <cfset courseStruct['CourseOutline_DueDate']=#CourseOutlineDeadlines_Query.CourseOutline_Due#>
            <cfset ArrayAppend(Outline_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn Outline_Course_Array>

    </cffunction>

 <!---Pulls all courses that have course reminder due today in course table--->
    <cffunction name="ReminderDueToday_Getter" hint="Returns list of courses that have their survey reminder due today">

        <cfquery datasource="WCSTracking" name="ReminderDeadlines_Query">
            SELECT course.ID, Reminder_Due, Course_Name
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.Reminder_Sent = 0 AND convert(DateTime2, Reminder_Due) = convert(date, getDate())
        </cfquery>

        <cfset Reminder_Course_Array=ArrayNew(1)>

        <cfloop query="ReminderDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#ReminderDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#ReminderDeadlines_Query.Course_Name#>
            <cfset courseStruct['Reminder_DueDate']=#ReminderDeadlines_Query.Reminder_Due#>
            <cfset ArrayAppend(Reminder_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn Reminder_Course_Array>

    </cffunction>
    
 <!---Pulls all courses that have course evaluation due today in course table--->
    <cffunction name="EvaluationDueToday_Getter" hint="Returns list of courses that have their evaluations due today">

        <cfquery datasource="WCSTracking" name="EvaluationDeadlines_Query">
            SELECT course.ID, Evaluation_Due, Course_Name
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.Eval_Sent = 0 AND convert(DateTime2, Evaluation_Due) = convert(date, getDate())
        </cfquery>

        <cfset Evaluation_Course_Array=ArrayNew(1)>

        <cfloop query="EvaluationDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#EvaluationDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#EvaluationDeadlines_Query.Course_Name#>
            <cfset courseStruct['Evaluation_DueDate']=#EvaluationDeadlines_Query.Evaluation_Due#>
            <cfset ArrayAppend(Evaluation_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn Evaluation_Course_Array>

    </cffunction>

 <!---Pulls all courses that have course grades due today in course table--->
    <cffunction name="GradesDueToday_Getter" hint="Returns list of courses that have their Grades due today">

        <cfquery datasource="WCSTracking" name="GradesDeadlines_Query">
            SELECT course.ID, Grades_Due, Course_Name
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.GA_Added = 0 AND convert(DateTime2, Grades_Due) = convert(date, getDate())
        </cfquery>

        <cfset Grades_Course_Array=ArrayNew(1)>

        <cfloop query="GradesDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#GradesDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#GradesDeadlines_Query.Course_Name#>
            <cfset courseStruct['Grades_DueDate']=#GradesDeadlines_Query.Grades_Due#>
            <cfset ArrayAppend(Grades_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn Grades_Course_Array>

    </cffunction>

    <cffunction name="DeletedCourseInfo_Getter" hint="Returns information about deleted courses">
    
        <cfquery datasource="WCSTracking" name="DeletedCourseInfo_Query">
            SELECT Number, ID, Course_Type, Course_Code, Course_Name, Section,
                Delivery, Course_Start, Course_End, Day_Deleted
            FROM Deleted_Course
        </cfquery>

        <cfset DeletedCourse_Array=ArrayNew(1)>

        <cfloop query="DeletedCourseInfo_Query">
            <cfset deletedCourseStruct=StructNew()>
            <cfset deletedCourseStruct['deletedCourse_Number']=#DeletedCourseInfo_Query.Number#>
            <cfset deletedCourseStruct['deletedCourse_ID']=#DeletedCourseInfo_Query.ID#>
            <cfset deletedCourseStruct['deletedCourse_Type']=#DeletedCourseInfo_Query.Course_Type#>
            <cfset deletedCourseStruct['deletedCourse_Name']=#DeletedCourseInfo_Query.Course_Name#>
            <cfset deletedCourseStruct['deletedCourse_Code']=#DeletedCourseInfo_Query.Course_Code#>
            <cfset deletedCourseStruct['deletedCourse_Section']=#DeletedCourseInfo_Query.section#>
            <cfset deletedCourseStruct['deletedCourse_Delivery']=#DeletedCourseInfo_Query.delivery#>
            <cfset deletedCourseStruct['deletedCourse_EndDate']=#DeletedCourseInfo_Query.Course_End#>
            <cfset deletedCourseStruct['deletedCourse_StartDate']=#DeletedCourseInfo_Query.Course_Start#>
            <cfset deletedCourseStruct['deletedCourse_dayDeleted']=#DeletedCourseInfo_Query.day_deleted#>
            <cfset ArrayAppend(DeletedCourse_Array, deletedCourseStruct)>
        </cfloop>

        <cfreturn DeletedCourse_Array>
    
    </cffunction>

 <!---Deletes course from deletedCourses that have been removed for over 3 days--->
    <cffunction name="ClearDeletedCourse" hint="Deletes course from deletedCourses that have been removed for over 3 days">
        
        <cfquery datasource="WCSTracking" name="ClearDeletedCourse_Query">
            DELETE FROM Deleted_Course
            WHERE recovery_Deadline < getdate();
        </cfquery>

    </cffunction>
    
 <!---Gets information from database about deleted courses--->
    <cffunction name="DeletedTextbookInfo_Getter" hint="Returns information about deleted Textbooks">
    
        <cfquery datasource="WCSTracking" name="DeletedTextbookInfo_Query">
            SELECT ID, ISBN, Title, Author, Edition, Publisher
            FROM Deleted_Textbooks
        </cfquery>

        <cfset DeletedTextbook_Array=ArrayNew(1)>

        <cfloop query="DeletedTextbookInfo_Query">
            <cfset deletedTextbookStruct=StructNew()>
            <cfset deletedTextbookStruct['deletedTextbook_ID']=#DeletedTextbookInfo_Query.ID#>
            <cfset deletedTextbookStruct['deletedTextbook_ISBN']=#DeletedTextbookInfo_Query.ISBN#>
            <cfset deletedTextbookStruct['deletedTextbook_Title']=#DeletedTextbookInfo_Query.Title#>
            <cfset deletedTextbookStruct['deletedTextbook_Author']=#DeletedTextbookInfo_Query.Author#>
            <cfset deletedTextbookStruct['deletedTextbook_Edition']=#DeletedTextbookInfo_Query.Edition#>
            <cfset deletedTextbookStruct['deletedTextbook_Publisher']=#DeletedTextbookInfo_Query.Publisher#>
            <cfset ArrayAppend(DeletedTextbook_Array, deletedTextbookStruct)>
        </cfloop>

        <cfreturn DeletedTextbook_Array>
    
    </cffunction>

 <!---Deletes textbooks from deletedTextbooks that have been removed for over 3 days--->
    <cffunction name="ClearDeletedTextbook" hint="Deletes course from deletedTextbooks that have been removed for over 3 days">
        
        <cfquery datasource="WCSTracking" name="ClearDeletedTextbook_Query">
            DELETE FROM Deleted_Textbooks
            WHERE recovery_Deadline < getdate();
        </cfquery>

    </cffunction>
    
 <!---Gets information from database about deleted instructors--->
    <cffunction name="DeletedinstructorInfo_Getter" hint="Returns information about deleted instructors">
    
        <cfquery datasource="WCSTracking" name="DeletedInstructorInfo_Query">
            SELECT ID, Instructor_Name, Instructor_Email
            FROM Deleted_Instructors
        </cfquery>

        <cfset Deletedinstructor_Array=ArrayNew(1)>

        <cfloop query="DeletedinstructorInfo_Query">
            <cfset deletedinstructorStruct=StructNew()>
            <cfset deletedinstructorStruct['deletedinstructor_ID']=#DeletedinstructorInfo_Query.ID#>
            <cfset deletedinstructorStruct['deletedinstructor_Name']=#DeletedinstructorInfo_Query.Instructor_Name#>
            <cfset deletedinstructorStruct['deletedinstructor_Email']=#DeletedinstructorInfo_Query.Instructor_Email#>
            <cfset ArrayAppend(Deletedinstructor_Array, deletedinstructorStruct)>
        </cfloop>

        <cfreturn Deletedinstructor_Array>
    
    </cffunction>

 <!---Deletes instructors from deletedInstructors that have been removed for over 3 days--->
    <cffunction name="ClearDeletedInstructors" hint="Deletes course from deletedInstructors that have been removed for over 3 days">
        
        <cfquery datasource="WCSTracking" name="DeletedInstructorInfo_Query">
            DELETE FROM Deleted_Instructors
            WHERE recovery_Deadline < getdate();
        </cfquery>

    </cffunction>

<!---Returns a list of Instructor IDs--->
    <cffunction name="UpcomingTextDueDates_Getter">

        <cfquery datasource="WCSTracking" name="UpcomingTextbookDeadlines_Query">
            SELECT course.ID, Text_Due, Course_Name
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.Text_Recieved = 0 AND convert(DateTime2, Text_Due) > convert(date, getDate())
                AND convert(DateTime2, Text_Due) < convert(date, DATEADD(week, 1, getDate())) AND Text_Required = 'yes'
        </cfquery>

        <cfset UpcomingTextDue_Course_Array=ArrayNew(1)>

        <cfloop query="UpcomingTextbookDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#UpcomingTextbookDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#UpcomingTextbookDeadlines_Query.Course_Name#>
            <cfset courseStruct['Textbook_DueDate']=#UpcomingTextbookDeadlines_Query.Text_Due#>
            <cfset ArrayAppend(UpcomingTextDue_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn UpcomingTextDue_Course_Array>

    </cffunction>

<!---Pulls all courses that have Contracts due in the upcoming week from the course table--->
    <cffunction name="UpcomingContractDueDates_Getter" hint="Returns list of courses with contracts due today">

        <cfquery datasource="WCSTracking" name="UpcomingcontractDeadlines_Query">
            SELECT course.ID, contract_Due, Course_Name
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE (CourseChecklist.contract_Recieved = 0 OR CourseChecklist.contract_Sent = 0) AND convert(DateTime2, contract_Due) > convert(date, getDate())
                AND convert(DateTime2, Contract_Due) < convert(date, DATEADD(week, 1, getDate()))
        </cfquery>

        <cfset UpcomingContractDue_Course_Array=ArrayNew(1)>

        <cfloop query="UpcomingContractDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#UpcomingContractDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#UpcomingContractDeadlines_Query.Course_Name#>
            <cfset courseStruct['Contract_DueDate']=#UpcomingContractDeadlines_Query.contract_Due#>
            <cfset ArrayAppend(UpcomingContractDue_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn UpcomingContractDue_Course_Array>

    </cffunction>

<!---Pulls all courses that have Owl Sites due next week in course table--->
    <cffunction name="UpcomingOWLDueDates_Getter" hint="Returns list of courses with OWL Sites due this week">

        <cfquery datasource="WCSTracking" name="UpcomingOWLDeadlines_Query">
            SELECT course.ID, owl_Due, Course_Name
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.owl_siteCreated = 0 AND convert(DateTime2, owl_Due) > convert(date, getDate())
                AND convert(DateTime2, OWL_Due) < convert(date, DATEADD(week, 1, getDate()))
                AND (OWL_Required = 'Blanksite' OR OWL_Required = 'copysite')
        </cfquery>

        <cfset UpcomingOWLDue_Course_Array=ArrayNew(1)>

        <cfloop query="UpcomingOWLDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#UpcomingOWLDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#UpcomingOWLDeadlines_Query.Course_Name#>
            <cfset courseStruct['OWL_DueDate']=#UpcomingOWLDeadlines_Query.OWL_Due#>
            <cfset ArrayAppend(UpcomingOWLDue_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn UpcomingOWLDue_Course_Array>

    </cffunction>

    
 <!---Pulls all courses that have course outline due today in course table--->
    <cffunction name="UpcomingCourseOutlineDueDates_Getter" hint="Returns list of courses with outline due this week">

        <cfquery datasource="WCSTracking" name="UpcomingCourseOutlineDeadlines_Query">
            SELECT course.ID, CourseOutline_Due, Course_Name, Course_Code
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.Outline_Recieved = 0 AND convert(DateTime2, CourseOutline_Due) > convert(date, getDate())
                AND convert(DateTime2, CourseOutline_Due) < convert(date, DATEADD(week, 1, getDate()))
        </cfquery>

        <cfset UpcomingOutline_Course_Array=ArrayNew(1)>

        <cfloop query="UpcomingCourseOutlineDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#UpcomingCourseOutlineDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#UpcomingCourseOutlineDeadlines_Query.Course_Name#>
            <cfset courseStruct['CourseOutline_DueDate']=#UpcomingCourseOutlineDeadlines_Query.CourseOutline_Due#>
            <cfset ArrayAppend(UpcomingOutline_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn UpcomingOutline_Course_Array>

    </cffunction>

<!---Pulls all courses that have course reminder due today in course table--->
    <cffunction name="UpcomingReminderDueDates_Getter" hint="Returns list of courses that have their survey reminder due this week">

        <cfquery datasource="WCSTracking" name="UpcomingReminderDeadlines_Query">
            SELECT course.ID, Reminder_Due, Course_Name
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.Reminder_Sent = 0 AND convert(DateTime2, Reminder_Due) > convert(date, getDate())
                AND convert(DateTime2, Reminder_Due) < convert(date, DATEADD(week, 1, getDate()))
        </cfquery>

        <cfset UpcomingReminder_Course_Array=ArrayNew(1)>

        <cfloop query="UpcomingReminderDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#UpcomingReminderDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#UpcomingReminderDeadlines_Query.Course_Name#>
            <cfset courseStruct['Reminder_DueDate']=#UpcomingReminderDeadlines_Query.Reminder_Due#>
            <cfset ArrayAppend(UpcomingReminder_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn UpcomingReminder_Course_Array>

    </cffunction>

    
 <!---Pulls all courses that have course evaluation due this week from the course table--->
    <cffunction name="UpcomingEvaluationDueDates_Getter" hint="Returns list of courses that have their evaluations due this week">

        <cfquery datasource="WCSTracking" name="UpcomingEvaluationDeadlines_Query">
            SELECT course.ID, Evaluation_Due, Course_Name
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.Eval_Sent = 0 AND convert(DateTime2, Evaluation_Due) > convert(date, getDate())
                AND convert(DateTime2, Evaluation_Due) < convert(date, DATEADD(week, 1, getDate()))
        </cfquery>

        <cfset UpcomingEvaluation_Course_Array=ArrayNew(1)>

        <cfloop query="UpcomingEvaluationDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#UpcomingEvaluationDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#UpcomingEvaluationDeadlines_Query.Course_Name#>
            <cfset courseStruct['Evaluation_DueDate']=#UpcomingEvaluationDeadlines_Query.Evaluation_Due#>
            <cfset ArrayAppend(UpcomingEvaluation_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn UpcomingEvaluation_Course_Array>
    
    </cffunction>

 <!---Pulls all courses that have course grades due this week from the course table--->
    <cffunction name="UpcomingGradesDueDates_Getter" hint="Returns list of courses that have their Grades due this week">

        <cfquery datasource="WCSTracking" name="UpcomingGradesDeadlines_Query">
            SELECT course.ID, Grades_Due, Course_Name
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.GA_Added = 0 AND convert(DateTime2, Grades_Due) > convert(date, getDate())
                AND convert(DateTime2, Grades_Due) < convert(date, DATEADD(week, 1, getDate()))
        </cfquery>

        <cfset UpcomingGrades_Course_Array=ArrayNew(1)>

        <cfloop query="UpcomingGradesDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#UpcomingGradesDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#UpcomingGradesDeadlines_Query.Course_Name#>
            <cfset courseStruct['Grades_DueDate']=#UpcomingGradesDeadlines_Query.Grades_Due#>
            <cfset ArrayAppend(UpcomingGrades_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn UpcomingGrades_Course_Array>

    </cffunction>

<!---Pulls all the courses with overdue textbooks from course table--->
    <cffunction name="OverdueTextDueDates_Getter">

        <cfquery datasource="WCSTracking" name="OverdueTextbookDeadlines_Query">
            SELECT course.ID, Text_Due, Course_Name, Text_Required
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.Text_Recieved = 0 AND convert(DateTime2, Text_Due) < convert(date, getDate())
                AND Text_Required = 'yes'
        </cfquery>

        <cfset OverdueText_Course_Array=ArrayNew(1)>

        <cfloop query="OverdueTextbookDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#OverdueTextbookDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#OverdueTextbookDeadlines_Query.Course_Name#>
            <cfset courseStruct['Textbook_DueDate']=#OverdueTextbookDeadlines_Query.Text_Due#>
            <cfset ArrayAppend(OverdueText_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn OverdueText_Course_Array>

    </cffunction>

<!---Pulls all courses that have OVERDUE Contracts from the course table--->
    <cffunction name="OverdueContractDueDates_Getter" hint="Returns list of courses with contracts due today">

        <cfquery datasource="WCSTracking" name="OverduecontractDeadlines_Query">
            SELECT course.ID, contract_Due, Course_Name
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE (CourseChecklist.contract_Recieved = 0 OR CourseChecklist.contract_Sent = 0) AND convert(DateTime2, contract_Due) < convert(date, getDate())
        </cfquery>

        <cfset OverdueContract_Course_Array=ArrayNew(1)>

        <cfloop query="OverdueContractDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#OverdueContractDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#OverdueContractDeadlines_Query.Course_Name#>
            <cfset courseStruct['Contract_DueDate']=#OverdueContractDeadlines_Query.contract_Due#>
            <cfset ArrayAppend(OverdueContract_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn OverdueContract_Course_Array>

    </cffunction>

<!---Pulls all courses that have overdue Owl Sites from the course table--->
    <cffunction name="OverdueOWLDueDates_Getter" hint="Returns list of courses with OWL Sites due this week">

        <cfquery datasource="WCSTracking" name="OverdueOWLDeadlines_Query">
            SELECT course.ID, owl_Due, Course_Name, OWL_Required
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.owl_siteCreated = 0 AND convert(DateTime2, owl_Due) < convert(date, getDate())
                AND (OWL_Required = 'Blanksite' OR OWL_Required = 'copysite');
        </cfquery>

        <cfset OverdueOWL_Course_Array=ArrayNew(1)>

        <cfloop query="OverdueOWLDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#OverdueOWLDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#OverdueOWLDeadlines_Query.Course_Name#>
            <cfset courseStruct['OWL_DueDate']=#OverdueOWLDeadlines_Query.OWL_Due#>
            <cfset ArrayAppend(OverdueOWL_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn OverdueOWL_Course_Array>

    </cffunction>

<!---Pulls all courses that have overdue course outlines from the course table--->
    <cffunction name="OverdueCourseOutlineDueDates_Getter" hint="Returns list of courses with outline due this week">

        <cfquery datasource="WCSTracking" name="OverdueCourseOutlineDeadlines_Query">
            SELECT course.ID, CourseOutline_Due, Course_Name, Course_Code
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.Outline_Recieved = 0 AND convert(DateTime2, CourseOutline_Due) < convert(date, getDate())
        </cfquery>

        <cfset OverdueOutline_Course_Array=ArrayNew(1)>

        <cfloop query="OverdueCourseOutlineDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#OverdueCourseOutlineDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#OverdueCourseOutlineDeadlines_Query.Course_Name#>
            <cfset courseStruct['CourseOutline_DueDate']=#OverdueCourseOutlineDeadlines_Query.CourseOutline_Due#>
            <cfset ArrayAppend(OverdueOutline_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn OverdueOutline_Course_Array>

    </cffunction>

<!---Pulls all courses that have course reminder due today in course table--->
    <cffunction name="OverdueReminderDueDates_Getter" hint="Returns list of courses that have their survey reminder due this week">

        <cfquery datasource="WCSTracking" name="OverdueReminderDeadlines_Query">
            SELECT course.ID, Reminder_Due, Course_Name
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.Reminder_Sent = 0 AND convert(DateTime2, Reminder_Due) < convert(date, getDate())
        </cfquery>

        <cfset OverdueReminder_Course_Array=ArrayNew(1)>

        <cfloop query="OverdueReminderDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#OverdueReminderDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#OverdueReminderDeadlines_Query.Course_Name#>
            <cfset courseStruct['Reminder_DueDate']=#OverdueReminderDeadlines_Query.Reminder_Due#>
            <cfset ArrayAppend(OverdueReminder_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn OverdueReminder_Course_Array>

    </cffunction>

<!---Pulls all courses that have overdue course evaluations from the course table--->
    <cffunction name="OverdueEvaluationDueDates_Getter" hint="Returns list of courses that have their evaluations due this week">

        <cfquery datasource="WCSTracking" name="OverdueEvaluationDeadlines_Query">
            SELECT course.ID, Evaluation_Due, Course_Name
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.Eval_Sent = 0 AND convert(DateTime2, Evaluation_Due) < convert(date, getDate())
        </cfquery>

        <cfset OverdueEvaluation_Course_Array=ArrayNew(1)>

        <cfloop query="OverdueEvaluationDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#OverdueEvaluationDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#OverdueEvaluationDeadlines_Query.Course_Name#>
            <cfset courseStruct['Evaluation_DueDate']=#OverdueEvaluationDeadlines_Query.Evaluation_Due#>
            <cfset ArrayAppend(OverdueEvaluation_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn OverdueEvaluation_Course_Array>
    
    </cffunction>

<!---Pulls all courses that have overdue course grades/attendance from the course table--->
    <cffunction name="OverdueGradesDueDates_Getter" hint="Returns list of courses that have their Grades due this week">

        <cfquery datasource="WCSTracking" name="OverdueGradesDeadlines_Query">
            SELECT course.ID, Grades_Due, Course_Name
            FROM Course
            JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
            WHERE CourseChecklist.GA_Added = 0 AND convert(DateTime2, Grades_Due) < convert(date, getDate())
        </cfquery>

        <cfset OverdueGrades_Course_Array=ArrayNew(1)>

        <cfloop query="OverdueGradesDeadlines_Query">
            <cfset courseStruct=StructNew()>
            <cfset courseStruct['Course_ID']=#OverdueGradesDeadlines_Query.ID#>
            <cfset courseStruct['Course_Name']=#OverdueGradesDeadlines_Query.Course_Name#>
            <cfset courseStruct['Grades_DueDate']=#OverdueGradesDeadlines_Query.Grades_Due#>
            <cfset ArrayAppend(OverdueGrades_Course_Array, courseStruct)>
        </cfloop>

        <cfreturn OverdueGrades_Course_Array>

    </cffunction>

    <cffunction name="instructorSearch">

        <cfargument name="instructor_SearchBox"
                    type="string"
                    required="yes">
        
        <cfset instructorsID=ArrayNew(1)>

        <cfquery datasource="WCSTracking" name="instructors_Query">
            SELECT ID
            FROM Instructors
            WHERE Instructor_Name = '%#instructoe_SearchBox#%'
        </cfquery>

        <cfloop query="instructors_Query">
            <cfset InstructorStruct=StructNew()>
            <cfset InstructorStruct['ID']=#instructors_Query.ID#>
            <cfset ArrayAppend(instructorsID, InstructorStruct)>
        </cfloop>

        <cfreturn instructorsID>
    </cffunction>

</cfcomponent>


