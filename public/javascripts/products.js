(function($){
	$(document).ready(function(){
		$('.add-row').hover(
			function(){ $(this).children('td').children('em').css( 'visibility', 'visible' ) },
			function(){ $(this).children('td').children('em').css( 'visibility', 'hidden' ) }
		);
		$('.add-row em').click( insert_text_field );

	});

	function insert_text_field()
	{
		var row = $(this).parents('tbody').children('tr:last').before('<tr><td><input type="text" name="data_table_name" /></td><td><input type=text" name="data_table_value" /></td><td colspan="4"><span name="add-entry" class="add-entry" id="add-entry-' + $('.add-entry').length + '">+</span><span name="remove-entry" class="remove-entry" id="remove-entry-' + $('.add-entry').length + '">&ndash;</span></td></tr>').prev().addClass( 'test' );

		$('.add-entry', row).click(add_data_table_row);
		$('.remove-entry', row).click( function(){ $(row).remove(); } );
	}

	function add_data_table_row()
	{
	   var name = $(this).parent().siblings('td:first').children('input').val();
	   var value = $(this).parent().siblings('td:first').next().children('input').val();
	   var row = $(this).parents( 'tr' );

	   var tr = document.createElement( 'tr' );

	   var td_name = document.createElement( 'td' );
	   var input_name = document.createElement('input');
	   var text_name = document.createTextNode( name );

	   var td_value = document.createElement( 'td' );
	   var input_value = document.createElement('input');
	   var text_value = document.createTextNode( value );

	   var td_up = document.createElement( 'td' );
	   var td_down = document.createElement( 'td' );
	   var td_edit = document.createElement( 'td' );
	   var td_delete = document.createElement( 'td' );

	   input_name.setAttribute( 'type', 'hidden' )
	   input_name.setAttribute( 'name', 'product[prices][keys][]' )
	   input_name.setAttribute( 'value', name )

	   td_name.appendChild( text_name );
	   td_name.appendChild( input_name );

	   input_value.setAttribute( 'type', 'hidden' )
	   input_value.setAttribute( 'name', 'product[prices][values][]' )
	   input_value.setAttribute( 'value', value )

	   td_value.appendChild( text_value );
	   td_value.appendChild( input_value );

	   tr.appendChild( td_name );
	   tr.appendChild( td_value );
	   tr.appendChild( td_up );
	   tr.appendChild( td_down );
	   tr.appendChild( td_edit );
	   tr.appendChild( td_delete );

	   row.before( tr );
	   //row.remove();
	}
})(jQuery);
