Taggable 
=====
A jQuery Tagging Plugin
----

This plugin's main goal is to add a way for tags to be dropped on to an element. 
Most of the heavy lifting is done by jQuery UI's draggable/droppable but I've added a few
extra options to make things a little easier. 

### Requirements ###
* jQuery 1.4+  (might work in older versions but this is untested)
* jQuery UI v1.8+ (might work in older versions but this is untested)

Make sure you include the required jQuery modules (above). If you don't have it locally, a quick way
to do this is use the copy hosted on Google's CDN.

	<!-- Load jQuery files from Google's CDN -->
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>

Then you need to include the plugin's file. If you want to just take it for a quick test ride, you can just link to the
copies on GitHub.

For the uncompressed version:

	<script type="text/javascript" src="http://github.com/downloads/jonDowdle/jqTaggable/jquery.taggable.js"></script>

For the minified version:

	<script type="text/javascript" src="http://github.com/downloads/jonDowdle/jqTaggable/jquery.taggable.min.js"></script>

Of course if you have it installed locally just change the `src` attribute to reflect that.

### Usage ###
Just call `.taggable()` on any of the elements that you'd like to become taggable by any elements with the 
class "tag" on the page (by default).

For a more fleshed out example, say we want our `<div class='target'>`s to be taggable by our 
`<label>`s under the `<div class='foo'>` element. So your markup would look like this:
	
	<div class='foo'>
		<label>I'm a Tag!</label>
		<label>I'm another tag!</label>
		<label>Monkey!</label>
	</div>
	
	<div class='target'>Something to tag</div>
	
To use Taggable with this setup you'd do so like this:

	$('div.target').taggable({
		tags: 'div.foo label'
	});

#### Options: ####

* tags
	* Accepts any jQuery selector
	* Defaults to '.tag'
* tagged
	* Function to call when item is tagged
	* Accepts a function
	* Example:
	`$('.target').taggable({ tagged: function(tagElement){ alert(tagElement);} });`
* untagged
	* Function to call when item is untagged
	* Accepts a function
	* Example:
	`$('.target').taggable({ untagged: function(tagElement){ alert(tagElement);} });`
* draggableHelper
	* Draggable helper
	* Accepts "clone" or "original"
	* Defaults to "clone"
	* See [jQuery UI docs](http://jqueryui.com/demos/draggable/#option-helper)
* draggableCursor
	* Draggable's cursor
	* Accepts CSS value for cursor
	* Defaults to 'pointer'
	* See [jQuery UI docs](http://jqueryui.com/demos/draggable/#option-cursor)
* draggableScope
	* Used to define the scope of where the what object is taggable by what tags
	* Defaults to 'taggable-jq-plugin'
	* See [jQuery UI docs](http://jqueryui.com/demos/draggable/#option-scope)
	
#### Events ####

You may also listen for these events:

* tagged
	* `$( ".selector" ).bind( "tagged", function(event, tagName) {  ... });`
* untagged
	* `$( ".selector" ).bind( "untagged", function(event, tagName) {  ... });`