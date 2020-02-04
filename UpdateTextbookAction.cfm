<!---
Name: Ahmed Faid
Description: Update Textbook Information
--->
<cfquery datasource="WCSTracking" name="CheckTextbook_Query">
    SELECT ISBN
    FROM Textbooks
    WHERE ISBN = '#TRIM(FORM.ISBN_TextBoxUPD)#' AND ISBN <> '#FORM.TextbookKey#'
</cfquery>

<cfif #CheckTextbook_Query.RecordCount# EQ 0>
    <cfquery datasource="WCSTracking">
        UPDATE textbooks
        <cfif #TRIM(FORM.ISBN_TextBoxUPD)# NEQ "">
            SET ISBN = '#TRIM(FORM.ISBN_TextBoxUPD)#',
        </cfif>
        <cfif #TRIM(FORM.title_TextBoxUPD)# NEQ "">
            title = '#TRIM(FORM.title_TextBoxUPD)#',
        </cfif>
        edition = '#TRIM(FORM.edition_TextBoxUPD)#',
        author = '#TRIM(FORM.author_TextBoxUPD)#',
        publisher = '#TRIM(FORM.publisher_TextBoxUPD)#'

        WHERE ISBN = '#FORM.TextbookKey#'
    </cfquery>

    <cfquery datasource="WCSTracking">
        UPDATE Course
        SET Textbook_ISBN =  '#TRIM(FORM.ISBN_TextBoxUPD)#'
        WHERE Textbook_ISBN = '#FORM.TextbookKey#'
    </cfquery>

    <cflocation URL="textbooks.cfm">

<cfelse>
    <cflocation URL="UpdateTextbook.cfm?ISBN=#URLEncodedFormat(Trim(FORM.TextbookKey))#&textbook_exists=#URLEncodedFormat('true')#">
</cfif>