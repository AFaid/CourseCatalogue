<!---
Name:			Insert Screen
Author:			Ahmed Faid
Description: 	Insert new course in the database
Created:		May 23rd
--->

<cfparam name="URL.added" default="0">
<cfparam name="URL.course_exists" default="false">

<cfinclude template="includes/header.cfm">
<cfinclude template="includes/sidebar.cfm">

<div <cfif #URL.added# EQ 1>class="alert alert-success" role="alert" <cfelse>class="hide"</cfif>>
   <strong>SUCCESS!</strong> Course Added to Database
</div>

<div <cfif #URL.course_exists# EQ 'true'>class="alert alert-danger" role="alert" <cfelse>class="hide"</cfif>>
   <strong>ERROR!</strong> Course Already Exists in Database
</div>


<div class="pageTitle">
    <h3>Add Course</h3>
</div>

<div class="advSearch">
        <cfform action="InsertAction.cfm">

        <label>Course Type:</label>
        <input type="radio" name="courseType_RadioBoxINS" value="public interest" checked>Public Interest
        <input type="radio" name="courseType_RadioBoxINS" value="languages">Languages
        <input type="radio" name="courseType_RadioBoxINS" value="post degree">Post Degree
        <input type="radio" name="courseType_RadioBoxINS" value="partnership">Partnership

        <label>Course Code:</label>
        <input type="text"
                name="courseCode_TextBoxINS"
                required
                pattern="[A-Za-z]{4}[0-9]{4}"
                title="4 letters 4 digits"
                autocomplete="off"
                minlength="8"
                maxlength="8">

        <label>Course Name:</label>
        <input type="text"
                name="courseName_TextBoxINS"
                required
                size="30"
                maxlength="50"
                autocomplete="off">

        <label>Section</label>
        <input type="text"
                name="section_TextBoxINS"
                required
                maxlength="3"
                pattern="[0-9]{3}"
                title="3 digits"
                autocomplete="off">

        <label>Days:</label>
        <input type="checkbox" name="days_CheckboxINS" value="Monday">Monday
        <input type="checkbox" name="days_CheckboxINS" value="Tuesday">Tuesday
        <input type="checkbox" name="days_CheckboxINS" value="Wednesday">Wednesday
        <input type="checkbox" name="days_CheckboxINS" value="Thursday">Thursday
        <input type="checkbox" name="days_CheckboxINS" value="Friday">Friday
        <input type="checkbox" name="days_CheckboxINS" value="Saturday">Saturday
        <input type="checkbox" name="days_CheckboxINS" value="Sunday">Sunday

        <label>Course Delivery Type:</label>
        <select name="Delivery_SelectBoxINS" id="Delivery_SelectBoxINS">
            <option value="inclass" SELECTED>In Class
            <option value="online">Online
            <option value="blended">Blended
            <option value="workshop">Workshop
        </select>

        <div class="floatLeft">
            <label>Course Start</label>
            <input type="date" name="startDate_DateBoxINS">
        </div>

        <div class="floatLeft">
            <label>Course End</label>
            <input type="date" name="endDate_DateBoxINS">
        </div>

        <div class="floatLeft">
            <label>Start Time</label>
            <input type="time" name="startTime_TimeBoxINS">
        </div>

        <div class="floatLeft">
            <label>End Time</label>
            <input type="time" name="endTime_TimeBoxINS">
        </div>

        <label>Course Evaluation:</label>
        <input type="radio" name="courseEvaluation_RadioBoxINS" value="grades" CHECKED>grades
        <input type="radio" name="courseEvaluation_RadioBoxINS" value="attendance">attendance
        <input type="radio" name="courseEvaluation_RadioBoxINS" value="both">both

        <label>Textbook Required:</label>
        <input type="radio" name="textbook_RadioBoxINS" value="yes" CHECKED> Yes
        <input type="radio" name="textbook_RadioBoxINS" value="no"> No
        <input type="radio" name="textbook_RadioBoxINS" value="TBA"> TBA

        <label>OWL:</label>
        <input type="radio" name="owlReq_RadioBoxINS" value="BlankSite" CHECKED> Blank Site
        <input type="radio" name="owlReq_RadioBoxINS" value="CopySite"> Copy Previous Site
        <input type="radio" name="owlReq_RadioBoxINS" value="no"> Not Required
        <input type="radio" name="owlReq_RadioBoxINS" value="TBA"> TBA

</div>

        <input type="submit" name="submit_ButtonIns" id="submitBtn">

</cfform>

<cfinclude template="includes/footer.cfm">
