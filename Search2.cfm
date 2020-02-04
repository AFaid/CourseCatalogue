
<cfinclude template="includes/header.cfm">
<cfinclude template="includes/sidebar.cfm">

<div class="pageTitle">
    <h3>Search Catalogue</h3>
    <div class="searchScreen-Nav">
        <a href="index.cfm"> Courses</a>
        <a>|</a>
        <a href="Search2.cfm"> Course Checklists</a>
    </div>
    <br>
</div>

<cfoutput>
<cfform action="SearchAction2.cfm">
    <div class="advSearch">

        <label>Textbooks:</label>
        <ul>
            <li>
                <input type="checkbox" name="TextOrdered_CheckBox" value="0">
                <span class="checkbox-Text">Textbook Ordered</span>
            </li>
            <li>
                <input type="checkbox" name="TextInStock_CheckBox" value="0">
                <span class="checkbox-Text">Textbook InStock</span>
            </li>
        </ul>

        <label> OWL Site: </label>
        <ul>
            <li>
                <input type="checkbox" name="OWLSiteCreated_CheckBox" value="0">
                <span class="checkbox-Text">Site Created</span>
            </li>
            <li>
                <input type="checkbox" name="OWLSiteReviewed_CheckBox" value="0">
                <span class="checkbox-Text">Site Reviewed</span>
            </li>
            <li>
                <input type="checkbox" name="OWLReadyToPublish_CheckBox" value="0">
                <span class="checkbox-Text">Ready To Publish</span>
            </li>
        </ul>

    </div>

    <input type="submit" name="submit_Button" id="submitBtn">

</cfform>
</cfoutput>
