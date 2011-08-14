module ProductsLib

	def self.url=( url_text )
		@url = url_text
	end

	def self.url
		@url
	end

	def self.request=( text )
		@request = text
	end

	def self.request
		@request
	end

	def self.setup( url, request )
		self.url = url
		self.request = request
		return get_product_type
	end

	def self.get_product_type
		request.match( 'admin\/rifle' ).nil? ? 0 : 1
	end

	def self.type_action( action )
		self.url + '/' + action
	end
end 
