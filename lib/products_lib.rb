module ProductsLib

	def self.request=( text )
		@request = text.gsub( /\/[\d]+/, '' )
	end

	def self.request
		@request
	end

	def self.setup( request )
		self.request = request
		type = get_product_type
		label = get_product_label( type )
		return type, label
	end

	def self.get_product_type
		request.match( '^/admin\/rifle' ).nil? ? 0 : 1
	end

	def self.get_product_label( type )
		type == 1 ? "rifle" : "product"
	end
end 
