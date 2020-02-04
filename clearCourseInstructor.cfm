<cfdump var="#URL.CourseID#">

<cfquery datasource="WCSTracking" name="removeCourseInstructor">
    UPDATE Course
    SET Instructor_ID = NULL
    WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar">
</cfquery>

<cflocation url="Course_Details.cfm?CourseID=#URLEncodedFormat(URL.CourseID)#">