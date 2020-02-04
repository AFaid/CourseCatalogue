<!--Name: Ahmed Faid
    Date: June 20th 2019
    Description: Adds a textbook to database-->

<cfdump var="#FORM#">
<cfquery datasource="WCSTracking" name="BookDuplicate_Query">
    SELECT ISBN FROM TEXTBOOKS
    WHERE ISBN = '#FORM.ISBN_TextBoxINS#'
</cfquery>

<cfdump var="#BookDuplicate_Query.RecordCount#">

<cfif #BookDuplicate_Query.RecordCount# eq 0>
    <cfquery datasource="WCSTracking">
        INSERT INTO Textbooks(ISBN 
        <cfif FORM.Title_TextBoxINS NEQ "">
            ,Title
        </cfif>
        <cfif FORM.Edition_TextBoxINS NEQ "">
            ,Edition
        </cfif>
        <cfif FORM.Author_TextBoxINS NEQ "">
            ,Author
        </cfif>
        <cfif FORM.Publisher_TextBoxINS NEQ "">
            ,Publisher
        </cfif>)

        VALUES ('#FORM.ISBN_TextBoxINS#' 
        <cfif FORM.Title_TextBoxINS NEQ "">
            ,'#FORM.title_TextBoxINS#'
        </cfif>
        <cfif FORM.Edition_TextBoxINS NEQ "">
            , #FORM.Edition_TextBoxINS#
        </cfif>
        <cfif FORM.Author_TextBoxINS NEQ "">
            ,'#FORM.Author_TextBoxINS#'
        </cfif>
        <cfif FORM.Publisher_TextBoxINS NEQ "">
            ,'#FORM.publisher_TextBoxINS#'
        </cfif>)

    </cfquery>

    <cfquery datasource="WCSTracking">
        UPDATE Course
        SET Textbook_ISBN = '#FORM.ISBN_TextBoxINS#'
        WHERE ID = '#FORM.CourseID#'
    </cfquery>

    <cflocation url="insert.cfm?added=#URLEncodedFormat(1)#">

<cfelse>

    <cflocation url="insertTextbook.cfm?ISBN_exists=#URLEncodedFormat('true')#&CourseID=#URLEncodedFormat(TRIM(FORM.CourseID))#">

</cfif>

