(function($) {
	$(document).ready( function(){
		$('#email,#password').focus(hideLabel)
		$('#email,#password').blur(showLabel)
	});

	function hideLabel(event)
	{
		$(this).siblings('label').hide();	
	}
	function showLabel(event)
	{
		if( $(this).val() == '' )
		{
			$(this).siblings('label').show();	
		}
	}

})(jQuery);
