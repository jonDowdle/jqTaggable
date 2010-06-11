/**
 * Taggable jQuery plugin
 * 
 * Requires jQuery UI
 *  
 * @param {Object} options
 * 
 * @classDescription
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
		tags: DEFAULT_TAG_SELECTOR,
		tagged: onTag,
		untagged: onUnTag,
		draggableHelper: 'clone',
		draggableCursor: 'pointer',
		draggableScope: 'taggable-jq-plugin'
	}, options);
	
	$(settings.tags).each(function(i, el){
		jQuery(el).draggable({
			scope: settings.draggableScope,
			helper: settings.draggableHelper,
			cursor: settings.draggableCursor
		})
	});
	
	this.each(function(i, el){
		jQuery(el).droppable({
			scope: settings.draggableScope,
			drop: function(event, ui){
				var tagValue = getTagValue(ui.draggable);
				var tagData = getTagData(event.target);
				jQuery(event.target).trigger('tagged', [tagValue]);
			},
			out: function(event, ui){
				var tagValue = getTagValue(ui.draggable);
				var tagData = getTagData(event.target);
				jQuery(event.target).trigger('untagged', [tagValue]);
			}	
		});
		
		
		// Bind events
		
		jQuery(el).bind('tagged', function(event, tagName){
			var tagValue = tagName ? tagName : getTagValue(this);
			var tagData = getTagData(event.target);
			
			// Push tag onto stack and add back to data store
			tagData.tags.push(tagValue);
			$(event.target).data('taggable', tagData)
			
			// Call event handler
			settings.tagged(event.target, tagValue);
		});
		
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
