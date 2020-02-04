<!---
Name: Ahmed Faid
Date: June 3rd 2019
Descrption: Details about every course
--->

<!---Gets information about course--->
<cfquery datasource="WCSTracking" name="CourseInfo_Query">
    SELECT ID, Course_Type, Course_Code, Course_Name, Section, Delivery, Course_Days,
        Course_Start, Course_End, Text_Required, OWL_Required, Textbook_ISBN,
        Course_Evaluation, Start_Time, End_Time, Contract_Due, Text_Due, Owl_Due, Instructor_ID,
        CourseOutline_Due, Reminder_Due, Evaluation_Due, Grades_Due, Course_Notes, Canceled
    FROM Course
    WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfset textbook_String ="#CourseInfo_Query.Textbook_ISBN#">
<cfset textbook_Array = textbook_String.Split(",")>

<cfquery datasource="WCSTracking" name="TextbookInfo_Query">
    SELECT ISBN, Title, Edition, Author, Publisher
    FROM Textbooks
    WHERE 0=1
    <cfloop array="#textbook_Array#" index="text_ISBN">
        <cfoutput>
        <cfif #text_ISBN# NEQ "">
            OR ISBN = '#text_ISBN#'    
        </cfif>
        </cfoutput>
    </cfloop>
</cfquery>

<!---gets information about course's textbook if textbook is defined for course
<cfquery datasource="WCSTracking" name="TextbookInfo_Query">
    SELECT ISBN, Title, Edition, Author, Publisher
    FROM Textbooks
    <cfif #CourseInfo_Query.Textbook_ISBN# NEQ "">
        WHERE ISBN = '#CourseInfo_Query.Textbook_ISBN#'
    <cfelse>
        WHERE 0=1
    </cfif>
</cfquery>
--->


<!---gets information about course's instructor if instructor is defined for course--->
<cfquery datasource="WCSTracking" name="InstructorInfo_Query">
    SELECT Instructor_Name, Instructor_Email
    FROM Instructors
    <cfif #CourseInfo_Query.Instructor_ID# NEQ "">
        WHERE ID = #CourseInfo_Query.Instructor_ID#
    <cfelse>
        WHERE 0=1
    </cfif>
</cfquery>

<!---gets course checklist information--->
<cfquery datasource="WCSTracking" name="CourseChecklist_Query">
    SELECT ID, Text_Recieved, Outline_Recieved, Reminder_Sent, Eval_SEnt, GA_Added, Class_Emailed, Materials_Onfile,
        Contract_Sent, Contract_Recieved, Text_Ordered, Text_InStock, Text_WebsiteUpdated, Text_EmailedStudents,
        OWL_Site, OWL_SiteCreated, OWL_InstructorEmailed, OWL_SiteReviewed, Owl_ReadyToPublish, Website_Updated
    FROM CourseChecklist
    WHERE ID = <cfqueryparam value="#URL.CourseID#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfset complete = "false">

