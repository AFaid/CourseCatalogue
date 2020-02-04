<cfquery datasource="WCSTracking">
    UPDATE Course
    SET Textbook_ISBN = Textbook_ISBN + ',#FORM.ExistingTextbookISBN_RadioBoxADD#'
    WHERE ID = '#FORM.CourseID#' AND Textbook_ISBN IS NOT NULL
</cfquery>
<cfquery datasource="WCSTracking">
    UPDATE Course
    SET Textbook_ISBN = '#FORM.ExistingTextbookISBN_RadioBoxADD#'
    WHERE ID = '#FORM.CourseID#' AND Textbook_ISBN IS NULL
</cfquery>

<cflocation url="Course_Details.cfm?CourseID=#URLEncodedFormat(TRIM(FORM.CourseID))#">