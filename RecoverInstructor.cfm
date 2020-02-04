<!---
Name: Ahmed Faid
Description: Removes instructor from deleted instructors table and adds it to instructor table
--->

<cfquery datasource="WCSTracking" name="InstructorBackupCopy_Query">
    INSERT INTO Instructors (Instructor_Name, Instructor_Email, Instructor_Status, Instructor_New, Instructor_NewEnd)
    SELECT Instructor_Name, Instructor_Email, Instructor_Status, Instructor_New, Instructor_NewEnd
    FROM Deleted_Instructors
    WHERE ID = <cfqueryparam value="#URL.InstructorID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfquery datasource="WCSTracking" name="DeleteInstructor_Query">
    DELETE FROM Deleted_Instructors
    WHERE ID = <cfqueryparam value="#URL.InstructorID#" cfsqltype="cf_sql_integer">
</cfquery>

<cflocation url="deleted.cfm">