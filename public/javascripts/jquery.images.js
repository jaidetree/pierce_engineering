(function($){
	var methods = {
		data : {},
		field_name: '',
		name : '',
		init : function( options ) {

			var settings = {};
			
			return this.each( function(){

				if( options )
				{
					$.extend( settings, options );
				}

				methods.data = options.hash;
				methods.field_name = options.field;
				methods.name = options.name;

				var table = methods.draw_table( this );

				methods.set_listeners(table);
			});
		},

		draw_table: function(table_container) {
			var table = methods.createElement( 'table', '', { class: 'data-table data-table-' + methods.name } );
			var tbody = methods.createElement( 'tbody' );

			var row_head = methods.createElement( 'tr' );
			row_head.appendChild( methods.createElement( 'th', 'Label' ) );
			row_head.appendChild( methods.createElement( 'th', 'Price' ) );
			row_head.appendChild( methods.createElement( 'th', '&nbsp;' ) );

			tbody.appendChild( row_head );

			for( var key in methods.data ) {
				tbody.appendChild( methods.createDataRow( key, methods.data[ key ] ) );	
			}

			var tr_add = methods.createElement( 'tr', 
				methods.createElement( 'td',
					methods.createElement( 'em', 'Add New Entry' ), 
					{ colspan: 3 }
				),
				{ class: 'add-row' }
			);

			tbody.appendChild( tr_add );

			table.appendChild( tbody );

			$(table_container).append( table );

			return table;
		},

		capitalize: function( text ) {
			return text.charAt(0).toUpperCase() + text.slice(1).toLowerCase();
		},

		createDataRow: function( name, value )
		{
			var field_name = methods.field_name;

			var label_name = document.createTextNode( name );
			var input_name = methods.createElement( 'input', name, { type: 'hidden', name: field_name + '[keys][]' } );
			var td_name = methods.createElement( 'td', [ label_name, input_name ] );

			var label_value = document.createTextNode( value );
			var input_value = methods.createElement( 'input', value, { type: 'hidden', name: field_name + '[values][]' } );
			var td_value = methods.createElement( 'td', [ label_value, input_value ] );

			var td_actions = methods.createElement( 'td', '', { class: 'actions' } ); 

			var tr = methods.createElement( 'tr', [ td_name, td_value, td_actions ] );

			return tr;
		},

		createElement: function( name, content, options ) {
			var element = document.createElement( name );

			if( content && name == "input" )
			{
				element.setAttribute( 'value', content );
			}
			else if( content && content instanceof Array )
			{
				for( var item in content )
				{
					element.appendChild( content[item] );
				}
			}
			else if( content && typeof content == "object" )
			{
				element.appendChild( content );
			}
			else if( content )
			{
				element.innerHTML = content;
			}

			if( options )
			{
				for( var attribute in options )
				{
					element.setAttribute( attribute, options[ attribute ] );
				}
			}


			return element;
		},

		set_listeners: function(table) {
			$('*', table).unbind( '.data-table' );
			$('.add-row', table).bind( 'mouseenter.data-table',
				function(){ $(this).children('td').children('em').css( 'visibility', 'visible' ) } ).bind( 'mouseleave.data-table',
				function(){ $(this).children('td').children('em').css( 'visibility', 'hidden' ) } );
			$('.add-row em', table).bind( 'click.data-table', methods.insert_text_field );
			$('tr', table).bind( 'mouseenter.data-table', methods.insert_actions ).bind( 'mouseleave.data-table', methods.remove_actions );

			methods.color_odd_rows(table);
		},

		color_odd_rows: function(obj) {
			$('tr', obj).removeClass( 'odd' ); 
			$('tr:odd', obj).addClass( 'odd' ); 
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

			$('.move-up').bind( 'click.data-table', methods.move_item_up );
			$('.move-down').bind( 'click.data-table', methods.move_item_down );
			$('.edit').bind( 'click.data-table', methods.edit_item );
			$('.delete').bind( 'click.data-table', methods.delete_item );
		},

		edit_item: function() {
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
			
			$(tr).children('td:last').children('.add-entry').bind( 'click.data-table', function(){
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

			$(tr).children('td:last').children('.remove-entry').bind( 'click.data-table', function(){ 
				name_td.html( html_name ); 
				value_td.html( html_value );
				$(this).parents('td').addClass('actions').html('');
			} );

		},

		delete_item: function() {
			if( confirm( 'Are you sure you want to delete this item?' ) )
			{
				$(this).parents( 'tr' ).remove();
			}
		},

		move_item_up: function() {
			var obj = $(this).parents( 'tr' );
			var parent = $(obj).prev();
			$(parent).before( obj );
			methods.color_odd_rows( $(this).parents( '.data-table' ) );
			$(this).parents( 'tr' ).trigger( 'mouseleave' );
		},

		move_item_down: function() {
			var obj = $(this).parents( 'tr' );
			var parent = $(obj).next();
			$(parent).after( obj );
			methods.color_odd_rows( $(this).parents( '.data-table' ) );
			$(this).parents( 'tr' ).trigger( 'mouseleave' );
		},

		remove_actions: function() {
			var td = $( '.actions', this );
			td.html('');
		},

		insert_text_field: function() {
			var row = $(this).parents('tbody').children('tr:last').before('<tr><td><input type="text" name="data_table_name" /></td><td><input type=text" name="data_table_value" /></td><td><span name="add-entry" class="add-entry" id="add-entry-' + $('.add-entry').length + '">&#10004;</span><span name="remove-entry" class="remove-entry" id="remove-entry-' + $('.add-entry').length + '">&#10008;</span></td></tr>').prev().addClass( 'new-row' );

			$('.add-entry', row).bind( 'click.data-table', methods.add_data_table_row );
			$('.remove-entry', row).bind( 'click.data-table', function(){ $(row).remove(); } );

		},

		add_data_table_row: function() {
		    var name = $(this).parent().siblings('td:first').children('input').val();
			var value = $(this).parent().siblings('td:first').next().children('input').val();

		    var row = $(this).parents( 'tr' );
			var tr = methods.createDataRow( name, value );
			var table = $(row).parents( 'table' );

			row.before( tr );


			methods.set_listeners( table );
			methods.color_odd_rows( table );
		   
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
