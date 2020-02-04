<!---
 Name: Ahmed Faid
 Date: May 29th 2019
 Description: Inserts new entry into course table
--->

<cfparam name="FORM.days_CheckboxINS" default="">

<!---Checks if course already exists--->
<cfquery datasource="WCSTracking" name="CourseChecker_Query">
    SELECT ID FROM Course
    WHERE ID = <cfqueryparam value="#TRIM(FORM.section_TextBoxINS)&TRIM(FORM.courseCode_TextBoxINS)#" cfsqltype="varchar">
</cfquery>

<!---If course doesnt exist add course to database--->
<cfif #CourseChecker_Query.RecordCount# EQ 0>

    <!---Query to insert courses in database. If statements replaces empty strings with null variables--->
    <cfquery datasource="WCSTracking" name="addCourse_Query">
        INSERT INTO Course( ID,
        Course_Type,
        Course_Code,
        Course_Name,
        Section,
        Delivery,
        <cfif (FORM.days_CheckboxINS NEQ "") AND (FORM.delivery_SelectBoxINS NEQ "online")>
            Course_Days,
        </cfif>
        <cfif FORM.startDate_DateBoxINS NEQ "">
            Course_Start,
        </cfif>
        <cfif FORM.endDate_DateBoxINS NEQ "">
            Course_End,
        </cfif>
        <cfif FORM.startTime_TimeBoxINS NEQ "">
            Start_Time,
        </cfif>
        <cfif FORM.endTime_TimeBoxINS NEQ "">
            End_Time,
        </cfif>
        Course_Evaluation,
        Text_Required,
        <cfif FORM.startDate_DateBoxINS NEQ "" >
            Contract_Due,
        </cfif>        
        <cfif (FORM.startDate_DateBoxINS NEQ "" ) AND (FORM.textbook_RadioBoxINS EQ "yes" )>
            Text_Due,
        </cfif>        
        <cfif (FORM.startDate_DateBoxINS NEQ "" ) AND (FORM.OWLReq_RadioBoxINS EQ "copysite" or FORM.OWLReq_RadioBoxINS EQ "blanksite") >
            OWL_Due,
        </cfif>
        <cfif (FORM.startDate_DateBoxINS NEQ "" )>
            courseOutline_Due,
        </cfif>
        <cfif (FORM.EndDate_DateBoxINS NEQ "" ) AND (FORM.courseType_RadioBoxINS NEQ "post degree" )>
            Reminder_Due,
        </cfif>
        <cfif (FORM.EndDate_DateBoxINS NEQ "" ) AND (FORM.courseType_RadioBoxINS NEQ "post degree" )>
            Evaluation_Due,
        </cfif>
        <cfif (FORM.EndDate_DateBoxINS NEQ "" )>
            Grades_Due,
        </cfif>
        OWL_Required)

        VALUES (
        '#TRIM(FORM.section_TextBoxINS)#'+'#TRIM(FORM.courseCode_TextBoxINS)#',
        '#FORM.courseType_RadioBoxINS#',
        '#TRIM(FORM.courseCode_TextBoxINS)#',
        '#TRIM(FORM.courseName_TextBoxINS)#',
        '#TRIM(FORM.section_TextBoxINS)#',
        '#FORM.Delivery_SelectBoxINS#',
        <cfif (FORM.days_CheckboxINS NEQ "") AND (FORM.delivery_SelectBoxINS NEQ "online")>
            '#FORM.days_CheckboxINS#',
        </cfif>
        <cfif FORM.startDate_DateBoxINS NEQ "">
            '#FORM.startDate_DateBoxINS#',
        </cfif>
        <cfif FORM.endDate_DateBoxINS NEQ "">
            '#FORM.endDate_DateBoxINS#',
        </cfif>
        <cfif FORM.startTime_TimeBoxINS NEQ "">
            '#FORM.startTime_TimeBoxINS#',
        </cfif>
        <cfif FORM.endTime_TimeBoxINS NEQ "">
            '#FORM.endTime_TimeBoxINS#',
        </cfif>
        '#FORM.courseEvaluation_RadioBoxINS#',
        '#FORM.textbook_RadioBoxINS#',
        <cfif (FORM.startDate_DateBoxINS NEQ "" )>
            DATEADD(week, -8, '#FORM.startDate_DateBoxINS#'),
        </cfif>    
        <cfif (FORM.startDate_DateBoxINS NEQ "" ) AND (FORM.textbook_RadioBoxINS EQ "yes" )>
            DATEADD(week, -8, '#FORM.startDate_DateBoxINS#'),
        </cfif>
        <cfif (FORM.startDate_DateBoxINS NEQ "" ) AND (FORM.OWLReq_RadioBoxINS EQ "copysite" or FORM.OWLReq_RadioBoxINS EQ "blanksite")>
            DATEADD(week, -8, '#FORM.startDate_DateBoxINS#'),
        </cfif>
        <cfif (FORM.startDate_DateBoxINS NEQ "" )>
            DATEADD(week, -2, '#FORM.startDate_DateBoxINS#'),
        </cfif>
        <cfif (FORM.EndDate_DateBoxINS NEQ "" ) AND (FORM.courseType_RadioBoxINS NEQ "post degree" )>
            DATEADD(day, 5, '#FORM.endDate_DateBoxINS#'),
        </cfif>
        <cfif (FORM.EndDate_DateBoxINS NEQ "" ) AND (FORM.courseType_RadioBoxINS NEQ "post degree" )>
            DATEADD(week, 1, '#FORM.endDate_DateBoxINS#'),
        </cfif>
        <cfif (FORM.EndDate_DateBoxINS NEQ "" )>
            <cfif  FORM.Delivery_SelectBoxINS NEQ "WORKSHOP" AND FORM.courseEvaluation_RadioBoxINS NEQ "Attendance">
                DATEADD(week, 2, '#FORM.endDate_DateBoxINS#'),
            <cfelse>
                '#FORM.EndDate_DateBoxINS#',
            </cfif>
        </cfif>
        '#FORM.owlReq_RadioBoxINS#' )

        INSERT INTO CourseChecklist (ID)
        VALUES ('#TRIM(FORM.section_TextBoxINS)#'+'#TRIM(FORM.courseCode_TextBoxINS)#')

    </cfquery>

    <cflocation url="InsertInstructor.cfm?CourseID=#URLEncodedFormat(TRIM(FORM.section_TextBoxINS & FORM.courseCode_TextBoxINS ))#">

    <!---If course already exists redirect to detailed page of the course--->
    <cfelse>
        <cflocation url="insert.cfm?CourseID=#URLEncodedFormat(TRIM(FORM.section_TextBoxINS & FORM.courseCode_TextBoxINS))#&course_exists=#URLEncodedFormat('true')#">
    </cfif>
