<cfinclude template="includes/header.cfm">
     
<cfparam name="URL.instructor_exists" default="false">

<cfquery datasource="WCSTracking" name="InstructorInfo_Query">
    SELECT ID, Instructor_Name, Instructor_Email, Instructor_New
    FROM Instructors
    WHERE Instructor_Status = 'active'
</cfquery>

<cfquery datasource="WCSTracking" name="CurrentInstructorInfo_Query">
    SELECT Instructor_Name, Instructor_Email, Instructor_New
    FROM Instructors
    JOIN Course ON Instructors.ID = Course.Instructor_ID
    WHERE Course.ID = '#URL.CourseID#'
</cfquery>

<cfoutput>

    <div class="alert alert-danger" role="alert" <cfif #URL.instructor_exists# EQ 'true'>style="display: block"<cfelse>style="display:none"</cfif>>
        <strong>ERROR!</strong> Instructor Already Exists in Database
    </div>

    <cfform action="UpdateCourseInstructorAction.cfm">

        <input type="hidden" name="CourseID" value="#URL.CourseID#">
        <input type="hidden" name="OldInstructorName" value="#CurrentInstructorInfo_Query.Instructor_Name#">

        <div class="pageTitle">
            <div class="floatRight">
                <a href="Course_Details.cfm?CourseID=#URLEncodedFormat(URL.CourseID)#">SKIP >>></a>
            </div>
            <div class="orange floatLeft">
                <a href="clearCourseInstructor.cfm?CourseID=#URLEncodedFormat(URL.CourseID)#">REMOVE INSTRUCTOR X</a>
            </div>
            <h3>Update Course Instructor</h3>
        </div>

        <div class="advSearch">
            <label>Instructor Name:</label>
            <input type="text"
                   name="InstructorName_TextBoxUPD"
                   required
                   size="30"
                   maxlength="50"
                   autocomplete="off"
                   value="#CurrentInstructorInfo_Query.Instructor_Name#">

            <label>Instructor Email:</label>
            <input type="text"
                   name="InstructorEmail_TextBoxUPD"
                   size="30"
                   maxlength="50"
                   autocomplete="off"
                   value="#CurrentInstructorInfo_Query.Instructor_Email#">

            <label>New/Returning:</label>
            <div class="floatLeft">
                <input type="radio" value="1" name="InstructorNew_RadioBoxUPD" <cfif #CurrentInstructorInfo_Query.Instructor_New# EQ 1>checked</cfif> required > New
                <input type="radio" value="0" name="InstructorNew_RadioBoxUPD"<cfif #CurrentInstructorInfo_Query.Instructor_New# EQ 0>checked</cfif>> Returning
            </div>

            <label>  </label>
        </div>

        <button type="submit" id="submitBtn">Submit</button>
    </cfform>

    <label></label>

    <cfform action="UpdateCourseInstructorAction2.cfm">

        <input type="hidden" name="CourseID" value="#URL.CourseID#">

        <div class="pageTitle">
            <h3>Or Select an Existing Instructor</h3>
        </div>

        <div class="results-Table">
            <table>
                <tr>
                    <td width="7%"><strong></strong></td>
                    <td width="7%"><strong>ID</strong></td>
                    <td width="10%"><strong>New/Returning</strong></td>
                    <td><strong>Instrucotr Name</strong></td>
                    <td><strong>Instructor Email</strong></td>
                </tr>
                <cfloop query="InstructorInfo_Query">
                    <tr>
                        <td><input type="radio" name="ExistingInstructor_RadioBoxUPD" value="#InstructorInfo_Query.ID#" required></td>
                        <td>#InstructorInfo_Query.ID#</td>
                        <td><cfif #InstructorInfo_Query.Instructor_New# EQ 1><strong>New</strong><cfelse>Returning</cfif>
                        <td>#InstructorInfo_Query.Instructor_Name#</td>
                        <td><cfinvoke component="Functions"
                                      method="StringNullChecker"
                                      value="#InstructorInfo_Query.Instructor_Email#">
                        </td>
                    </tr>
                </cfloop>
            </table>
        </div>

        <button type="submit" id="submitBtn">Submit</button>
    </cfform>

</cfoutput>
<cfinclude template="includes/footer.cfm">