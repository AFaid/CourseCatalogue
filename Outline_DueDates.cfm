<!--
Name: Ahmed Faid
Date: June 19 2019
Description: A list of courses and due dates for course outlines
-->
<cfquery datasource="WCSTracking" name="OutlineDueDate_Query">
    SELECT Course.ID, Course_Code, Course_Name, Section, CourseOutline_Due
    FROM Course 
    JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
    WHERE CourseChecklist.Outline_Recieved = 0 AND Course.CourseOutline_Due IS NOT null
    ORDER BY Course.CourseOutline_Due ASC
</cfquery>


<cfinclude template="includes/header.cfm">
<cfinclude template="includes/sidebar.cfm">

    <div class=" pageTitle">
        <h3>Outline Due</h3>
    </div>

    <div class="results-Table">
        <table>
            <tr>
                <td><strong>Course Code</strong></td>
                <td><strong>Course Name</strong></td>
                <td><strong>Section</strong></td>
                <td><strong>Outline Due</strong></td>
            </tr>

            <cfloop query="OutlineDueDate_Query">
                <cfoutput>
                <tr>
                    <td>#OutlineDueDate_Query.Course_Code#</td>
                    <td><a href="course_details.cfm?CourseID=#URLEncodedFormat(Trim(OutlineDueDate_Query.ID))#">#OutlineDueDate_Query.Course_Name#</a></td>
                    <td>#OutlineDueDate_Query.Section#</td>
                    <td>
                        <cfinvoke component="Functions"
                                  method="DateNullChecker"
                                  value="#OutlineDueDate_Query.CourseOutline_Due#">
                    </td>
                </tr>
                </cfoutput>
            </cfloop>

        </table>
    </div>

<cfinclude template="includes/footer.cfm">
