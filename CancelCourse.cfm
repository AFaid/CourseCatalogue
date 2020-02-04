<!--- Sets checklist items with due dates to null so they are ignored by queries--->
<cfquery name="CancelCourse_Query" datasource="WCSTracking">
    UPDATE CourseChecklist
    SET Text_Recieved = null,
    Contract_Sent = null,
    Contract_Recieved = null,
    OWL_Site = null,
    Outline_Recieved = null,
    Reminder_Sent = null,
    Eval_Sent = null,
    GA_Added = null,
    Class_Emailed = null
    WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfquery name="SetCanceled_Query" datasource="WCSTracking">
    UPDATE Course
    SET Canceled = 1
    WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar">
</cfquery>

<cflocation url="Course_Details.cfm?CourseID=#URLENCODEDFORMAT(URL.CourseID)#">