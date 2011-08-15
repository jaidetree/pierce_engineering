class Product < ActiveRecord::Base
	serialize :prices
	serialize :data
	validates :name, :presence => true

	belongs_to :user
	belongs_to :product_category
	has_many :product_images

	before_save :process_data

	def process_data
		data_keys = self.prices[:keys]
		data_values = self.prices[:values]

		self.prices = {}

		data_keys.each_with_index do |key, index|
			self.prices[ key ] = data_values[ index ]
		end
	end

	def base_price
		return ( self.prices.class.name == "Hash" && self.prices['base'] ) ? self.prices['base'] : 0
	end

	def self.all_products_by_cat_type(type)
		@products = Product.joins( :product_category ).where( 'product_categories.cat_type' => type ).all
	end

	def selected_image
		image = self.product_images.find_by_image_selected( true )
		return image ? image : false
	end

	def prices
		prices = read_attribute(:prices)
		prices.class.name == "Hash" || ( prices[:keys] && prices[:values] ) ? prices : {}
	end
		
	def product?
		self.product_category.cat_type == 0 ? true : false
	end

	def has_images?
		images = self.product_images
		images.nil? ? false : true
	end

end
