<link href="includes/emailStyling.css" rel="stylesheet">
<link href="includes/StylingSheet.css" rel="stylesheet">

<cfif #URL.InstructorID# NEQ "">
    <cfquery datasource="WCSTracking" name="InstructorEmail_Query">
        SELECT Instructor_Email FROM Instructors
        WHERE ID = #URL.InstructorID#
    </cfquery>
</cfif>

<cfoutput>
<div class="email">
    <cfform action="SendEmail.cfm">

        <div class="email-header">
            <div class="Email-Info">
                <label>TO:</label>
                <input type="email"
                       name="Recipent_EmailAddress"
                       required
                       placeholder="Recipient Email"
                       autocomplete="off"
                <cfif #URL.InstructorID# NEQ ""> value="#InstructorEmail_Query.Instructor_Email#"</cfif>>
            </div>

            <div class="Email-Info">
                <label>FROM:</label>
                <input type="email"
                       name="Sender_EmailAddress"
                       required
                       placeholder="Sender Email"
                       autocomplete="off">
            </div>

            <div class="Email-Info">
                <label>SUBJECT:</label>
                <input type="text"
                       name="Subject_TextBox"
                       placeholder="Add Subject"
                       autocomplete="off">
            </div>

        </div>

        <div class="email-body">
            <textarea name="EmailBody_TextArea" cols="70" rows="10"></textarea>
        </div>

        <div class="sendBtn">
            <button name="SendButton" value="submit">SEND EMAIL</button>
        </div>

    </cfform>
</div>
</cfoutput>
