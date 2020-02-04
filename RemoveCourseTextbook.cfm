<cfquery datasource="WCSTracking">
    UPDATE Course
    SET Textbook_ISBN = REPLACE(Textbook_ISBN, '#URL.ISBN#', '') 
    WHERE ID = '#URL.CourseID#'
</cfquery>

<cflocation url="Course_Details.cfm?CourseID=#URLEncodedFormat(TRIM(URL.CourseID))#">
