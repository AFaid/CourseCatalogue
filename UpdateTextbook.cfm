<!---
Name: Ahmed Faid
Description: Update Textbook screen
--->

<cfparam name="URL.textbook_exists" default="false">

<cfquery datasource="WCSTracking" name="TextbookInfo_Query">
    SELECT ISBN, Title, Edition, Author, Publisher
    FROM Textbooks
    WHERE ISBN = <cfqueryparam value="#URL.ISBN#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfinclude template="includes/header.cfm">
<cfinclude template="includes/sidebar.cfm">

<cfoutput>
    <div class="alert alert-danger" role="alert" <cfif #URL.textbook_exists# EQ 'true'> style="display: block"<cfelse> style="display: none"</cfif>>
        <strong> ERROR!</strong> The ISBN inserted already belongs to a textbook
    </div>
    
    <div class="pageTitle">
        <br><h2>Update "#TextbookInfo_Query.Title#"</h2>
    </div>
   
    <div class="advSearch">
        <cfform action="UpdateTextbookAction.cfm">

            <input type="hidden" name="TextbookKey" value="#URL.ISBN#">

            <label>ISBN: </label>
            <input type="text"
                    name="ISBN_TextBoxUPD"
                    id="ISBN"
                    required
                    pattern="[0-9]{13}"
                    title="13 digits"
                    maxlength="13"
                    minlength="13"
                    autocomplete="off"
                    value="#TextbookInfo_Query.ISBN#">

            <label>Title: </label>
            <input type="text"
                    name="title_TextBoxUPD"
                    size="30"
                    maxlength="50"
                    autocomplete="off"
                    value="#TextbookInfo_Query.Title#">

            <label>Edition: </label>
            <input type="text"
                    name="edition_TextBoxUPD"
                    maxlength="2"
                    autocomplete="off"
                    value= "#TextbookInfo_Query.Edition#">

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
</cfoutput>

<cfinclude template="includes/footer.cfm">