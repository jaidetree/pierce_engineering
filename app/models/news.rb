class News < ActiveRecord::Base
	serialize :products
	belongs_to :user

	def content
		content = read_attribute(:content)

		if content.empty?
			content = self.excerpt
		end

		content
	end

	def has_products?
		return ! self.products.empty?
	end

	def products_array
		return [] if ! has_products?
		products
	end

	def find_all_products
		return Product.find( self.products_array )
	end

	def products
		products = read_attribute( :products )
		products ? products : []
	end
end
