<!--
Name: Ahmed Faid
Date: June 19 2019
Description: A list of courses and due dates for evaluations reminder
-->
<cfquery datasource="WCSTracking" name="EvalDueDate_Query">
    SELECT Course.ID, Course_Code, Course_Name, Section, Reminder_Due, Evaluation_Due
    FROM Course
    JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
    WHERE CourseChecklist.Reminder_Sent = 0 and Course.Evaluation_Due IS NOT NULL
    ORDER BY Course.Reminder_Due ASC
</cfquery>

<cfinclude template="includes/header.cfm">
<cfinclude template="includes/sidebar.cfm">

    <div class="pageTitle">
        <h3>Evaluations and Evaluation Reminders Due</h3>
    </div>

    <div class="results-Table">
        <table>
            <tr>
                <td><strong>Course Code</strong></td>
                <td><strong>Course Name</strong></td>
                <td><strong>Section</strong></td>
                <td><strong>Reminders Due</strong></td>
                <td><strong>Evaluations Due</strong></td>
            </tr>

            <cfloop query="EvalDueDate_Query">
                <cfoutput>
                <tr>
                    <td>#EvalDueDate_Query.Course_Code#</td>
                    <td><a href="course_details.cfm?CourseID=#URLEncodedFormat(Trim(EvalDueDate_Query.ID))#">#EvalDueDate_Query.Course_Name#</a></td>
                    <td>#EvalDueDate_Query.Section#</td>
                    <td>
                        <cfinvoke component="Functions"
                                    method="DateNullChecker"
                                    value="#EvalDueDate_Query.Reminder_Due#">
                    </td>
                    <td>
                        <cfinvoke component="Functions"
                                    method="DateNullChecker"
                                    value="#EvalDueDate_Query.Evaluation_Due#">
                    </td>
                </tr>
                </cfoutput>
            </cfloop>

        </table>
    </div>

 <cfinclude template="includes/footer.cfm">