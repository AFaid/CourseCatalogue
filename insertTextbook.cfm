<!--Name: Ahmed Faid
    Date: June 20th 2019
    Description: Form to add a textbook to database-->

<cfparam name="url.ISBN_exists" default="">

<cfinclude template="includes/header.cfm">


<cfquery datasource="WCSTracking" name="textbookInfo_Query">
    SELECT ISBN, Title, Edition, Author, Publisher
    FROM Textbooks
</cfquery>

    <cfoutput>

        <div <cfif #URL.ISBN_exists# EQ 'true'>class="alert alert-danger" role="alert" <cfelse>class="hide"</cfif>>
            <strong>ERROR!</strong> Textbook with this ISBN Already Exists in Database
        </div> 

        <div class="pageTitle">
            <h2>Add Textbook</h2>
        </div>

        <div class="advSearch">
            <cfform action="insertTextbookAction.cfm">

                <input type="hidden" name="CourseID" value="#URL.CourseID#">

                <label>ISBN: </label>
                <input type="text"
                        name="ISBN_TextBoxINS"
                        required
                        pattern="[0-9]{13}"
                        title="13 digits"
                        maxlength="13"
                        minlength="13"
                        autocomplete="off">

                <label>Title: </label>
                <input type="text"
                        name="title_TextBoxINS"
                        size="30"
                        required
                        maxlength="50"
                        autocomplete="off">

                <label>Edition: </label>
                <input type="text"
                       name="edition_TextBoxINS"
                       maxlength="2"
                       autocomplete="off">

                <label>Author: </label>
                <input type="text"
                       name="author_TextBoxINS"
                       size="30"
                       maxlength="50"
                       autocomplete="off">

                <label>Publisher: </label>
                <input type="text"
                       name="publisher_TextBoxINS"
                       size="30"
                       maxlength="50"
                       autocomplete="off"><br><br>
        </div>

                <input type="submit" name="submit" id="submitBtn"><br><br>
            </cfform>
        </div>
        
    <label> </label>

    </cfoutput>
        
        <cfform action="insertTextbookAction2.cfm">

            <cfoutput>
                <input type="hidden" name="CourseID" value="#URL.CourseID#">
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
                    <cfoutput query="textbookInfo_Query">
                        <tr class="lowercase">
                            <td><input type="radio" name="ExistingTextbookISBN_RadioBoxINS" value="#TextbookInfo_Query.ISBN#"></td>
                            <td>#TextbookInfo_Query.ISBN#</td>
                            <td>#TextbookInfo_Query.Title#</td>
                            <td><cfinvoke component="Functions"
                                          method="StringNullChecker"
                                          value="#TextbookInfo_Query.Author#">
                            </td>
                            <td><cfinvoke component="Functions"
                                          method="StringNullChecker"
                                          value="#TextbookInfo_Query.Edition#">
                            </td>
                            <td><cfinvoke component="Functions"
                                          method="StringNullChecker"
                                          value="#TextbookInfo_Query.Publisher#">
                            </td>
                        </tr>
                    </cfoutput>
                </table>

                <input type="submit" name="submit" id="submitBtn">
            </div>
        </cfform>

<cfinclude template="includes/footer.cfm/">