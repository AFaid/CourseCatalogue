<cfparam name="url.ISBN_exists" default="">

<!---gets textbook isbn of the course--->
<cfquery datasource="WCSTracking" name="TextbookISBN_Query">
    SELECT Textbook_ISBN
    FROM Course
    WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfquery datasource="WCSTracking" name="ExistingTextbooks_Query">
    SELECT ISBN, Title, Edition, Author, Publisher
    FROM Textbooks
</cfquery>

<!---gets textbook information--->
<cfquery datasource="WCSTracking" name="TextbookInfo_Query">
    SELECT ISBN, Title, Edition, Author, Publisher
    FROM Textbooks
    WHERE ISBN = '#TextbookISBN_Query.Textbook_ISBN#'
</cfquery>

<cfinclude template="includes/header.cfm">

<!---populate form fields with textbook information--->    
<cfoutput>

    
    <div class="alert alert-danger" role="alert" <cfif #URL.ISBN_exists# EQ 'true'>style="display: block"<cfelse>style="display:none"</cfif>>
        <strong>ERROR!</strong> Textbook Already Exists in Database
    </div>  

    <div class="pageTitle">
        <br><h2>Update "#TextbookInfo_Query.Title#"</h2>
    </div>

    <div class="advSearch">
        <cfform action="UpdateCourseTextbookAction.cfm">

            <input type="hidden" name="TextbookKey" value="#TextbookISBN_Query.Textbook_ISBN#">
            <input type="hidden" name="CourseKey" value="#URL.ID#">

            <label>ISBN: </label>
            <input type="text"
                    name="ISBN_TextBoxUPD"
                    id="ISBN"
                    pattern="[0-9]{13}"
                    title="13 digits"
                    maxlength="13"
                    minlength="13"
                    autocomplete="off"
                    value="#TextbookInfo_Query.ISBN#"
                    required>

            <label>Title: </label>
            <input type="text"
                    name="title_TextBoxUPD"
                    required
                    size="30"
                    maxlength="50"
                    autocomplete="off"
                    value="#TextbookInfo_Query.Title#">

            <label>Edition: </label>
            <input type="text"
                    name="edition_TextBoxUPD"
                    maxlength="2"
                    autocomplete="off"
                    value="#TextbookInfo_Query.Edition#">

            <label>Author: </label>
            <input type="text"
                    name="author_TextBoxUPD"
                    size="30"
                    maxlength="50"
                    autocomplete="off"
                    value="#TextbookInfo_Query.Author#">

            <label>Publisher: </label>
            <input type="text"
                    name="publisher_TextBoxUPD"
                    size="30"
                    maxlength="50"
                    autocomplete="off"
                    value="#TextbookInfo_Query.Publisher#"><br><br>
    </div>

        <input type="submit" name="submit" id="submitBtn"><br><br>
        </cfform>
    </div>
</cfoutput>


    <cfform action="UpdateCourseTextbookAction2.cfm">

    <cfoutput>
        <input type="hidden" name="CourseKey" value="#URL.ID#">
    </cfoutput>

    <div class="container pageTitle">
        <h2>Or Choose One of the Following Options</h2>
    </div>

    <div class="container results-Table">
        <table>
            <tr>
                <td></td>
                <td><strong>ISBN</strong></td>
                <td><strong>Title</strong></td>
                <td><strong>Author</strong></td>
                <td><strong>Edition</strong></td>
                <td><strong>Publisher</strong></td>
            </tr>
            <cfoutput query="ExistingTextbooks_Query">
                <tr class="lowercase">
                    <td><input type="radio" name="ExistingTextbookISBN_RadioBoxINS" value="#ExistingTextbooks_Query.ISBN#"></td>
                    <td><cfinvoke component="Functions"
                                method="StringNullChecker"
                                Value="#ExistingTextbooks_Query.ISBN#">
                    </td>                    
                    <td><cfinvoke component="Functions"
                                method="StringNullChecker"
                                Value="#ExistingTextbooks_Query.Title#">
                    </td>                    
                    <td><cfinvoke component="Functions"
                                method="StringNullChecker"
                                Value="#ExistingTextbooks_Query.Author#">
                    </td>                    
                    <td><cfinvoke component="Functions"
                                method="StringNullChecker"
                                Value="#ExistingTextbooks_Query.Edition#">
                    </td>
                    <td><cfinvoke component="Functions"
                                method="StringNullChecker"
                                Value="#ExistingTextbooks_Query.Publisher#">
                    </td>
                </tr>
            </cfoutput>
        </table>

        <input type="submit" name="submit" id="submitBtn">
    </div>
</cfform>

<cfinclude template="includes/footer.cfm">