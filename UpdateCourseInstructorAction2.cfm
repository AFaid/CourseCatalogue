<cfquery datasource="WCSTracking" name="LinkInstructor_Query">
    UPDATE Course
    SET Instructor_ID = <cfqueryparam value=#FORM.ExistingInstructor_RadioBoxUPD# cfsqltype="CF_SQL_Integer">
        WHERE ID = '#FORM.CourseID#'
</cfquery>

<cflocation url="Course_Details.cfm?CourseID=#URLEncodedFormat(FORM.CourseID)#">
