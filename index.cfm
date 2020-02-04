 <!---
Name: Search Screen
Author:	Ahmed Faid
Description: Search through course record and display result
Created: May 23rd
--->

<!---pulls data for autocomplete suggestions for course name search--->
<cfinvoke component="Queries"
          method="CourseName_Getter"
          returnvariable="CourseName_Array">
    
<!---pulls data for autocomplete suggestions for course name search--->
<cfinvoke component="Queries"
          method="CourseCode_Getter"
          returnvariable="CourseCode_Array">


<cfinclude template="includes/header.cfm">
<cfinclude template="includes/sidebar.cfm">

<div class="pageTitle">
    <h3>Search Catalogue</h3>
    <div class="searchScreen-Nav">
        <a href="index.cfm"> Courses</a>
        <a>|</a>
        <a href="Search2.cfm"> Course Checklists</a>
    </div>
    <br>
</div>

<!---<a href="RESTful_Request.cfm">Link</a>--->

<div class="advSearch">
    <cfoutput>
    <cfform action="SearchAction.cfm">

        <label>Course Type:</label>
        <input type="radio" name="courseType_RadioBox" value="public interest"> <span class="value-option">Public Interest</span>
        <input type="radio" name="courseType_RadioBox" value="languages"><span class="value-option">Languages</span>
        <input type="radio" name="courseType_RadioBox" value="post degree"><span class="value-option">Post Degree</span>
        <input type="radio" name="courseType_RadioBox" value="partnership"><span class="value-option">Partnership</span>
        <input type="radio" name="courseType_RadioBox" value="all" checked><span class="value-option">All</span>

        <!---Course name form box--->
        <label>Course Code:</label>
        <input list="courseCode_TextBox" name="courseCode_TextBox" maxlength="8" autocomplete="off">
        <!---list of course codes for auto fill--->
        <datalist id="courseCode_TextBox">
            <cfloop array="#CourseCode_Array#" index="Course_Code">
                <option value="#Course_Code#">
            </cfloop>
        </datalist>

        <!---Course section form box--->
        <label>Course Section:</label>
        <input type="text" name="section_TextBox" autocomplete="off">

        <!---Course code form box--->
        <label>Course Name:</label>
        <input list="courseName_TextBox" name="courseName_TextBox" autocomplete="off">
        <!---list of course codes for auto fill--->
        <datalist id="courseName_TextBox">
            <option value="">
            <cfloop array="#CourseName_Array#" index="Course_Name">
                <option value="#Course_Name#">
            </cfloop>
        </datalist>

        <label>Instructor:</label>
        <input type="text" name="instructor_TextBox" autocomplete="off">

        <label>Days:</label>
        <input type="checkbox" name="days_Checkbox" value="Monday"><span class="value-option">Monday</span>
        <input type="checkbox" name="days_Checkbox" value="Tuesday"><span class="value-option">Tuesday</span>
        <input type="checkbox" name="days_Checkbox" value="Wednesday"><span class="value-option">Wednesday</span>
        <input type="checkbox" name="days_Checkbox" value="Thursday"><span class="value-option">Thursday</span>
        <input type="checkbox" name="days_Checkbox" value="Friday"><span class="value-option">Friday</span>
        <input type="checkbox" name="days_Checkbox" value="Saturday"><span class="value-option">Saturday</span>

        <!---Course Delivery type form box--->
        <label>Course Delivery Type:</label>
        <select name="Delivery_SelectBox">
            <option value="All" SELECTED>All
            <option value="inclass">In Class
            <option value="online">Online
            <option value="blended">Blended
            <option value="workshop">Workshop
        </select>

        <!---Course start date form box--->
        <div class="floatLeft">
            <label>Course Start</label>
            <input type="date" name="startDate_DateBox">
        </div>

        <!---Course end date form box--->
        <div class="floatLeft">
            <label>Course End</label>
            <input type="date" name="endDate_DateBox">
        </div>

        <!---Course start time form box--->
        <div class="floatLeft">
            <label>Start Time</label>
            <input type="time" name="startTime_TimeBox">
        </div>

        <!---Course end time form box--->
        <div class="floatLeft">
            <label>End Time</label>
            <input type="time" name="endTime_TimeBox">
        </div>


        <!---Textbook Required form box--->
        <div class="floatLeft">
            <label>Textbook Required:</label>
            <input type="radio" name="textbook_RadioBox" value="yes">Yes
            <input type="radio" name="textbook_RadioBox" value="no"> No
            <input type="radio" name="textbook_RadioBox" value="both" checked>Both
        </div>

        <!---Owl Requirment form box--->
        <div class="floatLeft">
            <label>OWL Required:</label>
            <input type="radio" name="owlReq_RadioBox" value="yes">Yes
            <input type="radio" name="owlReq_RadioBox" value="no">No
            <input type="radio" name="owlReq_RadioBox" value="both" checked>Both
        </div>

        <!---Method For Course Evaluation form box--->

        <label>Course Evaluation</label>
        <input type="radio" name="courseEvaluation_RadioBox" value="grades">grades
        <input type="radio" name="courseEvaluation_RadioBox" value="attendance">attendance
        <input type="radio" name="courseEvaluation_RadioBox" value="both">both
        <input type="radio" name="courseEvaluation_RadioBox" value="all" checked>all

        <label>Include Canceled</label>
        <input type="radio" name="canceled_RadioBox" value="yes" checked>Yes
        <input type="radio" name="canceled_RadioBox" value="no">No
</div>

        <input type="submit" name="submit_Button" id="submitBtn">

</cfform>
</cfoutput>

<cfinclude template="includes/footer.cfm" />
