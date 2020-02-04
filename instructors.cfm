<!---
Name: Ahmed Faid
Description: List of all instructors
--->

<cfparam name="FORM.InstructorSearch" default="">
<cfparam name="URL.instructor_removed" default="">
<cfparam name="URL.name" default="">

<cfquery datasource="WCSTracking" name="InstructorInfo_Query">
    SELECT id, instructor_name, instructor_email, Instructor_New, Instructor_Status 
    FROM Instructors
    WHERE 0=0
<cfif FORM.InstructorSearch NEQ "">
    AND instructor_name LIKE <cfqueryparam value="#FORM.InstructorSearch#" cfsqltype="varchar">
</cfif>
</cfquery>

<cfinclude template="includes/header.cfm">
<cfinclude template="includes/sidebar.cfm">

<div <cfif #URL.instructor_removed# EQ 'true'>class="alert alert-warning" role="alert" <cfelse>class="hide"</cfif>>
    <cfoutput>
        <strong>Warning!</strong> #URL.name# was Deleted from Instructors
    </cfoutput>
</div>

<div class="container pageTitle">
    <h3>INSTRUCTORS LIST</h3>
</div>

<cfform action="instructors.cfm">
    <cfoutput>
        <div class="searchBar">
            <input type="search" name="instructorSearch" placeholder="Name" value="#FORM.InstructorSearch#" autocomplete="off">
            <input type="submit" value="Search">
        </div>
    </cfoutput>
</cfform>

<div class="results-Table">
    <table>
        <tr>

            <td><span class="bold">ID</span></td>
            <td width="10%"><Strong>New/Returning</strong></td>
            <td width="10%"><strong>Status</strong></td>
            <td><span class="bold">Instructor Name</span></td>
            <td><span class="bold">Instructor Email</span></td>
            <td width="7%"></td>
            <td width="7%"></td>

        <cfloop query="InstructorInfo_Query">
            <cfoutput>
            <tr class="lowercase">
                <td>#InstructorInfo_Query.ID#</td>
                <td><cfif #InstructorInfo_Query.Instructor_New# EQ 1><strong>New</strong><cfelse>Returning</cfif>
                <td>#InstructorInfo_Query.Instructor_Status#</td>
                <td>
                    <cfinvoke component="Functions"
                                method="DateNullChecker"
                                Value="#InstructorInfo_Query.Instructor_Name#">
                </td>
                <td>
                    <cfinvoke component="Functions"
                                method="DateNullChecker"
                                Value="#InstructorInfo_Query.Instructor_Email#">
                </td>
                <td><a href="UpdateInstructor.cfm?InstructorID=#URLEncodedFormat(TRIM(InstructorInfo_Query.ID))#">Update</a></td>
                <td><a href="removeInstructor.cfm?InstructorID=#URLEncodedFormat(TRIM(InstructorInfo_Query.ID))#">Remove</a></td>
            </tr>
            </cfoutput>
        </cfloop>
    </table>
</div>

<cfinclude template="includes/footer.cfm">
