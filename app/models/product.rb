class Product < ActiveRecord::Base
	serialize :prices
	serialize :data
	validates :name, :presence => true
	validates :prices, :presence => true

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
end
