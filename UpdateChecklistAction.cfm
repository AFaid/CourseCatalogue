<!---
Name: Ahmed Faid
Date: June 5th 2019
Description: Updates Checklist Entries
--->

<cfheader name="Expires" value="Mon, 06 Jan 1990 00:00:01 GMT"> 
<cfheader name="Pragma" value="no-cache"> 
<cfheader name="cache-control" value="no-cache"> 

    <cfparam name="FORM.TextRecieved_CheckBox" default="0">
    <cfparam name="FORM.TextOrdered_CheckBox" default="0">
    <cfparam name="FORM.TextInStock_CheckBox" default="0">
    <cfparam name="FORM.TextWebsiteUpdated_CheckBox" default="0">
    <cfparam name="FORM.TextEmailedStudents_CheckBox" default="0">
    <cfparam name="FORM.OWLSite_CheckBox" default="0">
    <cfparam name="FORM.OWLSiteCreated_CheckBox" default="0">
    <cfparam name="FORM.OWLInstructorEmailed_CheckBox" default="0">
    <cfparam name="FORM.OWLSiteReviewed_CheckBox" default="0">
    <cfparam name="FORM.OWLReadyToPublish_CheckBox" default="0">
    <cfparam name="FORM.ContractSent_CheckBox" default="0">
    <cfparam name="FORM.ContractRecieved_CheckBox" default="0">
    <cfparam name="FORM.OutlineRecieved_CheckBox" default="0">
    <cfparam name="FORM.WebsiteUpdated_CheckBox" default="0">
    <cfparam name="FORM.ReminderSent_CheckBox" default="0">
    <cfparam name="FORM.GAadded_CheckBox" default="0">
    <cfparam name="FORM.EvalSent_CheckBox" default="0">
    <cfparam name="FORM.ClassEmailed_CheckBox" default="0">
    <cfparam name="FORM.MaterialsOnFile_CheckBox" default="0">

    <cfquery datasource="WCSTracking">
        UPDATE CourseChecklist

        SET
        Text_Ordered = <cfqueryparam value="#FORM.TextOrdered_CheckBox#" cfsqltype="cf_sql_bit">,
        Text_InStock = <cfqueryparam value="#FORM.TextInStock_CheckBox#" cfsqltype="cf_sql_bit">,
        Text_WebsiteUpdated = <cfqueryparam value="#FORM.TextWebsiteUpdated_CheckBox#" cfsqltype="cf_sql_bit">,
        Text_EmailedStudents = <cfqueryparam value="#FORM.TextEmailedStudents_CheckBox#" cfsqltype="cf_sql_bit">,
        <cfif (FORM.TextOrdered_CheckBox EQ 1) AND (FORM.TextInStock_CheckBox EQ 1) AND (FORM.TextWebsiteUpdated_CheckBox EQ 1) AND (FORM.TextEmailedStudents_CheckBox EQ 1)>
            Text_Recieved = 1,
        <cfelse>
            Text_Recieved = 0,
        </cfif>
        <cfif (OWLSiteCreated_CheckBox eq 1) AND (FORM.OWLInstructorEmailed_CheckBox EQ 1) AND (FORM.OWLSiteReviewed_CheckBox EQ 1) AND (FORM.OWLReadyToPublish_CheckBox EQ 1)>
            OWL_Site = 1,
        <cfelse>
            OWL_Site = 0,
        </cfif>
        OWL_SiteCreated = <cfqueryparam value="#FORM.OWLSiteCreated_CheckBox#" cfsqltype="cf_sql_bit">,
        OWL_InstructorEmailed = <cfqueryparam value="#FORM.OWLInstructorEmailed_CheckBox#" cfsqltype="cf_sql_bit">,
        OWL_SiteReviewed = <cfqueryparam value="#FORM.OWLSiteReviewed_CheckBox#" cfsqltype="cf_sql_bit">,
        OWL_ReadyToPublish = <cfqueryparam value="#FORM.OWLReadyToPublish_CheckBox#" cfsqltype="cf_sql_bit">,
        Contract_Sent = <cfqueryparam value="#FORM.ContractSent_CheckBox#" cfsqltype="cf_sql_bit">,
        Contract_Recieved = <cfqueryparam value="#FORM.ContractRecieved_CheckBox#" cfsqltype="cf_sql_bit">,
        Outline_Recieved = <cfqueryparam value="#FORM.OutlineRecieved_CheckBox#" cfsqltype="cf_sql_bit">,
        Website_Updated = <cfqueryparam value="#FORM.WebsiteUpdated_CheckBox#" cfsqltype="cf_sql_bit">,
        Reminder_Sent= <cfqueryparam value="#FORM.ReminderSent_CheckBox#" cfsqltype="cf_sql_bit">,
        Eval_Sent = <cfqueryparam value="#FORM.EvalSent_CheckBox#" cfsqltype="cf_sql_bit">,
        GA_Added = <cfqueryparam value="#FORM.GAadded_CheckBox#" cfsqltype="cf_sql_bit">,
        Class_Emailed= <cfqueryparam value="#FORM.ClassEmailed_CheckBox#" cfsqltype="cf_sql_bit">,
        Materials_OnFile=<cfqueryparam value="#FORM.MaterialsOnFile_CheckBox#" cfsqltype="cf_sql_bit">

        WHERE ID = <cfqueryparam value="#FORM.CourseIdentifier#" cfsqltype="cf_sql_varchar">
    </cfquery>

<cflocation url="Course_Details.cfm?CourseID=#URLEncodedFormat(Trim(FORM.CourseIdentifier))#">