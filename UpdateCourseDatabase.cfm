<!--Name: Ahmed Faid
    Date: June 5th 2019
    Description: Updates Course Information-->

<cfparam name="URL.course_exists" default="false">

<!---Gets Course information to popullate course form fields--->
<cfquery datasource="WCSTracking" name="CourseInfo_Query">
    SELECT ID, Course_Type, Course_Code, Course_Name, Section, Delivery, Course_Days,
    Course_Start, Course_End, Text_Required, OWL_Required, Instructor_ID,
    Course_Evaluation, Start_Time, End_Time

    FROM Course
    WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar">
</cfquery>

<!---Gets Course information to popullate instructor form fields--->
<cfquery datasource="WCSTracking" name="InstructorInfo_Query">
    SELECT Instructor_Name, Instructor_Email
    FROM Instructors
    <cfif #CourseInfo_Query.Instructor_ID# NEQ "">
        WHERE ID = #CourseInfo_Query.Instructor_ID#
    <cfelse>
        WHERE 0=1
    </cfif>
</cfquery>
    
    <cfinvoke component="functions"
              method="TimeNullChecker2"
              returnvariable="OldStartTime"
              value="#CourseInfo_Query.Start_Time#">

    <cfinvoke component="functions"
              method="TimeNullChecker2"
              returnvariable="OldEndTime"
              value="#CourseInfo_Query.End_Time#">

<cfinclude template="includes/header.cfm">


<div class="alert alert-danger" role="alert" <cfif #URL.course_exists# EQ 'true'>style="display: block"<cfelse>style="display:none"</cfif>>
   <strong>ERROR!</strong> Course Already Exists in Database
