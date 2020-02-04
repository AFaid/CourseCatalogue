<!---
Name: Ahmed Faid
Description: Recovers Deleted Courses
 --->

<!---Check for course with the same ID--->
<cfquery datasource="WCSTracking" name="checkCopy_Query">
    SELECT ID FROM Course
    WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar">
</cfquery>

<!---If a course is found with the same ID delete it and add it to the deleted course table--->
<cfif #checkCopy_Query.RecordCount# GT 0>

    <!---Create a backup copy of the course with the same id--->
    <cfquery datasource="WCSTracking" name="DuplicateBackupCopy_Course">
        INSERT INTO Deleted_Course (ID, Course_Type, Course_Code, Course_Name, Section, Delivery, Course_Days,
            Course_Start, Course_End, Text_Required, OWL_Required, Textbook_ISBN,
            Course_Evaluation, Start_Time, End_Time, Contract_Due, Text_Due, Owl_Due, Instructor_ID,
            CourseOutline_Due, Reminder_Due, Evaluation_Due, Grades_Due)
        SELECT ID, Course_Type, Course_Code, Course_Name, Section, Delivery, Course_Days,
            Course_Start, Course_End, Text_Required, OWL_Required, Textbook_ISBN,
            Course_Evaluation, Start_Time, End_Time, Contract_Due, Text_Due, Owl_Due, Instructor_ID,
            CourseOutline_Due, Reminder_Due, Evaluation_Due, Grades_Due
        FROM Course
        WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <!---delete the course with the same id--->
    <cfquery datasource="WCSTracking" name="DeleteDuplicatCourse_Query">
        DELETE FROM Course
        WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar">
    </cfquery>

</cfif>

<!---Recover the course and its corresponding checklist and add it to the course table--->
<cfquery datasource="WCSTracking" name="recoverCourse_Query">
    INSERT INTO Course (ID, Course_Type, Course_Code, Course_Name, Section, Delivery, Course_Days,
        Course_Start, Course_End, Text_Required, OWL_Required, Textbook_ISBN,
        Course_Evaluation, Start_Time, End_Time, Contract_Due, Text_Due, Owl_Due, Instructor_ID,
        CourseOutline_Due, Reminder_Due, Evaluation_Due, Grades_Due)
    SELECT ID, Course_Type, Course_Code, Course_Name, Section, Delivery, Course_Days,
        Course_Start, Course_End, Text_Required, OWL_Required, Textbook_ISBN,
        Course_Evaluation, Start_Time, End_Time, Contract_Due, Text_Due, Owl_Due, Instructor_ID,
        CourseOutline_Due, Reminder_Due, Evaluation_Due, Grades_Due
    FROM Deleted_Course
    WHERE Number = <cfqueryparam value="#URL.Number#" cfsqltype="cf_sql_integer">
</cfquery>

<!---Delete the backup copy after course has been recovered--->
<cfquery datasource="WCSTracking" name="DeleteCourseBackupCopy_Query">
    DELETE FROM Deleted_Course
    WHERE Number = <cfqueryparam value="#URL.Number#" cfsqltype="cf_sql_integer">
</cfquery>

<!---Creates a checklist for the recovered course--->
<cfquery datasource="WCSTracking" name="CreateChecklist_Query">
    INSERT INTO CourseChecklist(ID) VALUES('#URL.CourseID#')
</cfquery>


<cflocation url="deleted.cfm">
