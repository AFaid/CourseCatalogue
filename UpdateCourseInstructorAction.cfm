<!---checks if instructor exists--->
<cfquery datasource="WCSTracking" name="InstructorCheck_Query">
    SELECT Instructor_Name, ID
    FROM Instructors
    WHERE Instructor_Name = <cfqueryparam value="#FORM.InstructorName_TextBoxUPD#" cfsqltype="cf_sql_varchar"> AND Instructor_Status = 'active' 
</cfquery>

<!---If instructor's name does not change update same instructor information--->
<cfif FORM.InstructorName_TextBoxUPD EQ FORM.OldInstructorName AND InstructorCheck_Query.RecordCount EQ 1>

    <cfquery datasource="WCSTracking" name="UpdateInstructor_Query">
        UPDATE Instructors
        SET Instructor_Email = <cfqueryparam value="#FORM.InstructorEmail_TextBoxUPD#" cfsqltype="cf_sql_varchar">,
            Instructor_New = <cfqueryparam value="#FORM.InstructorNew_RadioBoxUPD#" cfsqltype="cf_sql_bit">
        WHERE Instructor_Name = <cfqueryparam value="#FORM.OldInstructorName#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cflocation url="Course_Details.cfm?CourseID=#URLEncodedFormat(FORM.CourseID)#">

<cfelseif FORM.InstructorName_TextBoxUPD NEQ "" AND InstructorCheck_Query.RecordCount EQ 0>

     <cfquery datasource="WCSTracking" name="InsertNewInstructor_Query">
         INSERT INTO Instructors (Instructor_Name, Instructor_Email, Instructor_New, Instructor_Status)
         VALUES ( <cfqueryparam value="#FORM.InstructorName_TextBoxUPD#" cfsqltype="cf_sql_varchar">,
                  <cfqueryparam value="#FORM.InstructorEmail_TextBoxUPD#" cfsqltype="cf_sql_varchar">,
                  <cfqueryparam value="#FORM.InstructorNew_RadioBoxUPD#" cfsqltype="cf_sql_bit">,
                  'Active')
    </cfquery>

    <cfquery datasource="WCSTracking" name="instructorID_Query">
        SELECT ID FROM Instructors
        WHERE Instructor_Name = '#FORM.InstructorName_TextBoxUPD#'
        AND Instructor_Email = '#FORM.InstructorEmail_TextBoxUPD#'
    </cfquery>

    <!---Link new instructor to the new course--->
    <cfquery datasource="WCSTracking" name="LinkInstructor_Query">
        UPDATE Course
        SET Instructor_ID = #instructorID_Query.ID#
        WHERE ID = '#FORM.CourseID#'
    </cfquery>

    <cflocation url="Course_Details.cfm?CourseID=#URLEncodedFormat(FORM.CourseID)#">

<cfelseif InstructorCheck_Query.RecordCount GT 0 AND FORM.InstructorName_TextBoxUPD NEQ FORM.OldInstructorName>

    <cflocation url="UpdateCourseInstructor.cfm?instructor_exists=#URLEncodedFormat('true')#&CourseID=#URLEncodedFormat(FORM.CourseID)#">
    
</cfif>