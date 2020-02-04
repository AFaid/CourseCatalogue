<!---
Name: Ahmed Faid
Description: Removes instructor from instructor table and adds it to deleted instructor table
--->

<!---Gets instructor information to be added to deleted instructors table--->
<cfquery datasource="WCSTracking" name="InstructorInfo_Query">
    SELECT Instructor_Name, Instructor_Email, Instructor_Status, Instructor_New, Instructor_NewEnd
    FROM Instructors
    WHERE ID = <cfqueryparam value="#URL.InstructorID#" cfsqltype="cf_sql_integer">
</cfquery>

<!---Instructor added to deleted instructors table and deleted from instructors table--->
<cfquery datasource="WCSTracking">
    INSERT INTO Deleted_Instructors (Instructor_Name, Instructor_Email, Instructor_Status, Instructor_New, Instructor_NewEnd, day_Deleted, recovery_Deadline)
    VALUES ('#InstructorInfo_Query.Instructor_Name#', '#InstructorInfo_Query.Instructor_Email#', '#InstructorInfo_Query.Instructor_Status#',
                '#InstructorInfo_Query.Instructor_New#', '#InstructorInfo_Query.Instructor_NewEnd#', getdate(), dateadd(week, 1, getdate()))

    DELETE FROM Instructors
    WHERE ID = <cfqueryparam value="#URL.InstructorID#" cfsqltype="cf_sql_integer">
</cfquery>

<!---Instructor removed from all courses linked to him/her--->
<cfquery datasource="WCSTracking">
    UPDATE Course
    SET Instructor_ID = null
    WHERE Instructor_ID = <cfqueryparam value="#URL.InstructorID#" cfsqltype="cf_sql_integer">
</cfquery>

<cflocation url="instructors.cfm?instructor_removed=#URLEncodedFormat('true')#&name=#URLEncodedFormat(TRIM(InstructorInfo_Query.Instructor_Name))#">