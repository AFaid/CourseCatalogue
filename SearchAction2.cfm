
<cfparam name="FORM.TextOrdered_CheckBox" default="1">
<cfparam name="FORM.TextInStock_CheckBox" default="1">
<cfparam name="FORM.OWLSiteReviewed_CheckBox" default="1">
<cfparam name="FORM.OWLReadyToPublish_CheckBox" default="1">
<cfparam name="FORM.OWLSiteCreated_CheckBox" default="1">

<cfquery datasource="WCSTracking" name="CourseInfo_Query">
    SELECT Course.ID, Course_Name, Course_Code, section, Delivery, Course_Start, Course_End, Instructor_ID,
            Course_Days, Course_Evaluation, Text_Required, OWL_Required, Start_Time, End_Time
    FROM Course
    JOIN CourseChecklist ON Course.ID = CourseChecklist.ID
    WHERE 0=0
    <cfif FORM.TextOrdered_CheckBox NEQ 1>
        AND Text_Ordered = 0
        AND Text_Required = 'yes'
    </cfif>
    <cfif FORM.TextInStock_CheckBox NEQ 1>
        AND Text_InStock = 0
        AND Text_Required = 'yes'
    </cfif>
    <cfif FORM.OWLSiteCreated_CheckBox NEQ 1>
        AND OWL_SiteCreated = 0
        AND (OWL_Required = 'copysite' OR OWL_Required = 'BlankSite')
    </cfif>
    <cfif FORM.OWLSiteReviewed_CheckBox NEQ 1>
        AND OWL_SiteReviewed = 0
        AND (OWL_Required = 'copysite' OR OWL_Required = 'BlankSite')
    </cfif>
    <cfif FORM.OWLReadyToPublish_CheckBox NEQ 1>
        AND OWL_ReadyToPublish = 0
        AND (OWL_Required = 'copysite' OR OWL_Required = 'BlankSite')
    </cfif>
</cfquery>

<cfinclude template="includes/header.cfm">

<cfoutput>
    <div class="container pageTitle">
        <h3>#CourseInfo_Query.RecordCount# Search Results</h3>
    </div>
</cfoutput>


<div class="results-Table">
    <table>
        <tr>
            <td>
                <strong>Course Code</strong>
            </td>
            <td>
                <strong>Section</strong>
            </td>
            <td>
                <strong>Course Name</strong>
            </td>
            <td>
                <strong>Instructor</strong>
            </td>
            <td>
                <strong>Delivery</strong>
            </td>
            <td>
                <strong>Start Date</strong>
            </td>
            <td>
                <strong>End Date</strong>
            </td>
            <td>
                <strong>Textbook Required</strong>
            </td>
            <td>
                <strong>OWL Required</strong>
            </td>
        </tr>

        <cfloop query="CourseInfo_Query">
            <cfoutput>
            <tr>
                <td class="uppercase">
                    <!--Link to a page with more information about each indvidual key-->
                    #CourseInfo_Query.Course_Code#
                </td>
                <td>
                    #CourseInfo_Query.Section#
                </td>
                <td>
                    <a href="Course_Details.cfm?CourseID=#URLEncodedFormat(Trim(ID))#">#CourseInfo_Query.Course_Name# </a>
                </td>
                <td>
                    <cfif #CourseInfo_Query.Instructor_ID# NEQ "">
                        <cfinvoke component="Queries"
                                  method="InstructorName_Getter"
                                  InstructorID="#CourseInfo_Query.Instructor_ID#">
                            <cfelse>
                                TBA
                    </cfif>
                </td>
                <td>
                    #CourseInfo_Query.Delivery#
                </td>
                <td>
                    <!--Uses DateNullChecker function to display "TBA" for dates which havent been entered (NULL)-->
                    <cfinvoke component="Functions"
                              method="DateNullChecker"
                              Value="#CourseInfo_Query.Course_Start#">
                </td>
                <td>
                    <!--Uses DateNullChecker function to display "TBA" for dates which havent been entered (NULL)-->
                    <cfinvoke component="Functions"
                              method="DateNullChecker"
                              Value="#CourseInfo_Query.Course_End#">
                </td>
                <td>
                    #CourseInfo_Query.Text_Required#
                </td>
                <td>
                    #CourseInfo_Query.OWL_Required#
                </td>
            </tr>
            </cfoutput>
        </cfloop>
    </table>
</div>

<cfinclude template="includes/footer.cfm">