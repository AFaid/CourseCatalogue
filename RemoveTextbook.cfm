<!---
Name: Ahmed Faid
Description: Removes Textbook from textbooks table and moves it to deleted textbooks table
--->
<cfquery datasource="WCSTracking" name="TextbookInfo_Query">
    SELECT ISBN, Title, Author, Edition, Publisher
    FROM Textbooks
    WHERE ISBN = <cfqueryparam value="#URL.ISBN#" cfsqltype="cf_sql_varchar">
</cfquery>

<!---Creates a copy of text book in deleted textbook page for potential recovery--->
<cfquery datasource="WCSTracking" name="TextbookBackupCopy_Query">
    INSERT INTO Deleted_Textbooks (ISBN, Title, Author, Edition, Publisher)
    SELECT ISBN, Title, Author, Edition, Publisher
    FROM Textbooks
    WHERE ISBN = <cfqueryparam value="#URL.ISBN#" cfsqltype="cf_sql_varchar">
</cfquery>

<!---sets textbook backup delete date and permanent delete date 3 days later--->
<cfquery datasource="WCSTracking" name="TextbookDateDeleted_Query">
    UPDATE Deleted_Textbooks 
    SET Day_Deleted = getdate(),
        Recovery_Deadline = dateadd(week, 1, getdate())
    WHERE ISBN = <cfqueryparam value="#URL.ISBN#" cfsqltype="cf_sql_varchar"> AND Day_Deleted is null
</cfquery>

<!--Deletes textbook from database--->
<cfquery datasource="WCSTracking" name="DeleteTextbook_Query">
    DELETE FROM Textbooks
    WHERE ISBN = <cfqueryparam value="#URL.ISBN#" cfsqltype="cf_sql_varchar">
</cfquery>

<!---Deletes any reference to the textbook--->
<cfquery datasource="WCSTracking" name="DeleteTextbookRef_Query">
    UPDATE Course
    SET Textbook_ISBN = null
    WHERE Textbook_ISBN = <cfqueryparam value="#URL.ISBN#" cfsqltype="cf_sql_varchar">
</cfquery>


<cflocation url="textbooks.cfm?textbook_removed=#URLEncodedFormat('yes')#&title=#URLEncodedFormat(TRIM(TextbookInfo_Query.Title))#">