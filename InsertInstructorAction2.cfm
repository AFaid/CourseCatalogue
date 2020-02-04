<cfquery datasource="WCSTracking" name="LinkInstructor_Query">
    UPDATE Course
    SET Instructor_ID = <cfqueryparam value=#FORM.ExistingInstructor_RadioBoxINS# cfsqltype="Integer">
    WHERE ID = '#FORM.CourseID#'
</cfquery>

<cfquery datasource="WCSTracking" name="TextRequired_Query">
    SELECT Text_Required
    FROM Course
    WHERE ID = '#FORM.CourseID#'
</cfquery>

<cfif #TextRequired_Query.Text_Required# eq 'yes'>
    <cflocation url="insertTextbook.cfm?CourseID=#URLEncodedFormat(TRIM(FORM.CourseID))#">
<cfelse>
    <cflocation url="insert.cfm?added=#URLEncodedFormat(1)#">
</cfif>