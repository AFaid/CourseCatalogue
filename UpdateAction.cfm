
<!---Sets coourse days equal to an empty string if no value is selected--->
<cfparam name="FORM.days_CheckboxUPD" default="">

<cfquery datasource="WCSTracking" name="CourseChecker_Query">
    SELECT ID FROM Course
    WHERE ID = '#TRIM(FORM.section_TextBoxUPD)#'+'#TRIM(FORM.courseCode_TextBoxUPD)#'
    AND ID <> '#FORM.courseKey_hidden#'
</cfquery>

<cfif #CourseChecker_Query.RecordCount# EQ 0>

    <!---Update Course Database
            *if form field is empty does not update corresponding value
            *if text required is set to 'no' sets removes course textbook and text due date values
            *if course is online set days to 'null'--->
    <cfquery datasource="WCSTracking" name="UpdateCourse_Query">
        UPDATE Course

        SET ID = <cfqueryparam value="#TRIM(FORM.section_TextBoxUPD)&TRIM(FORM.courseCode_TextBoxUPD)#" cfsqltype="cf_sql_varchar">,
        Course_Type=<cfqueryparam value="#FORM.courseType_RadioBoxUPD#" cfsqltype="cf_sql_varchar">,
        Course_Code = <cfqueryparam value="#TRIM(FORM.courseCode_TextBoxUPD)#" cfsqltype="cf_sql_varchar">,
        Course_Name = <cfqueryparam value="#TRIM(FORM.courseName_TextBoxUPD)#" cfsqltype="cf_sql_varchar">,
        section = <cfqueryparam value="#TRIM(FORM.section_TextBoxUPD)#" cfsqltype="cf_sql_varchar">,
        Delivery = <cfqueryparam value="#FORM.Delivery_SelectBoxUPD#" cfsqltype="cf_sql_varchar">,
        <cfif (FORM.days_CheckboxUPD NEQ "" ) AND (FORM.delivery_SelectBoxUPD NEQ "online" )>
            Course_Days = <cfqueryparam value="#FORM.days_CheckboxUPD#" cfsqltype="cf_sql_varchar">,
        </cfif>
        <cfif FORM.startDate_DateBoxUPD NEQ "">
            Course_Start = <cfqueryparam value="#FORM.startDate_DateBoxUPD#" cfsqltype="cf_sql_date">,
        </cfif>
        <cfif FORM.endDate_DateBoxUPD NEQ "">
            Course_End = <cfqueryparam value="#FORM.endDate_DateBoxUPD#" cfsqltype="cf_sql_date">,
        </cfif>
        <cfif FORM.startTime_TimeBoxUPD NEQ "">
            Start_Time = <cfqueryparam value="#FORM.startTime_TimeBoxUPD#" cfsqltype="cf_sql_time">,
        </cfif>
        <cfif FORM.endTime_TimeBoxUPD NEQ "">
            End_Time = <cfqueryparam value="#FORM.endTime_TimeBoxUPD#" cfsqltype="cf_sql_time">,
        </cfif>
        <cfif FORM.startDate_DateBoxUPD NEQ "">
            Contract_Due = DATEADD(week, -8, '#FORM.startDate_DateBoxUPD#'),
        </cfif>        
        <cfif (FORM.startDate_DateBoxUPD NEQ "" ) AND (FORM.textbook_RadioBoxUPD EQ "yes" )>
            Text_Due = DATEADD(week, -8, '#FORM.startDate_DateBoxUPD#'),
        </cfif>
        <cfif (FORM.startDate_DateBoxUPD NEQ "" ) AND (FORM.OWLReq_RadioBoxUPD EQ "copysite" or FORM.OWLReq_RadioBoxUPD EQ "blanksite")>
            OWL_Due = DATEADD(week, -8, '#FORM.startDate_DateBoxUPD#'),
        </cfif>
        <cfif (FORM.startDate_DateBoxUPD NEQ "" )>
            CourseOutline_Due = DATEADD(week, -2, '#FORM.startDate_DateBoxUPD#'),
        </cfif>
        <cfif (FORM.EndDate_DateBoxUPD NEQ "" ) AND (FORM.courseType_RadioBoxUPD NEQ "post degree" )>
            Reminder_Due= DATEADD(day, 5, '#FORM.endDate_DateBoxUPD#'),
        </cfif>
        <cfif (FORM.EndDate_DateBoxUPD NEQ "" ) AND (FORM.courseType_RadioBoxUPD NEQ "post degree" )>
            Evaluation_Due= DATEADD(week, 1, '#FORM.endDate_DateBoxUPD#'),
        </cfif>
        <cfif (FORM.EndDate_DateBoxUPD NEQ "" )>
            <cfif FORM.Delivery_SelectBoxUPD neq 'workshop' AND FORM.courseEvaluation_RadioBoxUPD NEQ "Attendance">
                Grades_Due= DATEADD(week, 2, '#FORM.endDate_DateBoxUPD#'),
            <cfelse>
                Grades_Due= <cfqueryparam value="#FORM.endDate_DateBoxUPD#" cfsqltype="cf_sql_date">,
            </cfif>
        </cfif>
        Text_Required = <cfqueryparam value="#FORM.textbook_RadioBoxUPD#" cfsqltype="cf_sql_varchar">,
        <cfif FORM.textbook_RadioBoxUPD EQ "no" or FORM.textbook_RadioBoxUPD EQ "TBA">
            Text_Due = null,
            Textbook_ISBN = null,
        </cfif>
        <cfif FORM.delivery_selectBoxUPD EQ 'online'>
            Course_Days = null,
        </cfif>
        <cfif FORM.courseType_RadioBoxUPD EQ 'post degree'>
            Evaluation_Due = null,
            Reminder_Due = null,
        </cfif>
        Owl_Required = <cfqueryparam value="#FORM.owlReq_RadioBoxUPD#" cfsqltype="cf_sql_varchar">,
        Course_Evaluation = <cfqueryparam value="#FORM.courseEvaluation_RadioBoxUPD#" cfsqltype="cf_sql_varchar">

        WHERE ID = <cfqueryparam value="#FORM.CourseID#" cfsqltype="cf_sql_varchar">

    </cfquery>

    <!---if the course id is changed change the id for the corresponding courseChecklist--->
    <cfquery datasource="WCSTracking" name="UpdateChecklistID_Query">
        UPDATE CourseChecklist

        SET ID = <cfqueryparam value="#TRIM(FORM.section_TextBoxUPD)&TRIM(FORM.courseCode_TextBoxUPD)#" cfsqltype="cf_sql_varchar">

        WHERE ID = <cfqueryparam value="#FORM.CourseID#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cflocation url="UpdateCourseInstructor.cfm?CourseID=#URLEncodedFormat(TRIM(FORM.section_TextBoxUPD)&TRIM(FORM.courseCode_TextBoxUPD))#">

<cfelse>

    <cflocation url="UpdateCourseDatabase.cfm?CourseID=#URLEncodedFormat(TRIM(FORM.courseKey_hidden))#&course_exists=#URLEncodedFormat('true')#">

</cfif>

=<!---gets id and uses it to redirect to course details page
    <cfquery datasource="WCSTracking" name="CourseID_Query">
        SELECT ID
        FROM Course
        WHERE ID = <cfqueryparam value="#TRIM(FORM.section_TextBoxUPD)&TRIM(FORM.courseCode_TextBoxUPD)#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cflocation url="Course_Details.cfm?CourseID=#CourseID_Query.ID#">
--->