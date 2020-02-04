 <!---Checks if instructor exists based on name--->
    <cfquery datasource="WCSTracking" name="InstructorCheck_Query">
        SELECT Instructor_Name, ID
        FROM Instructors
        WHERE Instructor_Name = '#Trim(FORM.InstructorName_TextBoxINS)#' AND Instructor_Status='Active'
    </cfquery>
    
    <!---If no ACTIVE instructors exist with that name and the form field is not empty add new instructor to database--->
    <cfif InstructorCheck_Query.RecordCount EQ 0 AND FORM.InstructorName_TextBoxINS NEQ "">
        <cfquery datasource="WCSTracking" name ="AddNewInstructor_Query">
            INSERT INTO Instructors(Instructor_Email, Instructor_Name, Instructor_New, Instructor_Status)
            VALUES( '#FORM.InstructorEmail_TextBoxINS#',
            '#FORM.InstructorName_TextBoxINS#', #FORM.InstructorNew_RadioBoxINS#, 'active')
        </cfquery>

        <!---Get new instructors ID--->
        <cfquery datasource="WCSTracking" name="instructorID_Query">
            SELECT ID FROM Instructors
            WHERE Instructor_Name = '#FORM.InstructorName_TextBoxINS#'
            AND Instructor_Email = '#FORM.InstructorEmail_TextBoxINS#'
        </cfquery>

        <!---Link new instructor to the new course--->
        <cfquery datasource="WCSTracking" name="LinkInstructor_Query">
            UPDATE Course
            SET Instructor_ID = #instructorID_Query.ID#
            WHERE ID = '#FORM.CourseID#'
        </cfquery>
    
        <cfquery datasource="WCSTracking" name="TextRequired_Query">
            SELECT Text_Required
            FROM Course
            WHERE ID = '#FORM.CourseID#'
        </cfquery>

        <cfdump var="#TextRequired_Query#">

        <cfif #TextRequired_Query.Text_Required# eq 'yes'>
            <cflocation url="insertTextbook.cfm?CourseID=#URLEncodedFormat(TRIM(FORM.CourseID))#">
        <cfelse>
            <cflocation url="insert.cfm?added=#URLEncodedFormat(1)#">
        </cfif>

    <!---if an active instructor already exists link new course to the instructor--->
    <cfelse>
        <cflocation url="InsertInstructor.cfm?instructor_exists=#URLEncodedFormat('true')#&CourseID=#URLEncodedFormat(TRIM('FORM.CourseID'))#">
    </cfif>


