<cfsetting showDebugOutput="false"/>
<cfparam name="url.skeptic" default="false">

<cfloop collection="#session.tags#" item="i">
<cfoutput>
	#i# : #structKeyList(session.tags[i])#<br />
</cfoutput>
</cfloop>

<cfif url.skeptic><cfdump var="#session.tags#"></cfif>
