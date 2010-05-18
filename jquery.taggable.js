/**
 * Taggable jQuery plugin
 * 
 * Requires jQuery UI
 *  
 * @param {Object} options
 * 
 * Example calls:
 * 
 * Basic call
 * $('.photo').taggable();
 * 
 * This defines the classes that can tag our taggable elements
 * $('.photo').taggable({ tags:'.tag' });

 * This calls event handlers when tags are added or removed
 * $('.photo').taggable({ tags:'.tag', tagged: onTag, untagged: onUnTag });
 * 
 */

jQuery.fn.taggable = function( options ){
	var DEFAULT_TAG_SELECTOR = '.tag';
	
	var getTagValue = function(tagElement){ return jQuery(tagElement).attr('rel') ? jQuery(tagElement).attr('rel') : jQuery(tagElement).text();};
	var getTagData = function(tagElement){ return jQuery(tagElement).data('taggable') ? jQuery(tagElement).data('taggable') : { tags: [] }; }
	
	var onTag = function(element, tag){ console.log('Tagged', element, 'with', tag); };
	var onUnTag = function(element, tag){ console.log('Untagged', element, 'with', tag); };
	
	var settings = jQuery.extend({
		tags: jQuery( DEFAULT_TAG_SELECTOR ),
		tagged: onTag,
		untagged: onUnTag
	}, options);
	
	settings.tags.each(function(i, el){
		jQuery(el).draggable({
			scope: 'taggable-jq-plugin',
			helper: 'clone',
			cursor: 'pointer'
		})
	});
	
	this.each(function(i, el){
		jQuery(el).droppable({
			scope: 'taggable-jq-plugin',
			drop: function(event, ui){
				var tagValue = getTagValue(ui.draggable);
				var tagData = getTagData(event.target);
				
				// Push tag onto stack and add back to data store
				
				console.log("Adding tag to ", event.target); 
				console.log("Current Tags ", tagData.tags);
				
				tagData.tags.push(tagValue);
				
				console.log("New Tags ", tagData.tags);
				
				$(event.target).data('taggable', tagData)
				
				// Call event handler
				settings.tagged(event.target, tagValue);
			},
			out: function(event, ui){
				var tagValue = getTagValue(ui.draggable);
				var tagData = getTagData(event.target);
				// Find tag in array
				var tagIndex = jQuery.inArray(tagValue, tagData.tags);

				console.log("Removing tag from ", event.target); 
				console.log("Current Tags ", tagData.tags);
				
				// Remove it and set obj's data to resulting array	
				tagData.tags.splice(tagIndex, 1);

				console.log("New Tags ", tagData.tags);
				
				$(event.target).data('taggable', tagData)
				
				settings.untagged(event.target, tagValue);
			}	
		});
		
		// Bind events
		jQuery(el).bind('untagged', function(event, tagName){
			var tagValue = tagName ? tagName : getTagValue(this);
			var tagData = getTagData(event.target);
			// Find tag in array
			var tagIndex = jQuery.inArray(tagValue, tagData.tags);
			// Remove it and set obj's data to resulting array	
			tagData.tags.splice(tagIndex, 1);
			$(event.target).data('taggable', tagData)
			settings.untagged(event.target, tagValue);
		});
	});

	return this;
};

jQuery.extend(jQuery.expr[":"], {
	tagged: function(obj, index, meta, stack){
		return jQuery(obj).data('taggable') != undefined;
	}
});
