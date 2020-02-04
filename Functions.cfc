<!--
Functions to assist    
-->

<cfcomponent>

    <!--Check if Date varible is NULL and prints appropriate message-->
    <cffunction name="DateNullChecker"
                hint="Date">

    <cfargument name="value"
                type="string"
                required="yes">

    <cfset length = #len(TRIM(value))#>
    
    <cfif length gt 0>
        <cfoutput>#TRIM(value)#</cfoutput> 
    <cfelse>
        <cfoutput>TBA</cfoutput> 
    </cfif>

    </cffunction>
    
    <!--Check if Date varible is NULL and prints appropriate message-->
    <cffunction name="StringNullChecker"
                hint="Date">

    <cfargument name="value"
                type="string"
                required="yes">

    <cfset length = #len(TRIM(value))#>
    
    <cfif length gt 0>
        <cfoutput>#TRIM(value)#</cfoutput> 
    <cfelse>
        <cfoutput>TBA</cfoutput> 
    </cfif>

    </cffunction>    
    

    <!--Check if Time varible is NULL and prints appropriate message-->
    <cffunction name="TimeNullChecker"
                returntype="string"
                hint="Time">

    <cfargument name="value"
                type="string"
                required="yes">

    <cfset length = len(TRIM(#value#))>
    
    <cfif length gt 0>
        <cfset time=RemoveChars(value, 1, 11)>
        <cfoutput>#RemoveChars(time, 9, 12)#</cfoutput> 
    <cfelse>
        <cfoutput>TBA</cfoutput> 
    </cfif>

    </cffunction>

    <!--Check if Time varible is NULL and prints appropriate message-->
    <cffunction name="TimeNullChecker2"
                returntype="string"
                hint="Time">

    <cfargument name="value"
                type="string"
                required="yes">

    <cfset length = len(TRIM(#value#))>
    
    <cfif length gt 0>
        <cfset time="#RemoveChars(value, 1, 11)#"> 
    <cfelse>
        <cfset time="">
    </cfif>

    <cfreturn time>

    </cffunction>


</cfcomponent>