</div>

    <div class="pageTitle">
        <cfoutput>
            <h3>Update #CourseInfo_Query.Course_Name#</h3>
        </cfoutput>
    </div>

    <div class="advSearch">
        <cfoutput>
        <cfform action="UpdateAction.cfm">

            <input type="hidden" name="courseKey_hidden" value="#CourseInfo_Query.ID#">

            <!--Switch statement to check value for course type-->
            <cfswitch expression="#CourseInfo_Query.Course_Type#">
                <cfcase value="public interest">
                    <cfset publicInterest_Checked = "checked">
                    <cfset languages_Checked ="unchecked">
                    <cfset postDegree_Checked="unchecked">
                    <cfset partnership_Checked="unchecked">
                </cfcase>
                <cfcase value="languages">
                    <cfset publicInterest_Checked = "unchecked">
                    <cfset languages_Checked ="checked">
                    <cfset postDegree_Checked="unchecked">
                    <cfset partnership_Checked="unchecked">
                </cfcase>
                <cfcase value="post degree">
                    <cfset publicInterest_Checked = "unchecked">
                    <cfset languages_Checked ="unchecked">
                    <cfset postDegree_Checked="checked">
                    <cfset partnership_Checked="unchecked">
                </cfcase>
                <cfcase value="partnership">
                    <cfset publicInterest_Checked="unchecked">
                    <cfset languages_Checked ="unchecked">
                    <cfset postDegree_Checked="unchecked">
                    <cfset partnership_Checked="checked">
                </cfcase>
            </cfswitch>

            <label>Course Type</label>
            <input type="radio" name="courseType_RadioBoxUPD" value="public interest" #publicInterest_Checked#>Public Interest
            <input type="radio" name="courseType_RadioBoxUPD" value="languages" #languages_checked#>Languages
            <input type="radio" name="courseType_RadioBoxUPD" value="post degree" #postDegree_checked#>Post Degree
            <input type="radio" name="courseType_RadioBoxUPD" value="partnership" #partnership_checked#>Partnership

            <label>Course Code:</label>
            <input type="text"
                   name="courseCode_TextBoxUPD"
                   required
                   pattern="[A-Za-z]{4}[0-9]{4}"
                   title="4 letters 4 digits"
                   autocomplete="off"
                   minlength="8"
                   maxlength="8"
                   value="#Trim(CourseInfo_Query.Course_Code)#">

            <label>Course Name:</label>
            <input type="text"
                   name="courseName_TextBoxUPD"
                   required
                   size="30"
                   maxlength="50"
                   autocomplete="off"
                   value="#Trim(CourseInfo_Query.Course_Name)#">

            <input type="hidden" name="CourseID" value="#CourseInfo_Query.ID#">

            <label>Section</label>
            <input type="text"
                   name="section_TextBoxUPD"
                   required
                   maxlength="3"
                   pattern="[0-9]{3}"
                   title="3 digits"
                   autocomplete="off"
                   value="#Trim(CourseInfo_Query.Section)#">

            <label>Days:</label>
                <input type="checkbox" name="days_CheckboxUPD" value="Monday" <cfif FindNoCase("monday", #CourseInfo_Query.Course_Days#) NEQ 0>Checked</cfif>>Monday
                <input type="checkbox" name="days_CheckboxUPD" value="Tuesday"<cfif FindNoCase("tuesday", #CourseInfo_Query.Course_Days#) NEQ 0>Checked</cfif>>Tuesday
                <input type="checkbox" name="days_CheckboxUPD" value="Wednesday"<cfif FindNoCase("wednesday", #CourseInfo_Query.Course_Days#) NEQ 0>Checked</cfif>>Wednesday
                <input type="checkbox" name="days_CheckboxUPD" value="Thursday"<cfif FindNoCase("thursday", #CourseInfo_Query.Course_Days#) NEQ 0>Checked</cfif>>Thursday
                <input type="checkbox" name="days_CheckboxUPD" value="Friday"<cfif FindNoCase("friday", #CourseInfo_Query.Course_Days#) NEQ 0>Checked</cfif>>Friday
                <input type="checkbox" name="days_CheckboxUPD" value="Saturday"<cfif FindNoCase("saturday", #CourseInfo_Query.Course_Days#) NEQ 0>Checked</cfif>>Saturday
                <input type="checkbox" name="days_CheckboxUPD" value="Sunday"<cfif FindNoCase("sunday", #CourseInfo_Query.Course_Days#) NEQ 0>Checked</cfif>>Sunday


            <label>Course Delivery Type:</label>
            <select name="Delivery_SelectBoxUPD" id="Delivery_SelectBoxUPD" required>
                <option value="inclass" <cfif #CourseInfo_Query.delivery# EQ "inclass"> selected </cfif>>In Class
                <option value="online"<cfif #CourseInfo_Query.delivery# EQ "online"> selected </cfif>>Online
                <option value="blended"<cfif #CourseInfo_Query.delivery# EQ "blended"> selected </cfif>>Blended
                <option value="workshop"<cfif #CourseInfo_Query.delivery# EQ "workshop"> selected </cfif>>Workshop
            </select>
            
            <div class="floatLeft">
                <label>Course Start</label>
                <input type="date" name="startDate_DateBoxUPD" value="#CourseInfo_Query.Course_Start#">
            </div>

            <div class="floatLeft">
                <label>Course End</label>
                <input type="date" name="endDate_DateBoxUPD" value="#CourseInfo_Query.Course_End#">
            </div>

            <div class="floatLeft">
                <label>Start Time</label>
                <input type="time" name="startTime_TimeBoxUPD" value="#OldStartTime#">
            </div>

            <div class="floatLeft">
                <label>End Time</label>
                <input type="time" name="endTime_TimeBoxUPD" value="#OldEndTime#">
            </div>

            <!--Switch statement to check value for course evaluation-->
            <cfswitch expression="#CourseInfo_Query.Course_Evaluation#">
                <cfcase value="grades">
                    <cfset Grades_Checked = "Checked">
                    <cfset Attendance_Checked ="Unchecked">
                    <cfset both_Checked="Unchecked">
                </cfcase>
                <cfcase value="attendance">
                    <cfset Grades_Checked = "Unchecked">
                    <cfset Attendance_Checked ="checked">
                    <cfset both_Checked="Unchecked">
                </cfcase>
                <cfcase value="both">
                    <cfset Grades_Checked = "Unchecked">
                    <cfset Attendance_Checked ="Unchecked">
                    <cfset both_Checked="checked">
                </cfcase>
            </cfswitch>
        
            <label>Course Evaluation:</label>
            <input type="radio" name="courseEvaluation_RadioBoxUPD" value="grades" #Grades_Checked#>grades
            <input type="radio" name="courseEvaluation_RadioBoxUPD" value="attendance" #Attendance_Checked#>attendance
            <input type="radio" name="courseEvaluation_RadioBoxUPD" value="both" #both_Checked#>both

            <!--Switch statement to check value for text requirement-->
            <cfswitch expression="#CourseInfo_Query.Text_Required#">
                <cfcase value="yes">
                    <cfset yesText_Checked = "Checked">
                    <cfset noText_Checked ="Unchecked">
                </cfcase>
                <cfcase value="no">
                    <cfset yesText_Checked = "unChecked">
                    <cfset noText_Checked ="checked">
                </cfcase>
            </cfswitch>

            <label>Textbook Required:</label>
            <input type="radio" name="textbook_RadioBoxUPD" value="yes" <cfif #CourseInfo_Query.Text_Required# eq 'yes'>checked</cfif>> Yes
            <input type="radio" name="textbook_RadioBoxUPD" value="no" <cfif #CourseInfo_Query.Text_Required# eq 'no'>checked</cfif>> No
            <input type="radio" name="textbook_RadioBoxUPD" value="TBA" <cfif #CourseInfo_Query.Text_Required# eq 'TBA'>checked</cfif>> TBA

            <label>OWL Required:</label>
            <input type="radio" name="owlReq_RadioBoxUPD" value="BlankSite" <cfif #CourseInfo_Query.Owl_Required# eq 'BlankSite'> checked </cfif>> Blank Site
            <input type="radio" name="owlReq_RadioBoxUPD" value="CopySite" <cfif #CourseInfo_Query.Owl_Required# eq 'copySite'> checked </cfif>> Copy Previous Site
            <input type="radio" name="owlReq_RadioBoxUPD" value="no" <cfif #CourseInfo_Query.Owl_Required# eq 'no'> checked </cfif>> No
            <input type="radio" name="owlReq_RadioBoxUPD" value="TBA" <cfif #CourseInfo_Query.Owl_Required# eq 'TBA'> checked </cfif>> TBA

        </div>
            
            <button type="submit" id="submitBtn">Submit</button>

    </cfform>
    </cfoutput>


<cfinclude template="includes/footer.cfm">

