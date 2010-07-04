<cfsetting showDebugOutput="false"/>
<cfsetting enablecfoutputonly="true">

<cfparam name="form.action" default="tag">
<cfparam name="form.image" default="">
<cfparam name="form.tag" default="">

<cfif isDefined("url.clear") || !isDefined("session.tags")><cfset session.tags= {}></cfif>

<cfif Len(form.image) gt 0>
	<cfif form.action eq 'tag'>
		<cfif structKeyExists(session.tags, form.image)>
			<cfif structKeyExists(session.tags[form.image], form.tag)>
				<cfset session.tags[form.image][form.tag] = true>
			</cfif>
			<cfset session.tags[form.image][form.tag] = true>
		<cfelse>
			<cfset session.tags[form.image] = {}>
			<cfset session.tags[form.image][form.tag] = true>
		</cfif>
	<cfelse>
		<cfset structDelete(session.tags[form.image], form.tag)>
	</cfif>
	<cfheader name="Content-Type" value="application/json">
<cfoutput>[{'image':#form.image#, 'currentTags':'#structKeyList(session.tags[form.image])#', 'result':true}]</cfoutput>
</cfif>

