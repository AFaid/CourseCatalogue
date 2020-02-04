<!--
Name: Ahmed Faid
Date: June 19 2019
Description: A list of courses and due dates for books
-->
<cfquery datasource="WCSTracking" name="TextDueDate_Query">
    SELECT Course.ID, Course.Course_Code, Course.Course_Name, Course.Section, Course.Text_Due, Textbooks.Title, Textbooks.Author
    FROM Course INNER JOIN Textbooks
    ON Course.Textbook_ISBN = Textbooks.ISBN
    JOIN CourseChecklist ON Course.ID=CourseChecklist.ID 
    WHERE CourseChecklist.Text_Recieved = 0 AND Course.Text_Due IS NOT NULL
    ORDER BY Course.Text_Due ASC
</cfquery>

<cfinclude template="includes/header.cfm">
<cfinclude template="includes/sidebar.cfm">

    <div class="pageTitle">
        <h3>Textbooks Due</h3>
    </div>
    
    <div class="results-Table">
        <table>
            <tr>
                <td><strong>Course Code</strong></td>
                <td><strong>Course Name</strong></td>
                <td><strong>Section</strong></td>
                <td><strong>Textbook Title</strong></td>
                <td><strong>Author</strong></td>
                <td><strong>Text Due</strong></td>
            </tr>

            <cfloop query="TextDueDate_Query">
                <cfoutput>
                <tr>
                    <td>#TextDueDate_Query.Course_Code#</td>
                    <td><a href="course_details.cfm?CourseID=#URLEncodedFormat(Trim(TextDueDate_Query.ID))#">#TextDueDate_Query.Course_Name#</a></td>
                    <td>#TextDueDate_Query.Section#</td>
                    <td>#TextDueDate_Query.Title#</td>
                    <td>#TextDueDate_Query.Author#</td>
                    <td>
                    <cfinvoke component="Functions"
                              method="DateNullChecker"
                              value="#TextDueDate_Query.Text_Due#">
                    </td>
                </tr>
                </cfoutput>
            </cfloop>

        </table>
    </div>
    
<cfinclude template="includes/footer.cfm">