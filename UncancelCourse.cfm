<cfquery name="CancelCourse_Query" datasource="WCSTracking">
    UPDATE CourseChecklist
    SET Text_Recieved = 0,
    Contract_Sent = 0,
    Contract_Recieved = 0,
    OWL_Site = 0,
    Outline_Recieved = 0,
    Reminder_Sent = 0,
    Eval_Sent = 0,
    GA_Added = 0,
    Class_Emailed = 0
    WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfquery name="SetCanceled_Query" datasource="WCSTracking">
    UPDATE Course
    SET Canceled = 0
    WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar">
</cfquery>

<cflocation url="Course_Details.cfm?CourseID=#URLENCODEDFORMAT(URL.CourseID)#">