class Product < ActiveRecord::Base
	include DataTable

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

		self.prices = DataTable.assemble_hash_from_array( self.prices )
		self.data = DataTable.assemble_hash_from_array( self.data )

		self.slug = self.name.clean
	end

	def base_price
		prices = self.prices_hash

		if prices.has_key?( :prices )
			return self.prices[:values][0]
		end

		return ( prices.class.name == "Hash" && prices['base'] ) ? prices['base'] : 0
	end

	def self.find_all_by_type(type)
		Product.joins( :product_category ).where( 'product_categories.cat_type' => type ).all
	end

	def selected_image
		@image ||= self.product_images.find_by_image_selected( true )
		return @image ? @image : false
	end

	def prices_hash
		return DataTable.get_hash( prices )
	end

	def data_hash
		return DataTable.get_hash( data )
	end
		
	def product?
		self.product_category.cat_type == 0 ? true : false
	end

	def has_images?
		images = self.product_images
		images.nil? ? false : true
	end

end
