<!---
Name: Ahmed Faid
Description: Update Instructor Screen
--->

<cfquery datasource="WCSTracking" name="InstructorInfo_Query">
    SELECT Instructor_Name, Instructor_Email,Instructor_New, Instructor_Status
    FROM Instructors
    WHERE ID = <cfqueryparam value="#URL.InstructorID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfinclude template="includes/header.cfm">

    <cfoutput>

        <div class="pageTitle">
            <br><h2>Update Instructor</h2>
        </div>

        <cfform action="UpdateInstructorAction.cfm">
            <div class="advSearch">

                <input type="hidden" name="InstructorID_Hidden" value="#URL.InstructorID#">

                <div class="onoffswitch">
                    <input type="checkbox" name="InstructorStatus_CheckBoxUPD" class="onoffswitch-checkbox" id="myonoffswitch" value="Active" 
                           <cfif InstructorInfo_Query.Instructor_Status EQ 'Active'>checked</cfif>>
                    <label class="onoffswitch-label" for="myonoffswitch">
                        <span class="onoffswitch-inner"></span>
                        <span class="onoffswitch-switch"></span>
                    </label>
                </div>

                <label>Instructor Name:</label>
                <input type="text"
                       name="InstructorName_TextBoxUPD"
                       size="30"
                       maxlength="50"
                       autocomplete="off"
                       value="#InstructorInfo_Query.Instructor_Name#">

                <label>Instructor Email:</label>
                <input type="text"
                       name="InstructorEmail_TextBoxupd"
                       size="30"
                       maxlength="50"
                       autocomplete="off"
                       value="#InstructorInfo_Query.Instructor_Email#">

                <label>New/Returning:</label>
                <div class="floatLeft">
                    <input type="radio" value="1" name="InstructorNew_RadioBoxUPD" <cfif #InstructorInfo_Query.Instructor_New# EQ 1>checked</cfif>> New
                    <input type="radio" value="0" name="InstructorNew_RadioBoxUPD"<cfif #InstructorInfo_Query.Instructor_New# EQ 0>checked</cfif>> Returning
                </div>

                <label>  </label>

            </div>

            <input type="submit" name="submit_ButtonIns" id="submitBtn">
        </cfform>
    </cfoutput>

    <cfinclude template="includes/footer.cfm">
