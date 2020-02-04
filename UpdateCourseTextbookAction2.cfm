
<cfquery datasource="WCSTracking">
    UPDATE Course
    SET Textbook_ISBN = <cfqueryparam value="#FORM.ExistingTextbookISBN_RadioBoxINS#" cfsqltype="cf_sql_varchar">
    WHERE ID = <cfqueryparam value="#FORM.CourseKey#" cfsqltype="cf_sql_varchar">
</cfquery>

<cflocation url="Course_Details.cfm?CourseID=#FORM.CourseKey#">