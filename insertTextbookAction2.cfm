
<cfquery datasource="WCSTracking">
    UPDATE Course
    SET Textbook_ISBN = '#FORM.ExistingTextbookISBN_RadioBoxINS#'
    WHERE ID = '#FORM.CourseID#'
</cfquery>

<cflocation url="insert.cfm?added=#URLEncodedFormat(1)#">