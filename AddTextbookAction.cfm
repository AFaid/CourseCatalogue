<!--Name: Ahmed Faid
    Date: June 20th 2019
    Description: Adds a textbook to database-->

<cfdump var="#FORM#">
<cfquery datasource="WCSTracking" name="BookDuplicate_Query">
    SELECT ISBN FROM TEXTBOOKS
    WHERE ISBN = '#FORM.ISBN_TextBoxADD#'
</cfquery>

<cfdump var="#BookDuplicate_Query.RecordCount#">

<cfif #BookDuplicate_Query.RecordCount# eq 0>
    <cfquery datasource="WCSTracking">
        INSERT INTO Textbooks(ISBN 
        <cfif FORM.Title_TextBoxADD NEQ "">
            ,Title
        </cfif>
        <cfif FORM.Edition_TextBoxADD NEQ "">
            ,Edition
        </cfif>
        <cfif FORM.Author_TextBoxADD NEQ "">
            ,Author
        </cfif>
        <cfif FORM.Publisher_TextBoxADD NEQ "">
            ,Publisher
        </cfif>)

        VALUES ('#FORM.ISBN_TextBoxADD#' 
        <cfif FORM.Title_TextBoxADD NEQ "">
            ,'#FORM.title_TextBoxADD#'
        </cfif>
        <cfif FORM.Edition_TextBoxADD NEQ "">
            , #FORM.Edition_TextBoxADD#
        </cfif>
        <cfif FORM.Author_TextBoxADD NEQ "">
            ,'#FORM.Author_TextBoxADD#'
        </cfif>
        <cfif FORM.Publisher_TextBoxADD NEQ "">
            ,'#FORM.publisher_TextBoxADD#'
        </cfif>)

    </cfquery>

    <cfquery datasource="WCSTracking">
        UPDATE Course
        SET Textbook_ISBN = Textbook_ISBN + ',#FORM.ISBN_TextBoxADD#'
        WHERE ID = '#FORM.CourseID#' AND Textbook_ISBN IS NOT NULL
    </cfquery>    
    
    <cfquery datasource="WCSTracking">
        UPDATE Course
        SET Textbook_ISBN = '#FORM.ISBN_TextBoxADD#'
        WHERE ID = '#FORM.CourseID#' AND Textbook_ISBN IS NULL
    </cfquery>

    <cflocation url="Course_Details.cfm?CourseID=#URLEncodedFormat(TRIM(FORM.CourseID))#">

<cfelse>

    <cflocation url="AddTextbook.cfm?ISBN_exists=#URLEncodedFormat('true')#&CourseID=#URLEncodedFormat(TRIM(FORM.CourseID))#">

</cfif>