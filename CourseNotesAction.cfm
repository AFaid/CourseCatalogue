
<cfquery datasource="WCSTracking" name="AddNotes_Query">
    UPDATE Course
    SET Course_Notes = '#FORM.CourseNotes_TextArea#'
    WHERE ID = '#FORM.CourseKey_HiddenBox#'
</cfquery>

<cflocation url="Course_Details.cfm?CourseID=#URLEncodedFormat(FORM.CourseKey_HiddenBox)#">