<cfquery datasource="WCSTracking" name="TextbookChecker_Query">
    select * from textbooks where isbn = '#TRIM(FORM.ISBN_TextBoxUPD)#' and isbn <> '#FORM.TextbookKey#'
</cfquery>

<cfif #TextbookChecker_Query.RecordCount# eq 0 AND FORM.ISBN_TextBoxUPD NEQ #FORM.TextbookKey#>
    <cfquery datasource="WCSTracking">
        INSERT INTO Textbooks(ISBN, Title, Edition, Author, Publisher)
        VALUES ('#TRIM(FORM.ISBN_TextBoxUPD)#', '#TRIM(FORM.title_TextBoxUPD)#', '#TRIM(FORM.edition_TextBoxUPD)#',
        '#TRIM(FORM.author_TextBoxUPD)#', '#TRIM(FORM.publisher_TextBoxUPD)#')

        UPDATE Course
        SET Textbook_ISBN =  '#TRIM(FORM.ISBN_TextBoxUPD)#'
        WHERE ID = '#FORM.CourseKey#'
    </cfquery>

    <cflocation url="Course_Details.cfm?CourseID=#FORM.CourseKey#">

<cfelseif #TextbookChecker_Query.RecordCount# eq 0 AND FORM.ISBN_TextBoxUPD EQ #FORM.TextbookKey#>
    <cfquery datasource="WCSTracking">
        UPDATE Textbooks
        SET Title = '#TRIM(FORM.title_TextBoxUPD)#',
        Edition = '#TRIM(FORM.edition_TextBoxUPD)#',
        author = '#TRIM(FORM.author_TextBoxUPD)#',
        publisher = '#TRIM(FORM.publisher_TextBoxUPD)#'
        WHERE ISBN = '#TRIM(FORM.ISBN_TextBoxUPD)#'
    </cfquery>

    <cflocation url="Course_Details.cfm?CourseID=#FORM.CourseKey#">

<cfelseif #TextbookChecker_Query.RecordCount# GT 0>

    <cflocation url="UpdateCourseTextbook.cfm?ID=#FORM.CourseKey#&ISBN_exists=#URLEncodedFormat('true')#">

</cfif>



