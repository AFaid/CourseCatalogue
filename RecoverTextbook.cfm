<!---
Name: Ahmed Faid
Description: Moves Textbook from deleted textbooks table to textbooks table
--->

<!---Checks textbooks for same isbn--->
<cfquery datasource="WCSTracking" name="TextbookChecker_Query">
    SELECT ISBN
    FROM Textbooks
    WHERE ISBN = <cfqueryparam value="#URL.ISBN#" cfsqltype="cf_sql_varchar">
</cfquery>

<!---If no textbooks have the same ISBN add textbook to textbooks table and delete it from deleted textbooks table--->
<cfif #TextbookChecker_Query.RecordCount# EQ 0>
    <cfquery datasource="WCSTracking" name="recoverTextbook_Query">
        INSERT INTO Textbooks (ISBN, Title, Author, Edition, Publisher)
        SELECT ISBN, Title, Author, Edition, Publisher
        FROM Deleted_Textbooks
        WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfquery datasource="WCSTracking" name="DeleteBackupCopy_Query">
        DELETE FROM Deleted_Textbooks
        WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_varchar">
    </cfquery>

<!---If there is a textbook with the same ISBN swap it with the textbook in the deleted textbooks table--->
<cfelse>
    <cfquery datasource="WCSTracking" name="DuplicateBackupCopy">
        INSERT INTO Deleted_Textbooks (ISBN, Title, Author, Edition, Publisher)
        SELECT ISBN, Title, Author, Edition, Publisher
        FROM Textbooks
        WHERE ISBN = <cfqueryparam value="#URL.ISBN#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfquery datasource="WCSTracking" name="DeleteDuplicate_Query">
        DELETE FROM Textbooks
        WHERE ISBN = <cfqueryparam value="#URL.ISBN#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfquery datasource="WCSTracking" name="recoverTextbook_Query">
        INSERT INTO Textbooks (ISBN, Title, Author, Edition, Publisher)
        SELECT ISBN, Title, Author, Edition, Publisher
        FROM Deleted_Textbooks
        WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfquery datasource="WCSTracking" name="DeleteBackupCopy_Query">
        DELETE FROM Deleted_Textbooks
        WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_varchar">
    </cfquery>

</cfif>

<cflocation url="deleted.cfm">
