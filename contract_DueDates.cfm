<!--
Name: Ahmed Faid
Date: June 19 2019
Description: A list of courses and due dates for Course contract
-->

<cfquery datasource="WCSTracking" name="contractDueDate_Query">
    SELECT Course.ID, Course_Code, Course_Name, Section, contract_Due
    FROM Course
    JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
    WHERE (CourseChecklist.contract_Recieved = 0 or CourseChecklist.contract_sent = 0) AND Course.contract_Due IS NOT NULL
    ORDER BY Course.contract_Due ASC
</cfquery>


<cfinclude template="includes/header.cfm">
    <cfinclude template="includes/sidebar.cfm">

        <div class="container pageTitle">
            <h3>Contract Due</h3>
        </div>

        <div class="results-Table">
            <table>
                <tr>
                    <td><strong>Course Code</strong></td>
                    <td><strong>Course Name</strong></td>
                    <td><strong>Section</strong></td>
                    <td><strong>Contract Due</strong></td>
                </tr>

                <cfloop query="contractDueDate_Query">
                    <cfoutput>
                    <tr>
                        <td>#contractDueDate_Query.Course_Code#</td>
                        <td><a href="course_details.cfm?CourseID=#URLEncodedFormat(Trim(contractDueDate_Query.ID))#">#contractDueDate_Query.Course_Name#</a></td>
                        <td>#contractDueDate_Query.Section#</td>
                        <td>
                            <cfinvoke component="Functions"
                                      method="DateNullChecker"
                                      value="#contractDueDate_Query.contract_Due#">
                        </td>
                    </tr>
                    </cfoutput>
                </cfloop>

            </table>
        </div>

        <cfinclude template="includes/footer.cfm">
