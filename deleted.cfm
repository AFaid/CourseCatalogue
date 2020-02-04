<!---
Name: Ahmed Faid
Description: Shows courses, textbooks, and instructors deleted in the last 3 days
--->

<cfinvoke component="Queries"
          method="ClearDeletedTextbook">

<cfinvoke component="Queries"
          method="ClearDeletedinstructors">

<cfinvoke component="Queries"
          method="ClearDeletedCourse">
    
<cfinvoke component="Queries"
          method="DeletedTextbookInfo_Getter"
          returnvariable="deletedtextbook_Array">

<cfinvoke component="Queries"
          method="DeletedCourseInfo_Getter"
          returnvariable="deletedCourse_Array">
        
<cfinvoke component="Queries"
          method="DeletedinstructorInfo_Getter"
          returnvariable="deletedinstructor_Array">


<cfinclude template="includes/header.cfm">
<cfinclude template="includes/sidebar.cfm">

    <div class="pageTitle">
        <h4>Instructors</h4>
    </div>
    <br>

    <div class="deleted-Table">
        <table>
            <tr>
                <td><span class="bold">Instructor Name</span></td>
                <td><span class="bold">Instructor Email</span></td>
                <td width="7%"></td>
            </tr>
            <cfoutput>
            <cfloop array="#DeletedInstructor_Array#" index="DeletedInstructor">
            <tr>
                <td>#DeletedInstructor.DeletedInstructor_Name#</td>
                <td>#DeletedInstructor.DeletedInstructor_Email#</td>
                <td><a href="RecoverInstructor.cfm?InstructorID=#URLEncodedFormat(TRIM(DeletedInstructor.DeletedInstructor_ID))#">Recover</a></td>
            </tr>
            </cfloop>
            </cfoutput>
        </table>
    </div>

    
    <div class="pageTitle">
        <br><h4>Textbooks</h4><br>
    </div>
    <br>
    
    <div class="deleted-Table">
        <table>
                <tr>
                    <td><span class="bold">ISBN</span></td>
                    <td><span class="bold">Title</span></td>
                    <td><span class="bold">Edition</span></td>
                    <td><span class="bold">Author</span></td>
                    <td><span class="bold">Publisher</span></td>
                    <td width="7%"><span class="bold"></span></td>
                </tr>
                <cfoutput>
                <cfloop array="#DeletedTextbook_Array#" index="DeletedTextbook">
                <tr>    
                    <td>#DeletedTextbook.DeletedTextbook_ISBN#</td>
                    <td>#DeletedTextbook.DeletedTextbook_Title#</td>
                    <td>#DeletedTextbook.DeletedTextbook_Edition#</td>
                    <td>#DeletedTextbook.DeletedTextbook_Author#</td>
                    <td>#DeletedTextbook.DeletedTextbook_Publisher#</td>
                    <td><a href="RecoverTextbook.cfm?ISBN=#URLEncodedFormat(TRIM(DeletedTextbook.DeletedTextbook_ISBN))#
                                     &ID=#URLEncodedFormat(DeletedTextbook.DeletedTextbook_ID)#"> Recover </a></td>
                </tr>
                </cfloop>
                </cfoutput>
        </table>
    </div>

    <div class="pageTitle">
        <br><h4>Courses</h4><br>
    </div>
        <div class="deleted-Table">
            <table>
                <tr>
                    <td>
                        <strong>Course Code</strong>
                    </td>
                    <td>
                        <strong>Course Type</strong>
                    </td>
                    <td>
                        <strong>Course Name</strong>
                    </td>
                    <td>
                        <strong>Section</strong>
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
                    <td width="7%">
                        <strong></strong>
                    </td>

                </tr>
                <cfoutput>
                <cfloop array="#DeletedCourse_Array#" index="DeletedCourse">
                    <tr>
                        <td>
                            #DeletedCourse.DeletedCourse_Code#
                        </td>
                        <td>
                            #DeletedCourse.DeletedCourse_Type#
                        </td>
                        <td>
                            #DeletedCourse.DeletedCourse_Name#
                        </td>
                        <td>
                            #DeletedCourse.DeletedCourse_Section#
                        </td>
                        <td>
                            #DeletedCourse.DeletedCourse_Delivery#
                        </td>
                        <td>
                            <!--Uses DateNullChecker function to display value for dates which havent been entered (NULL)-->
                            <cfinvoke component="Functions"
                                      method="DateNullChecker"
                                      Value="#DeletedCourse.DeletedCourse_StartDate#">
                        </td>
                        <td>
                            <!--Uses DateNullChecker function to display value for dates which havent been entered (NULL)-->
                            <cfinvoke component="Functions"
                                      method="DateNullChecker"
                                      Value="#DeletedCourse.DeletedCourse_EndDate#">
                        </td>
                        <td>
                            <a href="RecoverCourse.cfm?CourseID=#URLEncodedFormat(Trim(DeletedCourse.DeletedCourse_ID))#
                                            &Number=#URLEncodedFormat(DeletedCourse.DeletedCourse_Number)#"> Recover </a>
                        </td>
                    </tr>
                </cfloop>
                </cfoutput>
            </table>
        </div>

<cfinclude template="includes/footer.cfm"> 