<cfsilent>

<cfsetting showDebugOutput=false />
<cfparam name="form.image" default="">
<cfparam name="form.tag" default="">

<cfif isDefined("url.clear")><cfset session.tags= {}></cfif>

<cfif !isDefined("session.tags")>
	<cfset session.tags = {}>
</cfif>

<cfif structKeyExists("#session.tags#", form.image)>
	<cfif structKeyExists("#session.tags[form.image]#", form.tag)>
		<cfset session.tags[form.image][form.tag] = true>
	</cfif>
	<cfset session.tags[form.image][form.tag] = true>
<cfelse>
	<cfset session.tags[form.image] = {}>
</cfif>


<!--- <cfheader name="Content-Type" value="application/json"> --->
</cfsilent><cfoutput>[{'image':#form.image#, 'currentTags':'#structKeyList(session.tags[form.image])#', 'result':true}]</cfoutput>
<cfdump var="#form#">
<cfdump var="#session.tags#">
<cfabort >