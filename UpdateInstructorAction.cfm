<!---
Name: Ahmed Faid
Description: Updates Instructor Information
--->

<cfparam name="FORM.InstructorStatus_CheckBoxUPD" default="Inactive">

<cfquery datasource="WCSTracking">
    UPDATE Instructors
    SET Instructor_Name = '#TRIM(FORM.InstructorName_TextBoxUPD)#',
    Instructor_Email = '#TRIM(FORM.InstructorEmail_TextBoxUPD)#',
    Instructor_New = #FORM.InstructorNew_RadioBoxUPD#,
    Instructor_Status = '#FORM.InstructorStatus_CheckBoxUPD#'
    WHERE ID = #FORM.InstructorID_Hidden#
</cfquery>

<cflocation url="instructors.cfm">