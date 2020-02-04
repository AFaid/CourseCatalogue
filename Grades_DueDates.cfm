<!--
Name: Ahmed Faid
Date: June 19 2019
Description: A list of courses and due dates for Course Grades
-->
<cfquery datasource="WCSTracking" name="GradesDueDate_Query">
    SELECT Course.ID, Course_Code, Course_Name, Section, Grades_Due
    FROM Course
    JOIN CourseChecklist ON Course.ID=CourseChecklist.ID
    WHERE CourseChecklist.GA_Added = 0 AND Course.Grades_Due IS NOT NULL
    ORDER BY Course.Grades_Due ASC
</cfquery>


<cfinclude template="includes/header.cfm">
<cfinclude template="includes/sidebar.cfm">

    <div class="container pageTitle">
        <h3>Grades Due</h3>
    </div>

    <div class="results-Table">
        <table>
            <tr>
                <td><strong>Course Code</strong></td>
                <td><strong>Course Name</strong></td>
                <td><strong>Section</strong></td>>
                <td><strong>Grades Due</strong></td>
            </tr>

            <cfloop query="GradesDueDate_Query">
                <cfoutput>
                <tr>
                    <td>#GradesDueDate_Query.Course_Code#</td>
                    <td><a href="course_details.cfm?CourseID=#URLEncodedFormat(Trim(GradesDueDate_Query.ID))#">#GradesDueDate_Query.Course_Name#</a></td>
                    <td>#GradesDueDate_Query.Section#</td>
                    <td>
                        <cfinvoke component="Functions"
                                    method="DateNullChecker"
                                    value="#GradesDueDate_Query.Grades_Due#">
                    </td>
                </tr>
                </cfoutput>
            </cfloop>

        </table>
    </div>

<cfinclude template="includes/footer.cfm">