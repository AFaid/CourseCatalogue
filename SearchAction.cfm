<!---
Name:			Search Screen
Author:			Ahmed Faid
Description: 	Search through course record and display result
Created:		May 23rd
--->
<!--Selects Courses and course information from database based on form entry
    If form field is left empty = all courses-->

<!---Sets days equal to an empty string if not specified by user--->
<cfparam name="FORM.days_Checkbox" default="">
<cfparam name="URL.course_removed" default="">
<cfparam name="URL.Course_Name" default="">

<cfinclude template="includes/header.cfm">
<cfinclude template="includes/sidebar.cfm">

<cfif #URL.course_removed# EQ "">
    <!---Pulls information from table based on user's entries. If the user does not enter a value for one of the form field all values are pulled--->
    <cfquery datasource="WCSTracking" name="Course_Query">
        SELECT ID, Course_Name, Course_Code, section, Delivery, Course_Start, Course_End, Instructor_ID,
            Course_Days, Course_Evaluation, Text_Required, OWL_Required, Start_Time, End_Time
        FROM Course
        WHERE 0=0

        <cfif FORM.courseType_RadioBox NEQ "all">
            AND Course_Type LIKE '%#FORM.courseType_RadioBox#%'
        </cfif>
        <cfif FORM.courseCode_TextBox NEQ "">
            AND Course_Code LIKE '%#FORM.courseCode_TextBox#%'
        </cfif>
        <cfif FORM.courseName_TextBox NEQ "">
            AND Course_Name LIKE '%#FORM.courseName_TextBox#%'
        </cfif>
        <cfif FORM.section_TextBox NEQ "">
            AND section LIKE '%#FORM.section_TextBox#%'
        </cfif>
        <cfif FORM.instructor_TextBox NEQ "" AND FORM.instructor_TextBox NEQ "tba">
            AND Instructor_ID IN (SELECT ID FROM Instructors WHERE Instructor_Name LIKE '%#FORM.instructor_TextBox#%')
        <cfelseif FORM.instructor_TextBox EQ "tba">
            AND Instructor_ID IS NULL
        </cfif>
        <cfif FORM.Delivery_SelectBox NEQ "All">
            AND Delivery LIKE '%#FORM.Delivery_SelectBox#%'
        </cfif>
        <cfif FORM.startDate_DateBox NEQ "" AND FORM.startDate_DateBox NEQ "0001-01-01">
            AND Course_Start >= #parseDateTime(FORM.startDate_DateBox)#
        <cfelseif FORM.startDate_DateBox EQ "0001-01-01">
            AND Course_Start IS NULL
        </cfif>
        <cfif FORM.endDate_DateBox NEQ "" AND FORM.EndDate_DateBox NEQ "00001-01-01">
            AND Course_End <= #parseDateTime(FORM.endDate_DateBox)#
        <cfelseif FORM.EndDate_DateBox EQ "0001-01-01">
            AND Course_End is NULL
        </cfif>        
        <cfif FORM.days_Checkbox NEQ "">
            AND Course_Days LIKE '%#FORM.days_Checkbox#%'
        </cfif>
        <cfif FORM.startTime_TimeBox NEQ "">
            AND Start_Time LIKE '%#FORM.startTime_TimeBox#%'
        </cfif>
        <cfif FORM.endTime_TimeBox NEQ "">
            AND End_Time LIKE '%#FORM.endTime_TimeBox#%'
        </cfif>
        <cfif FORM.courseEvaluation_RadioBox NEQ "all">
            AND Course_Evaluation LIKE '%#FORM.courseEvaluation_RadioBox#%'
        </cfif>
        <cfif FORM.textbook_RadioBox NEQ "both">
            AND Text_Required LIKE '%#FORM.textbook_RadioBox#%'
        </cfif>
        <cfif FORM.owlReq_RadioBox NEQ "both">
            AND OWL_Required LIKE '%#FORM.owlReq_RadioBox#%'
        </cfif>
        <cfif FORM.canceled_RadioBox EQ "no">
            AND Canceled = 0
        </cfif>
        ORDER BY Course_Name
    </cfquery>

<cfelse>
    <cfquery datasource="WCSTracking" name="Course_Query">
        SELECT ID, Course_Name, Course_Code, section, Delivery, Course_Start, Course_End, Instructor_ID,
        Course_Days, Course_Evaluation, Text_Required, OWL_Required, Start_Time, End_Time
        FROM Course
        WHERE 0=0
    </cfquery>
</cfif>

<div <cfif #URL.course_removed# NEQ 'true'>class="hide"<cfelse> class="alert alert-warning" role="alert" </cfif>>
    <cfoutput>
        <strong>Warning!</strong> #URL.Course_Name# was Deleted from Courses
    </cfoutput>
</div>

<cfoutput>
    <div class="container pageTitle">
        <h3>#Course_Query.RecordCount# Search Results</h3>
    </div>
</cfoutput>

<!---displays results--->
<div class="results-Table">
    <table>
        <tr>
            <td>
                <strong>Course Code</strong>
            </td>
            <td>
                <strong>Section</strong>
            </td>
            <td>
                <strong>Course Name</strong>
            </td>
            <td>
                <strong>Instructor</strong>
            </td>
            <td>
                <strong>Delivery</strong>
            </td>
            <td>
                <strong>Start Date</strong>
            </td>
            <td>
                <strong>End Date</strong>
            </td>
            <td>
                <strong>Textbook Required</strong>
            </td>
            <td>
                <strong>OWL Required</strong>
            </td>
        </tr>

        <cfloop  query="Course_Query">
        <cfoutput>
            <tr>
                <td class="uppercase">
                    <!--Link to a page with more information about each indvidual key-->
                    #Course_Query.Course_Code#
                </td>
                <td>
                    #Course_Query.Section#
                </td>
                <td>
                    <a href="Course_Details.cfm?CourseID=#URLEncodedFormat(Trim(ID))#">#Course_Query.Course_Name# </a>
                </td>
                <td>
                    <cfif #Course_Query.Instructor_ID# NEQ "">
                        <cfinvoke component="Queries"
                                  method="InstructorName_Getter"
                                  InstructorID="#Course_Query.Instructor_ID#">
                    <cfelse>
                        TBA
                    </cfif>
                </td>
                <td>
                    #Course_Query.Delivery#
                </td>
                <td>
                    <!--Uses DateNullChecker function to display "TBA" for dates which havent been entered (NULL)-->
                    <cfinvoke component="Functions"
                              method="DateNullChecker"
                              Value="#Course_Query.Course_Start#">
                </td>
                <td>
                    <!--Uses DateNullChecker function to display "TBA" for dates which havent been entered (NULL)-->
                    <cfinvoke component="Functions"
                              method="DateNullChecker"
                              Value="#Course_Query.Course_End#">
                </td>
                <td>
                    #Course_Query.Text_Required#
                </td>
                <td>
                    #Course_Query.OWL_Required#
                </td>
            </tr>
        </cfoutput>
        </cfloop>
    </table>
</div>

<cfinclude template="includes/footer.cfm">
