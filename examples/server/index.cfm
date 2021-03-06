<cfsetting showdebugoutput="false">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Taggable Demo 1</title>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.js"></script>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
		<script type="text/javascript" src='../../jquery.taggable.js'></script>
		
		<script type="text/javascript">
		$(function(){
			$('.photo').taggable({
				tags: '#tags .tag.active',
				tagged: onTag ,
				untagged: onUntag
			});
			
			$('.close.control').live('click', function(){
				var taggedObj = $(this).parent().prev();
				taggedObj.trigger('untagged', [ $(this).parent().text() ] );
				$(this).parent().remove();
			});

			function onTag(element, tag){ 
				if( $(element).siblings('[rel='+tag+']').length == 0 ){
					/* Graphically let user know tag was added */
					$(element).after('<div class="tag active" rel="'+ tag +'">' + tag + '<div class="close control" /></div>');
					/* Send to server */
					$.post('http://localhost:8888/taggable-jq/examples/server/saveTags.cfm', { 'action':'tag', 'image': $(element).attr('rel'), 'tag':tag },
						function(results, txtStatus){ console.log(results,txtStatus); }
					) ;
					
				}else{
					$(element).siblings('[rel='+tag+']').effect('bounce');
				}
			};
			
			function onUntag(element, tag){
				$.post('http://localhost:8888/taggable-jq/examples/server/saveTags.cfm', { 'action':'untag', 'image': $(element).attr('rel'), 'tag':tag });	
			};
						
		});
		</script>
		<style type="text/css">
		body{
			line-height: 150%;
		}
		#things-to-tag{
			float: right;
			list-style:none;
			padding: 0;
			margin: 0;
		}
		#things-to-tag .photo{
			max-height: 150px;
		}
		
		#tags{
			float: left;
			margin: 0;
			padding:0;
			list-style:none;
		}
		.tag{
			background: transparent url('../../assets/disabled-tag.png') no-repeat 0px 2px;
			border-bottom: 1px #aaa dashed;
			color: #888;
			cursor: auto;
			margin: 5px 25px 0 0;
			padding-left: 23px;
			
		}
		.tag.active{
			color: #000000;
			cursor: pointer;
			background-image: url('../../assets/enabled-tag.png');
		}
		
		.tag .close.control{
			background:transparent url('../../assets/delete_16.png') no-repeat 0 4px;
			width: 16px; height: 20px;
			float:right;
		}	
		</style>	
	</head>
	<body>
		
		<ul id="tags">
			<li class="tag active">Monkey</li>
			<li class="tag active">Funny</li>
			<li class="tag active">Stupid</li>
			<li class="tag">Silly</li>
		</ul>
		<ul id="things-to-tag">
			<li>
				<img class="photo" src="../../assets/buddha.jpg" rel="14" />
				<cfif structKeyExists(session.tags, '14')>
					<cfloop collection="#session.tags[14]#" item="tag">
						<cfoutput><div rel="#tag#" class="tag active">#tag#<div class="close control"></div></div></cfoutput>
					</cfloop>
				</cfif>	
			</li>
			<li><img class="photo" src="../../assets/mrt.jpg" rel="15" />
				<cfif structKeyExists(session.tags, '15')>
					<cfloop collection="#session.tags[15]#" item="tag">
						<cfoutput><div rel="#tag#" class="tag active">#tag#<div class="close control"></div></div></cfoutput>
					</cfloop>
				</cfif>
			</li>
			<li><img class="photo" src="../../assets/normal_sm.jpg" rel="16" />
				<cfif structKeyExists(session.tags, '16')>
					<cfloop collection="#session.tags[16]#" item="tag">
						<cfoutput><div rel="#tag#" class="tag active">#tag#<div class="close control"></div></div></cfoutput>
					</cfloop>
				</cfif>
			</li>
		</ul>
	</body>
</html>
