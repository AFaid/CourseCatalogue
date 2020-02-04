
<cfmail from="#TRIM(FORM.Sender_EmailAddress)#"
        to="#TRIM(FORM.Recipent_EmailAddress)#"
        bcc="#FORM.Sender_EmailAddress#"
        subject="#FORM.Subject_TextBox#"
        replyto="#FORM.Sender_EmailAddress#"
        type="text">

    #FORM.EmailBody_TextArea#

</cfmail>

<script>
    window.close();
</script>