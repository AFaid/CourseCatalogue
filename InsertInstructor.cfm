<cfinclude template="includes/header.cfm">
     
<cfparam name="URL.instructor_exists" default="false">

<cfquery datasource="WCSTracking" name="InstructorInfo_Query">
    SELECT ID, Instructor_Name, Instructor_Email, Instructor_New
    FROM Instructors
    WHERE Instructor_Status = 'active'
</cfquery>

<cfquery datasource="WCSTracking" name="TextRequired_Query">
    SELECT Text_Required
    FROM Course
    WHERE ID = '#URL.CourseID#'
</cfquery>

<cfoutput>

    <div <cfif #URL.instructor_exists# EQ 'true'>class="alert alert-danger" role="alert" <cfelse>class="hide"</cfif>>
        <strong>ERROR!</strong> Instructor Already Exists in Database
    </div>

    <cfform action="InsertInstructorAction.cfm">

        <input type="hidden" name="CourseID" value="#URL.CourseID#">

        <div class="pageTitle">
            <div class="floatRight">
                <cfif #textRequired_Query.Text_Required# eq "yes">
                    <a href="insertTextbook.cfm?CourseID=#URLEncodedFormat(URL.CourseID)#">SKIP >>></a>
                    <cfelse>
                        <a href="insert.cfm?added=#URLEncodedFormat(1)#">SKIP >>></a>
                </cfif>
            </div>
            <h3>Add Instructor</h3>
        </div>

        <div class="advSearch">
            <label>Instructor Name:</label>
            <input type="text"
                   name="InstructorName_TextBoxINS"
                   required
                   size="30"
                   maxlength="50"
                   autocomplete="off">

            <label>Instructor Email:</label>
            <input type="text"
                   name="InstructorEmail_TextBoxINS"
                   size="30"
                   maxlength="50"
                   autocomplete="off">

            <label>New/Returning:</label>
            <div class="floatLeft">
                <input type="radio" value="1" name="InstructorNew_RadioBoxINS" checked> New
                <input type="radio" value="0" name="InstructorNew_RadioBoxINS"> Returning
            </div>

            <label>  </label>
        </div>

        <button type="submit" id="submitBtn">Submit</button>
    </cfform>

    <label></label>

    <cfform action="InsertInstructorAction2.cfm">

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
                        <td><input type="radio" name="ExistingInstructor_RadioBoxINS" value="#InstructorInfo_Query.ID#" required></td>
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