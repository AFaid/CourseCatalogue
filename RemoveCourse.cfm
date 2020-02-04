<!---
Name: Ahmed Faid
Description: Removes course and corresponding checklist from database.
--->

<cfquery datasource="WCSTracking" name="CourseInfo_Query">
    SELECT Course_Name from Course
    WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar">
</cfquery>

<!---Creates a copy of course in deleted textbook page for potential recovery--->
<cfquery datasource="WCSTracking" name="CourseBackupCopy_Query">
    INSERT INTO deleted_course(ID, Course_Type, Course_Code, Course_Name, Section, Delivery, Course_Days,
        Course_Start, Course_End, Text_Required, OWL_Required, Textbook_ISBN,
        Course_Evaluation, Start_Time, End_Time, Contract_Due, Text_Due, Owl_Due, Instructor_ID,
        CourseOutline_Due, Reminder_Due, Evaluation_Due, Grades_Due)

    SELECT ID, Course_Type, Course_Code, Course_Name, Section, Delivery, Course_Days,
        Course_Start, Course_End, Text_Required, OWL_Required, Textbook_ISBN,
        Course_Evaluation, Start_Time, End_Time, Contract_Due, Text_Due, OWL_Due, Instructor_ID,
        CourseOutline_Due, Reminder_Due, Evaluation_Due, Grades_Due
    FROM Course
    WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar">
</cfquery>

<!--Deletes course from database--->
<cfquery datasource="WCSTracking" name="DeleteCourse_Query">
    DELETE FROM COURSE
    WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar"> 
</cfquery>

<!--Deletes course's corresponding checklist from database--->
<cfquery datasource="WCSTracking" name="DeleteCourseChecklist_Query">    
    DELETE FROM COURSECHECKLIST
    WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar">
</cfquery>

<!---sets course backup delete date and permanent delete date 3 days later--->
<cfquery datasource="WCSTracking" name="CourseDateDeleted_Query">
    UPDATE deleted_course 
    SET day_Deleted = GETDATE(), 
        recovery_Deadline = DATEADD(week, 1, GETDATE())
    WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar"> AND day_Deleted is null
</cfquery>

<cflocation url="SearchAction.cfm?Course_Name=#URLEncodedFormat(TRIM(CourseInfo_Query.Course_Name))#&course_removed=#URLEncodedFormat('true')#">

