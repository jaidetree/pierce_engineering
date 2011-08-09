(function($){
	var methods = {
		init : function( options ) {
			$('.add-row').hover(
				function(){ $(this).children('td').children('em').css( 'visibility', 'visible' ) },
				function(){ $(this).children('td').children('em').css( 'visibility', 'hidden' ) }
			);
			$('.add-row em').click( insert_text_field );
			$('.data-table tr').hover(insert_actions, remove_actions);

			color_odd_rows();
		},

		color_odd_rows: function(obj) {
			if( undefined== obj )
			{
				$('.data-table').each( function(){ 
					$('tr:odd').addClass( 'odd' ); 
				});
			}
			else
			{
				$('tr', obj).removeClass( 'odd' ); 
				$('tr:odd', obj).addClass( 'odd' ); 
			}
		},

		insert_actions: function() {
			var td = $( '.actions', this );		

			if( ! td.length )
				return;

			var first = $(this).parents('tbody').children(':first').index() + 1;
			var last = $(this).parents('tbody').children(':last').index() - 1 - ( $(this).parents('tbody').children('.new-row').length );
			var index = $(this).index();

			if( index != first )
			{
				var up = document.createElement('span');
				up.setAttribute( 'class', 'move-up' );
				up.innerHTML = '&#9650;';
				$(td).append( up );
			}

			if( index != last )
			{
				var down = document.createElement('span');
				down.setAttribute( 'class', 'move-down' );
				down.innerHTML = '&#9660;';
				$(td).append( down );
			}

			var edit = document.createElement('span');
			edit.setAttribute( 'class', 'edit' );
			edit.innerHTML = 'edit';
			$(td).append( edit );

			var remove = document.createElement('span');
			remove.setAttribute( 'class', 'delete' );
			remove.innerHTML = 'x';
			$(td).append( remove );

			$('.move-up').click(move_item_up);
			$('.move-down').click(move_item_down);
			$('.edit').click(edit_item);
			$('.delete').click(delete_item);
		},

		edit_items: function() {
			var tr = $(this).parents('tr');
			var name = document.createElement( 'input' );
			name.setAttribute( 'type', 'text' );
			name.setAttribute( 'name', 'data_table_name' );

			var value = document.createElement( 'input' );
			value.setAttribute( 'type', 'text' );
			value.setAttribute( 'name', 'data_table_value' );

			var update = document.createElement( 'span' );
			update.innerHTML = "&#10004;"
			update.setAttribute( 'class', 'add-entry' );

			var cancel = document.createElement( 'span' );
			cancel.innerHTML = "&#10008;"
			cancel.setAttribute( 'class', 'remove-entry' );

			var name_td = $(this).parents('tr').children('td:first')
			var value_td = $(this).parents('tr').children('td:eq(1)')

			name.setAttribute( 'value', $(name_td).children('input').val() );
			value.setAttribute( 'value', $(value_td).children('input').val() );

			html_name = name_td.html();
			html_value = value_td.html();

			name_td.html( name );
			value_td.html( value );

			$(tr).children('td.actions').removeClass('actions').html( update ).append( cancel );
			
			$(tr).children('td:last').children('.add-entry').click( function(){
				var name_val = $(name).val();
				var value_val = $(value).val();

				name_td.html( html_name );
				value_td.html( html_value );

				$('input', name_td ).val( name_val );
				$('input', value_td ).val( value_val );

				$(name_td).get(0).replaceChild( document.createTextNode(name_val), $(name_td).get(0).childNodes[0]);
				$(value_td).get(0).replaceChild( document.createTextNode(value_val), $(value_td).get(0).childNodes[0]);

				$(this).parents('td').addClass('actions').html('');


			} );

			$(tr).children('td:last').children('.remove-entry').click( function(){ 
				name_td.html( html_name ); 
				value_td.html( html_value );
				$(this).parents('td').addClass('actions').html('');
			} );

		},

		delete_items: function() {
			if( confirm( 'Are you sure you want to delete this item?' ) )
			{
				$(this).parents( 'tr' ).remove();
			}
		},

		move_item_up: function() {
			var obj = $(this).parents( 'tr' );
			var parent = $(obj).prev();
			$(parent).before( obj );
			color_odd_rows( $(this).parents( '.data-table' ) );
			$(this).parents( 'tr' ).trigger( 'mouseleave' );
		},

		move_item_down: function() {
			var obj = $(this).parents( 'tr' );
			var parent = $(obj).next();
			$(parent).after( obj );
			color_odd_rows( $(this).parents( '.data-table' ) );
			$(this).parents( 'tr' ).trigger( 'mouseleave' );
		},

		remove_actions: function() {
			var td = $( '.actions', this );
			td.html('');
		},

		insert_text_field: function() {
			var row = $(this).parents('tbody').children('tr:last').before('<tr><td><input type="text" name="data_table_name" /></td><td><input type=text" name="data_table_value" /></td><td><span name="add-entry" class="add-entry" id="add-entry-' + $('.add-entry').length + '">&#10004;</span><span name="remove-entry" class="remove-entry" id="remove-entry-' + $('.add-entry').length + '">&#10008;</span></td></tr>').prev().addClass( 'new-row' );

			$('.add-entry', row).click(add_data_table_row);
			$('.remove-entry', row).click( function(){ $(row).remove(); } );

		},

		add_data_table_row: function() {
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
		   row.remove();
		}
	}; // var methods = {}

	$.fn.dataTable = function( method ) {
		if( methods[method] ) {
			return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ) );
		} else if ( typeof method === 'object' || ! method ) {
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'Method ' + method + ' does not exist on jQuery.dataTable' );
		}
	};
})(jQuery);