<cfinclude template="includes/header.cfm">
<cfinclude template="includes/sidebar.cfm">

    <cfoutput>

        <br>
        <!---Display course information--->
        <div class="normalCap details-Table">
            <table>
                <tr colspan="5">
                    <div class="pageTitle">
                        <cfif #CourseInfo_Query.Canceled# EQ 1> <h4><span class="orange">Canceled: </span></h4></cfif>
                        <h4>#CourseInfo_Query.Course_Name#</h4>
                        <!---Opens Note Pad (Note Pad Located at the bottom)--->
                        <span class="glyphicon glyphicon-envelope" aria-hidden="true"
                              onclick="myPopup('http://saber.registrar.uwo.pri/afaid/website/Email.cfm?InstructorID=#URLEncodedFormat(CourseInfo_Query.Instructor_ID)#', 'web', 1200, 500);"></span>
                        <br>
                        <div class="floatRight link">
                            <cfif #CourseInfo_Query.Canceled# EQ 0>
                                <a href="UpdateCourseDatabase.cfm?CourseID=#URLEncodedFormat(Trim(CourseInfo_Query.ID))#">[Update]</a>
                                <a href="CancelCourse.cfm?CourseID=#URLEncodedFormat(Trim(CourseInfo_Query.ID))#">[Cancel]</a>
                            <cfelse>
                                <a href="UncancelCourse.cfm?CourseID=#URLEncodedFormat(Trim(CourseInfo_Query.ID))#">[Uncancel]</a>
                            </cfif>
                            <a href="RemoveCourse.cfm?CourseID=#URLEncodedFormat(Trim(CourseInfo_Query.ID))#">[Remove]</a>
                        </div>
                        <h6>#CourseInfo_Query.Course_Code#</h6><br>
                        <h6>#CourseInfo_Query.Section#</h6>
                    </div>
                </tr>
                <br>
                <tr>
                    <td width="20%">
                        <span class="bold">Start Date: </span>
                        <!---Prints "TBA" if there is no value specified for start date--->
                        <cfinvoke component="Functions"
                                  method="DateNullChecker"
                                  value="#CourseInfo_Query.Course_Start#">
                    </td>
                    <td width="20%">
                        <span class="bold">End Date: </span>
                        <!---Prints "TBA" if there is no value specified for end date--->
                        <cfinvoke component="Functions"
                                  method="DateNullChecker"
                                  value="#CourseInfo_Query.Course_End#">
                    </td>
                    <td width="30%">
                        <span class="bold">Instructor: </span>
                        <!---Prints "TBA" if there is no value specified for instructor name--->
                        <cfif #InstructorInfo_Query.Instructor_Name# NEQ "">
                            #InstructorInfo_Query.Instructor_Name#
                            <cfelse>
                                TBA
                        </cfif>
                    </td>
                    <td width="30%">
                        <span class="bold">OWL Due: </span>
                        <!---Prints "TBA" if there is no value specified for textbook due date or "NA" if value doesn't exist--->
                        <cfif CourseInfo_Query.OWL_Required NEQ "no">
                            <cfinvoke component="Functions"
                                      method="DateNullChecker"
                                      value="#CourseInfo_Query.OWL_Due#">
                                <cfelse>
                                    N/A
                        </cfif>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span class="bold">Start Time: </span>
                        <!---Prints "TBA" if there is no value specified for start time--->
                        <cfinvoke component="Functions"
                                  method="TimeNullChecker"
                                  value="#CourseInfo_Query.Start_Time#">
                    </td>
                    <td>
                        <span class="bold">End Time: </span>
                        <!---Prints "TBA" if there is no value specified for end time--->
                        <cfinvoke component="Functions"
                                  method="TimeNullChecker"
                                  value="#CourseInfo_Query.End_Time#">
                    </td>
                    <td>
                        <span class="bold">Instructor Email: </span>
                        <!---Prints "TBA" if there is no value specified for course instructor's email--->
                        <cfinvoke component="Functions"
                                  method="StringNullChecker"
                                  value="#InstructorInfo_Query.Instructor_Email#">
                    </td>
                    <td>
                        <span class="bold">Course Outline Due: </span>
                        <!---Prints "TBA" if there is no value specified for course outline due date--->
                        <cfinvoke component="Functions"
                                  method="DateNullChecker"
                                  value="#CourseInfo_Query.CourseOutline_Due#">
                    </td>
                </tr>
                <tr>
                    <td>
                        <span class="bold">Course Evaluation: </span> #CourseInfo_Query.Course_Evaluation#
                    </td>
                    <td>
                        <span class="bold">Delivery: </span> #CourseInfo_Query.Delivery#
                    </td>
                    <td>
                        <span class="bold">Days:</span>
                        <!---Prints "TBA" if there is no value specified for Course Days or "NA" if value doesn't exist--->
                        <cfif (#CourseInfo_Query.Course_Days# EQ "" ) AND (#CourseInfo_Query.Delivery# NEQ "online" )>
                            TBA
                            <cfelseif (#CourseInfo_Query.Course_Days# EQ "" ) AND (#CourseInfo_Query.Delivery# EQ "online" )>
                                N/A
                                <cfelse>
                                    #CourseInfo_Query.Course_Days#
                        </cfif>
                    </td>
                    <td>
                        <span class="bold">Survey Reminder Due: </span>
                        <!---Prints "TBA" if there is no value specified for reminder due date or "NA" if value doesn't exist--->
                        <cfif #CourseInfo_Query.Course_Type# NEQ 'post degree'>
                            <cfinvoke component="Functions"
                                      method="DateNullChecker"
                                      value="#CourseInfo_Query.Reminder_Due#">
                                <cfelse>
                                    N/A
                        </cfif>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span class="bold">Textbook Required: </span> #CourseInfo_Query.Text_Required#
                    </td>
                    <td>
                        <span class="bold">Owl Required: </span> #CourseInfo_Query.OWL_Required#
                    </td>
                    <td>
                        <span class="bold">Contract Due: </span>
                        <cfinvoke component="Functions"
                                  method="DateNullChecker"
                                  value="#CourseInfo_Query.Contract_Due#">
                    </td>

                    <td>
                        <span class="bold">Survey Due</span>
                        <!---Prints "TBA" if there is no value specified for evaluation due date or "NA" if value doesn't exist--->
                        <cfif #CourseInfo_Query.Course_Type# NEQ 'post degree'>
                            <cfinvoke component="Functions"
                                      method="DateNullChecker"
                                      value="#CourseInfo_Query.Evaluation_Due#">
                                <cfelse>
                                    N/A
                        </cfif>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td>
                        <span class="bold">Text Due: </span>
                        <!---Prints "TBA" if there is no value specified for textbook due date or "NA" if value doesn't exist--->
                        <cfif CourseInfo_Query.Text_Required NEQ "no">
                            <cfinvoke component="Functions"
                                      method="DateNullChecker"
                                      value="#CourseInfo_Query.Text_Due#">
                                <cfelse>
                                    N/A
                        </cfif>
                    </td>
                    <td>
                        <sapn class="bold">Grades/Attendance Due: </sapn>
                        <!---Prints "TBA" if there is no value specified for reminder due date or "NA" if value doesn't exist--->
                        <cfinvoke component="Functions"
                                  method="DateNullChecker"
                                  value="#CourseInfo_Query.Grades_Due#">
                    </td>
                </tr>

            </table>
        </div>

        <!---if textbook is required show textbook infor--->
        <cfif #CourseInfo_Query.Text_Required# NEQ 'no'>
        <div class="pageTitle">
            <cfif #CourseInfo_Query.Canceled# EQ 0>
                <a href="AddTextbook.cfm?CourseID=#URLEncodedFormat(Trim(CourseInfo_Query.ID))#">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                </a>
            <cfelse>
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
            </cfif>
            <h4>Textbooks:</h4>
        </div>
        <cfloop query="TextbookInfo_Query">
            <cfoutput>
                <br>
                <div class="details-Table">
                    <table>
                        <tr>
                            <div class="subHeader">
                                Book: <cfif #TextbookInfo_Query.Title# NEQ "">#TextbookInfo_Query.Title# <cfelse> TBA </cfif>
                            </div>
                            <div class="floatRight link">
                                <a href="RemoveCourseTextbook.cfm?CourseID=#URLEncodedFormat(Trim(CourseInfo_Query.ID))#&ISBN=#URLEncodedFormat(TextbookInfo_Query.ISBN)#"
                                   <cfif #CourseInfo_Query.Text_Required# NEQ "yes">  class="disabled"</cfif>>[Remove]</a>
                            </div>
                        </tr>
                        <tr>
                            <td>
                                <span class="bold">Author: </span> <cfif #TextbookInfo_Query.Author# NEQ ""> #TextbookInfo_Query.Author#<cfelse> TBA </cfif>
                            </td>
                            <td>
                                <span class="bold">Publisher: </span><cfif #TextbookInfo_Query.Publisher# NEQ "">#TextbookInfo_Query.Publisher#<cfelse> TBA </cfif>
                            </td>
                            <td>
                                <span class="bold">ISBN: </span> <cfif #TextbookInfo_Query.ISBN# NEQ ""> #TextbookInfo_Query.ISBN#<cfelse> TBA </cfif>
                            </td>
                            <td><span class="bold">Editon: </span> <cfif #TextbookInfo_Query.Edition# NEQ ""> #TextbookInfo_Query.Edition#<cfelse> TBA </cfif></td>
                        </tr>
                    </table>

                </div>
            </cfoutput>
        </cfloop>
            <br><br>
        </cfif>

        <!------------------------------------------------------------------------------------CHECKLIST---------------------------------------------------------------------------------->

        <cfif (#CourseChecklist_Query.Contract_Sent# EQ 1) AND (#CourseChecklist_Query.Contract_Recieved# EQ 1)
              AND #CourseChecklist_Query.Outline_Recieved# EQ 1 AND #CourseChecklist_Query.Website_Updated# EQ 1
              AND #CourseChecklist_Query.GA_Added# EQ 1 AND #CourseChecklist_Query.Class_Emailed# EQ 1
              AND #CourseChecklist_Query.Materials_Onfile# EQ 1>

            <cfset complete="true">

                <cfif #CourseInfo_Query.Text_Required# EQ "yes" AND #CourseChecklist_Query.Text_Recieved# NEQ 1>
                    <cfset complete="false">
                </cfif>
                <cfif (#CourseInfo_Query.OWL_Required# eq "blankSite" OR #CourseInfo_Query.OWL_Required# eq "CopySite" ) AND #CourseChecklist_Query.OWL_Site# NEQ 1>
                    <cfset complete="false">
                </cfif>
                <cfif #CourseInfo_Query.Course_Type# NEQ 'Post Degree' AND (#CourseChecklist_Query.Reminder_Sent# NEQ 1 OR #CourseChecklist_Query.Eval_Sent# NEQ 1)>
                    <cfset complete="false">
                </cfif>

        </cfif>



        <div class="ToDoList-Container">
            <div class="pageTitle">
                <h4>To-Do List: </h4>
                <h4 <cfif complete eq "false">class="hide"</cfif>><span class="green">Complete</span></h4>
            </div>

            <!---Course checklist; values checked/unchecked based on value stored in database--->
            <cfform action="UpdateChecklistAction.cfm">

                <input type="hidden" name="CourseIdentifier" value="#CourseChecklist_Query.ID#">

                <div class="checkbox">

                    <div class="checkbox-item">
                        <input type="checkbox" name="ContractSent_CheckBox" value="1" <cfif #CourseChecklist_Query.Contract_Sent# EQ 1>checked</cfif>>
                        <span class="checkbox-Text">Contract Sent</span>
                    </div>

                    <div class="checkbox-item">
                        <input type="checkbox" name="ContractRecieved_CheckBox" value="1" <cfif #CourseChecklist_Query.Contract_Recieved# EQ 1>checked</cfif>>
                        <span class="checkbox-Text">Contract Received</span>
                    </div>

                    <cfif #CourseInfo_Query.Text_Required# IS "yes">
                        <div class="checkbox-item">
                            <details>
                                <summary>
                                    <input type="checkbox" name="TextRecieved_CheckBox" value="1" onclick="return false;" <cfif #CourseChecklist_Query.Text_Recieved# EQ 1>checked</cfif>>
                                    <span class="checkbox-Text">Text Received</span>
                                </summary>
                                <ul>
                                    <li>
                                        <input type="checkbox" name="TextOrdered_CheckBox" value="1" <cfif #CourseChecklist_Query.Text_Ordered# EQ 1>checked</cfif>>
                                        <span class="checkbox-Text">Textbook Ordered</span>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="TextInStock_CheckBox" value="1" <cfif #CourseChecklist_Query.Text_InStock# EQ 1>checked</cfif>>
                                        <span class="checkbox-Text">Textbook InStock</span>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="TextWebsiteUpdated_CheckBox" value="1" <cfif #CourseChecklist_Query.Text_WebsiteUpdated# EQ 1>checked</cfif>>
                                        <span class="checkbox-Text">Website Updated</span>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="TextEmailedStudents_CheckBox" value="1" <cfif #CourseChecklist_Query.Text_EmailedStudents# EQ 1>checked</cfif>>
                                        <span class="checkbox-Text">Emailed Students</span>
                                    </li>
                                </ul>
                            </details>
                        </div>
                    </cfif>

                    <cfif #CourseInfo_Query.OWL_Required# eq "blankSite" OR #CourseInfo_Query.OWL_Required# eq "CopySite">
                        <div class="checkbox-item">
                            <details>
                                <summary>
                                    <input type="checkbox" name="OWLSite_CheckBox" value="1" onclick="return false;" <cfif #CourseChecklist_Query.OWL_Site# EQ 1>checked</cfif>>
                                    <span class="checkbox-Text">OWL Site</span>
                                </summary>
                                <ul>
                                    <li>
                                        <input type="checkbox" name="OWLSiteCreated_CheckBox" value="1" <cfif #CourseChecklist_Query.OWL_SiteCreated# EQ 1>checked</cfif>>
                                        <span class="checkbox-Text">Site Created</span>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="OWLInstructorEmailed_CheckBox" value="1" <cfif #CourseChecklist_Query.OWL_InstructorEmailed# EQ 1>checked</cfif>>
                                        <span class="checkbox-Text">Instructor Emailed</span>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="OWLSiteReviewed_CheckBox" value="1" <cfif #CourseChecklist_Query.OWL_SiteReviewed# EQ 1>checked</cfif>>
                                        <span class="checkbox-Text">Site Reviewed</span>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="OWLReadyToPublish_CheckBox" value="1" <cfif #CourseChecklist_Query.OWL_ReadyToPublish# EQ 1>checked</cfif>>
                                        <span class="checkbox-Text">Ready To Publish</span>
                                    </li>
                                </ul>
                            </details>
                        </div>
                    </cfif>

                    <div class="checkbox-item">
                        <details>
                            <summary>
                                <input type="checkbox" name="OutlineRecieved_CheckBox" value="1" <cfif #CourseChecklist_Query.Outline_Recieved# EQ 1>checked</cfif>>
                                <span class="checkbox-Text">Outline Received</span>
                            </summary>
                            <ul>
                                <li>
                                    <input type="checkbox" name="WebsiteUpdated_CheckBox" value="1" <cfif #CourseChecklist_Query.Website_Updated# EQ 1>checked</cfif>
                                    <span class="checkbox-Text">Website Updated</span>
                                </li>
                            </ul>
                        </details>
                    </div>

                    <cfif #CourseInfo_Query.Course_Type# NEQ 'Post Degree'>
                        <div class="checkbox-item">
                            <input type="checkbox" name="ReminderSent_CheckBox" value="1" <cfif #CourseChecklist_Query.Reminder_Sent# EQ 1>checked</cfif>>
                            <span class="checkbox-Text"> Survey Reminder</span>
                        </div>

                        <div class="checkbox-item">
                            <input type="checkbox" name="EvalSent_CheckBox" value="1" <cfif #CourseChecklist_Query.Eval_SEnt# EQ 1>checked</cfif>>
                            <span class="checkbox-Text">Survey Sent to Manager</span>
                        </div>
                    </cfif>

                    <div class="checkbox-item">
                        <input type="checkbox" name="GAadded_CheckBox" value="1" <cfif #CourseChecklist_Query.GA_Added# EQ 1> checked</cfif>>
                        <span class="checkbox-Text">Grades/Attendance Received </span>
                    </div>

                    <div class="checkbox-item">
                        <input type="checkbox" name="ClassEmailed_CheckBox" value="1" <cfif #CourseChecklist_Query.Class_Emailed# EQ 1>checked</cfif>>
                        <span class="checkbox-Text">Grades/Attendance Class Emailed</span>
                    </div>

                    <div class="checkbox-item">
                        <input type="checkbox" name="MaterialsOnFile_CheckBox" value="1" <cfif #CourseChecklist_Query.Materials_Onfile# EQ 1>checked</cfif>>
                        <span class="checkbox-Text">Materials On File</span>
                    </div>

                </div>

                <input type="submit" name="saveChecklist" value="Save" <cfif #CourseInfo_Query.Canceled# EQ 1>disabled="disabled"</cfif>>

            </cfform>
        </div>

        <div class="notes-section">
            <cfform action="CourseNotesAction.cfm" class="notes-container">

                <div class="pageTitle">
                    <h4>NOTES: </h4>
                    <h1> </h1>
                </div>

                <textarea name="CourseNotes_TextArea" cols="65" rows="10"><cfoutput>#CourseInfo_Query.Course_Notes#</cfoutput></textarea>

                <input type="hidden" name="CourseKey_HiddenBox" value="#URL.CourseID#">

                <input type="submit" name="saveNotes" value="Save" <cfif #CourseInfo_Query.Canceled# EQ 1>disabled="disabled"</cfif>>

            </cfform>
        </div>


        <!-------------------------------------------------------------------------NOTEPAD------------------------------------------------------------------------------------------>
        <cfform action="CourseNotesAction.cfm" class="notes-container">
            <div class="notes-popup" id="myForm">
                <a class="closeNotes" onclick="closeNotePad()">&times;</a>

                <h1 style="display:inline-block">Notes</h1>

                <textarea name="CourseNotes_TextArea" cols="10" rows="10"><cfoutput>#CourseInfo_Query.Course_Notes#</cfoutput></textarea>

                <input type="hidden" name="CourseKey_HiddenBox" value="#URL.CourseID#">

                <button type="submit" id="saveBtn">Save</button>
            </div>
        </cfform>



    </cfoutput>

<cfinclude template="includes/footer.cfm">

<script>
    function myPopup(myURL, title, myWidth, myHeight) {
        var left = (screen.width - myWidth) / 2;
        var top = (screen.height - myHeight) / 4;
        var myWindow = window.open(myURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + myWidth + ', height=' + myHeight + ', top=' + top + ', left=' + left);
    }
</script>

