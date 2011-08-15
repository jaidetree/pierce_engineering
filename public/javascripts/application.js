(function($){
	$(document).ready(function(){ 
		$('.fancybox').fancybox({ 'overlayColor': '#000'});
		$("a[rel=gallery]").fancybox({
			'titlePosition' 	: 'over',
			'overlayColor'		: '#000',
			'titleFormat'		: function(title, currentArray, currentIndex, currentOpts) {
				return '<span id="fancybox-title-over">Image ' + (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>';
			}
		});
	});
})(jQuery)       
