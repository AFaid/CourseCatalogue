<cfparam name="FORM.textSearch" default="">
<cfparam name="URL.textbook_removed" default="">
<cfparam name="URL.title" default="">

<cfquery datasource="WCSTracking" name="TextbookInfo_Query">
    SELECT ISBN, Title, Edition, Author, Publisher
    FROM Textbooks
    WHERE Title != '' AND ISBN != ''
    <cfif FORM.textSearch NEQ "">
        AND Title LIKE <cfqueryparam value="#FORM.textSearch#" cfsqltype="varchar">
    </cfif>
</cfquery>

<cfinclude template="includes/header.cfm">
<cfinclude template="includes/sidebar.cfm">

<div <cfif #URL.textbook_removed# EQ 'true'>class="alert alert-warning" role="alert" <cfelse>class="hide"</cfif>>
    <cfoutput>
        <strong>Warning!</strong> #URL.title# was deleted from Textbooks
    </cfoutput>
</div>

    <div class="pageTitle">
        <h3>TEXTBOOKS LIST</h3>
    </div>

<!---Filters which textbooks information to display--->
    <cfform action="textbooks.cfm">
    <cfoutput>
        <div class="searchBar">
            <input type="search" name="textSearch" placeholder="Title" value="#FORM.textSearch#" autocomplete="off">
            <input type="submit" value="Search">
        </div>
</cfoutput>
    </cfform>

    <!---Displays Textbooks information--->
    <div class="results-Table">
        <table>
            <tr>
                <td><span class="bold">ISBN</span></td>
                <td><span class="bold">Title</span></td>
                <td><span class="bold">Edition</span></td>
                <td><span class="bold">Author</span></td>
                <td><span class="bold">Publisher</span></td>
                <td width="7%"><span class="bold"></span></td>
                <td width="7%"><span class="bold"></span></td>
            </tr>
            <cfloop query="TextbookInfo_Query">
            <cfoutput>
            <tr class="lowercase">    
                <td>#TextbookInfo_Query.ISBN#</td>
                <td><a href="textbookDetails.cfm?ISBN=#URLEncodedFormat(TRIM(TextbookInfo_Query.ISBN))#">
                    <cfinvoke component="Functions"
                            method="StringNullChecker"
                            Value="#TextbookInfo_Query.Title#">
                </a></td>
                <td>
                <cfinvoke component="Functions"
                            method="StringNullChecker"
                            Value="#TextbookInfo_Query.Edition#">
                </td>
                <td>
                <cfinvoke component="Functions"
                            method="StringNullChecker"
                            Value="#TextbookInfo_Query.Author#">
                </td>
                <td>
                <cfinvoke component="Functions"
                            method="StringNullChecker"
                            Value="#TextbookInfo_Query.Publisher#">
                </td>
                <td><a href="UpdateTextbook.cfm?ISBN=#URLEncodedFormat(Trim(TextbookInfo_Query.ISBN))#">Update</a></td>
                <td><a href="RemoveTextbook.cfm?ISBN=#URLEncodedFormat(Trim(TextbookInfo_Query.ISBN))#">Remove</a></td>
            </tr>
            </cfoutput>
            </cfloop>
        </table>
    </div>

 <cfinclude template="includes/footer.cfm">