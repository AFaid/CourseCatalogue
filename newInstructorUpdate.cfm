
<cfquery datasource="WCSTracking" name="InstructorsCourseInfo_Query">
    SELECT Instructor_ID, Course_Start, Course_End
    FROM Course
    WHERE Course_Start = (select min(Course_Start) from course as c where c.Instructor_ID = Course.Instructor_Id)
</cfquery>

<cfoutput query="InstructorsCourseInfo_Query">
    
    <cfquery datasource="WCSTracking" name="UpdateInstructors_Query">
        UPDATE Instructors
        SET Instructor_NewEnd = '#InstructorsCourseInfo_Query.Course_End#'
        WHERE ID = #InstructorsCourseInfo_Query.Instructor_ID#
    </cfquery>

    <cfquery datasource="WCSTracking" name="ChangeInstructorsStatus_Query">
        UPDATE Instructors
        SET Instructor_New = 0
        WHERE Instructor_NewEnd < getdate() AND Instructor_New = 1
    </cfquery>

</cfoutput>
