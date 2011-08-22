class Product < ActiveRecord::Base
	serialize :prices
	serialize :data
	validates :name, :presence => true, :uniqueness => true

	belongs_to :user
	belongs_to :product_category
	has_many :product_images

	before_save :process_data

	def to_param
		return self.slug.nil? ? self.id.to_s : self.slug
	end

	def process_data

		self.prices = assemble_hash_from_array( self.prices )
		self.data = assemble_hash_from_array( self.data )

		self.slug = self.name.clean
	end

	def assemble_hash_from_array( data )
		return {} if data.nil?
		data_keys = data[:keys]
		data_values = data[:values]

		hash = {}

		if data_keys.class.name == "Array" 
			data_keys.each_with_index do |key, index|
				hash[ key ] = data_values[ index ]
			end
		end

		return hash

	end

	def base_price
		if not self.prices[:keys].nil? 
			return self.prices[:values][0]
		end
		return ( self.prices.class.name == "Hash" && self.prices['base'] ) ? self.prices['base'] : 0
	end

	def self.find_all_by_type(type)
		Product.joins( :product_category ).where( 'product_categories.cat_type' => type ).all
	end

	def selected_image
		@image ||= self.product_images.find_by_image_selected( true )
		return @image ? @image : false
	end

	def prices_hash
		return {} if prices.class.name == "String" || prices.nil? 
		return assemble_hash_from_array( prices ) if not prices[:keys].nil?
		prices.class.name.match( /^Hash/) || ( prices[:keys] && prices[:values] ) ? prices : {} 
	end

	def data_hash
		return {} if data.class.name == "String" || data.nil? 
		return assemble_hash_from_array( data ) if not data[:keys].nil?
		data.class.name.match( /^Hash/) ? data : {} 
	end
		
	def product?
		self.product_category.cat_type == 0 ? true : false
	end

	def has_images?
		images = self.product_images
		images.nil? ? false : true
	end

end
