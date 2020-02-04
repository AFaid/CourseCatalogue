
<cfquery datasource="WCSTracking" name="TextbookInfo_Query">
    SELECT ISBN, Title, Edition, Author, Publisher
    FROM Textbooks
    WHERE ISBN = <cfqueryparam value="#URL.ISBN#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfquery datasource="WCSTracking" name="courseList_Query">
    SELECT DISTINCT Course_Name
    FROM Course
    WHERE Textbook_ISBN = <cfqueryparam value="#URL.ISBN#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfinclude template="includes/header.cfm">
<cfinclude template="includes/sidebar.cfm">

        <cfoutput>
        <br>
        <div class="details-Table">
            <table>
                <tr>
                    <div class="pageTitle">
                        <h4>#TextbookInfo_Query.Title#</h4><br>
                        <div class="floatRight link">
                            <a href="UpdateTextbook.cfm?ISBN=#URLEncodedFormat(Trim(TextbookInfo_Query.ISBN))#">[Update]</a>
                            <a href="RemoveTextbook.cfm?ISBN=#URLEncodedFormat(Trim(TextbookInfo_Query.ISBN))#">[Remove]</a>
                        </div>
                        <br>
                    </div>
                </tr>
                <tr>
                    <td><span class="bold">Author: </span> #TextbookInfo_Query.Author#</td>
                    <td><span class="bold">Publisher: </span> #TextbookInfo_Query.Publisher#</td>
                    <td><span class="bold">ISBN: </span> #TextbookInfo_Query.ISBN#</td>
                    <td><span class="bold">Editon: </span> #TextbookInfo_Query.Edition#</td>
                </tr>
                <tr>
                    <td colspan="4"><span class="bold">Courses: </span><br>
                       <cfif #CourseList_Query.RecordCount# gt 0>
                            <cfloop query="CourseList_Query">#CourseList_Query.Course_Name#, </cfloop>
                       <cfelse>
                           N/A
                       </cfif>
                    </td>
                </tr>
            </table>

        </div>
        </cfoutput>

<cfinclude template="includes/footer.cfm">
