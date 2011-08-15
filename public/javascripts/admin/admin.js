(function($){
	$(document).ready( function() {
		$('.image-list .edit').live( 'click', editImage );  

		$("a.fancybox").fancybox();
		$("a[rel=gallery]").fancybox({
			'titlePosition' 	: 'over',
			'titleFormat'		: function(title, currentArray, currentIndex, currentOpts) {
				return '<span id="fancybox-title-over">Image ' + (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>';
			}
		});
	});

	function editImage(e) {
		var caption = $(this).parents('li').children('.caption'), caption_text = $(caption).html();
		var href = $(this).attr('href');

		if( $('em', caption).is( 'em' ) )
		{
			caption_text = '';
		}

		var input = prompt( 'Edit Image Caption', caption_text );

		if( ! input )
		{
			return false;
		}

        var csrf_token = $('meta[name=csrf-token]').attr('content');
        var csrf_param = $('meta[name=csrf-param]').attr('content');

		$(caption).text( input );

		// settings.data = encodeURI( "utf8=" + encodeURI('✓') + "&amp;" + csrf_param + "=" + encodeURI( csrf_token ) + "&amp;" + encodeURI( 'product_image[image_caption]' ) + "=" + encodeURI( input ) + "&amp;commit=Update+Image" );

		data = {};
		data.utf8 = '✓';
		data[csrf_param] = csrf_token;
		data['product_image[image_caption]'] = input;

		$.ajax( { 
			url: href + '.js',
			type: 'PUT',
			data: data, 
			dataType: 'script',
			isLocal: true
		} );

		return false;
	}
})(jQuery);
